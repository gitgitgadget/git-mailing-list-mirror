From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 02:40:36 -0800 (PST)
Message-ID: <20060213104036.67433.qmail@web31811.mail.mud.yahoo.com>
References: <20060213101443.GD11053@mythryan2.michonline.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 11:41:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8b8a-0003C2-Sx
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 11:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWBMKkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 05:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWBMKkk
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 05:40:40 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:4751 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932073AbWBMKkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 05:40:37 -0500
Received: (qmail 67435 invoked by uid 60001); 13 Feb 2006 10:40:36 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xMAOncpWS+Nqj4ibMPiPrbZJSYNaTdpWCRV4YOFJ+px6JuyZbeua3KHRsVq8kH1FjDTi4hC0xlwW/t4q7UROHPGU2NbJj+nyqKXjkAXakPVqAZ+0YvMUNsHAv3x8TLdWORDoM0LVpOp+nDLPms3jay/U9F3Niec7FWaVLJ2stPc=  ;
Received: from [65.74.249.167] by web31811.mail.mud.yahoo.com via HTTP; Mon, 13 Feb 2006 02:40:36 PST
To: Ryan Anderson <ryan@michonline.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060213101443.GD11053@mythryan2.michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16068>

Andrew,

Here is the output:

$ git-diff-tree --pretty -p 386093ef9a6c88576d8b418bf1c8616d5e410a20
diff-tree 386093ef9a6c88576d8b418bf1c8616d5e410a20 (from ce5f8d70ba6e3d7ffcaff86b2cf91a42c27f77af)
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Wed Feb 1 03:04:57 2006 -0800

    [PATCH] ipw2200: fix ->eeprom[EEPROM_VERSION] check
    
    priv->eeprom is a pointer.
    
    Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
    Acked-by: Yi Zhu <yi.zhu@intel.com>
    Cc: James Ketrenos <jketreno@linux.intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
index 916b24c..14beab4 100644
--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -2456,7 +2456,7 @@ static void ipw_eeprom_init_sram(struct 
           copy.  Otherwise let the firmware know to perform the operation
           on it's own
         */
-       if ((priv->eeprom + EEPROM_VERSION) != 0) {
+       if (priv->eeprom[EEPROM_VERSION] != 0) {
                IPW_DEBUG_INFO("Writing EEPROM data into SRAM\n");
 
                /* write the eeprom data to sram */

   Luben
