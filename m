From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/21] glossary: define pathspec
Date: Wed, 15 Dec 2010 22:02:41 +0700
Message-ID: <1292425376-14550-7-git-send-email-pclouds@gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSsuP-0000YW-2l
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab0LOPEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:04:42 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60760 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab0LOPEk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:04:40 -0500
Received: by gyb11 with SMTP id 11so1069978gyb.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=D1VgooDBmaAwvI5I1anHVbsWhk9GdwZpTHBi0T71DmY=;
        b=bZKIJKDgjDAwhX5ooE2Efii09JBaGwqvwHbbcURRXwbpzUwE8vl2MskkQJpl5Wb8+S
         1wG1dt9vOKO0YE5V1+XaxCYzgmp3S+T01hB+4xqH+wEFScdpms5fGGJxVdb4vEW5CMGn
         wVbI4PwHt8H/pAlCuq9BiwcJucmInBzeihJG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=T/OPxum1zQQkufnYhUKDvBXPhlY2lAlqWMAfmOm6M10IxPE4R+vWzEThq7MrlSjn1n
         JEqNTHJ8Q4Ziwu2wiaw9C1U90ebQEBN+wBNnYplkm+9XLWUhUOFH2NFt5aDwJ2KQuAyM
         t9XflyzjXgQrnJzHrUkpRr0TnNcfU1fBOOibI=
Received: by 10.150.195.15 with SMTP id s15mr10116309ybf.338.1292425479975;
        Wed, 15 Dec 2010 07:04:39 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id 3sm758555yhl.0.2010.12.15.07.04.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 07:04:39 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 22:03:46 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163761>

=46rom: Jonathan Nieder <jrnieder@gmail.com>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/glossary-content.txt |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index 1f029f8..4ed2a28 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -273,6 +273,29 @@ This commit is referred to as a "merge commit", or=
 sometimes just a
 	<<def_pack,pack>>, to assist in efficiently accessing the contents of=
 a
 	pack.
=20
+[[def_pathspec]]pathspec::
+       Pattern used to specify paths.
++
+Pathspecs are used on the command line of "git ls-files", "git
+ls-tree", "git grep", "git checkout", and many other commands to
+limit the scope of operations to some subset of the tree or
+worktree.  See the documentation of each command for whether
+paths are relative to the current directory or toplevel.  The
+pathspec syntax is as follows:
+
+* any path matches itself
+* the pathspec up to the last slash represents a
+  directory prefix.  The scope of that pathspec is
+  limited to that subtree.
+* the rest of the pathspec is a pattern for the remainder
+  of the pathname.  Paths relative to the directory
+  prefix will be matched against that pattern using fnmatch(3);
+  in particular, '*' and '?' _can_ match directory separators.
++
+For example, Documentation/*.jpg will match all .jpg files
+in the Documentation subtree,
+including Documentation/chapter_1/figure_1.jpg.
+
 [[def_parent]]parent::
 	A <<def_commit_object,commit object>> contains a (possibly empty) lis=
t
 	of the logical predecessor(s) in the line of development, i.e. its
--=20
1.7.3.3.476.g10a82
