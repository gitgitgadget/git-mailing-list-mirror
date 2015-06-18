From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools: add config option to disable auto-merge
Date: Thu, 18 Jun 2015 01:42:53 -0700
Message-ID: <20150618084252.GA38187@gmail.com>
References: <1434490514-36204-1-git-send-email-rappazzo@gmail.com>
 <1434490514-36204-2-git-send-email-rappazzo@gmail.com>
 <xmqqd20u6s2b.fsf@gitster.dls.corp.google.com>
 <CANoM8SWN2ZzgMP_MoDRRFA8ZjzRh724iaJ7GwrD2WddrjqwuqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, ssaasen@atlassian.com,
	john@keeping.me.uk, Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:43:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5VPu-0000WX-EL
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 10:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbbFRInN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 04:43:13 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33875 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbbFRInK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 04:43:10 -0400
Received: by pdbki1 with SMTP id ki1so61866981pdb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 01:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FfTG/Kg61lFL7CfuXzyc6TSYaWqeO62UCt5MQUtkgWU=;
        b=YpMc3iG6K3xHnGHVB7IVVe98zCA9p/rN1KcRODszjT9rWbrkRIyq2irltZ4oUeC1QK
         j27nbDWhQC/Jf6CoMtRpuktC/sEBpkj9GjWeeFARjXbIDl0nH3w/sznUb1+Cfpzm4REr
         gRgahJ8sLGnA83vW7YB7RnMzXmgbz1frYs1OFjGurUmSsu0o8i4HQP/AC53MUsx6Cpld
         SCrUPkS7zO+gQXueHx/rC5hy7Ntk/oHeUy2ycJRV0rVkg2pAIpCxyZPMxCgKvXSci63x
         +Jey8shgdXLk7RatMgVBEOoGmiu//doEerApqMpgah8TgcsWCVgvAJFMxn4X0nFnU59o
         uqYA==
X-Received: by 10.66.154.233 with SMTP id vr9mr19248484pab.124.1434616989442;
        Thu, 18 Jun 2015 01:43:09 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id h11sm7258311pdj.27.2015.06.18.01.43.07
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 01:43:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANoM8SWN2ZzgMP_MoDRRFA8ZjzRh724iaJ7GwrD2WddrjqwuqQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271937>

On Wed, Jun 17, 2015 at 10:27:58PM -0400, Mike Rappazzo wrote:
> On Wed, Jun 17, 2015 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Michael Rappazzo <rappazzo@gmail.com> writes:
> >
> >> For some mergetools, the current invocation of git mergetool will
> >> include an auto-merge flag.  By default the flag is included, however if
> >> the git config option 'merge.automerge' is set to 'false', then that
> >> flag will now be omitted.
> >
> > ... and why is the "automerge" a bad thing that user would want to
> > avoid triggering under which condition?  That description may not
> > have to be in the proposed log message, but it would help users when
> > they decide if they want to use the configuration to describe it in
> > the mergetool.automerge configuration.
> >
> > And depending on the answer to the above question, a configuration
> > variable may turn out be a bad mechanism to customize this (namely,
> > set-and-forget configuration variable is a bad match for a knob that
> > is more "per invocation" than "user taste").
> >
> > Is this not about "automerge" but more about "always-show-UI because
> > I like GUI?"  Then that may be a "user taste" thing that is a good
> > match for a configuration variable.  I simply cannot tell from what
> > was in the message I am responding to.
> 
> I feel that the auto-merge takes away the context of the changes.
> 
> I use araxis merge as my mergetool of choice.  I almost always immediately
> undo the auto-merge.  After taking a moment to look at each file, I will
> then (usually) use the keyboard shortcut for auto-merge.
> 
> It sure would be nice to "set-and-forget" a config variable to remove the
> annoyance of having to undo the auto-merge.  I think that this config
> option is reasonable.  Perhaps my documentation leaves something to be
> desired.  I can take another stab at it.

If this is the case then I would recommend making it more
granular.  Just because Araxis' automerge is undesirable does
not mean that some other tools' automerge is as well.
e.g. the config variable could be "mergetool.<tool>.automerge"
rather than the top-level "mergetool.automerge" variable.

But, as Junio suggested, having a command-line flag to skip the
behavior might be a better first step.  Something like,
"git mergetool --no-automerge".

Most of Git's behavior that can be modified via configuration
can also be modified on the command-line, so exposing this
feature as a flag would probably be a good idea.

Even without a config variable, it can still be fire-and-forget
convenient by using a git alias to supply the flag.

In lieu of any of these features, another option is that you can
override the default command by setting "mergetool.araxis.cmd",
and "git mergetool" will use your definition rather than its
built-in command.  We left that escape hatch in for just this
purpose.

I'm curious, is this a common use case?  I'm personally not a
good judge of that, but I'll let the list chime in.  Thoughts?
-- 
David
