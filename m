Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30692C4332F
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 11:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiBPLxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 06:53:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiBPLxG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 06:53:06 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D41D3AC6
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 03:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1645012360;
        bh=qqYgbq23o4qXbWLkuD0Xn78oGffa5aYKXlJLVkUeKNI=;
        h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
        b=fQ2p8u3+rsEYoT0/KH/sZSCCI0ilFX8m1lvbYHT2IddpYRJUdPCii8soVf803szIU
         e9N/8PSmvkZVEu+wlHSrqTAKYdTpxC+5Hnk7NkyHQVuHUaR/t/zn7lqpy6u1XHiFf5
         8c3rbWbwvA/AqHucIn3K+al5cIqxI+6aShPLhIxk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAcpg-1nQsRU3012-00BNDc; Wed, 16
 Feb 2022 12:52:40 +0100
Date:   Wed, 16 Feb 2022 12:52:39 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Improvements to tests and docs for .gitattributes
 eol
Message-ID: <20220216115239.uo2ie3flaqo3nf2d@tb-raspi4>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220214020827.1508706-1-sandals@crustytoothpaste.net>
 <xmqqilth2u28.fsf@gitster.g>
 <20220214204631.mquj645jt5qajwku@tb-raspi4>
 <xmqq8rud0ytj.fsf@gitster.g>
 <9ab7761a-ff63-f809-47af-033825e5779e@kdbg.org>
 <YgwtMhuODDcVWEd6@camp.crustytoothpaste.net>
 <9ce63b16-cf75-3404-88cf-0623194db07b@kdbg.org>
 <YgzRyKZwsPw6rTyT@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgzRyKZwsPw6rTyT@camp.crustytoothpaste.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:DDd6F3CfHnuHPwtf7sOs1rur3SHoKUCOx5GTXw89M063v3jc97C
 bvITbZxrOQexv/hNocXHmoaK7ok+VteEAM04nW7Iq1p6fl8vlWe0Pcrs8nXW1jkvoFGQMam
 p09qjczsVLSWsSy412x/iflPITH2XD+OYVjCztKMGa6ux5litGSxdY0RTlNJHwgaBq5yzux
 DNBVe6ZaQp29OPWwIlZ1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HRpfcchk4N8=:79zLTuMJbxvsLo0SZksWzA
 74TcZXIe4ZJL9WU1CSIhUmvwdhT1oOuotfyCafivsR+rUm+sNmgOkYCfCtcOFpXa2IsDJAF1k
 KWVh0MfEPFmaj32ffbo/8GbXw1uu6WpoUoc+X2s8zo32ptVbNNuCJVoh7yZNFxXHsjdeXHdXm
 ag/Fks9RQpvSS25F+fGWcSdHuSHWkyWUoKh63hTWOc75nKbjlrNPhzow0CHNVQ2gc3+YwrIkQ
 Rm4xPTIZyy/IGuuxYKnLa4r/kyDQwd7Ti25aD1qNBL2D2WDSGKAhTThFRnwzHAHrXPYuieyxQ
 IRKQqIQyva7HIqPa5kymhMgZhw4YBWOCdxGcpPwl8kQgV4q46yn00c3ZgXT24FfKB5Y677VfV
 EqKqI5KYTl2UEp2aWRUisBZ7avM5cpSjNwrMg5QV8RNZ0kGihqKJYZW2uTeJD6FIoO/BpUnj6
 xX/ipyUSCrt2BrVr7QkZKuUc4+vVXKZp//rCVJsXEdGc0ZLbiyNwY+c3Jy2ddcdDTRKuRT4Mh
 7jiQRd/vxLuVM1MUE0v/ZPAKYSxl13O1NdPfVJEYBfJArr2pR6RXdIhXxXJcfgktLUXZZODlp
 KAjE+0dYcL8fQdxaZlprypRtHsoV58suTH8t4fYXufKSyU6aX807qhyTMdDXEn51FVERbfG7L
 OMX+oL7hN043lE4Rpl9V9XmL5nDZ0dDiC1Lp1vb8iqwYUEVfcew688R7ywYvd7sgfhV2/kPqZ
 amBjZuvH80XUQhi+Rg1BqEWcNiZ3dXI+rn6jStsOxfSfWpYDOTOsYiTUgZP5nUZmlRh8raA0I
 GbX9WdWLvTcFgQXWz+SRSJVrsti9GA/1Ne8RgsEjShQ+FILkLMNiKc44dHeUY96z0nI/E/7Qb
 avi/K41zoMVLUFA6/rHP6lFqMoaB3OgjcCtcYH/uOWyaR0knFnHDbLEjhRC9OvxOzQ4KZ0ajt
 UCdKJ6xIIPz0lHGX/9y1ZC3vBL0WKpNlsYLlCUAwUtLnoKHaa4Cehf4XwrMyXZbd93DiF/q8T
 X3VyrO/4V4tY30J4e7KtpOWPvjeUOgUBL2yEDY+qJQ+cZeaWEDYePkb2Z5dCxeFNzFgH+xZDx
 N7ifLKJ5JJAiJU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 10:28:24AM +0000, brian m. carlson wrote:
> On 2022-02-16 at 07:00:24, Johannes Sixt wrote:
> > Just so you know where my confusion arises from: Your updated text has
> > the structure (as I read it)
> >
> >    if ... set or unspecified or if auto then ... detected ... and LF
> >
> > It is unclear whether the 'then' conditions apply only to 'if auto'.
> > Even if the additional 'if' in the middle makes me think that the
> > 'then's apply only to the 'auto' case, it is sufficently vage because =
in
> > my mental model there is not much difference between an 'unset' and a
> > set-to-'auto' attribute, and I wonder why the 'then's should not apply
> > to the 'unset' case as well.
> >
> > Moreover, after re-reading the text, I notice that text may be read as
> > "this attribute has an effect only if <conditions>" where <conditions>
> > basically means "always except for when the 'if auto' case is not met"=
,
> > right? Would it perhaps be better to write "has no effect if <very
> > specific condition>"?
>
> The situation is that eol is in effect if and only if:

Well written

>
> * text is set;
> * text is unspecified; or
> * text is auto, the file is detected as text, and the file has LF line
>   endings in the index.
>
> Alternately, it has no effect if and only if:
>
> * text is unset;
> * text is auto and the file is detected as binary; or
> * text is auto and the file is detected as text and has CRLF line
>   endings.
... CRLF line endings in the index.
                      ^^^^^^^^^^^^

One of the reasons that the eol attribute is not 100% well-specified
is that people should use the eol attribute together with text.

Either
text=3Dauto eol=3Dcrlf
or
text=3Dauto eol=3Dlf
or
text eol=3Dcrlf
or
text eol=3Dlf

Older git versions did treat
* text=3Dauto
* eol=3Dcrlf

The same as
* text eol=3Dcrlf
Which did corrupt binary files.

Never git versions treat
* text=3Dauto
* eol=3Dcrlf
as
* text=3Dauto eol=3Dcrlf
in the sense that only auto-detected text files are converted,
if they had not been commited with crlf before.

In that sense I feel that the short form
eol=3Dcrlf
should be avoided

>
> I'm not sure one reads significantly easier than the other.  I slightly
> prefer the former because it has fewer conditions with multiple nested
> entries, though.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA


