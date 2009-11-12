From: Niko Schwarz <niko.schwarz@googlemail.com>
Subject: git svn show-ignore bug?
Date: Thu, 12 Nov 2009 12:13:20 +0100
Message-ID: <01C132B1-3CEE-4EF2-A4BC-5C1D71088FBF@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 12:14:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Xct-0000CR-10
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 12:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbZKLLNS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 06:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbZKLLNR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 06:13:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:20993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZKLLNR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 06:13:17 -0500
Received: by fg-out-1718.google.com with SMTP id e12so859803fga.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 03:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version:x-mailer;
        bh=61StuYaPDCmigLj3UR3h/ePDASYh+RxmGlNGSO0T4ko=;
        b=FFx0RXO+kSFP0bWVZ8XcQ32ActS8UmmY82COaJGXR54F4ZThN8hbe6fAu8RBH02xYG
         yS1xaNvi/9yQxWlEWZu0Z6zRzfyPggQ75VMLlJS5lvErQQfejXcoi1bTb0Ufkn0uPS65
         fvzXU6WD5ZPqWSW4C+mBld+6oXcm5LVYLUCwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer;
        b=UQXJbZf8TvhLnn47IzN821nY1rQ1XVRWthywlZJj2YjRnLmnprNSvnZ7jlwdvB5PSl
         BJ4GRaldUu+Wq82hwItO5/87JA5k8IcdegHIJmZ9wRj3/uPjPFhI4lfsKei98L89nmO0
         qcVqgdf9RuejGZ5wWdSGYTrYN3kenETpyBQLo=
Received: by 10.86.11.26 with SMTP id 26mr1987164fgk.72.1258024401839;
        Thu, 12 Nov 2009 03:13:21 -0800 (PST)
Received: from iamwlan45.unibe.ch (iamwlan45.unibe.ch [130.92.209.45])
        by mx.google.com with ESMTPS id e20sm6634794fga.15.2009.11.12.03.13.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 03:13:21 -0800 (PST)
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132763>

Hi there, in the IRC channel today, someone asked me to report this =20
behavior to you because they suspect a bug in show-ignore.

Ok, so here's the output of git svn info:

Path: .
URL: https://www.iam.unibe.ch/scg/svn_repos
Repository Root: https://www.iam.unibe.ch/scg/svn_repos
Repository UUID: 54883e8d-cf1d-0410-83d6-f114b9419f37
Revision: 29639
Node Kind: directory
Schedule: normal
Last Changed Author: oscar
Last Changed Rev: 29639
Last Changed Date: 2009-11-12 11:22:35 +0100 (Do, 12 Nov 2009)


I can do git svn rebase, git svn fetch, and those things work. =20
Dcommit, works, too. But git svn show-ignore >> .gitignore does not =20
work.

This is the dialog with the system:
Nikos-Mbp-3:svn_repos niko$ git svn show-ignore >> .gitignore
Authentication realm: <https://www.iam.unibe.ch:443> SCG Subversion =20
Repository
Password for 'schwarz':
Authentication realm: <https://www.iam.unibe.ch:443> SCG Subversion =20
Repository
Username: schwarz
Password for 'schwarz':
Authentication realm: <https://www.iam.unibe.ch:443> SCG Subversion =20
Repository
Username: schwarz
Password for 'schwarz':
Autorisierung schlug fehl: PROPFIND von =BB/scg/svn_repos/IAM=AB: =20
Autorisierung schlug fehl: Could not authenticate to server: rejected =20
Basic challenge (https://www.iam.unibe.ch) at /opt/local/libexec/git-=20
core/git-svn line 2276


That's all the info I have, I'm afraid. I'm sure that the password is =20
correct, as it works from XCode.

Thanks in advance, cheers,

Niko
