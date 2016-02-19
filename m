From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git submodule should honor "-c credential.helper" command line argument
Date: Thu, 18 Feb 2016 23:29:09 -0800
Message-ID: <CA+P7+xr9dLOyaVky1jvXm7MkF0JUqs5SadrTdr4o83baMp397A@mail.gmail.com>
References: <56B0E3AA.30804@syntevo.com> <20160203042554.GA21179@sigill.intra.peff.net>
 <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
 <CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com>
 <56B74B17.4040304@syntevo.com> <CA+P7+xpFmZBUwq1h9Xhi7xKYfAyvcouBiV5ujHxuGJQJTMHXZw@mail.gmail.com>
 <CA+P7+xpHNHVSJnVg3HwiBjWxRdSpLXCsm3GpWst=BNyhLMVd5A@mail.gmail.com> <20160219043019.GA14764@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 08:30:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWfVw-0007lV-6n
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 08:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbcBSH3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 02:29:30 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:35631 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbcBSH33 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 02:29:29 -0500
Received: by mail-io0-f181.google.com with SMTP id g203so100879154iof.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 23:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BGeED0NAgwwZrJrlA3F3IpHbgj8W3bKQNPSTedZKO7E=;
        b=wyQDkqXpINpHcysfuJ0bPr2FVyQeMqyRAT9QquxR/8kRKmQjguPKYtsDBkY4tX+zyB
         hPE2gtAFYPa0eJSINkuHv1vC9FUSdz6TC2KVwWRfrGXnuu07xDlAl7cR3KCXnhcP2tKf
         dT5zZlgUv/uh5I21KXN2zLyYsz8IGuGZYl2V6pNkihXkq/ErAi50Lm8yHOprWEyDI0LB
         T+ixNuXxOXf6+D7ygZ4wXSMZnDRSefWc6blqsumeKJIsFq11s0CnsB7Onvn6TrtoUJWT
         dTuky1Ycy+ZlB2MIa4lUXzfUKVXCPNU5Zla98I5znmwLL3OmKE0Dtm/b/j80i/7Z/Ehp
         JHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=BGeED0NAgwwZrJrlA3F3IpHbgj8W3bKQNPSTedZKO7E=;
        b=FIkFZufwZejvMxsws5OZvgZfdmxxmMrFIsfBxqOQJt8ffLOBLJhfgaK7+q+kdcbBJs
         g5dmZsKzGMB7S8v7Js0YK7CeYjvI9deB/5aEY2vOcaPsWNaSZi/+FPs9mTW/Op7H0K+T
         UNEC6qmmijVhqEmys9QJv9wAWa+o/hCEl3w7e/Am3fUl5axFREVbLpsZD81CMa5CLHi+
         XJFoLwJqLv3cdBbiqPZnxmBnyYP6sNCG+DyOG/Esysi/t3zmUtXvNrCzSfrln3vWW0gH
         IIv1+JqfoJXNvFhGlDC9dgcpAoJ9VOqr+bDdHunugeKeVY9WqH3+8WVYJhDAlEJOOgAU
         sFxA==
X-Gm-Message-State: AG10YORIrtdBWnmnF6nG5j4yEcl6Ib9T6PvMHLrDrevyQBcCjmGhCeHI1ClM/jYioa0lmKAH73XpzK3wmP3LMA==
X-Received: by 10.107.156.14 with SMTP id f14mr15866514ioe.0.1455866968702;
 Thu, 18 Feb 2016 23:29:28 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 18 Feb 2016 23:29:09 -0800 (PST)
In-Reply-To: <20160219043019.GA14764@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286662>

On Thu, Feb 18, 2016 at 8:30 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 18, 2016 at 05:15:54PM -0800, Jacob Keller wrote:
>
>> I am looking at this more and I am stuck as to how best to provide a
>> test case.
>>
>> I think the problem as stated above is pretty straight forward, we
>> just want to stop clearing GIT_CONFIG_PARAMETERS but I can't find an
>> easy way to test that we've done the right thing. There are no current
>> tests for using a credential helper with submodule update right now.
>
> If you just want to test that GIT_CONFIG_PARAMETERS is left untouched in
> the submodule, you can tweak any config setting that would impact the
> newly-cloned repo. E.g. this:
>
>   unset GIT_COMMITTER_NAME
>   git config --global user.name='Global Name'
>   git -c user.name='Command-Line Name' clone repo-with-module foo
>   head -1 foo/.git/logs/HEAD
>   head -1 foo/.git/modules/sub/logs/HEAD
>
> shows that the parent-level clone uses the "-c" name, but the submodule
> does not.
>
> That being said, I am not sure this is the right solution. In the thread
> I linked earlier[1], Jens indicated he would prefer not to blindly share
> config with the submodules, and I think I agree. Or are you proposing to
> pick and choose the keys in GIT_CONFIG_PARAMETERS, and whitelist
> credential.*?
>
> In that case, obviously my test example would not work, though I think
> that it might be fine to put "user.name" onto the whitelist (the things
> we really would worry about is stuff like "core.worktree" that clearly
> does not make sense to carry over into the submodule).
>
> -Peff
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/264840
>

I would prefer to either.. blacklist stuff like core.worktree, or
whitelist a bunch of stuff that makes sense. In this case though, I
would prefer to have an explicit test of credential.helper, but I
don't know if any of our tests actually have a solid test case for
"credential.helper was used in a clone. There may not be test
infrastructure for this though, so your test might work well enough.

As for how to whitelist config to share with the submodule I am really
not 100% sure, since we just clear GIT_CONFIG_PARAMETERS, and I think
we'd need a specialized variant of clear_local_git_env_vars specific
to submodule then.

Thanks,
Jake
