From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/4] nd/invalidate-i-t-a-cache-tree
Date: Sun, 16 Dec 2012 11:15:24 +0700
Message-ID: <1355631328-26678-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 05:15:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk5dY-0004J7-Ms
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 05:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443Ab2LPEPD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Dec 2012 23:15:03 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab2LPEPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 23:15:01 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3258633pbc.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 20:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=xLaPFT5sGzrWuFSKOP3RGT7n0UwlsaHrh/zl/hgiDJo=;
        b=vpFD1ZTxki1hq4If/fg8k3zlKs0pQshMSu/ROSLimDCIRQMtooQiNYoaqTBc7WQzqp
         JZ/fMt+gel2IyTOUJg4HaBe9vzx9tbLLn5Lnqt8UBws/Xqs2sfx8p+SJI+WkEL1Fz+/R
         dkEGEga09+ym0LFXn0uUVTxuNpEsBAVtBNsIvNSdNpw/3W/AILwPNmysOSmOxMgkQN1e
         XbXThXXIFTBfoQkx96BMaSPf4XZ3cmUG94sutgYr13y/AUukoZ7QN7g3fJTSTFCJPtgZ
         KoGOsbLGQ9RSCJh6I9sD4ZRmxVkncWKHKWNYQN5x7Xta1ckmclcWED7SHLHcTSlGKl9B
         ZMEA==
Received: by 10.66.76.41 with SMTP id h9mr30227799paw.1.1355631300629;
        Sat, 15 Dec 2012 20:15:00 -0800 (PST)
Received: from lanh ([115.74.41.198])
        by mx.google.com with ESMTPS id i3sm6061951pav.18.2012.12.15.20.14.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 20:14:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Dec 2012 11:15:37 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211576>

This version also fixes the CE_REMOVE bug I mentioned. As a side
effect, the bug fix makes the i-t-a fix cleaner.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  cache-tree: remove dead i-t-a code in verify_cache()
  cache-tree: replace "for" loops in update_one with "while" loops
  cache-tree: fix writing cache-tree when CE_REMOVE is present
  cache-tree: invalidate i-t-a paths after generating trees

 cache-tree.c          | 61 +++++++++++++++++++++++++++++++++++++------=
--------
 cache-tree.h          |  1 +
 t/t2203-add-intent.sh | 20 +++++++++++++++++
 3 files changed, 65 insertions(+), 17 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df
