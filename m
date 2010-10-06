From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH] git.txt: document limitations on non-typical repos (and hints)
Date: Wed,  6 Oct 2010 21:21:38 +0700
Message-ID: <1286374898-3694-1-git-send-email-pclouds@gmail.com>
References: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: weigelt@metux.de, spearce@spearce.org, jrnieder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, raa.lkml@gmail.com,
	Junio C Hamano <gitster@pobox.com>, judge.packham@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 06 16:22:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3UsX-00033E-RV
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 16:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759054Ab0JFOVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 10:21:53 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:58257 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765Ab0JFOVw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 10:21:52 -0400
Received: by pxi10 with SMTP id 10so1923104pxi.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WpyJvk2Tovi//gajwcnLeLoTVdHWRGK6Pok121vo3cY=;
        b=U2JelPgZkAk6t8ulvJFifABrPZEB/Df/IEnaeUJr8f2S15GzMiA5wqp4GltjDvVJwI
         yXPuOVMmiOCA8oWti9tvosWm5t+0bMeFF3So5VyYs3UL2KaxvUQblXGSGdjePhAOFjiX
         rrHyr7ZTWc4mYWNuzOXiguceS5WiwWg5r6Adw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=C5rWvkE83ADhojWGD6YtBUbQjckcN8ycK0g2J6A1YLIdf5NM1ymSNQNLb8KMS07tYK
         iizW6/BOKUNEpaaUnuWgMGUzFTudQCTALp9F593dMnzZRsCG3ayGPVBDY1BCdTLeiJp1
         QMor/Z7FoMlgy7jqJkfZx1g+JGBmhF8HGkdQ4=
Received: by 10.142.245.16 with SMTP id s16mr2559959wfh.76.1286374910945;
        Wed, 06 Oct 2010 07:21:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.218.98])
        by mx.google.com with ESMTPS id q6sm1491851waj.22.2010.10.06.07.21.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 07:21:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  6 Oct 2010 21:21:39 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158289>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I wanted to make a more detailed description, per command. It would
 serve as guidance for people on special repos, also as TODOs for Git
 developers. But that seems a lot of work on analyzing each commands.

 Instead I made this text to warn users where performance may decrease,
 and to hint them features that might help. Do I miss anything?

 There were discussions in the past on maintaining large files out-of-r=
epo,
 and symlinks to them in-repo. That sounds like a good advice, doesn't =
it?

 Documentation/git.txt |   46 +++++++++++++++++++++++++++++++++++++++++=
+++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index dd57bdc..8408923 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -729,6 +729,52 @@ The index is also capable of storing multiple entr=
ies (called "stages")
 for a given pathname.  These stages are used to hold the various
 unmerged version of a file when a merge is in progress.
=20
+Performance concerns
+--------------------
+
+Git is written with performance in mind and it works extremely well
+with its typical repositories (i.e. source code repositories, with
+a moderate number of small text files, possibly with long history).
+Non-typical repositories (huge number of files, or very large
+files...) may experience performance degradation. This section describ=
es
+how Git behaves in such repositories and how to reduce impact.
+
+For repositories with really long history, you may want to work on
+a shallow clone of it (see linkgit:git-clone[1], option '--depth').
+A shallow repository does not contain full history, so it may consume
+less disk space and network bandwidth. On the other hand, you cannot
+fetch from it. And obviously you cannot look further back than what
+it has in history (you can deepen history though).
+
+For repositories with a large number of files, but you only need
+a few of them present in working tree, you can use sparse checkout
+(see linkgit:git-read-tree[1], section 'Sparse checkout'). Sparse
+checkout can be used with either a normal repository, or a shallow
+one.
+
+Git uses lstat(3) to detect changes in working tree. A huge number
+of lstat(3) calls may impact performance, especially on systems with
+slow lstat(3). In some cases you can reduce the number of lstat(3)
+calls by specifying what directories you are interested in, so no
+lstat(3) outside is needed.
+
+For repositories with a large number of files, you need all of them
+present in working tree, but you know in advance only a few of them
+may be modified, please consider using assume-unchanged bit (see
+linkgit:git-update-index[1]). This helps reduce the number of lstat(3)
+calls.
+
+Some Git commands need entire file content in memory to process.
+You may want to avoid using them if possible on large files. Those
+commands include:
+
+* All checkout commands (linkgit:git-checkout[1],
+  linkgit:git-checkout-index[1], linkgit:git-read-tree[1],
+  linkgit:git-clone[1]...)
+* All diff-related commands (linkgit:git-diff[1],
+  linkgit:git-log[1] with diff, linkgit:git-show[1] on commits...)
+* All commands that need file conversion processing
+
 Authors
 -------
 * git's founding father is Linus Torvalds <torvalds@osdl.org>.
--=20
1.7.0.2.445.gcbdb3
