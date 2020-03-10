Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFD6C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99527208E4
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 22:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Z0yr1jwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgCJWIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:08:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:39345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgCJWIr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 18:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583878118;
        bh=Zmb9Wb3d0j3u3d8y0g1b4wo/OZ86NSSoMqT02FOOUSQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z0yr1jwZJIek2qvY0JRJAEBKTay+L/I4y41+eHKwzlHscgGNhq//RcK4yhdo+/Xes
         ePCUWKUt0uVkRuaWMx08Zr3Q+UWtyb9kY8inq9PapcrmWZrkJBygAQSmb6r6+8bVGW
         DCtO7H/fsKlGsU4Hv6gYcFl5Jm9bkmPJ/xw8bIXw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.176]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MdvmY-1jmlhA055y-00b4rh; Tue, 10 Mar 2020 23:08:38 +0100
Date:   Tue, 10 Mar 2020 23:08:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <xmqq36agjbt3.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003102306150.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet> <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com> <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2003082319260.46@tvgsbejvaqbjf.bet> <xmqqr1y11sn7.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2003092013090.46@tvgsbejvaqbjf.bet> <xmqq36ah1fao.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2003101239000.46@tvgsbejvaqbjf.bet>
 <xmqq36agjbt3.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zbqB5yICmep3kyMGdfZ2iG5e7TyESlTQjrYZQLQlQ6wJDFFZLJo
 pL7B/Sas2bEhDehFlPeIIVQMAyZosW7z+NFy0ZcuR9I0GxqYowtB+s6JurhCmAG7TQxJQJa
 juP6I4r5HYB3h9Apefzycct+598LNEnYeWl/vvnQNutO0cKFNDP/XWfuVAO2IsKj46shpo2
 gkMpXq3xxyKYR5/6JnC+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DFuw5OaJvsE=:s12L1easWomFRRKjFkvqBw
 gVbbVNzXfia/1h29nyTZF8hQckBxdw+erRfbfTOtS/FpqozBLPac8Vq8bYID+4JRcj6H7ICgL
 DPWhGMt6+b9IckY+sPNAjp0aScTdOfpGtzwoUXYohOuN0oJ7IokBi/vT9Ag0ne/sf30KIA09U
 Zx3CZmkd/dB6ARl5peZqyTIKmCWbJ2fAoOKjYY1QxVrOdg2HNYJzlBEb9F806PCQIpGKZvDcI
 9gRD5Np2Xtxp3ds3CZhKLua5vx5e7VjUofyhgwIY87uWIXa7lTangh70vEZM5b8Mkc6xuANYb
 3XqDcf3TKOk5DCHQiHLIpgyNIyhrJY1VWPB0858jc6O64pnxSg5olOOiFaqv2+rfNP0DztCeI
 BjCK8M4pt5vJ3C3umvO+typdkDqdy4oRpnqj8o5h3fal4s6pQl1A6kZR+iYOGEgHAnUh63uNT
 PoRG2od+rWrvj5S+ALtYMoL7yPtmAGfJB2dlPhr2U9Wc1oBvT7epDn2IehJh3MIGlxndzqnaw
 JX5cbXV89IYsI/DADBGfMxV21vlVsC6j+oBbK9iNtpX5caTFb1VrhPW6mdBUjpLzRr0byN9ZZ
 8PxRAh9hcm5SwgykOIiNMaLDIdF2AGlaKHbY99VEP8SoJNycQEeSlES3RPaRqpsw/8c3A4RaQ
 eUTq3b8YS9Hg7TcPRGEqLVaEsNZes9EPTTHq2LPVyZD9Y6ioE0uOEwQYB60zOtA4nxSZY+C8u
 bAaBDJ+5Ltqc17pAW2O9lyr/RFtK127hFsl/8X24Nz0KaHlzqogX6fGYPaNvDF6dwssCqf0SU
 Boq+KkmMAGTvA9rudeSnxaM192mSSf6VuA3qcRfp4T5ZYCwatO94OnnACc0N9vC3J+sInuMqp
 PRuQeRw181sIVfH0+q5onWc6Mr2SOFht6rsxM73Pt8BE4ZKeiw+0YSobzH/J/LRkDN0BhjIaX
 WnZfl57UVeOFlS4yg34g5F4n4dmawqrq6wvF2xPSLJ08m60fv4DcXZg3kzMwWeUbeUyM/burv
 1PKbwZ64xtwIj8vfdd2PdBaqAwZMXZI2cJZ8vSedNXfD9s34fPlZnEr1mg6hiYHz1Zs0c1lYG
 NdIFtdk05l90fqfjOL16dRD+QE8jrJo9dFF7V503JGe/ZltceEbbftxkUNKk3TViSl8yyeZgI
 waLDUCZqgJ0hqoIEWgyrHzYY1jpENi+G4Me/APKTzg71UEaUDNZwJnD7uazs7GokKvN68xBU0
 41c9wvN88a5EqwTxC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 10 Mar 2020, Junio C Hamano wrote:

> At this point, I'd have to say that your quibbling does not deserve
> a serious response and it would be better use of my time to
> disengage from this thread.

I thought we were discussing whether it makes sense to leave
`git-bugreport` as a stand-alone executable, or rather make it a built-in.

If my attempts to convince you that it would be better as a built-in
strike you as "quibbling", then I should probably pull out from trying to
review and help with this here patch series. I really thought I was
helping. My apologies for annoying you instead.

Ciao,
Dscho
