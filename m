Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E74C11D05
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 16:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC13207FD
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 16:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AdzaLmW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgBTQHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:07:15 -0500
Received: from mout.web.de ([212.227.15.3]:32845 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgBTQHP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 11:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582214823;
        bh=u0hkZ0H0gkSlzakhAJW2XvLhxUuof9D+Rx5e1XEefa4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AdzaLmW+jvN0rgu+OLNz2JR+SJ+jKjtMpiSJMJESwDk6jlRDsHPf0A2G/XNkcy+LI
         sTupYD6YeXB7Qpt5TOm3CoOT52pYUX7rEGrH16hQdW2PLdv7UjRWG5Vt2fMmQLj0wr
         TtMani5HYoOdKk1AzRPJ2NWbmpwFfb5tYkUhXIbM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK6mD-1j3z0M0h9h-001Rbg; Thu, 20
 Feb 2020 17:07:03 +0100
Subject: Re: Bug: Git: Clone: University Network: No Output on Terminal
To:     Manish Devgan <manish.nsit8@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
References: <CABVXwf6q1xMFhw+xd5f8GKATwC9k8mrXUkykpGgvTj7hv9pwEw@mail.gmail.com>
 <4d17a541-3c5c-0cf3-6ea6-11c214aa4674@web.de>
 <CABVXwf404m9FdsoLxYxZriYT6uif_fsMs8B4dY4RmeQojqK9Wg@mail.gmail.com>
 <9ed26e7e-c19c-cdb2-0710-3b91bf31291b@web.de>
 <CABVXwf6mPXWof3RHshDo=FSX8dvqUYDFH6-ecaCXDi4KhY8QJQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <520ed4fd-40cf-04ff-4717-f7d5c962a748@web.de>
Date:   Thu, 20 Feb 2020 17:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CABVXwf6mPXWof3RHshDo=FSX8dvqUYDFH6-ecaCXDi4KhY8QJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oMsqpvy9P87guwBdjDHn2x8n1ERWK2oO7lhngkptwpR2VsN1DWX
 adkVYhTJG9aznPHckc7AU2pdrPuRYjwFrJN9ojXluadn0WA2HNNYxn45x/fVbwCS4ceIFJN
 oRRjbY4SGGQWCbL0THY+r7TwTzdnIfjX8WQhykcacF0u2jC1ZhzpmmoFEYynlZIDfQCvwAD
 TGC7UZj0uKCTYUap32yvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B5jUBFJUsCk=:RN0juoHB4wyggV7bJtCziY
 Mvvm3Oh5QF1ucnNlLB8OOqP6tY41qQn7H0CuovOlrWy+kTeOxe2CqyNS+B3vXcuHwkwkTIpap
 yfO59T4PmgjUl2RnXKRcnLJ7Jchf7/YWEXdV+HtZCFyrf5BeifjJZw8pJw3a6m4whLu9kjz0C
 kB8+IzS/QtSThKwm/LNCCSc1DXIG04qiKhe4qUDRtB9Zv/u1jlJaltKmfSoU359qK0tLR2ptQ
 CHqbRdmVRzTr9hZYWhw4WsrqsCcMCPi/5dOWCOKYt376hi4ZN5q215jnQEHnsu15dKsQapZ+8
 fY5r3SqlwcJCNZ3wnxmmhZD/u2R1De74P1QvoYMrO3GIYJ+xwt6CxqC6WjnbMIXpnjCX7YO55
 oEix0sE+dWqR2RX90i5WPcS8PTDNkKwPG4gO4AaSrAOYs2a1siD7UwVXuhJGv/idr4sCeVpD5
 LJd0sSeWDs4jqvDfNBOIcsYMHkiVEaTZy7PVR+TBsj3WXMWozs49j4+mCQUa4hHgNk4QC4Dbk
 UhEiUUJvDGJtMGyprhr05ITN58ma9gXrtuZGnJfRYs3hxy6hO2ZDloba8xfpZm4+u5GObgNqM
 2IqUFOUnM7otMCSkoAaXykw/je3HvdOxQ+UZOPDxcat8dtaFZnFrmwFBigrgm0jmuvILE5gO/
 k5CIVbvz9biYb6R+rLXKdSiJ+W+31Af8WI5eYPAzC9Te0jtzBJtX90o5lSIzK67TFp2TISNy8
 hSD+Uk6pZ3wWumnAcpy2H6ts8LXrX5gIZ9TBSvCmSjG4lE9y+08atLN1bqm2JfyT9y+a3B8Fp
 28Pn1ot2OPkd1h8WX36c3V+mIV7lUQRTyPWjTVTvfrW6p2A0qlUnNOL2PaYJypSa2QAxcTcXk
 NKXA9p0Leb5KbI7iQq730VGUerKpltCHeD4PXHFLd6nxjHiqYYPFwiLA4hm7X4ESVxnQsoRos
 XeIAiIm8V5kICW4GvN8/FrNMPrLsXDyuPxkB+GOO1t9wkq0nQPmwpvOS7dqskCQNzRENduv8X
 tNYcelsF0tMokH7WGuc0delgrmOYkyjgbTI/3D6klyKvaBcfyt4M+0hUXzI2ybdF2mFA2yKHp
 a/+iy3UCHcmPBZgUgWoQzMN6Cs2w1yXkO7ZOzBft3kwyG8TGFcdqK6dOUJpccoD2xtKTebjvU
 j/O5gVwRnhxLao9B+Wncwo2GKMgwlZho46bIFwECb4LpRo0+fA06m1OttNJl7MS2lj1/JjYE+
 CAoz8WUMlI468Jdjy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.02.20 um 11:20 schrieb Manish Devgan:
> This is great. But perhaps I would want the output to come
> irrespective of --progress argument in case of dumb_http.

It's on by default if you use git on a terminal (as opposed to calling
it from a script).

Ren=C3=A9
