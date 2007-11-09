From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git submodules and diffing
Date: Fri,  9 Nov 2007 23:57:37 +0100
Message-ID: <1194649057-19676-1-git-send-email-jnareb@gmail.com>
References: <4D079E0B-D6FB-4FBA-B449-2EFBFD5A5DE4@imendio.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: Sven Herzberg <sven@imendio.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 23:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqcnl-000295-Lw
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 23:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbXKIW56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 17:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755794AbXKIW56
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 17:57:58 -0500
Received: from ik-out-1112.google.com ([66.249.90.179]:21193 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627AbXKIW55 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 17:57:57 -0500
Received: by ik-out-1112.google.com with SMTP id c28so415486ika
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 14:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:newsgroups:references;
        bh=t360uqtINCoSIOZiqrey0jZ10Lke1LR1wMKyai7FaoA=;
        b=dVedUva8EJ7MyEVuG9aJpwAQ7SycDCG/Fpqsw423rtfLzVKMboL9aFE/q6xzNTsDRpUtFGJvc/SncZE3MrRUL0MWAN9jiWfHL+whH9hfiz3EsTHs0SmtEt7p2ds7TELm5kZp4Lf7NtghPftMhrAeft4xyZWVo9Z3FcoETxkp/3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:newsgroups;
        b=mKTYlMuT2xKP0GN5efBG/fTI0eVxv7zDZHxXWUbtWBqkgW+Xku/rB7hkOO7e119IAd3AdD5Iq8go2hdPEKGIY1dlVfka1aarMWpkv4XId4nO5sg4/R2yuJF7+Q2XQCsIiBm1o9qVPVl72GzcJmYT7Y9voUwOK5TaSzKhivnzofQ=
Received: by 10.67.15.15 with SMTP id s15mr212510ugi.1194649075777;
        Fri, 09 Nov 2007 14:57:55 -0800 (PST)
Received: from roke.D-201 ( [83.8.213.178])
        by mx.google.com with ESMTPS id c24sm3463236ika.2007.11.09.14.57.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Nov 2007 14:57:54 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA9Mvrjg019692;
	Fri, 9 Nov 2007 23:57:54 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA9Mvbfh019690;
	Fri, 9 Nov 2007 23:57:37 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <4D079E0B-D6FB-4FBA-B449-2EFBFD5A5DE4@imendio.com>
Newsgroups: gmane.comp.version-control.git
References: <4D079E0B-D6FB-4FBA-B449-2EFBFD5A5DE4@imendio.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64270>

Sven Herzberg wrote:

> When I started working with git submodules, I realized that git-diff  
> only lists the revision ids of a submodule if it has changed. I have  
> created a repository which includes a diff command for git-submodule,  
> so you can use it like "gut submodule diff <modules...>"
> 
> I pushed my git tree at git://git.imendio.com/sven/git.git

I have checked it int the gitweb at
  http://git.imendio.com/?p=sven/git.git

> Feel free to look into the changes and request improvements or merge  
> it into your tree.

As far as I can see that is single patch (single commit) on top of
git.git repository, so you could have send this patch to the list,
to be commented upon.

Although having "git submodule diff" is quite nice, I'd rather have
"git diff --recurse-submodules" (or something like that) if I want to
get diff of submodules.

>From browsing commitdiff
  http://git.imendio.com/?p=sven/git.git;a=commitdiff;h=7fa1d4911d1ac2590ab1eccd84a7f235aca7878e
I'd like to mention that instead of

  (unset GIT_DIR && cd "$path" && git diff $flag "$sha1..HEAD")

you can simply use

  git --git-dir="$path" diff $flag "$sha1..HEAD"

Note that you can write "$sha1.." (but it is a bit cryptic)

> PS: Please CC me, I'm not on this list

You can always read list using NNTP / news / Usenet interface at
  nntp://news.gmane.org/gmane.comp.version-control.git
or one of the mailing list archives, see
  http://git.or.cz/gitwiki/GitCommunity

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
