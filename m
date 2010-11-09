From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: document show -s
Date: Tue, 9 Nov 2010 11:12:48 -0600
Message-ID: <20101109171248.GG18960@burratino>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288711888-21528-8-git-send-email-Matthieu.Moy@imag.fr>
 <4CD97399.4010704@gnatter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Eli Barzilay <eli@barzilay.org>,
	Junio C Hamano <gitster@pobox.com>
To: Will Hall <will@gnatter.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 18:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFrky-0000v5-P4
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 18:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab0KIRNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 12:13:10 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35610 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab0KIRNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 12:13:08 -0500
Received: by ewy7 with SMTP id 7so3706403ewy.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 09:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3UO6PE2mYxj5F5vxx9uqWnwaeg7gHi3SfBE8FC4c1nk=;
        b=OkNnhcqzk+g36YD29eOvh4NwVxNbWweaYqc/ZNNJX4/ofPv3yAL2WvoWhlVQPhliob
         kCOfK0oz/tg233d2lF/85ziREfrnHns9Ke29tp+3PeJHGb3a4q8setHQVJfhBQPx8/ux
         LKhaqW9vru/w3Da8mCsJyH3OEdVHXpUz3Qxn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rXd/IiiyCyfErZiwTpc0r1jH651b2VukgQ34hfs4PVmQQGU+PEJ0zCPaUtyvVSRfIj
         woow/8qcTEKR2iWR42gZDBqhXlPBjlRFb/buuHEa74wvviP8i5wMJW7CdcTi5qeS6yOJ
         /ExnlUdEh85WfaL1AtysDjY3aNmf2qZSo1oB0=
Received: by 10.213.13.3 with SMTP id z3mr5536621ebz.28.1289322787317;
        Tue, 09 Nov 2010 09:13:07 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l23sm805513fam.19.2010.11.09.09.13.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 09:13:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CD97399.4010704@gnatter.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161060>

Git's diff machinery has supported a -s (silence diff output) option
as far back as v0.99~900 (Silent flag for show-diff, 2005-04-13), but
the option is only advertised in an odd corner of the git diff-tree
manual.

The main use is to retrieve basic metadata about a commit:

	git show -s rev

Explain this in the 'git log' manual and provide an example in the
'git show' examples section.  This is kind of a cop-out, since it
would be more useful to explain it in the 'git show' manual proper,
which says:

	The command takes options applicable to the git
	diff-tree command to control how the changes the
	commit introduces are shown.

	This manual page describes only the most frequently
	used options.

Fixing that is a larger task for another day.

Reported-by: Will Hall <will@gnatter.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Will Hall wrote:

> I know this should be obvious but I can't find *any* reference to
> this in git show --help

Thanks, good catch.

 Documentation/git-show.txt         |    4 ++++
 Documentation/rev-list-options.txt |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 2049c60..f0a8a1a 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -54,6 +54,10 @@ git show v1.0.0::
 git show v1.0.0^\{tree\}::
 	Shows the tree pointed to by the tag `v1.0.0`.
 
+git show -s --format=%s v1.0.0^\{commit\}::
+	Shows the subject of the commit pointed to by the
+	tag `v1.0.0`.
+
 git show next~10:Documentation/README::
 	Shows the contents of the file `Documentation/README` as
 	they were current in the 10th last commit of the branch
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7a42567..1aaaf5a 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -146,6 +146,9 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 -t::
 
 	Show the tree objects in the diff output. This implies '-r'.
+
+-s::
+	Suppress diff output.
 endif::git-rev-list[]
 
 Commit Limiting
-- 
1.7.2.3.557.gab647.dirty
