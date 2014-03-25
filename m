From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 18/25] setup.c: support multi-checkout repo setup
Date: Tue, 25 Mar 2014 21:07:10 +0700
Message-ID: <20140325140710.GA25789@lanh>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-19-git-send-email-pclouds@gmail.com>
 <5330469D.9020008@web.de>
 <CACsJy8DQ16xd+LOki0pxDVwPyWJ_hYLqJjW4-4VXa92yo1rD1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 15:06:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSRzi-0007LG-RP
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 15:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbaCYOGS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 10:06:18 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:36448 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbaCYOGS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 10:06:18 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so505994pbb.0
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g5U6Klr12LtKlv3T1wnVERy74IOFeTBqIM9qYSo7FRI=;
        b=qiIdbugBSyuM1I7ju2mJ4zX94l6/ce0NfIWrWO/W/fzo+cHVrBkseKgpMRgJ39rHEd
         NMSAKI8eNYSmkassYYR49gZgD7/fCLWvPTm6uONaob8JJb8Gi5jFTvIa3of3bjXi2BwY
         fGIDzqMv7jmdeauUqHHREydoHtWvV3nsmmRDOYTGDbOBWE3S/pzkUTx2q1afoDNUEaMS
         YpJhTKN7OHuyR0vOazHdWem52kOcKUVQ3bUuJzdQ7Us5c/YRSW4CuxVOps4QEfxfFieY
         oV18oROK1zJ+Gnn9Yy9QbLkQCGFgDiscDc9ZlfCKje+crDZfcQ4TPBufZh5cyBmvyfoI
         zltw==
X-Received: by 10.66.11.66 with SMTP id o2mr11139568pab.142.1395756377595;
        Tue, 25 Mar 2014 07:06:17 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id vf7sm45151741pbc.5.2014.03.25.07.06.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 07:06:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 25 Mar 2014 21:07:10 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8DQ16xd+LOki0pxDVwPyWJ_hYLqJjW4-4VXa92yo1rD1A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245038>

On Tue, Mar 25, 2014 at 08:52:13PM +0700, Duy Nguyen wrote:
> On Mon, Mar 24, 2014 at 9:52 PM, Torsten B=F6gershausen <tboegi@web.d=
e> wrote:
> > Did I report that t1501  fails when  there is a softlink in $PWD ?
> > /home/tb/projects is a softlink to /disc5/projects/
>=20
> Yes you did and I forgot. I have fixed it, running test suite and wil=
l
> send the reroll soon.

Junio, it seems you have picked up all minor changes after
v5. Resending the whole series for one fix seems overkill. Could you
just --autosquash this one in?

-- 8< --
Subject: [PATCH] fixup! setup.c: support multi-checkout repo setup

---
 t/t1501-worktree.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 2ac4424..e6ac7a4 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -359,7 +359,7 @@ test_expect_success 'GIT_DIR set (1)' '
 	(
 		cd work &&
 		GIT_DIR=3D../gitfile git rev-parse --git-common-dir >actual &&
-		echo "$TRASH_DIRECTORY/repo.git" >expect &&
+		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
 		test_cmp expect actual
 	)
 '
@@ -370,7 +370,7 @@ test_expect_success 'GIT_DIR set (2)' '
 	(
 		cd work &&
 		GIT_DIR=3D../gitfile git rev-parse --git-common-dir >actual &&
-		echo "$TRASH_DIRECTORY/repo.git" >expect &&
+		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
 		test_cmp expect actual
 	)
 '
@@ -381,7 +381,7 @@ test_expect_success 'Auto discovery' '
 	(
 		cd work &&
 		git rev-parse --git-common-dir >actual &&
-		echo "$TRASH_DIRECTORY/repo.git" >expect &&
+		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
 		test_cmp expect actual &&
 		echo haha >data1 &&
 		git add data1 &&
@@ -399,7 +399,7 @@ test_expect_success '$GIT_DIR/common overrides core=
=2Eworktree' '
 	(
 		cd work &&
 		git rev-parse --git-common-dir >actual &&
-		echo "$TRASH_DIRECTORY/repo.git" >expect &&
+		test-path-utils real_path "$TRASH_DIRECTORY/repo.git" >expect &&
 		test_cmp expect actual &&
 		echo haha >data2 &&
 		git add data2 &&
--=20
1.9.1.345.ga1a145c
-- 8< --
