From: Alex Riesen <raa.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 16:31:19 +0100
Message-ID: <81b0412b0601100731p46ec276btfe04382a9e53bd5c@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13706@hdsmsx401.amr.corp.intel.com>
	 <Pine.LNX.4.64.0601090835580.3169@g5.osdl.org>
	 <7vu0cdjhd1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>,
	"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Martin Langhoff <martin.langhoff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Tue Jan 10 16:32:38 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwLUC-0007mf-Kq
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Tue, 10 Jan 2006 16:32:37 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S932227AbWAJPc3 (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Tue, 10 Jan 2006 10:32:29 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S932238AbWAJPc3
	(ORCPT <rfc822;linux-acpi-outgoing>);
	Tue, 10 Jan 2006 10:32:29 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:40119 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932227AbWAJPc2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Tue, 10 Jan 2006 10:32:28 -0500
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.204])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k0AFWP0R014923
	for <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Tue, 10 Jan 2006 07:32:27 -0800
Received: by nproxy.gmail.com with SMTP id k26so1361185nfc
        for <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Tue, 10 Jan 2006 07:31:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gzli5oBRgOOnv4K+jNRmI1P4rg1qYw7uP0yJJSZhd81SAT5GbpAytLri4bih2unFkj4NPf+M0S0c+Qi4/7u4gJTPj/YzPSe7MLVJ0UH/UPrQRre2uo88THnIjr7qvUvMGR6MU+kKhCmYkxKmF3C3lWx4deMgeoFtsS1n2P9vcHo=
Received: by 10.48.248.11 with SMTP id v11mr81870nfh;
        Tue, 10 Jan 2006 07:31:19 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Tue, 10 Jan 2006 07:31:19 -0800 (PST)
To: Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org>
In-Reply-To: <7vu0cdjhd1.fsf-u5dp/1a/izZijMVVUgEtmwqrb7wDvxM8@public.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 1/9/06, Junio C Hamano <junkio-j9pdmedNgrk@public.gmane.org> wrote:
> 2. Fix "git checkout <branch>" so that it does a reasonable thing
>    even when a dirty path is different in current HEAD and
>    destination branch.  Then I could:
>
>         $ git checkout symref ;# this would not work in the current git
>             # it would die like this:
>             # $ git checkout symref
>             # fatal: Entry 'gitweb.cgi' not uptodate. Cannot merge.

That is actually very interesting. I already wished sometimes to be
able to switch branches with a dirty working directory (and usually
ended up with git diff+checkout+apply).
Even if it results in a merge and conflict markers in files it looks
like a very practical idea!

>         $ git diff ;# just to make sure inevitable automated merge
>                     # did the right thing
>         $ git commit -a -m "Fix symref fix"
>             # I could collapse them into one instead, like this:
>             # $ git reset --soft HEAD^
>             # $ git commit -a -C ORIG_HEAD
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
