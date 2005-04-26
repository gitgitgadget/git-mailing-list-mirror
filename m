From: "Joshua T. Corbin" <jcorbin@wunjo.org>
Subject: Re: [PATCH] cogito recursive cg-add and cg-rm
Date: Tue, 26 Apr 2005 01:17:19 -0400
Message-ID: <200504260117.20205.jcorbin@wunjo.org>
References: <200504260027.03451.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 26 07:13:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQIOE-0007Tg-WE
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 07:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVDZFSa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 01:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDZFSa
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 01:18:30 -0400
Received: from node1.wunjo.org ([64.62.190.230]:27828 "EHLO node1.wunjo.org")
	by vger.kernel.org with ESMTP id S261290AbVDZFSZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 01:18:25 -0400
Received: by node1.wunjo.org (Postfix, from userid 65534)
	id AFEA742EFC; Tue, 26 Apr 2005 01:18:24 -0400 (EDT)
Received: from [192.168.1.100] (24.238.44.109.res-cmts.tv13.ptd.net [24.238.44.109])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by node1.wunjo.org (Postfix) with ESMTP id 59A1A42B74
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 01:18:22 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: KMail/1.8
In-Reply-To: <200504260027.03451.jcorbin@wunjo.org>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on node1
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=5.0 tests=RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Small one line fix on top of the previos patch, apparently I was too hasty and 
didn't test cg-rm on a single file ;)

Signed-off-by: Joshua T. Corbin <jcorbin@wunjo.org>

Index: cg-rm
===================================================================
--- bb131a04832677b22959ffe47f68900b94accc0c/cg-rm  (mode:100755 
sha1:f2d2e0c042fdf9496d53e833a50d960331e145b4)
+++ 5b396356f2c852f95a4226e955e186f46851a1f0/cg-rm  (mode:100755 
sha1:7701a83878c1e02dbce3abc0e3f1290c56c1be16)
@@ -40,7 +40,7 @@
     shift
   done > $RMFILE
   rm -f $(cat $RMFILE)
-  rmdir $(find $RMDIRS -depth -type d)
+  [ -n "$RMDIRS" ] && rmdir $(find $RMDIRS -depth -type d)
   update-cache --remove -- $(cat $RMFILE)
   rm -f $RMFILE
 else
