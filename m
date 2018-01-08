Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DD81FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 14:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933606AbeAHOpS (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 09:45:18 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:39185 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933150AbeAHOpO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 09:45:14 -0500
Received: by mail-wr0-f182.google.com with SMTP id z48so5267266wrz.6
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 06:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6nq31Sv8ZmmMytzIPcRTCLE2qGAI6dauAQeDcIE3SC8=;
        b=jvuIlO5t32/eElxgkKdqHdfVQJUJUavV57JhqoAS1c/Y4jo7rycZHgWBpG+byFj+O1
         aFaECHrybWhWB+miOxy/R1CzaTYmvFBmjyk0r/5cins2kaPdXLCl5Eg2ahBVg3hfQ1XH
         hIGndkdBZ5vY8Hy/hrt2iQK4CPETI/QVfai81b2JQZffYXylIZ7E+tmWqivKxDYD7Th2
         pP7qs8r/jPwhDKs010p/W3OSybw3apkjl8Tv9WozyhKlr0cE1s/c6PSN0413XCeb2Z0j
         Mu/p2vVGoAl/NZn7RpfCFGN3V3wKTrgZEx2iWTBeUAB7qTsHdJj1pkk9nWvAnxLxK7Ld
         0Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6nq31Sv8ZmmMytzIPcRTCLE2qGAI6dauAQeDcIE3SC8=;
        b=hVs/cmEUNhR+Dxitei+C85Fe6K4qprGs77JbW0+Bdm4P8eZrGzufiOZUz3Fd/O9j4F
         AW2CEYK0xcyRUnVYubAHgQWAHlWtEe7KEf+hNNevcIi6KlZjAmg0UL0MzPhmqIJst2Dy
         ne1fqC6qcPxTzuuJxSU1KGiVQBv6OyzzRnotEQ3f8nzKRK5ENRWXsYqOxCTAOVwqFbsA
         HXlNObfO72wftqcf/rjyy5T9iTLFHrdO6Yi2OILLu6v/hVbSoNOmqTb94WHA9zBeQ1h8
         Y8Gy7WGFY+7Ajs8C7hhjJGu8OTjGi38eO08089MZjHG05Ogwn/jgGga3VuurKFUJpAVD
         dHQg==
X-Gm-Message-State: AKGB3mJazuecmPt1PyxT4GDzSGl6kayDvFIW2vzIVlmgktSlbub8j1a/
        IChkBCSdYaUos/FnKtGHHHzvrw08Am3mH9gWZ0Q=
X-Google-Smtp-Source: ACJfBosIo/BfYr1Pe9kf6AZk22hdGIbW1sg1mNibil9YdofGuRcR/PaklQwIYIl8PAYaPeIGaE3djDWlx47hMPWfb4E=
X-Received: by 10.223.197.11 with SMTP id q11mr10491988wrf.186.1515422713255;
 Mon, 08 Jan 2018 06:45:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.197.193 with HTTP; Mon, 8 Jan 2018 06:45:12 -0800 (PST)
In-Reply-To: <CAP8UFD03-EPxQQk51RZgb9Osdb4P=B67CLU6PrEP0O9chcHOCw@mail.gmail.com>
References: <CAELBRWLyZ5s2Wvk2U5Ks2adx23Z+51dbEs3QbAq+5nGLe21srQ@mail.gmail.com>
 <20180106082116.11057-1-martin.agren@gmail.com> <CAELBRWJJYfRUxkzoeFfHQbSL5xzPQKt4srdoge=4K4n=ChN-TA@mail.gmail.com>
 <CAP8UFD03-EPxQQk51RZgb9Osdb4P=B67CLU6PrEP0O9chcHOCw@mail.gmail.com>
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
Date:   Mon, 8 Jan 2018 23:45:12 +0900
Message-ID: <CAELBRWLV7wQm_b9Lvj67KiAMAxq6vNOzA3z62S-f5=3A5LyjZQ@mail.gmail.com>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="089e0826ace8824087056244d8f4"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--089e0826ace8824087056244d8f4
Content-Type: text/plain; charset="UTF-8"

Hi all,

Thank you guys for insightful help.  I just read the code and now I understand
what you guys are saying.  Yeah, I can say the fix is "spot on".

But, to be honest, it's hard to see why you need "if (p)" at  the first glance.
So, how about this fix, instead?

I also found a bug in show_list().  I'm attaching a patch as well.
-- 
           yashi

--089e0826ace8824087056244d8f4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-bisect-debug-convert-struct-object-to-object_id.patch"
Content-Disposition: attachment; 
	filename="0001-bisect-debug-convert-struct-object-to-object_id.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jc6biv7z0

RnJvbSBkMTQ5YTEzNDhlOTRlYTAyNDZhMTAxODE3NTFjZTNiZjliYTQ4MTk4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZYXN1c2hpIFNIT0pJIDx5YXNoaUBhdG1hcmstdGVjaG5vLmNv
bT4KRGF0ZTogTW9uLCA4IEphbiAyMDE4IDIyOjMxOjEwICswOTAwClN1YmplY3Q6IFtQQVRDSCAx
LzJdIGJpc2VjdDogZGVidWc6IGNvbnZlcnQgc3RydWN0IG9iamVjdCB0byBvYmplY3RfaWQKClRo
ZSBjb21taXQgZjJmZDA3NjBmNjJlNzk2MDlmZWY3YmZkN2VjZWJiMDAyZThlNGNlZCBjb252ZXJ0
ZWQgc3RydWN0Cm9iamVjdCB0byBvYmplY3RfaWQgYnV0IGEgZGVidWcgZnVuY3Rpb24gc2hvd19s
aXN0KCksIHdoaWNoIGlzCmlmZGVmJ2VkIHRvIG5vb3AsIGluIGJpc2VjdC5jIHdhc24ndC4KClNv
IGZpeCBpdC4KLS0tCiBiaXNlY3QuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Jpc2VjdC5jIGIvYmlzZWN0
LmMKaW5kZXggMGZjYTE3YzAyLi5mYjNlNDQ5MDMgMTAwNjQ0Ci0tLSBhL2Jpc2VjdC5jCisrKyBi
L2Jpc2VjdC5jCkBAIC0xMzIsNyArMTMyLDcgQEAgc3RhdGljIHZvaWQgc2hvd19saXN0KGNvbnN0
IGNoYXIgKmRlYnVnLCBpbnQgY291bnRlZCwgaW50IG5yLAogCQl1bnNpZ25lZCBmbGFncyA9IGNv
bW1pdC0+b2JqZWN0LmZsYWdzOwogCQllbnVtIG9iamVjdF90eXBlIHR5cGU7CiAJCXVuc2lnbmVk
IGxvbmcgc2l6ZTsKLQkJY2hhciAqYnVmID0gcmVhZF9zaGExX2ZpbGUoY29tbWl0LT5vYmplY3Qu
c2hhMSwgJnR5cGUsICZzaXplKTsKKwkJY2hhciAqYnVmID0gcmVhZF9zaGExX2ZpbGUoY29tbWl0
LT5vYmplY3Qub2lkLmhhc2gsICZ0eXBlLCAmc2l6ZSk7CiAJCWNvbnN0IGNoYXIgKnN1YmplY3Rf
c3RhcnQ7CiAJCWludCBzdWJqZWN0X2xlbjsKIApAQCAtMTQ0LDEwICsxNDQsMTAgQEAgc3RhdGlj
IHZvaWQgc2hvd19saXN0KGNvbnN0IGNoYXIgKmRlYnVnLCBpbnQgY291bnRlZCwgaW50IG5yLAog
CQkJZnByaW50ZihzdGRlcnIsICIlM2QiLCB3ZWlnaHQocCkpOwogCQllbHNlCiAJCQlmcHJpbnRm
KHN0ZGVyciwgIi0tLSIpOwotCQlmcHJpbnRmKHN0ZGVyciwgIiAlLipzIiwgOCwgc2hhMV90b19o
ZXgoY29tbWl0LT5vYmplY3Quc2hhMSkpOworCQlmcHJpbnRmKHN0ZGVyciwgIiAlLipzIiwgOCwg
c2hhMV90b19oZXgoY29tbWl0LT5vYmplY3Qub2lkLmhhc2gpKTsKIAkJZm9yIChwcCA9IGNvbW1p
dC0+cGFyZW50czsgcHA7IHBwID0gcHAtPm5leHQpCiAJCQlmcHJpbnRmKHN0ZGVyciwgIiAlLipz
IiwgOCwKLQkJCQlzaGExX3RvX2hleChwcC0+aXRlbS0+b2JqZWN0LnNoYTEpKTsKKwkJCQlzaGEx
X3RvX2hleChwcC0+aXRlbS0+b2JqZWN0Lm9pZC5oYXNoKSk7CiAKIAkJc3ViamVjdF9sZW4gPSBm
aW5kX2NvbW1pdF9zdWJqZWN0KGJ1ZiwgJnN1YmplY3Rfc3RhcnQpOwogCQlpZiAoc3ViamVjdF9s
ZW4pCi0tIAoyLjE1LjEKCg==
--089e0826ace8824087056244d8f4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-bisect-handle-empty-list-in-best_bisection_sorted.patch"
Content-Disposition: attachment; 
	filename="0002-bisect-handle-empty-list-in-best_bisection_sorted.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jc6biv8o1

RnJvbSAyZWM4ODIzZGUzYmQwY2E4MjUzZGRiZDA3ZjU4YjY2YWZjZmFiZTk2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZYXN1c2hpIFNIT0pJIDx5YXNoaUBhdG1hcmstdGVjaG5vLmNv
bT4KRGF0ZTogTW9uLCA4IEphbiAyMDE4IDIyOjM1OjEyICswOTAwClN1YmplY3Q6IFtQQVRDSCAy
LzJdIGJpc2VjdDogaGFuZGxlIGVtcHR5IGxpc3QgaW4gYmVzdF9iaXNlY3Rpb25fc29ydGVkKCkK
CkluIDdjMTE3MTg0ZDcgKCJiaXNlY3Q6IGZpeCBvZmYtYnktb25lIGVycm9yIGluCmBiZXN0X2Jp
c2VjdGlvbl9zb3J0ZWQoKWAiLCAyMDE3LTExLTA1KSB0aGUgbW9yZSBjYXJlZnVsIGxvZ2ljIGRl
YWxpbmcKd2l0aCBmcmVlaW5nIHAtPm5leHQgaW4gNTBlNjJhOGU3MCAoInJldi1saXN0OiBpbXBs
ZW1lbnQKLS1iaXNlY3QtYWxsIiwgMjAwNy0xMC0yMikgd2FzIHJlbW92ZWQuCgpUaGlzIGZ1bmN0
aW9uLCBhbmQgYWxzbyBhbGwgb3RoZXIgZnVuY3Rpb25zIGJlbG93IGZpbmRfYmlzZWN0aW9uKCkg
dG8KYmUgY29tcGxldGUsIHdpbGwgYmUgY2FsbGVkIHdpdGggYW4gZW1wdHkgY29tbWl0IGxpc3Qg
aWYgYWxsIGNvbW1pdHMKYXJlIF91bmludGVyZXN0aW5nXy4gIFNvIHRoZSBmdW5jdGlvbnMgbXVz
dCBiZSBwcmVwYXJlZCBmb3IgaXQuCgpUaGlzIGNvbW1pdCwgaW5zdGVhZCBvZiByZXN0b3Jpbmcg
dGhlIGNoZWNrLCBtb3ZlcyB0aGUgY2xlYW4tdXAgY29kZQppbnRvIHRoZSBsb29wLiAgVG8gZG8g
dGhhdCB0aGlzIGNvbW1pdCBjaGFuZ2VzIHRoZSBub24tbGFzdC1jYXNlCmJyYW5jaCBpbiB0aGUg
bG9vcCB0byBhIGxhc3QtY2FzZSBicmFuY2gsIGFuZCBjbGVhbi11cCB1bnVzZWQgdHJhaWxpbmcK
ZWxlbWVudHMgdGhlcmUuCgpXZSBjb3VsZCwgb24gdGhlIG90aGVyIGhhbmQsIGRvIGEgYmlnICJp
ZiBsaXN0IiBjb25kaXRpb24gYXQgdGhlIHZlcnkKYmVnaW5uaW5nLiAgQnV0LCB0aGF0IGRvZXNu
J3Qgc291bmQgcmlnaHQgZm9yIHRoZSBjdXJyZW50IGNvZGUgYmFzZS4KTm8gb3RoZXIgZnVuY3Rp
b25zIGRvZXMgdGhhdCBidXQgYWxsIGJsb2NrcyBpbiB0aGUgZnVuY3Rpb25zIGFyZQp0b2xlcmFu
dCB0byBhbiBlbXB0eSBsaXN0LgoKQnkgdGhlIHdheSwgYXMgeW91IGNhbiB0ZWxsIGZyb20gdGhl
IG5vbi1sYXN0LWNhc2UgYnJhbmNoIHdlIGhhZCBpbgp0aGUgbG9vcCwgdGhpcyBmaXggc2hvdWxk
bid0IGNhdXNlIGEgcGlwZWxpbmUgc3RhbGwgb24gZXZlcnkgaXRlcmF0aW9uCm9uIG1vZGVybiBw
cm9jZXNzb3JzIHdpdGggYSBicmFuY2ggcHJlZGljdG9yLgoKU2lnbmVkLW9mZi1ieTogWWFzdXNo
aSBTaE9KSSA8eWFzdXNoaS5zaG9qaUBnbWFpbC5jb20+Ci0tLQogYmlzZWN0LmMgfCAxMiArKysr
KysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvYmlzZWN0LmMgYi9iaXNlY3QuYwppbmRleCBmYjNlNDQ5MDMuLmNlYzRh
NTM3ZiAxMDA2NDQKLS0tIGEvYmlzZWN0LmMKKysrIGIvYmlzZWN0LmMKQEAgLTIxOCw3ICsyMTgs
NyBAQCBzdGF0aWMgc3RydWN0IGNvbW1pdF9saXN0ICpiZXN0X2Jpc2VjdGlvbl9zb3J0ZWQoc3Ry
dWN0IGNvbW1pdF9saXN0ICpsaXN0LCBpbnQgbgogCQljbnQrKzsKIAl9CiAJUVNPUlQoYXJyYXks
IGNudCwgY29tcGFyZV9jb21taXRfZGlzdCk7Ci0JZm9yIChwID0gbGlzdCwgaSA9IDA7IGkgPCBj
bnQ7IGkrKykgeworCWZvciAocCA9IGxpc3QsIGkgPSAwOyBpIDwgY250OyBpKyssIHAgPSBwLT5u
ZXh0KSB7CiAJCXN0cnVjdCBvYmplY3QgKm9iaiA9ICYoYXJyYXlbaV0uY29tbWl0LT5vYmplY3Qp
OwogCiAJCXN0cmJ1Zl9yZXNldCgmYnVmKTsKQEAgLTIyNiwxMSArMjI2LDEzIEBAIHN0YXRpYyBz
dHJ1Y3QgY29tbWl0X2xpc3QgKmJlc3RfYmlzZWN0aW9uX3NvcnRlZChzdHJ1Y3QgY29tbWl0X2xp
c3QgKmxpc3QsIGludCBuCiAJCWFkZF9uYW1lX2RlY29yYXRpb24oREVDT1JBVElPTl9OT05FLCBi
dWYuYnVmLCBvYmopOwogCiAJCXAtPml0ZW0gPSBhcnJheVtpXS5jb21taXQ7Ci0JCWlmIChpIDwg
Y250IC0gMSkKLQkJCXAgPSBwLT5uZXh0OworCisJCWlmIChpID09IGNudCkgeworCQkJLyogY2xl
YW4tdXAgdW51c2VkIGVsZW1lbnRzIGlmIGFueSAqLworCQkJZnJlZV9jb21taXRfbGlzdChwLT5u
ZXh0KTsKKwkJCXAtPm5leHQgPSBOVUxMOworCQl9CiAJfQotCWZyZWVfY29tbWl0X2xpc3QocC0+
bmV4dCk7Ci0JcC0+bmV4dCA9IE5VTEw7CiAJc3RyYnVmX3JlbGVhc2UoJmJ1Zik7CiAJZnJlZShh
cnJheSk7CiAJcmV0dXJuIGxpc3Q7Ci0tIAoyLjE1LjEKCg==
--089e0826ace8824087056244d8f4--
