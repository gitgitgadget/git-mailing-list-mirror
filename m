From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] nd/attr-match-optim-more updates
Date: Sun, 14 Oct 2012 18:55:38 +0700
Message-ID: <1350215742-20761-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 13:56:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNMnx-0004hG-88
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 13:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab2JNL4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2012 07:56:04 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:44029 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2JNL4C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 07:56:02 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2104032dak.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 04:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=+bpVUP3KWvYo43oTS3N2wX5Kne2oQC/jgqIbPOKDB7w=;
        b=Ap4wvQSnW0Jm0Q0WiDJl9nUg5Vxl3TxBWXFp7QkYUUfUHUo6PnrQ8yR39lhPrK0MyF
         j2pqpP+mlQXaTmNcwUGbvXXMA6nQgaGuyvFVD3lgeGMv2SJuNVoIJy2LtgTb7wAoZtXB
         2hVWRKMPkKT/pH4FN/KjzJ/4igah0wMpS0XvY3L3Z4G7GEfdr7YkDia/jJdCrWbLsINZ
         GePM/3ecankDiy+VwNbSPQnhxuh2giqv3nyck+SkqeIQgMvOW3WnNYvO6AvW/rTNJwJI
         0YAQJNI7Oe9VsgIYz5yKwS88wIXyRhJpZ/up7syzYwOEyG7Euqml3NZxNNh4HXWa1li4
         uVTA==
Received: by 10.68.132.41 with SMTP id or9mr29043556pbb.67.1350215762169;
        Sun, 14 Oct 2012 04:56:02 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.44.221])
        by mx.google.com with ESMTPS id mn5sm7399645pbc.12.2012.10.14.04.55.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 04:56:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 18:55:47 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207656>

This is on top of nd/attr-match-optim-more to fix the bug I sent
recently [1] sharing the code, thus sharing any fixes.

[1] http://thread.gmane.org/gmane.comp.version-control.git/207652

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  exclude: stricten a length check in EXC_FLAG_ENDSWITH case
  exclude: fix a bug in prefix compare optimization
  exclude/attr: share basename matching code
  exclude/attr: share full pathname matching code

 attr.c                             |  50 +++------------
 dir.c                              | 121 +++++++++++++++++++++++------=
--------
 dir.h                              |   5 ++
 t/t3001-ls-files-others-exclude.sh |   6 ++
 4 files changed, 95 insertions(+), 87 deletions(-)

--=20
1.8.0.rc2.11.g2b79d01
