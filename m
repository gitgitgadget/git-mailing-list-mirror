From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and GENERIC_KERNEL_EXECVE
Date: Wed, 24 Oct 2012 04:02:49 +0300
Message-ID: <CA+55aFyYD2jvD3+TSe=GhBgg5UQt2RNFdYf6HGiKRX-xWzFmdw@mail.gmail.com>
References: <20121016223508.GR2616@ZenIV.linux.org.uk> <201210192041.q9JKf7jD003998@farm-0010.internal.tilera.com>
 <20121019213548.GR2616@ZenIV.linux.org.uk> <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk> <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com> <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <alpine.LFD.2.02.1210232232070.2756@ionos> <20121023205119.GA27729@sigill.intra.peff.net>
 <alpine.LFD.2.02.1210232307480.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Al Viro <viro@zeniv.linux.org.uk>,
	Chris Metcalf <cmetcalf@tilera.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Gleixner <tglx@linutronix.de>
X-From: linux-arch-owner@vger.kernel.org Wed Oct 24 03:03:21 2012
Return-path: <linux-arch-owner@vger.kernel.org>
Envelope-to: glka-linux-arch@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arch-owner@vger.kernel.org>)
	id 1TQpNR-0004xG-0i
	for glka-linux-arch@plane.gmane.org; Wed, 24 Oct 2012 03:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943Ab2JXBDM (ORCPT <rfc822;glka-linux-arch@m.gmane.org>);
	Tue, 23 Oct 2012 21:03:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49442 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933666Ab2JXBDL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Oct 2012 21:03:11 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so4179129obb.19
        for <multiple recipients>; Tue, 23 Oct 2012 18:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=3uGLjXTceZDxZ94jfUf3Y1pAqHb/56hsXGPcr8QqJoA=;
        b=SkD2cPC+2T+jzCFlLzNzEa6ZtoOfZ/h/gRFzkfUks2sC1YKWR3vHmZMpgxttVjxBFG
         rkNWlFwNCakxLxjYOyw/0TmlBc4cCTju002cXb/WqE2vtaDFyYI6UUVOUDLXLOKuYtYx
         jNYpzUjt+4b7I8rNZM+JducDLemhjrGveDCR7UNBUUkIthWyag32Az7TDQ90/kGaQoay
         p6aa7JlkHEcylFTFYOHqmMmCojDv+rmYPYUPduelG7QTgof3SIoM0aSTt9FdidvWJNBo
         7ZPIRE2+Xfc74tBpGyKCjerShMkXOSpNk35nCW9obr2BTCAF5f7vC27PmBRE08scTLUY
         QQGw==
Received: by 10.182.23.79 with SMTP id k15mr11646182obf.100.1351040589811;
 Tue, 23 Oct 2012 18:03:09 -0700 (PDT)
Received: by 10.76.2.242 with HTTP; Tue, 23 Oct 2012 18:02:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1210232307480.2756@ionos>
X-Google-Sender-Auth: DGiBmrZyZJcepPIhd-017quol1Q
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208278>

On Wed, Oct 24, 2012 at 12:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> It is spelled:
>>
>>   git notes add -m <comment> SHA1
>
> Cool!

Don't use them for anything global.

Use them for local codeflow, but don't expect them to be distributed.
It's a separate "flow", and while it *can* be distributed, it's not
going to be for the kernel, for example. So no, don't start using this
to ack things, because the acks *will* get lost.

             Linus
