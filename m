Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46DC91F428
	for <e@80x24.org>; Sun,  2 Sep 2018 00:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbeIBEs2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 00:48:28 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:42962 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeIBEs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 00:48:28 -0400
Received: by mail-oi0-f53.google.com with SMTP id k81-v6so21858468oib.9
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 17:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WCGxFjoam87/3fjpFfPIbtGUgfqooCZ5TBQPqReQJNU=;
        b=uR6Obx7ssvDiFuzTjzKtrPb5XX2RLOeu/KbT4alPvWW5tcLy6s8Jd+zxLjU3nQOApG
         rxff07aIwzAZwTmE/wX6Jl5bNNz93Pp3Q98imLkldatNnWuPQs0j9t7QbiDVplLqwQrz
         APn9FwYvh/jfPv3+H4rIVnKp+LqiOXagM8j/LVyUMHjp6jIeilkg8GOvq237H0WpOcPO
         SMjQrQ8ZmdL84q2nRiGtkgGJoTMbk8lv0VpMVjvSbHm8TYlV2ocG4+/S0dVnjrsakY0Y
         Mi1Kum3DMrn+TjvahtNaBufYMiPhSR4MZbceQ2wr65UyAd6U81IVZov0kHWK+IRklP57
         Q4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WCGxFjoam87/3fjpFfPIbtGUgfqooCZ5TBQPqReQJNU=;
        b=WxiduySfpf4wAGuG3KdNQtM7N9dvvn4zfxI67NbGqxg0C+bM+MmoBM0A3ztV82k2e+
         QE1j5vuNpLV6gqGfx9owNuYufsKlm/7VLqagEDAWlYtIVq9ptPyg28HB0kj50THJlQkW
         E2uYty9c1IyyMcIXGnFOLTse00raTC3XpUHk9vaPRVy3P9nhGWrKlrkHHBFqYTe4JHiD
         7XRgrCJxrgeoEWrnigTGX6rrFoM5ijI/HF7wNBpzWwvCOvaiMUKfq3+8D1hBe/PL8wZt
         JK7XsW1raqKP/dC7xbWNGjT1F5spMyIk1YEuo7+yeZCQZmYVXlqzhbJxtSG9vWA4zex+
         6VgA==
X-Gm-Message-State: APzg51BvjcOfZQsDwAUO1Pdl8Ki/Rg336lM0XODd+bc8PyrAuPeiPx0a
        iLPotGoTDvj8+1iNzjUW2D7rhjkDnfL2O2tPdN0=
X-Google-Smtp-Source: ANB0VdZUoN0YTY6a2Ur5Fr85dlSOnqPJNMPXWE6C+p0ixwFjdbTLWmUyGyetrO1vk+J7jXP4TXK83FOn7QlepFVxNp8=
X-Received: by 2002:a54:4784:: with SMTP id o4-v6mr12819464oic.101.1535848483272;
 Sat, 01 Sep 2018 17:34:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1281:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 17:34:41 -0700 (PDT)
In-Reply-To: <20180806212603.GA21026@sigill.intra.peff.net>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org> <20160517194533.GA11289@sigill.intra.peff.net>
 <20160517195136.GB11289@sigill.intra.peff.net> <20160517195541.GC11289@sigill.intra.peff.net>
 <CAM-tV-9gAGBLsEh3=aa-bHT2DmJb=dfahq+kUW+0GLoc7eFq0w@mail.gmail.com>
 <CAM-tV--dHGJbxfWGKrRde+Q2-cnmCXNshQtX4PN7jnMWER_+bg@mail.gmail.com>
 <20180625162308.GA13719@sigill.intra.peff.net> <CAM-tV-8sbbht7NUwf87-gq=+P=LNPyiEcv3zL+1BxfXK+ktmVA@mail.gmail.com>
 <20180806212603.GA21026@sigill.intra.peff.net>
From:   Noam Postavsky <npostavs@users.sourceforge.net>
Date:   Sat, 1 Sep 2018 20:34:41 -0400
X-Google-Sender-Auth: MHZ_Sj5rHxNxpTvZgmslxROUIM0
Message-ID: <CAM-tV-_=4WuMGemm6RTB902-m8JfMKGp_OkQFuJMagPE8bOOtg@mail.gmail.com>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000465a450574d8979c"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000465a450574d8979c
Content-Type: text/plain; charset="UTF-8"

On 6 August 2018 at 17:26, Jeff King <peff@peff.net> wrote:

> I suspect it still has a bug, which is that it is handling this
> first-parent-goes-left case, but probably gets the straight-parent case
> wrong. But at least in this form, I think it is obvious to see where
> that bug is (the "three" in the comment is not accurate in that latter
> case, and it should be two).

Yes, thanks, it makes a lot more sense this way. I believe the
attached handles both parent types correctly.

--000000000000465a450574d8979c
Content-Type: text/x-diff; charset="US-ASCII"; 
	name="v3-0001-log-Fix-coloring-of-certain-octupus-merge-shapes.patch"
Content-Disposition: attachment; 
	filename="v3-0001-log-Fix-coloring-of-certain-octupus-merge-shapes.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jlk4cp340

RnJvbSBhODQxYTUwYjAxNmMwY2ZjOTE4MzM4NGU2YzNjYTg1YTIzZDFlMTFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOb2FtIFBvc3RhdnNreSA8bnBvc3RhdnNAdXNlcnMuc291cmNl
Zm9yZ2UubmV0PgpEYXRlOiBTYXQsIDEgU2VwIDIwMTggMjA6MDc6MTYgLTA0MDAKU3ViamVjdDog
W1BBVENIIHYzXSBsb2c6IEZpeCBjb2xvcmluZyBvZiBjZXJ0YWluIG9jdHVwdXMgbWVyZ2Ugc2hh
cGVzCgpGb3Igb2N0b3B1cyBtZXJnZXMgd2hlcmUgdGhlIGZpcnN0IHBhcmVudCBlZGdlIGltbWVk
aWF0ZWx5IG1lcmdlcyBpbnRvCnRoZSBuZXh0IGNvbHVtbiB0byB0aGUgbGVmdDoKCnwgKi0uCnwg
fFwgXAp8LyAvIC8KCnRoZW4gdGhlIG51bWJlciBvZiBjb2x1bW5zIHNob3VsZCBiZSBvbmUgbGVz
cyB0aGFuIHRoZSB1c3VhbCBjYXNlOgoKfCAqLS4KfCB8XCBcCnwgfCB8ICoKCkFsc28gcmVmYWN0
b3IgdGhlIGNvZGUgdG8gaXRlcmF0ZSBvdmVyIGNvbHVtbnMgcmF0aGVyIHRoYW4gZGFzaGVzLApi
dWlsZGluZyBmcm9tIGFuIGluaXRpYWwgcGF0Y2ggc3VnZ2VzdGlvbiBieSBKZWZmIEtpbmcuCgpT
aWduZWQtb2ZmLWJ5OiBOb2FtIFBvc3RhdnNreSA8bnBvc3RhdnNAdXNlcnMuc291cmNlZm9yZ2Uu
bmV0PgotLS0KIGdyYXBoLmMgfCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAxMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ncmFwaC5jIGIvZ3JhcGguYwppbmRleCBlMWY2ZDNiZGQu
LjQ3OGM4NmRmYiAxMDA2NDQKLS0tIGEvZ3JhcGguYworKysgYi9ncmFwaC5jCkBAIC04NDgsMjEg
Kzg0OCw0NSBAQCBzdGF0aWMgaW50IGdyYXBoX2RyYXdfb2N0b3B1c19tZXJnZShzdHJ1Y3QgZ2l0
X2dyYXBoICpncmFwaCwKIAkJCQkgICAgc3RydWN0IHN0cmJ1ZiAqc2IpCiB7CiAJLyoKLQkgKiBI
ZXJlIGRhc2hsZXNzX2NvbW1pdHMgcmVwcmVzZW50cyB0aGUgbnVtYmVyIG9mIHBhcmVudHMKLQkg
KiB3aGljaCBkb24ndCBuZWVkIHRvIGhhdmUgZGFzaGVzIChiZWNhdXNlIHRoZWlyIGVkZ2VzIGZp
dAotCSAqIG5lYXRseSB1bmRlciB0aGUgY29tbWl0KS4KKwkgKiBIZXJlIGRhc2hsZXNzX2NvbW1p
dHMgcmVwcmVzZW50cyB0aGUgbnVtYmVyIG9mIHBhcmVudHMgd2hpY2ggZG9uJ3QKKwkgKiBuZWVk
IHRvIGhhdmUgZGFzaGVzIChiZWNhdXNlIHRoZWlyIGVkZ2VzIGZpdCBuZWF0bHkgdW5kZXIgdGhl
CisJICogY29tbWl0KS4gIEFuZCBkYXNoZnVsX2NvbW1pdHMgYXJlIHRoZSByZW1haW5pbmcgb25l
cy4KIAkgKi8KIAljb25zdCBpbnQgZGFzaGxlc3NfY29tbWl0cyA9IDI7Ci0JaW50IGNvbF9udW0s
IGk7Ci0JaW50IG51bV9kYXNoZXMgPQotCQkoKGdyYXBoLT5udW1fcGFyZW50cyAtIGRhc2hsZXNz
X2NvbW1pdHMpICogMikgLSAxOwotCWZvciAoaSA9IDA7IGkgPCBudW1fZGFzaGVzOyBpKyspIHsK
LQkJY29sX251bSA9IChpIC8gMikgKyBkYXNobGVzc19jb21taXRzICsgZ3JhcGgtPmNvbW1pdF9p
bmRleDsKLQkJc3RyYnVmX3dyaXRlX2NvbHVtbihzYiwgJmdyYXBoLT5uZXdfY29sdW1uc1tjb2xf
bnVtXSwgJy0nKTsKKwlpbnQgZGFzaGZ1bF9jb21taXRzID0gZ3JhcGgtPm51bV9wYXJlbnRzIC0g
ZGFzaGxlc3NfY29tbWl0czsKKworCS8qCisJICogVXN1YWxseSwgZWFjaCBwYXJlbnQgZ2V0cyBp
dHMgb3duIGNvbHVtbiwgbGlrZSB0aGlzOgorCSAqCisJICogfCAqLS4KKwkgKiB8IHxcIFwKKwkg
KiB8IHwgfCAqCisJICoKKwkgKiBTb21ldGltZXMgdGhlIGZpcnN0IHBhcmVudCBnb2VzIGludG8g
YW4gZXhpc3RpbmcgY29sdW1uLCBsaWtlIHRoaXM6CisJICoKKwkgKiB8ICotLgorCSAqIHwgfFwg
XAorCSAqIHwvIC8gLworCSAqCisJICovCisJaW50IHBhcmVudF9pbl9leGlzdGluZ19jb2xzID0g
Z3JhcGgtPm51bV9wYXJlbnRzIC0KKwkJKGdyYXBoLT5udW1fbmV3X2NvbHVtbnMgLSBncmFwaC0+
bnVtX2NvbHVtbnMpOworCisJLyoKKwkgKiBEcmF3IHRoZSBkYXNoZXMuICBXZSBzdGFydCBpbiB0
aGUgY29sdW1uIGZvbGxvd2luZyB0aGUKKwkgKiBkYXNobGVzc19jb21taXRzLCBidXQgc3VidHJh
Y3Qgb3V0IHRoZSBwYXJlbnQgd2hpY2ggZ29lcyB0byBhbgorCSAqIGV4aXN0aW5nIGNvbHVtbjog
d2UndmUgYWxyZWFkeSBjb3VudGVkIHRoYXQgY29sdW1uIGluIGNvbW1pdF9pbmRleC4KKwkgKi8K
KwlpbnQgZmlyc3RfY29sID0gZ3JhcGgtPmNvbW1pdF9pbmRleCArIGRhc2hsZXNzX2NvbW1pdHMK
KwkJLSBwYXJlbnRfaW5fZXhpc3RpbmdfY29sczsKKwlpbnQgaTsKKworCWZvciAoaSA9IDA7IGkg
PCBkYXNoZnVsX2NvbW1pdHM7IGkrKykgeworCQlzdHJidWZfd3JpdGVfY29sdW1uKHNiLCAmZ3Jh
cGgtPm5ld19jb2x1bW5zW2krZmlyc3RfY29sXSwgJy0nKTsKKwkJc3RyYnVmX3dyaXRlX2NvbHVt
bihzYiwgJmdyYXBoLT5uZXdfY29sdW1uc1tpK2ZpcnN0X2NvbF0sCisJCQkJICAgIGkgPT0gZGFz
aGZ1bF9jb21taXRzLTEgPyAnLicgOiAnLScpOwogCX0KLQljb2xfbnVtID0gKGkgLyAyKSArIGRh
c2hsZXNzX2NvbW1pdHMgKyBncmFwaC0+Y29tbWl0X2luZGV4OwotCXN0cmJ1Zl93cml0ZV9jb2x1
bW4oc2IsICZncmFwaC0+bmV3X2NvbHVtbnNbY29sX251bV0sICcuJyk7Ci0JcmV0dXJuIG51bV9k
YXNoZXMgKyAxOworCXJldHVybiAyICogZGFzaGZ1bF9jb21taXRzOwogfQogCiBzdGF0aWMgdm9p
ZCBncmFwaF9vdXRwdXRfY29tbWl0X2xpbmUoc3RydWN0IGdpdF9ncmFwaCAqZ3JhcGgsIHN0cnVj
dCBzdHJidWYgKnNiKQotLSAKMi4xMS4wCgo=
--000000000000465a450574d8979c--
