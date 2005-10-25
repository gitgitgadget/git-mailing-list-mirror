From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: latest stg/git commandline completions code
Date: Tue, 25 Oct 2005 17:24:28 +0100
Message-ID: <b0943d9e0510250924g3f5d9281r@mail.gmail.com>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac>
	 <200510251642.46169.blaisorblade@yahoo.it> <tnxwtk1lj58.fsf@arm.com>
	 <200510251753.20164.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ben Clifford <benc@hawaga.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 18:27:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EURbV-0006uW-3h
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 18:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVJYQY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 12:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVJYQY3
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 12:24:29 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:6822 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932199AbVJYQY3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 12:24:29 -0400
Received: by xproxy.gmail.com with SMTP id t11so288240wxc
        for <git@vger.kernel.org>; Tue, 25 Oct 2005 09:24:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=koRBh8MiOaDFOspv2V8YrMkMKq7E54hvTBmYt87pd8n94oIxG22C/ML50Wnmer7+ZmO59X4nr7OTi6ukrfBSC//VuPipVbL4FkEImx2ww2LkcroOjAMu28u9KzzLQsCfbgfL5XWHTscsm6hTrvKFN9CkzJjX5bFW0KQPe0PRdtM=
Received: by 10.70.28.8 with SMTP id b8mr4308996wxb;
        Tue, 25 Oct 2005 09:24:28 -0700 (PDT)
Received: by 10.70.31.3 with HTTP; Tue, 25 Oct 2005 09:24:28 -0700 (PDT)
To: Blaisorblade <blaisorblade@yahoo.it>
In-Reply-To: <200510251753.20164.blaisorblade@yahoo.it>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10595>

On 25/10/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> The best idea seems to write a Python script sourcing the Stgit source
> (stgit/main.py to get commands, and then loading each class and iterating
> over the "options" module member).

I can add a function in stgit/main.py which would list the options.
The tla-completion generates a file listing a command with its option
on every line:

  push -a -all -n --number -t --to --reverse --undo -h --help
  ...

Since I don't know much about the bash completion, let me know of the
format you'd prefer.

> Btw, what do you think about speeding up completions by reimplementing things
> like "stg applied" or "stg unapplied" via cat (as noted in the comments at
> the beginning of the script)? Tab completions can easily livelock a shell on
> a busy system, so it's worthy speeding the thing up.

In general, it is better to use the stg commands but the repository
structure won't probably change for a long time and it's OK to
optimise (if the speed improvement is visible). Anyway, these
particular commands are pretty fast (they behave like cat) but there
are others which are slower (usually the commands involving calls to
the GIT tool).

--
Catalin
