From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Makefile: introduce NO_PTHREADS
Date: Mon, 1 Dec 2008 09:57:56 +0000
Message-ID: <e2b179460812010157y29ca5405ta8ff7efea3f2a167@mail.gmail.com>
References: <200811121029.34841.thomas@koch.ro>
	 <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil>
	 <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org>
	 <7vtza95h01.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org>
	 <e2b179460811170203v41e54ecclc3d6526bcc0fe928@mail.gmail.com>
	 <492148AD.1090604@viscovery.net>
	 <e2b179460811170245t1845cc66h7cb2a18c43a79359@mail.gmail.com>
	 <4921548E.6070802@viscovery.net> <4933A058.3050101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	dhruvakm@gmail.com
To: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 10:59:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L75Yg-0002zH-8J
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 10:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbYLAJ56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 04:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbYLAJ56
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 04:57:58 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:34606 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYLAJ55 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 04:57:57 -0500
Received: by qw-out-2122.google.com with SMTP id 3so480906qwe.37
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 01:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gol6UZKvASMKSJlroJh92Lu4jBMrcuFGrTA64cuvgME=;
        b=Quwpp+D81NGUNEmaV+8gXiNSjSuy+78HbXWLb6HaubVZkFfHGAp3s+v0NC9+ISzwb4
         AEqyWuK/QRzH+yYwV3PmVdDmYrGT4lLBQFcENmg3gBgdK3dtITKLjZARuwhDRdpuRfm9
         nw5HKREP8+uTbHDwUPU7IuIOgyWBL9tjQGy0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sRORyduJR6QgTVHCcB3IQjo1GWVvPAc6JsioxwFbmmynU8aMfDwaZXVxDKX3d+kBkj
         h8BsHxoXR7rGEId66B0wS0xLilyE90lz5w5Cit6PyeAvKhCj8F4sMlHhHdrqBq/Berl9
         1wQFoXu/OmNdT2ggcRJwKoLsJhk2Gtoxuvf+8=
Received: by 10.214.78.6 with SMTP id a6mr9408851qab.97.1228125476338;
        Mon, 01 Dec 2008 01:57:56 -0800 (PST)
Received: by 10.214.80.4 with HTTP; Mon, 1 Dec 2008 01:57:56 -0800 (PST)
In-Reply-To: <4933A058.3050101@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102014>

2008/12/1 Johannes Sixt <j.sixt@viscovery.net>
>
> Johannes Sixt schrieb:
> > Mike Ralphson schrieb:
> >> 2008/11/17 Johannes Sixt <j.sixt@viscovery.net>:
> >>> Mike Ralphson schrieb:
> >>>> 2008/11/15 Linus Torvalds <torvalds@linux-foundation.org>:
> >>>>> On Sat, 15 Nov 2008, Junio C Hamano wrote:
> >>>>>> This introduces make variable NO_PTHREADS for platforms that lack the
> >>>>>> support for pthreads library or people who do not want to use it for
> >>>>>> whatever reason.  When defined, it makes the multi-threaded index
> >>>>>> preloading into a no-op, and also disables threaded delta searching by
> >>>>>> pack-objects.
> >>>>> ...
> >
> > :-( Maybe NO_PTHREADS is indeed the safer choice? I'm not going to dig
> > into this today, though. (I'm on AIX 4.3.something.)
> >
> >>> BTW, this needs to be squashed in, because we don't have pthreads on Windows:
> >>>...
>
> you said you would resend the patch, but I think you forgot about it.
> Would you do that now, please?

Not forgotten, just slow. The current state I believe is we should
have NO_PTHREADS for AIX < v5. THREADED_DELTA_SEARCH and the new
multi-threaded lstat are actually ok on AIX 5.3 at least - though I
couldn't see any performance benefit on my repo / hardware
combination.

But now after dhruva's observation I'm unsure what the desired change
is for Windows. 8-(

Mike
