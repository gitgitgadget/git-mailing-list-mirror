From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v3 0/3] Tests for merge-recursive rename-options
Date: Tue, 23 Feb 2016 22:41:28 -0300
Message-ID: <1456278091-6564-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 02:43:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYOUU-0004UT-On
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 02:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbcBXBnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 20:43:43 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35296 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbcBXBnm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 20:43:42 -0500
Received: by mail-qk0-f178.google.com with SMTP id o6so1661487qkc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 17:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ZmZ5I6stS/J7UrkoeHSqoLUPftJVpQY8hlEW+7Aod6Y=;
        b=cauEQg8YRW/FpIF/nQA4/FE2/bv3vhy0mYT2BTB8XksTOMzcjlP4d1ZYxfkanEuf/i
         nY+f/LdamRgc/idm8oOsyqv/w9THbVHwmIqnZswwj2+CKKgpsnxHmj7qSrAu1QjHp8nw
         Sr7C+cMDEx5UxZSBtqkxexulkEB0ZLkHLNhDAF2QIVsvlrzvrxed1Jy2sKBWlCBeU5Hx
         41l3lEJpBBhNEe6odBOCeFgAnMc/x6qiToi10vDWnpVEdAs0ZB9pUiMrw+VR/bJFHTDu
         O9pW0aJUb7+Z1iX1CauRrhodSKLgaj+IckKoZFlhyNJKA1zXyvP7019ghpHitADDK6+m
         aj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=ZmZ5I6stS/J7UrkoeHSqoLUPftJVpQY8hlEW+7Aod6Y=;
        b=W1yGqLmnMFIDB2UQ0ta2JpWScKGKqHn3wbYAZ+c0fSvmWc+JTincHDtM/pYtd9tHth
         yvGusSLHYvOCzJhz9FAmQSm222pp520iQLw1XpqYvxeKgeIv9OU2FbpaK/1whgfGaJzn
         kAoClBVoJMx2SbFfAz9UhGlKN+84TYppT1XNDnZyGFzIaAnTeaXGw41YkvqFSWUCMtOT
         oRWqxEnZOzbTlKx86XpoV3HXjcGrVURbISxyCzUX66m1FxvYb5lCTz71/3xWtfbIN5yT
         Y48MC3htNq8onVtM9POXipvYR4MLnfW06EVtF/ROzN+9P56zQ2D4pF5UtnLhPELOm2G6
         zj4Q==
X-Gm-Message-State: AG10YOT5x4o7AG5COB77XB7/Sy7Lyn9QxUH+4HCN1eks9XfJLng9gAf0/gMGIva9Gn7uUg==
X-Received: by 10.55.221.18 with SMTP id n18mr14009934qki.50.1456278221958;
        Tue, 23 Feb 2016 17:43:41 -0800 (PST)
Received: from traveller.moon (189-19-119-165.dsl.telesp.net.br. [189.19.119.165])
        by smtp.gmail.com with ESMTPSA id e127sm271155qkb.34.2016.02.23.17.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 17:43:41 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287156>

Just a quick update incorporating Eric's latest comments.

Still based on
c443d39 (merge-recursive: find-renames resets threshold, 2016-02-21).

=46elipe Gon=C3=A7alves Assis (3):
  t3034: add rename threshold tests
  t3034: test option to disable renames
  t3034: test deprecated interface

 ...s.sh =3D> t3032-merge-recursive-space-options.sh} |   2 +-
 t/t3034-merge-recursive-rename-options.sh          | 312 +++++++++++++=
++++++++
 2 files changed, 313 insertions(+), 1 deletion(-)
 rename t/{t3032-merge-recursive-options.sh =3D> t3032-merge-recursive-=
space-options.sh} (99%)
 create mode 100755 t/t3034-merge-recursive-rename-options.sh

--=20
2.7.1.492.gd821b20
