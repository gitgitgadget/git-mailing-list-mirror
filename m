X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 16:18:13 -0800
Message-ID: <f2b55d220612081618v26f7c714l7d4ea5315a964aa@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <20061207193012.GA84678@dspnet.fr.eu.org> <4578722E.9030402@zytor.com>
	 <4579611F.5010303@dawes.za.net> <45798FE2.9040502@zytor.com>
	 <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
	 <457998C8.3050601@garzik.org>
	 <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
	 <f2b55d220612081546u1ffa98e5q75be55d31da82a2f@mail.gmail.com>
	 <4579F9FF.7050701@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 00:18:27 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Jeff Garzik" <jeff@garzik.org>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oDImgwgql5479IsoPqM8u4nTQAhQZwqnCpACXe8suH+pAiZk4US9LqE+dDx/xXVMGb1TcmWRP8aYD7UnoRBUWAU1M0c+zOhvELjbqaltbM7fXsIYfj+rqpA7N1Ij33d18GbZ9E45fdMNt7R95Qc+SVXTwBtY+8TQxw06+wEY3kA=
In-Reply-To: <4579F9FF.7050701@zytor.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33776>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gspv0-0002I2-TO for gcvg-git@gmane.org; Sat, 09 Dec
 2006 01:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947568AbWLIASQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 19:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947571AbWLIASQ
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 19:18:16 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:1259 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1947568AbWLIASO (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 19:18:14 -0500
Received: by wx-out-0506.google.com with SMTP id h27so952981wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 16:18:14 -0800 (PST)
Received: by 10.90.55.19 with SMTP id d19mr4986186aga.1165623494087; Fri, 08
 Dec 2006 16:18:14 -0800 (PST)
Received: by 10.90.94.7 with HTTP; Fri, 8 Dec 2006 16:18:13 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

On 12/8/06, H. Peter Anvin <hpa@zytor.com> wrote:
> There is another thing that probably will be required, and I'm not sure
> if something in front of Apache (like Squid) rather than behind it can
> easily deal with: on timeout, the process needs to continue in order to
> feed the cache.  Otherwise, you're still in a failure scenario as soon
> as timeout happens.

I would think this would be a great deal easier to handle in an
arm's-length "accelerator" than in the origin server.  Only restart
the hit to the origin server if you think that something has actually
gone wrong there.  Serve stale data to the client if you have to.
From the page I quoted:

"In addition an option to shortcut the cache revalidation of
frequently accessed objects is added, making further requests
immediately return as a cache hit while a cache revalidation is
pending. This may temporarily give slightly stale information to the
clients, but at the same time allows for optimal response time while a
frequently accessed object is being revalidated. This too is an
optimization only intended for accelerators, and only for accelerators
where minimizing request latency is morer important than freshness."

I don't know how sophisticated this logic is currently, but I would
think that it wouldn't be that hard to tune up.

Cheers,
