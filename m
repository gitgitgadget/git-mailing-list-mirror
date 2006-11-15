X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] Seek back to current filepos when mmap()ing with NO_MMAP
Date: Wed, 15 Nov 2006 13:26:56 -0500
Message-ID: <118833cc0611151026q25fb6eeeid3a74e20498f00d@mail.gmail.com>
References: <Pine.LNX.4.63.0611151727000.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 18:27:09 +0000 (UTC)
Cc: junkio@cox.net, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lbe7xpQPsuZObCG/GgbsQq7wKuiiulR3gMIXXDlzMqg2IXLgNbe3KrtCw4Y7l/Be3iouXvRiMWVhh5mPjx3aywRV2AHoC8gpCOIdSFVl6b7ZGxMLoq9Zk31eL689FVEE47SeFdk1/hwIrVZBpKb6R+LEFDhNlHKNQEt0ScAN5ZY=
In-Reply-To: <Pine.LNX.4.63.0611151727000.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31460>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkPTR-0005Tf-Nr for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030808AbWKOS06 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 13:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030812AbWKOS05
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:26:57 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:55050 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1030808AbWKOS05
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 13:26:57 -0500
Received: by wx-out-0506.google.com with SMTP id s7so324387wxc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 10:26:56 -0800 (PST)
Received: by 10.70.43.8 with SMTP id q8mr3503920wxq.1163615216452; Wed, 15
 Nov 2006 10:26:56 -0800 (PST)
Received: by 10.70.97.15 with HTTP; Wed, 15 Nov 2006 10:26:56 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Using xmalloc in there seems wrong.  A plain malloc would do and the
error would be returned back to the mmap caller.

