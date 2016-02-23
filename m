From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH 0/3] Tests for merge-recursive rename options
Date: Tue, 23 Feb 2016 01:38:42 -0300
Message-ID: <1456202325-6037-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 05:41:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY4md-0007PB-8X
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 05:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270AbcBWElB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 23:41:01 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34703 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757262AbcBWElA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 23:41:00 -0500
Received: by mail-vk0-f47.google.com with SMTP id e185so150559022vkb.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 20:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=4u34GfHOgxkfO+WLtE5iVH+vmrNysu8lNvd4wFISN9g=;
        b=H4rOMlBSqgnasant1JZfpAnFJl6A5ms5EJ3rRx+9/LmmKknUOJwHqY+x4+FnQXWSkq
         J+jePhfLnHsNJyVukDnh3gCOsblqonYU02Frci/ueiQOCbsPD0etpo1bVn9lEqDWkm8H
         n5B4sK4IDQ14VIksrldMAisz3tTFGXvKcKa3WVs4tAZQe9fHhrjMeS/WLcys386P7RgT
         rpbt8PfjHDlPBVfEC+zk2gMYEM5fV+1iOd82ilf+3sKCulSx6ubBMqB41ZR7LY7hTEu3
         Cc2kFKyZ7ZWsXDPeqc14WRMP20qdCVITwQTlOWanE8mgXJ8c3mBh5BFItHyY/JFux1Kg
         maoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=4u34GfHOgxkfO+WLtE5iVH+vmrNysu8lNvd4wFISN9g=;
        b=ms+XY1M2eCiVBvJL4wgUQRwxe0l/wT8wHCnW/ic7HUjeDvHNsGAk3mLnYSMO+QM6Wu
         jwgdpmvrsvAFKIal2oyG+V4dGQUAhuLft2g6ED6Dr2CGnQbRkq+7IPVA1LG1mbaZj3+y
         AFcQzUha2UoC8/TWnxzXx2ZvTCn4LZwGaSkPjOoOYYQPxRgV7VIPK2Zbj0g2KZNJ3yzj
         99DlnywAdtuzSwE/1oKofH/GCAgkk9s4F4ZPQ2+HViyYj4+UJ90crVctRRfEqwTJfmwT
         4dsG4UAh+Ru89X/WKUyX1zjmEg2MOuUX8wGBvDHKWP2b4/2PfkwH1v6+A5oPp2UP/R1y
         aPMQ==
X-Gm-Message-State: AG10YORspLdRozaYVk4EvDdoHy6xHfw+g3HnGQ0xy+cyuiFF4fDTSs2J675cF3A8pbPgDQ==
X-Received: by 10.31.128.82 with SMTP id b79mr26306821vkd.47.1456202459301;
        Mon, 22 Feb 2016 20:40:59 -0800 (PST)
Received: from traveller.moon (201-43-158-89.dsl.telesp.net.br. [201.43.158.89])
        by smtp.gmail.com with ESMTPSA id o141sm3772201vkd.19.2016.02.22.20.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 20:40:58 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.492.gd821b20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287010>

Based on c443d39 (merge-recursive: find-renames resets threshold, 2016-=
02-21).

This patch involves only the tests for the features introduced in
fa/merge-recursive-no-rename, for better review.

The tests were rewritten so that the similarity indices are parsed inst=
ead of
assumed.

=46elipe Gon=C3=A7alves Assis (3):
  t3034: add rename threshold tests
  t3034: test option to disable renames
  t3034: test deprecated interface

 ...s.sh =3D> t3032-merge-recursive-space-options.sh} |   2 +-
 t/t3034-merge-recursive-rename-options.sh          | 309 +++++++++++++=
++++++++
 2 files changed, 310 insertions(+), 1 deletion(-)
 rename t/{t3032-merge-recursive-options.sh =3D> t3032-merge-recursive-=
space-options.sh} (99%)
 create mode 100755 t/t3034-merge-recursive-rename-options.sh

--=20
2.7.1.492.gd821b20
