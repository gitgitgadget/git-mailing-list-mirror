From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/4] fsck improvements
Date: Mon,  7 Nov 2011 09:59:22 +0700
Message-ID: <1320634766-24511-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stephen Boyd <bebarino@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 04:00:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNFS9-0007wa-Te
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 04:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab1KGDAt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 22:00:49 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56982 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab1KGDAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 22:00:49 -0500
Received: by iage36 with SMTP id e36so5337621iag.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 19:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=WEYJuiHBGcHVH+EmyqGL6/b2lqCDH41Aacd+QJ4/+K8=;
        b=FFcZBjTS2f2Nlil192hOvUXrMTq/uVKqrDbIk6THzKK0pFgfcKAcs9GgrzBPNgAkUm
         oZP5u49f1XVUNac5kfV10/UF4odnoFQNwjnpnrJ/dq9JMnESXG/ITN02kJQdK+Cmi9Sk
         dwuTQfsREMW9jS+tXYC3nJ2F5E38gGQJZUvmo=
Received: by 10.231.45.9 with SMTP id c9mr9706882ibf.73.1320634848457;
        Sun, 06 Nov 2011 19:00:48 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.230.110])
        by mx.google.com with ESMTPS id a4sm20250911pbd.7.2011.11.06.19.00.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 19:00:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 07 Nov 2011 09:59:27 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184939>

2/4 is updated to check as many objects as possible.
4/4 has new doc update and explains why --verbose turn progress off

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  fsck: return error code when verify_pack() goes wrong
  verify_packfile(): check as many object as possible in a pack
  fsck: avoid reading every object twice
  fsck: print progress

 Documentation/git-fsck.txt |   11 ++++++-
 builtin/fsck.c             |   78 +++++++++++++++++++++++++++++++++++-=
--------
 pack-check.c               |   28 +++++++++++-----
 pack.h                     |    6 +++-
 4 files changed, 96 insertions(+), 27 deletions(-)

--=20
1.7.4.74.g639db
