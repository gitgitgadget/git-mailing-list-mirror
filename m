Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAD0C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D4B61108
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 07:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhKSHv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 02:51:29 -0500
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49]:39763 "EHLO
        out162-62-57-49.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhKSHv2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Nov 2021 02:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vip.qq.com;
        s=s201512; t=1637308102;
        bh=0KRaFxZG81JLYnZ4uabKG0o3HtlFC37i3RbLWuc2o5g=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date;
        b=HDKKxkA38cZPcAhKdoavaLGbUJHlbPhuelH+uQjIGFdffQIM4Q00KoBH1CT+2NxwK
         5RV5AJef3IZiXlnOM0s/EZ8WfckEvz06vSZmUEFwtoK1AHfFOvPe8iOmFe7fu9WANS
         9K4SYs15uv51Gq3Vcf2hX3mZwSwFSNamop9jMsXI=
X-QQ-FEAT: oHWrrGTW1dBLOpUwnNstqWnlSG3bxRlF
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: OOWntbL6xj16TeAPlPm0mNz1gVsIMxEePJ/szesvYHoqovfGz4ano6KjpJWGx8
         /xLvtLUX1MfraZK3Uvfy3xoTm2o6IuuJd+4LyIBtJRGjEfKkO7GU/efZqfQhSYtn7UwdVSBWICk2z
         9mK+3ZM5T6Qfbi7QjcUDD/DyXjCCj+owNT0O3M5XsulwfR8NnXpZrFLgy1ztqaxV3rqA8nO1UBwDq
         In89sM3jXULTrRUeaDl02p+ULyB4huIBc67lIGbXZa+87CqzlXaIwgaaXofxOi6cIRakE4byn5HhQ
         BVsVLkh1WT60lEl5WrzDpXHi4lm92uXQgidt6WoeLRgaWRWf9X5OHr6Ed7EXUlz/bHZ0bqLK2TWmo
         38hr6+2niWUN7fcEvKD5H2DaMjg3rq5d4Z1DjWBuW/ZDeFTVIGB7uQ0LN6RUpNS+X63UccqdMPC0L
         M5UDxa9MNmFVvhyeJ7dooDuz5XO0U/JPXZQC7O7b7lGwMZluQjVf0z8YJB7XICDJ2jHRwS+fIGeqL
         B/vbmCP896f23Nt5T+NAi4JNQpHfxjy4q3rfVTIgpuErxiEFVxC/1myV+5KVat6OIhf2EwAAVP8ut
         isA3wSX6vF08QUR9LZWQSFAX9U2dfX7IoyjeIb92Y8yd4OgqTPtDkFP3w0bgoKr6/m8CypjAJLKtS
         PoxWpD3uvdM4CJ9ReLyS1YHRieZizKXu/fbQLUkNYNzA+WLEXtKnWVODg/yTLl3Ue1dd3I1Mg43YE
         w1dXXEWA2X3wm8/AgUAPFMtVh1SZ8B7jfMmVmGno38a08CtD/vv2Mea5XuM6O86bhICnG69bUELX4
         oydFPNMjNdVV2ZN3BuMCsa52gLtyBRfITw4B6ALONffDuDvVTZ4qNXgSnEa2xMBp5HLyERzSCVNhF
         kvrSAPO4sMbr8r1MXYrM+3g5kpyi2Sd
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 61.144.247.110
In-Reply-To: <2ebb863f.246.17d37140518.Coremail.pwxu@coremail.cn>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
 <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
 <xmqqilwpuiv4.fsf@gitster.g>
 <b9c1244.36.17d35decb26.Coremail.pwxu@coremail.cn>
 <xmqqmtm0snol.fsf@gitster.g>
        <2ebb863f.246.17d37140518.Coremail.pwxu@coremail.cn>
X-QQ-STYLE: 
X-QQ-mid: webmail514t1637306713t5819674
From:   "=?gb18030?B?QWxlZW4=?=" <aleen42@vip.qq.com>
To:     "=?gb18030?B?QWxlZW4g0OzF5s7E?=" <pwxu@coremail.cn>,
        "=?gb18030?B?SnVuaW8gQyBIYW1hbm8=?=" <gitster@pobox.com>
Cc:     "=?gb18030?B?QWxlZW4gdmlhIEdpdEdpdEdhZGdldA==?=" 
        <gitgitgadget@gmail.com>,
        "=?gb18030?B?Z2l0?=" <git@vger.kernel.org>,
        "=?gb18030?B?UmVuqKYgU2NoYXJmZQ==?=" <l.s.r@web.de>,
        "=?gb18030?B?UGhpbGxpcCBXb29k?=" <phillip.wood123@gmail.com>
Subject: RE: [PATCH v6 0/3] am: support --empty=(die|drop|keep) option to handle empty patches
Mime-Version: 1.0
Content-Type: text/plain;
        charset="gb18030"
Content-Transfer-Encoding: base64
Date:   Fri, 19 Nov 2021 15:25:12 +0800
X-Priority: 3
Message-ID: <tencent_97599A81311F56C0395EE209EC64CD485805@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBJIGtub3cgaXQsIGFuZCBhcyBJIHNhaWQgYmVmb3JlIHRoYXQgZ2l0Z2l0Z2FkZ2V0IG5l
ZWQgUFIgY3JlYXRvcnMgdG8KPiBzaWduIG9mZiB1c2VyIG5hbWUgb2YgR2l0SHViIGFjY291
bnQsIGFjY29yZGluZyB0byB0aGUgRENPIGNoZWNrLiBJIGNhbgo+IGNvbmZpcm1lZCB0aGF0
ICJBbGVlbiIgYW5kICJBbGVlbiDQ7MXmzsQiIGFyZSBib3RoIHRoZSByZWFsIG5hbWUgb2Yg
bWluZSwKPiB0aGUgY29tbWl0dGVyLiBJIGNhbiB1c2UgdGhlIGFjY291bnQgYWxlZW40MkB2
aXAucXEuY29tIHRvIGNvbmZpcm0gdGhpcy4KCkNvbmZpcm1lZC4=

