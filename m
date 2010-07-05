From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Makefile: work around ksh's failure to handle missing
 list argument to for loop
Date: Mon, 05 Jul 2010 11:31:08 +0200
Message-ID: <4C31A65C.7030002@drmicha.warpmail.net>
References: <80typu1ozt.fsf@tiny.isode.net> <8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil> <4C30D4D5.3020900@drmicha.warpmail.net> <4C31796E.9050109@viscovery.net> <4C319478.4070903@drmicha.warpmail.net> <4C31A298.1030005@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	git@vger.kernel.org, PWalker752@aol.com, newsletter@dirk.my1.cc,
	bruce.stephens@isode.com, Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 11:32:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVi25-0007wP-Bm
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 11:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425Ab0GEJcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 05:32:04 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54938 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751299Ab0GEJcC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 05:32:02 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E0CD7115DB7;
	Mon,  5 Jul 2010 05:32:00 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 05 Jul 2010 05:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=cRYc+8u2sQQlrYq62D1KDhfHpfA=; b=szJMwkQcHI/8uwMN71acmGzT++BQtGaHIlq8iMcv0vx5DCU7fSC5VFgiS8MtKheG19M31WP9AnCnc+2/ekQ1OXxMwxBbrU5ex083tKLSAZh4LbPvf8qK0ODEFe3Y5E1hHjVmvKS97tM9rSKdYLcBO7QnKxFq/iXByH6Pgag418Q=
X-Sasl-enc: xHt4HdbtRJBqrAZwfa4csxPeYyBrSjF0OfgJdne05oYK 1278322320
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A39804F419D;
	Mon,  5 Jul 2010 05:31:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <4C31A298.1030005@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150253>

Johannes Sixt venit, vidit, dixit 05.07.2010 11:15:
> Am 7/5/2010 10:14, schrieb Michael J Gruber:
>> BTW: Is the $$var gmake specific?
> 
> No. $ is a (special?) make variable that contains only a dollar sign. To
> expand the variable in the Makefile, you have to write $$ (like for any
> other Makefile variable whose name has only a single character, like $@,
> $<, etc). As a result, you get a single dollar sign in the shell command
> text. :-)

I guess I need this in my personal tree:

diff --git a/Michael b/Michael
index 5318944..2ff6a75 100644
--- a/Michael
+++ b/Michael
@@ -0815,2 +0815,2 @@ endif

-stupid remark about lower case
-stupid question about escaping $
+compensate for lack of morning coffee
+note that an empty shell var is more than nothing at all

Michael
