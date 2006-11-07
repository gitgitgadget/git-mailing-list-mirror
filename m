X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Tue, 7 Nov 2006 14:55:01 +0100
Message-ID: <81b0412b0611070555u1833cc8ci1d37d45782562df8@mail.gmail.com>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com>
	 <45507965.3010806@peralex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 13:55:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IFX807kUdITN+FF0z4KOniyhjFleJHGcI9okleffkVRnmkk6l5Rg74k1q5XAXVeLYYJo6tjs5qnofShp0MWFRGwM4yxiLSEaXXowfCniLcDWdN58cHuHVYEPNvD/9ZYVBMD9sgCp/g8Q1tBz6HW5mdDGb4JP6jn/uh75lXOZGFk=
In-Reply-To: <45507965.3010806@peralex.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31071>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhRQ2-0004IW-OF for gcvg-git@gmane.org; Tue, 07 Nov
 2006 14:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750953AbWKGNzG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 08:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbWKGNzG
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 08:55:06 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:7139 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S1750953AbWKGNzD
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 08:55:03 -0500
Received: by wr-out-0506.google.com with SMTP id i7so232962wra for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 05:55:03 -0800 (PST)
Received: by 10.78.201.10 with SMTP id y10mr8294214huf.1162907702000; Tue, 07
 Nov 2006 05:55:02 -0800 (PST)
Received: by 10.78.128.2 with HTTP; Tue, 7 Nov 2006 05:55:01 -0800 (PST)
To: "Noel Grandin" <noel@peralex.com>
Sender: git-owner@vger.kernel.org

> So the problem is probably memory fragmentation.

probably.

> You might have more joy if you allocated one HUGE chunk immediately on
> startup to use for the pack, and then kept re-using that chunk.

Well, it is not _one_ chunk. The windows/cygwin abomin...combination
may take an issue with this: it seem to copy complete address space
at fork, which even for such a small packs I have here takes system
down lightly (yes, I tried it).

