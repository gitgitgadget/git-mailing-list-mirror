Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD2C3F68F
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3200217BA
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="c3jzEpel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGUbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:31:13 -0500
Received: from mout.web.de ([212.227.17.12]:46495 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgBGUbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 15:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581107464;
        bh=e+e94Ui4ZcNBtGVkPrZBxyXsfjA++GPt5QEJAc9VfKk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=c3jzEpelA5UBeVIzpzb8UPtrEIlAKw/XnJh1WNFMhl6x1BG5dKF+oIszYxPzOFrTE
         KkX31AHR+Qd9yduXd5AgFEUcVOHJBQrbpZYZnTyzxOxpVeVAixbnahW7GDy1x+cmn4
         cGtJV9DkfQIVWSR7Vc0UGfnKnh17RqiEILVIR6jE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoYjO-1jTBdi1OPq-00ga1J; Fri, 07
 Feb 2020 21:31:04 +0100
Subject: Re: bug? illegal text in commit log
To:     Pratyush Yadav <p.yadav@ti.com>, Junio C Hamano <gitster@pobox.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
References: <20200204010524-mutt-send-email-mst@kernel.org>
 <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
 <xmqqd0arfyw8.fsf@gitster-ct.c.googlers.com>
 <20200207110216.ppf5aksfkam54bip@ti.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c67e59a2-0f81-8311-e14c-f27876e45cf0@web.de>
Date:   Fri, 7 Feb 2020 21:31:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207110216.ppf5aksfkam54bip@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cdBfjPxaPsOMUKp4rJpyPNfBx9sYVID+zKLDFqCYigK6wAmaBV/
 cwL4OEArDfEPBxZxw5cjCeDAZFNwr2PNb11wH+tkHP1uDlzhXfIoo4yGJM/3ffG5bWyifyj
 UVbsP81hLf0ARuX7i893po1GRTT4ozFOsNbisq4aZNKFS+QmA8GrLYfRC1oDUYkE7pt0VZc
 fpCGuBIpMrp8JAPS7+KGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XV/+IZjI/CM=:APLqppgB3ELR8HGj85QJdA
 Rgj974ynFUicTaAl5QiFecfZ+6NstmpTsMfaMeCrYvHgoItlNOTmw8bLv8sGY+9EGh9iDoBZt
 5FxgafFl/RnROEeR9Wmop/nnZOmhA7xEC2ylU2c1q3SJHo9yND7CtRX7+Q/07FImkRxX56hFB
 4y1Qm9iDIPlOiUvCQm3kLRbhgtkQvyxq5dVGSb50//ujvfe766Mgc8yf9lxKPlAjD8CYoN2DH
 lDyilz3/RYZxm/ia4ETjCj/Zn1Zzflz0t/egMxIasypWkNSfe/hzEL4L5/KQiHGk2nsnWLldU
 4gz4VaMhup6azIyEfVNq/og5yT6qvnyMP9G4Wd5zAJmcq27OCebjU5wLK36niX32Fowq9fGf/
 M5z7zP5i/lUwiawTF6E/keWlVLEBfb0XJZVcImAzkutUywACquXBIJ6TWl9G4x2IM96ZeZ+6h
 ClOtmBVPN5Vf/5L4kdKf3ZF+SMqE7m7NxPa03UCeeY5bNl28g2EMbOmmp8r/fMoDcxOGB+eHb
 vHRyFcpE8Ql4JP8gncxQMgAdmVcEfiC3pJf6a/HlionsIkSxaWPesQfBTaGlW1C4zILWZoUuz
 59FQaRhTOq/yO4q2LyF1gH8ALIPyaM7k3pgTd9u4pMCB0wEolQuKeObPrUXd3FK/bdUIA2WPZ
 qSLp9vmhilSFzFuKdIt5bHWC1CsDk6U9Sn1qVIPMOUQ3OjRNjX43BcbrYnWakaz1Z77EGtAVF
 XIEj8Ounds93mjDZ0+iHXbB0PAnnymwLPYsQfrITy2MRiepp2LIs4IN1xSVxVmn2ILOb84E0N
 79JM7fqpBVM8kdFjYZXMlEqGzLMFf1Vt0Ji/QXSkIWhc2U7q2AzeX/cwjh7aCUrA2ozCvM06a
 Y8TIlvclYifHG42qWs7WHTI9NtyGo5+3R7ITH1qsY/edAYiS3LTi7ZjCOsniaAeDCTXmIUod6
 1Lv6elmHUvsIUATpxEQS45K6TDt9zLE8fOi229sGn8+zX46ISCwgPRdt7hH0Uxht+ueLQ1GOr
 PNva1MXbqhOH42HGGmJaKE7fYfNs/7OkkhTMOiERs5WLiNTdHvV+ZRQN/rH+At3rfRaZMEVZV
 IZbXCLNOyoCEBf7wM+b/c40aVrqYKYTa6d2lpPNT7d/T82FxtoM6TsPmNocUqK8cd2+R32D6I
 1AIYah02uVoXg+/gFR4YWjZygcKYc05UFKXEvP6cz5g8LU5bAYV/5iEN9bkRv8Vg5W9DHE1ky
 kx5Rs1Cyokd0yT8Nf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.02.20 um 12:02 schrieb Pratyush Yadav:
> On 06/02/20 08:45AM, Junio C Hamano wrote:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> Like a Lines: header specifying the number of lines in the commit mess=
age?
>>
>> The only part of the workflow that can count the number reliably is
>> format-patch.  But the output of format-patch is designed to be
>> edited further, and expecting users to adjust the number when they
>> make such an edit is a bit too much.
>
> I haven't thought this through, but I'll throw the idea out anyway:
>
> How about counting lines in the diff (the one generated by format-patch,
> not the one in the commit message) instead of lines in the commit
> message? This way, the bottom n lines in the mail (barring the
> signature) are the diff contents.
>
> I personally have often edited the commit message and added comments
> below the '---' line in the patches output by format-patch, but I rarely
> ever manually edit the diff. It is just really easy to corrupt the patch
> when you manually edit it.

That's a good idea from a usability point of view.  However, mailinfo()
parses patches line by line.  It doesn't know the total number of lines
until it's done.  (It would if the Lines header from RFC 1036 was
mandatory for emails; RFC 2076 says it's "not standardized for use in
e-mail".)  It cannot easily go back at that point.

Reading the whole message into a buffer or a temporary file would be an
option, but that would give up the nice property that patches are
streamed.

Ren=C3=A9
