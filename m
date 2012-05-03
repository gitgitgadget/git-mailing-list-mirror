From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] [GIT PULL] ktest: A couple of fixes
Date: Wed, 02 May 2012 17:33:44 -0700 (PDT)
Message-ID: <m3havyqf17.fsf@localhost.localdomain>
References: <20120502004439.965120020@goodmis.org>
	<CA+55aFy02d13HkfwY-TEGwu=2cd8en+_rnrnwcwixGKRmdJRtA@mail.gmail.com>
	<7v62cf6y3d.fsf@alter.siamese.dyndns.org>
	<1335966292.14207.40.camel@gandalf.stny.rr.com>
	<7vsjfigx23.fsf@alter.siamese.dyndns.org>
	<1336003655.14207.71.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
X-From: git-owner@vger.kernel.org Thu May 03 02:34:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPjzf-0001O2-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 02:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281Ab2ECAdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 20:33:47 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60015 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab2ECAdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 20:33:46 -0400
Received: by were53 with SMTP id e53so778844wer.19
        for <multiple recipients>; Wed, 02 May 2012 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=K8NhXqLtAZqbnaVLpSPID8VmiB8Vwul05mmy+lWzaSo=;
        b=MaQHXOG7J0AONyNLPgDCRGiVl3mPrerIsyYuTJqHBZt5S4mUYYudvZFllAsLIPpPcp
         9l4H76vLb1KrkykkS1IMD+QvF97MAqJwevfK/sUHCAC8GyA3rds5IWTjygtAApMRxmZj
         UkAtF7K5GgwpEt8xTf0yCgCbVg59i6LT7ph/qYLPw/fNX0gh59Fxm8D+ACYBS01sJxMb
         1alXLcS9d0ru2UE2APJMXsTVs6/4/LUh8bXU5JlJJqlSNY9rwCowWQ4bSfq2pEfKtphr
         Cc3jBwiDCbNPzomBFyLQCfVbRue718WXd2nQ0t+4xAMXPMLvlmWRN3rWhUwFNzvoWnIo
         xRAg==
Received: by 10.180.77.233 with SMTP id v9mr9196009wiw.22.1336005225167;
        Wed, 02 May 2012 17:33:45 -0700 (PDT)
Received: from localhost.localdomain (eps70.neoplus.adsl.tpnet.pl. [83.20.60.70])
        by mx.google.com with ESMTPS id ea6sm47792854wib.5.2012.05.02.17.33.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 May 2012 17:33:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q430XhAO029499;
	Thu, 3 May 2012 02:33:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q430Xeap029496;
	Thu, 3 May 2012 02:33:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1336003655.14207.71.camel@gandalf.stny.rr.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196873>

Steven Rostedt <rostedt@goodmis.org> writes:

> I'll throw in one more feature request, that you can take or leave (I
> have another script for it ;-), something that does a listing of
> branches in order of date. I have over a hundred branches in my repo,
> and I forget which branch was the last one I was working on. So I
> created a script called git-ls (attached).
> 
> Here's what the output looks like:
> 
> $ git-ls | tail
> 681d1c4    2012-04-19    trace/tip/perf/urgent                         tracing: Fix stacktrace of latency tracers (irqsoff and friends)
> 59cfede    2012-04-19    trace/rfc/iolatency                           tracing: Add iolatency tracer
> 61463fa    2012-04-24    trace/tip/perf/core                           ftrace/x86: Remove the complex ftrace NMI handling code
> e201738    2012-04-26    trace/tip/perf/core-2                         ftrace/x86: Remove the complex ftrace NMI handling code
> 053cef1    2012-04-27    trace/rfc/tracing/fentry                      ftrace/x86: Add support for -mfentry to x86_64
> 4a6d70c    2012-04-27    trace/tip/perf/core-3                         ftrace/x86: Remove the complex ftrace NMI handling code
> a76c3eb    2012-04-30    trace/rfc/kprobes/ftrace                      ftrace/x86: Add support for x86_32 to pass pt_regs to function tracer
> 6e1b77e    2012-05-02    trace/rfc/kprobes/ftrace-v2                   kprobes: Update header for ftrace optimization
> a4cc5f1    2012-05-02    trace/tip/perf/next-2                         ftrace/x86: Add separate function to save regs
> 9bd8569    2012-05-02    trace/tip/perf/next                           trace: Make removal of ring buffer pages atomic
> 
> It lists the branches in order of date of last commit.
> 
> Again, just showing some things that I find useful. If no one else finds
> these interesting, then just ignore it. I have my scripts :-)

Well, there is "git branch -v -v":

  $ git branch -v -v
  [...]
    gsoc2012-wiki                  0e71ecb [gsoc2012/wiki/master: ahead 11, behind 4] '"Published" and "secret" commits' project
    html                           8b94cd8 Autogenerated HTML docs for v1.7.7.1-488-ge8e1c
    i18n-po.pl                     aa8ce2e [git-i18n/ab/i18n-po: ahead 1] po/pl.po: Eliminate fuzzy translations
    maint                          bf50515 Git 1.7.10.1
  [...]
    t/doc-config-extraction        451c2ef [git/trast/t/doc-config-extraction-v2: ahead 2257, behind 3] Documentation: complete config list from other manpages
    test                           b77178e gitweb: Separate features with no project specific override
    todo                           10c7888 Meta/dodoc: assign default values
    user-manual                    4c22f3d Comments to user-manual (WIP)


I guess that git-for-each-ref could be extended with behind / ahead
information, perhaps as modifiers to existing %(upstream) field...

P.S. I would associate "git ls" with listing worktree files.

-- 
Jakub Narebski
