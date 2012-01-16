From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] nd/commit-ignore-i-t-a replacement
Date: Mon, 16 Jan 2012 09:36:45 +0700
Message-ID: <1326681407-6344-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 03:37:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmcRl-0006aA-QH
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 03:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab2APChA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 21:37:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57717 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab2APCg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 21:36:59 -0500
Received: by iagf6 with SMTP id f6so1796054iag.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 18:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=KCS0o8ungjYvzXOhyAWzRyS8IyP/jw2+JFzqbkhjpwU=;
        b=MZ3X4cwDqSHUQfa4aNkRZVwgyMg2kBvJP5epY6+ss26MuWDjc5gaRo7cU/BU6cjl3J
         zLImLRl+z7fhYhYiXtzP6cq1ubY5oVv3rC0a3X/jtLL25jHG6jl3+aRejmWMsP5WNr6W
         rqCVi2CyPY01KX+P4rR6q2ORhwalVVtS7TzqU=
Received: by 10.50.188.166 with SMTP id gb6mr10950870igc.18.1326681418765;
        Sun, 15 Jan 2012 18:36:58 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ba5sm14197778igb.6.2012.01.15.18.36.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 18:36:57 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 09:36:48 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188606>

This replaces current topic branch in pu with a more sensible
approach using config key. write-tree also learns about this.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  cache-tree: update API to take abitrary flags
  commit, write-tree: allow to ignore CE_INTENT_TO_ADD while writing
    trees

 Documentation/config.txt         |    5 +++++
 Documentation/git-add.txt        |   12 ++++++++++--
 Documentation/git-write-tree.txt |    8 +++++++-
 builtin/commit.c                 |   13 ++++++++++---
 builtin/write-tree.c             |    2 ++
 cache-tree.c                     |   35 +++++++++++++++++-------------=
-----
 cache-tree.h                     |    5 ++++-
 merge-recursive.c                |    2 +-
 t/t2203-add-intent.sh            |   30 ++++++++++++++++++++++++++++++
 test-dump-cache-tree.c           |    2 +-
 10 files changed, 87 insertions(+), 27 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
