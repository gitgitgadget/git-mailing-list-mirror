X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 8 Dec 2006 15:46:44 -0800
Message-ID: <f2b55d220612081546u1ffa98e5q75be55d31da82a2f@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
	 <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>
	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
	 <45798FE2.9040502@zytor.com>
	 <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
	 <457998C8.3050601@garzik.org>
	 <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 23:47:04 +0000 (UTC)
Cc: "Jeff Garzik" <jeff@garzik.org>, "H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l6VhvEfTn1uzOiLvY65jdQ8JNuQ2+3uZbs9YivmVqM2R7lW9bdkNo63LpPWCCepMtjS/QKZWsC0+2rPyFtp9YTIz7KSlxqAx5CNQ5XA9o6vGeYgbmYSP+D8oqHvnv2aJh1+NIGvCkdOPExHfOla3ctCUN8U05+jZs6Pycu7utco=
In-Reply-To: <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33771>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GspQh-0007XK-9x for gcvg-git@gmane.org; Sat, 09 Dec
 2006 00:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947505AbWLHXqr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947504AbWLHXqq
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 18:46:46 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:53967 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1947505AbWLHXqp (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 18:46:45 -0500
Received: by wx-out-0506.google.com with SMTP id h27so947681wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 15:46:45 -0800 (PST)
Received: by 10.90.104.14 with SMTP id b14mr4894414agc.1165621604609; Fri, 08
 Dec 2006 15:46:44 -0800 (PST)
Received: by 10.90.94.7 with HTTP; Fri, 8 Dec 2006 15:46:44 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/8/06, Linus Torvalds <torvalds@osdl.org> wrote:
> You can't have a cache architecture where the client just does a "get",
> like memcached does. You need to have a "read-for-fill" operation ...

In Squid 2.6:
    collapsed_forwarding on
    refresh_stale_window <seconds>
(apply the latter only to stanzas where you want "readahead" of
about-to-expire cache entries)

Brief design description at http://devel.squid-cache.org/collapsed_forwarding/.

(I didn't write this code, everything I know about squid leaked
through the Google-shaped pinhole in my tinfoil hat, etc.  But if you
go this way I'd like to be in the loop to understand the scalability
issues around netfilter-assisted transparent proxying.)

Cheers,
