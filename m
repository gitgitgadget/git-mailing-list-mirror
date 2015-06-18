From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] mergetools: add config option to disable auto-merge
Date: Thu, 18 Jun 2015 11:14:49 -0400
Message-ID: <CANoM8SXLTKSPPdByNtGXaqchStTwKF8-1J6A5YW43CT0ikPRHQ@mail.gmail.com>
References: <1434490514-36204-1-git-send-email-rappazzo@gmail.com>
 <1434490514-36204-2-git-send-email-rappazzo@gmail.com> <xmqqd20u6s2b.fsf@gitster.dls.corp.google.com>
 <CANoM8SWN2ZzgMP_MoDRRFA8ZjzRh724iaJ7GwrD2WddrjqwuqQ@mail.gmail.com> <20150618084252.GA38187@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Saasen <ssaasen@atlassian.com>, john@keeping.me.uk,
	Git List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 17:15:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5bXB-0001zx-B5
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 17:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744AbbFRPPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 11:15:13 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35775 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbbFRPPL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 11:15:11 -0400
Received: by obbgp2 with SMTP id gp2so56123623obb.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dEv+gVcYybsMEMNtw+qLBFWpj9Zah6w78q1iupjH9yc=;
        b=RmrWTgljPL0XURpdzPhWFUCloWCr0T2zUKmgYcd48Jr8M0BDFLA0Ldu3TgDvO55Tkt
         JJtw1LeaFwaC2VutiZCUsJb3mxWx+D5r5nwauEPMpYAmEA7nVW3wJABgJiZ8l560cBpT
         wI+CKDFrdvQBUElj9HQPQYM32B7NdoPIXgVndyGkxfM2tBwZokBJI7jtwMYMnGjsIY/K
         /t8fgOmds2Jr0qNGFZVh3teTj3/e0sNmaekocf3L+sswfDmKF99jNm+Xzv2FmFkS/E/s
         ScZ4yn0dpxfbf/K0aXYzWm7WEP8T6eWJpeU64CHs2hPSgNmy9l2XEITfvA1ms4hNziqj
         1KPQ==
X-Received: by 10.182.58.81 with SMTP id o17mr9396843obq.76.1434640510249;
 Thu, 18 Jun 2015 08:15:10 -0700 (PDT)
Received: by 10.202.174.131 with HTTP; Thu, 18 Jun 2015 08:14:49 -0700 (PDT)
In-Reply-To: <20150618084252.GA38187@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272013>

On Thu, Jun 18, 2015 at 4:43 AM David Aguilar <davvid@gmail.com> wrote:
>
> On Wed, Jun 17, 2015 at 10:27:58PM -0400, Mike Rappazzo wrote:
> >
> > I feel that the auto-merge takes away the context of the changes.
> >
> > I use araxis merge as my mergetool of choice.  I almost always immediately
> > undo the auto-merge.  After taking a moment to look at each file, I will
> > then (usually) use the keyboard shortcut for auto-merge.
> >
> > It sure would be nice to "set-and-forget" a config variable to remove the
> > annoyance of having to undo the auto-merge.  I think that this config
> > option is reasonable.  Perhaps my documentation leaves something to be
> > desired.  I can take another stab at it.
>
> If this is the case then I would recommend making it more
> granular.  Just because Araxis' automerge is undesirable does
> not mean that some other tools' automerge is as well.
> e.g. the config variable could be "mergetool.<tool>.automerge"
> rather than the top-level "mergetool.automerge" variable.

I don't necessarily think that araxis' automerge is bad, but I like to look
at the before and after to understand the context of a conflict.  I can't
imagine that this is a quirk of araxis, but is probably something that
exists for any auto-merging tool.  The feature doesn't seem to be that
widely supported among the other tooling.  I only found the three to use
such a feature.

Since the automerge option is not available on every merge tool, it seems
reasonable to use "mergetool.<tool>.automerge" instead of "merge.automerge".

>
>
> But, as Junio suggested, having a command-line flag to skip the
> behavior might be a better first step.  Something like,
> "git mergetool --no-automerge".
>
> Most of Git's behavior that can be modified via configuration
> can also be modified on the command-line, so exposing this
> feature as a flag would probably be a good idea.


This makes sense, and if this change is to go forward, I will implement the
command line option.

>
> Even without a config variable, it can still be fire-and-forget
> convenient by using a git alias to supply the flag.
>
> In lieu of any of these features, another option is that you can
> override the default command by setting "mergetool.araxis.cmd",
> and "git mergetool" will use your definition rather than its
> built-in command.  We left that escape hatch in for just this
> purpose.

I guess that if this patch does not go forward, I will have to use this
workaround.
