X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Adding glob support to remotes
Date: Thu, 23 Nov 2006 08:44:27 +0000
Message-ID: <200611230844.29061.andyparkins@gmail.com>
References: <200611220904.21850.andyparkins@gmail.com> <200611221441.02459.andyparkins@gmail.com> <7v3b8bryt6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 08:44:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=b8l/5zSZVvdy/PI9uOMuiD1y3/cJW6tIaB5NZw55oPMcMKofO4t1CKF1NVbvr8HrEYGHkyrK5GMtefGBjzmP7AN0nFfWuhm7gX3YQvEulOxFcGPNUCHH57pZfxROi+ZZmDkAuIRMGGQDLw2peHbPMBEcpzhQa83149GV3Cddi2c=
User-Agent: KMail/1.9.5
In-Reply-To: <7v3b8bryt6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32121>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnACD-0002DB-Vv for gcvg-git@gmane.org; Thu, 23 Nov
 2006 09:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933271AbWKWIoe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 03:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933276AbWKWIoe
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 03:44:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:16573 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933271AbWKWIod
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 03:44:33 -0500
Received: by ug-out-1314.google.com with SMTP id 44so381407uga for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 00:44:32 -0800 (PST)
Received: by 10.67.91.6 with SMTP id t6mr4649996ugl.1164271472401; Thu, 23
 Nov 2006 00:44:32 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id m1sm11857538ugc.2006.11.23.00.44.31; Thu, 23 Nov 2006 00:44:32 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 November 22 20:50, Junio C Hamano wrote:

> I do not understand and that is why I do not understand why you
> would need to touch check-ref-format.

The problem is that I didn't want to call git-ls-remote in git-parse-remote, 
as git-parse-remote doesn't know about $uploadpack or what the actual remote 
in use is.  It seemed fairly intrusive to completely alter the functions in 
git-parse-remote; which is obviously a set of library functions.

Instead I did the expansion in git-fetch.sh.  Unfortunately that meant 
disabling the check-ref-format call in canon_refs_list_for_fetch.

> point at" is to ask ls-remote, and if you do one ls-remote
> upfront then all you need to do here is a single grep.

I understand now.  I'll look again at this tonight and send a further patch.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
