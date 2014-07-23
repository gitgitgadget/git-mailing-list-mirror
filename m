From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] nd/multiple-work-trees follow-ups
Date: Wed, 23 Jul 2014 18:43:10 +0700
Message-ID: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 13:44:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9uxs-00028X-L7
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 13:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757414AbaGWLoD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 07:44:03 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:49585 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbaGWLoB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 07:44:01 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so1449705pde.18
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 04:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=3JRuUNsOYorYk+HBVp3NZKnOLelYq+dSHXSz62vVhcE=;
        b=oVp6bIGOR5jk5w0ggbPYEtWwqJh/P6NJe03I+ymKcaTJMTaC/TR92Y4dHdH5x+L9uI
         pysnO0lUyB60d4O7jn+R8fGZAA6DdMjurn5VaYxcP59TrHeEacDHz+/yyqV2QXe+ib0+
         8CUERsW73LjhSFaa2NlqCFXZ07aHvkUlsz1R6YtqMVpapx11KgBqVB7Suig6e8jLOVwA
         fVlVWhqzjKMe/tIeowVijbMimAYI09O+AdjfGEyxM2EQYFIDeGLEJQYBVzYz4VEI+q8H
         HZDBAegdQIKn4I+IMemNOY0Bgtiq2xpxLRjU45Q0O71YlFe7Rjwnwhr9ALd9pXa4VVPM
         vl/w==
X-Received: by 10.66.174.199 with SMTP id bu7mr945938pac.54.1406115836499;
        Wed, 23 Jul 2014 04:43:56 -0700 (PDT)
Received: from lanh ([115.73.248.125])
        by mx.google.com with ESMTPSA id rb8sm8011831pab.27.2014.07.23.04.43.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2014 04:43:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 23 Jul 2014 18:43:50 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254063>

The series has entered 'next' so I can't replace patches any more.
Besides the brown paper bag fixes, checkout now rejects if a branch is
already checked out elsewhere.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  gitrepository-layout.txt: s/ignored/ignored if/
  prune --repos: fix uninitialized access
  checkout --to: no auto-detach if the ref is already checked out
  checkout --to: fix dangling pointers in remove_junk()
  environment.c: fix incorrect git_graft_file initialization

 Documentation/config.txt               |  3 ++
 Documentation/gitrepository-layout.txt |  6 +--
 advice.c                               |  2 +
 advice.h                               |  1 +
 builtin/checkout.c                     | 88 ++++++++++++++++++++------=
--------
 builtin/prune.c                        | 16 +++----
 environment.c                          |  2 +-
 t/t0060-path-utils.sh                  |  1 +
 t/t2025-checkout-to.sh                 | 40 ++++++++++++----
 t/t2026-prune-linked-checkouts.sh      |  2 +-
 10 files changed, 102 insertions(+), 59 deletions(-)

--=20
1.9.1.346.ga2b5940
