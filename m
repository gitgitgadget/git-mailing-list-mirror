From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Re: Relative submodule URLs
Date: Mon, 25 Aug 2014 09:29:07 -0500
Message-ID: <CAHd499Bat5AFc1E4Sfezx9Qi8LPsxkyKKkBb2eg8JQb9kdPzgg@mail.gmail.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
	<CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com>
	<53F76907.1090904@xiplink.com>
	<20140824133428.GA2839@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 16:29:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLvGk-0006rF-Pq
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 16:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932809AbaHYO3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 10:29:10 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:49873 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932492AbaHYO3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 10:29:09 -0400
Received: by mail-vc0-f169.google.com with SMTP id le20so15439644vcb.28
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TmQbstS+lZnVR959SZFHU6aYxo1L/p2vqu+JNeymOb0=;
        b=Oc1v2ye+5/KnCCnYFq3kuhCyYyvD4qiDNURqeACqEOrJJdSeTSwfVE/b7qPreYWWfP
         cxxPIBBcq+jEhhxkvoM7alX86RQqqXHidrKGD0DAepG4L3tBJW/bMcEWS9qRVGTZ1LYk
         0IMOwWvG50iEMxJdKh/LAIw6QltBFTK+f88xZie2H3TSEywwIDsdkaOe+ho4QeAX1Kv4
         CH6NDpuHPu9XJlENPa2fwZHXUGHtBGP0h/Fe4m6yR5xQIKX8Ga7VQ/nUtTlZ4GnyTK6Q
         7P/uLCnB6cD0FMr5/lBtNAdrkfg/+biuZppfAw8fCwHbQ/5OZKBw0kcZTu/kj/kp95qL
         mzZw==
X-Received: by 10.220.105.142 with SMTP id t14mr17076698vco.14.1408976947595;
 Mon, 25 Aug 2014 07:29:07 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Mon, 25 Aug 2014 07:29:07 -0700 (PDT)
In-Reply-To: <20140824133428.GA2839@book.hvoigt.net>
X-Google-Sender-Auth: e1ouq7wDxbqw8xO_yXplpqNb4MU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255827>

On Sun, Aug 24, 2014 at 8:34 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> New --with--remote parameter for 'git submodule'
> ------------------------------------------------
>
> While having said all that about submodule settings I think a much
> much simpler start is to go ahead with a commandline setting, like
> Robert proposed here[2].
>
> For that we do not have to worry about how it can be stored,
> transported, defined per submodule or on a branch, since answers to this
> are given at the commandline (and current repository state).
>
> There are still open questions about this though:
>
>   * Should the name in the submodule be 'origin' even though you
>     specified --with-remote=somewhere? For me its always confusing to
>     have the same/similar remotes named differently in different
>     repositories. That why I try to keep the names the same in all my
>     clones of repositories (i.e. for my private, github, upstream
>     remotes).
>
>   * When you do a 'git submodule sync --with-remote=somewhere' should
>     the remote be added or replaced.
>
> My opinion on these are:
>
> The remote should be named as in the superproject so
> --with-remote=somewhere adds/replaces the remote 'somewhere' in the
> submodules named on the commandline (or all in case no submodule is
> specified). In case of a fresh clone of the submodule, there would be no
> origin but only a remote under the new name.
>
> Would the --with-remote feature I describe be a feasible start for you
> Robert? What do others think? Is the naming of the parameter
> '--with-remote' alright?
>
> Cheers Heiko
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/255512
> [2] http://article.gmane.org/gmane.comp.version-control.git/255512
> [3] https://github.com/jlehmann/git-submod-enhancements/wiki#special-ref-overriding-gitmodules-values

Hi Heiko,

My last email response was in violation of your request to keep the
two topics separate, sorry about that. I started typing it this
weekend and completed the draft this morning, without having read this
response from you first. At this point my only intention was to start
discussion on a possible short-term solution. I realize the Git
developers are working hard on improving submodule workflow for the
long term. In addition I do not have the domain expertise to properly
make suggestions in regards to longer-term solutions, so I leave that
to you :-)

The --with-remote feature would allow me to begin using relative
submodules because:

On a per-submodule basis, I can specify the remote it will use. When I
fork a submodule and need to start tracking it, I can run `git
submodule sync --with-remote fork`, which will take my super repo's
'fork' remote, REPLACE 'origin' in the submodule with that URL, and
also redo the relative URL calculation. This is ideal since I use HTTP
at home (so I can use my proxy server to access git behind firewall at
work) and at work physically I use SSH for performance (to avoid HTTP
protocol). I also like the idea of "never" having to update my
submodule URLs again if the git server moves, domain name changes, or
whatever else.

Here is what I think would make the feature most usable. I think you
went over some of these ideas but I just want to clarify, to make sure
we're on the same page. Please correct me as needed.

1. Running `git submodule update --with-remote <name>` shall fail the
command unconditionally.
2. Using the `--with-remote` option on submodule `update` or `sync`
will fail if it detects absolute submodule URLs in .gitmodule
3. Running `git submodule update --init --with-remote <name>` shall
fail the command ONLY if a submodule is being processed that is NOT
also being initialized.
4. The behavior of git submodule's `update` or `sync` commands
combined with `--with-remote` will REPLACE or CREATE the 'origin'
remote in each submodule it is run in. We will not allow the user to
configure what the submodule remote name will end up being (I think
this is current behavior and forces good practice; I consider `origin`
an adopted standard for git, and actually wish it was more enforced
for super projects as well!)

Let me know if I've missed anything. Once we clarify requirements I'll
attempt to start work on this during my free time. I'll start by
testing this through msysgit, since I do not have linux installed, but
I have Linux Mint running in a Virtual Machine so I can test on both
platforms as needed (I don't have a lot of experience on Linux
though).

I hope you won't mind me reaching out for questions as needed, however
I will attempt to be as resourceful as possible since I know you're
all busy. Thanks.
