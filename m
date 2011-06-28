From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: [PATCH] progress: use \r as EOL only if isatty(stderr) is true
Date: Tue, 28 Jun 2011 18:51:53 +0200
Message-ID: <20110628165153.GA59095@sherwood.local>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <BANLkTinRe=pA=_obCmPKBjJMXH_pDfwCtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 18:56:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbbaE-0006Ri-Se
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 18:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759924Ab1F1Qyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 12:54:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46273 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988Ab1F1QwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 12:52:03 -0400
Received: by bwd5 with SMTP id 5so340827bwd.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IKeRgAD/Eg+xaOyZLKqjQvHjiEkvrzHgeDFYVlFFpuQ=;
        b=UCBfRQgWfniXRYofqBowBitA8wVb93MebnT/75KC+Ay30yMJj57VjNg9D0SHbHb1Id
         kf7jGQIO4KXmoJwzf/58osvBXJaQFLfCNfgqou7UceP3F2Dql0lx3NxRjRr+/ai3nAU/
         AXow2mosSVEuE+SIx8o+N87ClUJ1wjvXdLbWQ=
Received: by 10.204.46.227 with SMTP id k35mr424192bkf.104.1309279921365;
        Tue, 28 Jun 2011 09:52:01 -0700 (PDT)
Received: from sherwood.local ([82.113.99.172])
        by mx.google.com with ESMTPS id k16sm361727bks.13.2011.06.28.09.51.59
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 09:52:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinRe=pA=_obCmPKBjJMXH_pDfwCtw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176407>

@ Tay Ray Chuan <rctay89@gmail.com> wrote (2011-06-28 18:27+0200):
> hmm, shouldn't the onus of checking tty fall on to callers of
> progress* functions?

I dunno and have no overview of the git(1) codebase.  I have a
"arena/code.extern.repos/" directory tree and use a shell script
which manages it (e.g.  "$ arena-manager update" to pull all repos).
The output of this script is (also) redirected into a log file via
tee(1), and for git(1) invocations the resulting output is not very
useful.

I agree that it is maybe silly to not use --no-progress from within
the script (the script comes from cvs(1) background).  Maybe i should
change it to not use git porcelain but directly script the plumbing -
:-) -, but i am *very* new to git(1) and in the meanwhile this simple
patch pimps up my log output.

--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
