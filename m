From: maximilian attems <max@stro.at>
Subject: send-email sends twice on uppercase email adresses
Date: Fri, 13 Jun 2008 13:53:09 +0200
Message-ID: <20080613115309.GD7212@baikonur.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 13:56:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K77tR-0001Tw-3y
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 13:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbYFMLzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 07:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbYFMLzi
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 07:55:38 -0400
Received: from baikonur.stro.at ([213.239.196.228]:37667 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbYFMLzi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 07:55:38 -0400
Received: by baikonur.stro.at (Postfix, from userid 1001)
	id D5E575C00B; Fri, 13 Jun 2008 13:53:09 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by Amavis (ClamAV) at stro.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84868>

below email got send twice to mario,
1x would be enough, expand_aliases should probably just lc the email

----- Forwarded message from maximilian attems <max@stro.at> -----

X-Original-To: max@stro.at
From: maximilian attems <max@stro.at>
To: "David S. Miller" <davem@davemloft.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	Mario Limonciello <Mario_Limonciello@dell.com>,
	Mario Limonciello <Mario_Limonciello@Dell.com>,
	Tim Gardner <tim.gardner@canonical.com>,
	maximilian attems <max@stro.at>
Subject: [PATCH] hci_usb: Blacklist Bluetooth Dell Wireless 370 for SCO MTU
Date: Fri, 13 Jun 2008 13:47:19 +0200

From: Mario Limonciello <Mario_Limonciello@dell.com>

Add Dell Wireless 370 device to blacklist to enable SCO MTU workaround.

fixes report
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/209715

Signed-off-by: Mario Limonciello <Mario_Limonciello@Dell.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: maximilian attems <max@stro.at>
---
 drivers/bluetooth/hci_usb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/hci_usb.c b/drivers/bluetooth/hci_usb.c
index d73e513..e9eef9a 100644
--- a/drivers/bluetooth/hci_usb.c
+++ b/drivers/bluetooth/hci_usb.c
@@ -134,6 +134,8 @@ static struct usb_device_id blacklist_ids[] = {
 
 	/* Dell laptop with Broadcom chip */
 	{ USB_DEVICE(0x413c, 0x8126), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	/* Dell Wireless 370 */
+	{ USB_DEVICE(0x413c, 0x8156), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 
 	/* Microsoft Wireless Transceiver for Bluetooth 2.0 */
 	{ USB_DEVICE(0x045e, 0x009c), .driver_info = HCI_RESET },
-- 
1.5.5.3


----- End forwarded message -----
