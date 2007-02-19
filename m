From: Andy Parkins <andyparkins@gmail.com>
Subject: Numeric constants as strings
Date: Mon, 19 Feb 2007 09:16:34 +0000
Message-ID: <200702190916.35813.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 10:16:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ4dZ-0003xh-TG
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 10:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbXBSJQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 04:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXBSJQn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 04:16:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:15582 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbXBSJQm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 04:16:42 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2367303nfa
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 01:16:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UK2xGdw9PLOHQ7x9wHIg0XXvAqagdF4oxCxte1+5LmB1TnUflKHesetiwVWP1nwdkjMFtT369wcof61fnCXLTQx0XwHNUv+AHKjMlEDlBjF0dIwYq6x6OJXrq9JLL1GMxA15ZPiB2OIQgkLCRkPYLB28Nv+GrRv3BGiE5Na4Lk4=
Received: by 10.48.217.20 with SMTP id p20mr5521236nfg.1171876600791;
        Mon, 19 Feb 2007 01:16:40 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id k23sm25695852nfc.2007.02.19.01.16.37;
        Mon, 19 Feb 2007 01:16:37 -0800 (PST)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40107>

Hello,

I'm working on bringing my hash width literals patch up to date now that 1.5.0 
has passed.  It's all been trivial apart from one line:

#define HASH_WIDTH_ASCII 40
-               printf("%-40s %s%s (%d subtrees)\n",
+               printf("%-" HASH_WIDTH_ASCII "s %s%s (%d subtrees)\n",

This compiles, but I suspect that it's not going to do what I want it to do.  
It's something I've never been able to do in C - how does one get quotes 
around a defined value?  I don't really want to resort to

+               printf("%-*s %s%s (%d subtrees)\n", HASH_WIDTH_ASCII,

As that's a runtime change.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
