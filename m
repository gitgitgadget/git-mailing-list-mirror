Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626721F462
	for <e@80x24.org>; Tue,  4 Jun 2019 19:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFDTPp (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 15:15:45 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45548 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDTPp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 15:15:45 -0400
Received: by mail-ua1-f66.google.com with SMTP id v18so2232840uad.12
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzbwCvi/fIEpHZ6RkILf0C6ZBSI5eq1KdWB3H6mfT0w=;
        b=OPoa5IMqf0OOlezh4RR/E21FNmbvVQW8gS7/sR4+66O2cwAlvfagV7fPSBNHwQC1Km
         rsDsSH/dkDsjyt6cfEWuVOQHWQQkK+gkt+pW6W/9ydGgjv0QrSUpTcW1QKgQeoVReHEI
         AQ24JZkcuKcS+HZsrst9w/6GdlWO12ZCO4lExljODz0vInJZohK34tezkTnCPYz6crxK
         imRh9+EWxsT3bHw4FOPTbhq8NNzAd9kCFtLy7rAjX9OsaR7ZPxa537VpQMf1uKPY1NvK
         1EbQH3vAlZRoa2caowU3ibk5pVzWNwYLnrlclNh8KTRSz46VYOAaNXL/SVi/R0tG3gH1
         JKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzbwCvi/fIEpHZ6RkILf0C6ZBSI5eq1KdWB3H6mfT0w=;
        b=c9uAaKtTGrqg5lGhUA5N/qlcmc+jncIMX89tQObEcqQsgaFLt189CzfFn0xvi+6oGA
         tDX3YnWKQuPODM/uMxv72wJ3MpmBQzpmwV7UDFtMEj33MVfAWbOPF35bt5qFS0oAYaIj
         RcACHh8X+9/WjLTgt2qYiH4EMom4qjZOs5OVQrklLwCSlusunGUuwGeOf8TDFOV2DSyQ
         rU7JPH/7Buq2VXFxIH5leO/z0oS9H0cCa1jkzZXlpwdgkF63zLJyXxHrsuUtZvAetDK+
         miNnnoNllvLLJk/EUvWpeUucfOHSU3TLRLB+xmoMplH7J80ut66MawjcSivxSBjDtWe4
         lgYw==
X-Gm-Message-State: APjAAAXY6WyDNQndCAiA4T95UOX7oFgl5kZZQbYdEA/6Ga3SRKfoUj1P
        eoEh3hmY5xBGgL5P865QUHYapdtvvs27pMr6vKM=
X-Google-Smtp-Source: APXvYqyvCCOTdxui8Til7HbiWfZoerkYkTAmRPmBxX0cYNSmMCixSgzWw6Vh8eQC02AB4ew8/b/Fv0rDv0MIzGGVWtk=
X-Received: by 2002:a9f:3844:: with SMTP id q4mr16960637uad.48.1559675743850;
 Tue, 04 Jun 2019 12:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190604021330.16130-1-felipe.contreras@gmail.com> <20190604143553.GD10598@sigill.intra.peff.net>
In-Reply-To: <20190604143553.GD10598@sigill.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 4 Jun 2019 14:15:32 -0500
Message-ID: <CAMP44s3-8uaTn-1fUKqGLX8weMaK4yjvfdxcw8TF3JZfuKYGUQ@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/5] Fix fetch regression with transport helpers
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000ad6f45058a844e00"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000ad6f45058a844e00
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 4, 2019 at 9:35 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 03, 2019 at 09:13:25PM -0500, Felipe Contreras wrote:

> > I'm not exactly sure the solution is the one we want, but hopefull it gives an
> > idea as to what is needed.
>
> It looks good to me. Thanks for fixing this.
>
> The breakage is in v2.20, so I don't think this needs to be rushed into
> v2.22 (which is already at -rc3). But it should probably go to 'maint'
> sooner rather than later.

Indeed, it's probably not so urgent since people have not even been
complaining (that I know of). However, I think it's clear that there's
a regression and the fix is simple, so maybe just apply the obvious
fix, and leave the rest of the patches for later?

I'm attaching only the fix, just to temp the idea of applying that
tiny thing into v2.2.

-- 
Felipe Contreras

--000000000000ad6f45058a844e00
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fetch-fix-regression-with-transport-helpers.patch"
Content-Disposition: attachment; 
	filename="0001-fetch-fix-regression-with-transport-helpers.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jwi6mux80>
X-Attachment-Id: f_jwi6mux80

RnJvbSBhNTk5MDNlOTgyOGE0ZjI2NTY0NzAxNGNhODdmYTNiZTkwMTZhMjI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgQ29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQGdt
YWlsLmNvbT4KRGF0ZTogVHVlLCA0IEp1biAyMDE5IDE0OjEwOjQzIC0wNTAwClN1YmplY3Q6IFtQ
QVRDSF0gZmV0Y2g6IGZpeCByZWdyZXNzaW9uIHdpdGggdHJhbnNwb3J0IGhlbHBlcnMKCkNvbW1p
dCBlMTk4YjNhNzQwIGNoYW5nZWQgdGhlIGJlaGF2aW9yIG9mIGZldGNoIHdpdGggcmVnYXJkcyB0
byB0YWdzLgpCZWZvcmUsIG51bGwgb2lkcyB3aGVyZSBub3QgaWdub3JlZCwgbm93IHRoZXkgYXJl
LCByZWdhcmRsZXNzIG9mIHdoZXRoZXIKdGhlIHJlZnMgaGF2ZSBiZWVuIGV4cGxpY2l0bHkgY2xl
YXJlZCBvciBub3QuCgogIGUxOThiM2E3NDAgKGZldGNoOiByZXBsYWNlIHN0cmluZy1saXN0IHVz
ZWQgYXMgYSBsb29rLXVwIHRhYmxlIHdpdGggYSBoYXNobWFwKQoKV2hlbiB1c2luZyBhIHRyYW5z
cG9ydCBoZWxwZXIgdGhlIG9pZHMgY2FuIGNlcnRhaW5seSBiZSBudWxsLiBTbyBub3cKdGFncyBh
cmUgaWdub3JlZCBhbmQgZmV0Y2hpbmcgdGhlbSBpcyBpbXBvc3NpYmxlLgoKVGhpcyBwYXRjaCBm
aXhlcyB0aGF0IGJ5IGhhdmluZyBhIHNwZWNpZmljIGZsYWcgdGhhdCBpcyBzZXQgb25seSB3aGVu
IHdlCmV4cGxpY2l0bHkgd2FudCB0byBpZ25vcmUgdGhlIHJlZnMsIHJlc3RvcmluZyB0aGUgb3Jp
Z2luYWwgYmVoYXZpb3IuCgpTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgQ29udHJlcmFzIDxmZWxpcGUu
Y29udHJlcmFzQGdtYWlsLmNvbT4KLS0tCiBidWlsdGluL2ZldGNoLmMgfCA5ICsrKysrLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9idWlsdGluL2ZldGNoLmMgYi9idWlsdGluL2ZldGNoLmMKaW5kZXggNGJhNjNkNWFjNi4u
ZjQ5NjJiOTNkNiAxMDA2NDQKLS0tIGEvYnVpbHRpbi9mZXRjaC5jCisrKyBiL2J1aWx0aW4vZmV0
Y2guYwpAQCAtMjM5LDYgKzIzOSw3IEBAIHN0YXRpYyBpbnQgd2lsbF9mZXRjaChzdHJ1Y3QgcmVm
ICoqaGVhZCwgY29uc3QgdW5zaWduZWQgY2hhciAqc2hhMSkKIHN0cnVjdCByZWZuYW1lX2hhc2hf
ZW50cnkgewogCXN0cnVjdCBoYXNobWFwX2VudHJ5IGVudDsgLyogbXVzdCBiZSB0aGUgZmlyc3Qg
bWVtYmVyICovCiAJc3RydWN0IG9iamVjdF9pZCBvaWQ7CisJaW50IGlnbm9yZTsKIAljaGFyIHJl
Zm5hbWVbRkxFWF9BUlJBWV07CiB9OwogCkBAIC0zMTksNyArMzIwLDcgQEAgc3RhdGljIHZvaWQg
ZmluZF9ub25fbG9jYWxfdGFncyhjb25zdCBzdHJ1Y3QgcmVmICpyZWZzLAogCQkJICAgICF3aWxs
X2ZldGNoKGhlYWQsIHJlZi0+b2xkX29pZC5oYXNoKSAmJgogCQkJICAgICFoYXNfb2JqZWN0X2Zp
bGVfd2l0aF9mbGFncygmaXRlbS0+b2lkLCBPQkpFQ1RfSU5GT19RVUlDSykgJiYKIAkJCSAgICAh
d2lsbF9mZXRjaChoZWFkLCBpdGVtLT5vaWQuaGFzaCkpCi0JCQkJb2lkY2xyKCZpdGVtLT5vaWQp
OworCQkJCWl0ZW0tPmlnbm9yZSA9IDE7CiAJCQlpdGVtID0gTlVMTDsKIAkJCWNvbnRpbnVlOwog
CQl9CkBAIC0zMzMsNyArMzM0LDcgQEAgc3RhdGljIHZvaWQgZmluZF9ub25fbG9jYWxfdGFncyhj
b25zdCBzdHJ1Y3QgcmVmICpyZWZzLAogCQlpZiAoaXRlbSAmJgogCQkgICAgIWhhc19vYmplY3Rf
ZmlsZV93aXRoX2ZsYWdzKCZpdGVtLT5vaWQsIE9CSkVDVF9JTkZPX1FVSUNLKSAmJgogCQkgICAg
IXdpbGxfZmV0Y2goaGVhZCwgaXRlbS0+b2lkLmhhc2gpKQotCQkJb2lkY2xyKCZpdGVtLT5vaWQp
OworCQkJaXRlbS0+aWdub3JlID0gMTsKIAogCQlpdGVtID0gTlVMTDsKIApAQCAtMzU0LDcgKzM1
NSw3IEBAIHN0YXRpYyB2b2lkIGZpbmRfbm9uX2xvY2FsX3RhZ3MoY29uc3Qgc3RydWN0IHJlZiAq
cmVmcywKIAlpZiAoaXRlbSAmJgogCSAgICAhaGFzX29iamVjdF9maWxlX3dpdGhfZmxhZ3MoJml0
ZW0tPm9pZCwgT0JKRUNUX0lORk9fUVVJQ0spICYmCiAJICAgICF3aWxsX2ZldGNoKGhlYWQsIGl0
ZW0tPm9pZC5oYXNoKSkKLQkJb2lkY2xyKCZpdGVtLT5vaWQpOworCQlpdGVtLT5pZ25vcmUgPSAx
OwogCiAJLyoKIAkgKiBGb3IgYWxsIHRoZSB0YWdzIGluIHRoZSByZW1vdGVfcmVmc19saXN0LApA
QCAtMzY4LDcgKzM2OSw3IEBAIHN0YXRpYyB2b2lkIGZpbmRfbm9uX2xvY2FsX3RhZ3MoY29uc3Qg
c3RydWN0IHJlZiAqcmVmcywKIAkJCUJVRygidW5zZWVuIHJlbW90ZSByZWY/Iik7CiAKIAkJLyog
VW5sZXNzIHdlIGhhdmUgYWxyZWFkeSBkZWNpZGVkIHRvIGlnbm9yZSB0aGlzIGl0ZW0uLi4gKi8K
LQkJaWYgKCFpc19udWxsX29pZCgmaXRlbS0+b2lkKSkgeworCQlpZiAoIWl0ZW0tPmlnbm9yZSkg
ewogCQkJc3RydWN0IHJlZiAqcm0gPSBhbGxvY19yZWYoaXRlbS0+cmVmbmFtZSk7CiAJCQlybS0+
cGVlcl9yZWYgPSBhbGxvY19yZWYoaXRlbS0+cmVmbmFtZSk7CiAJCQlvaWRjcHkoJnJtLT5vbGRf
b2lkLCAmaXRlbS0+b2lkKTsKLS0gCjIuMjEuMAoK
--000000000000ad6f45058a844e00--
