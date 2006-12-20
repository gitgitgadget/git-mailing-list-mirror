X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on many OSes other than Linux
Date: Wed, 20 Dec 2006 23:13:23 +0100
Message-ID: <dbfc82860612201413u1cc006eapcd70c427e1ea9e0b@mail.gmail.com>
References: <86y7p57y05.fsf@blue.stonehenge.com>
	 <Pine.LNX.4.64.0612181906450.18171@xanadu.home>
	 <20061219051108.GA29405@thunk.org>
	 <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
	 <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0612191027270.18171@xanadu.home>
	 <7vk60npv7x.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0612191409500.18171@xanadu.home>
	 <Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 22:13:39 +0000 (UTC)
Cc: "Nicolas Pitre" <nico@cam.org>, "Junio C Hamano" <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MAZaUZ8cg0VyNZu4eOKyWWXOdAf8c18Ir6cYwq8g9GcADA1Tdru/irlI8wcuhbXHpRxAvVMtUlxQT0hKiu7ViXH7ZkWzjLQEu1icn+4393BhV4FhBmmGB7w8nDkGOYvnV4ymczXH8yYQnbr5zzR4OIQjds71uonp8btWqDIMAKA=
In-Reply-To: <Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
Content-Disposition: inline
X-Google-Sender-Auth: 025a23bddfe7d411
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34967>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx9gn-0000nT-Bt for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030380AbWLTWN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWLTWN0
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:13:26 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:2904 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1030380AbWLTWNZ (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 17:13:25 -0500
Received: by wr-out-0506.google.com with SMTP id i7so1590730wra for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 14:13:25 -0800 (PST)
Received: by 10.90.78.9 with SMTP id a9mr7907321agb.1166652804179; Wed, 20
 Dec 2006 14:13:24 -0800 (PST)
Received: by 10.90.31.6 with HTTP; Wed, 20 Dec 2006 14:13:23 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/19/06, Linus Torvalds <torvalds@osdl.org> wrote:

> It's the C++ people who tend to have sucky compile times.

Always looking for a way to bash on C++, eh?

