Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DC5207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933878AbcI2Vxo (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:53:44 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36208 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932185AbcI2Vxn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:53:43 -0400
Received: by mail-oi0-f66.google.com with SMTP id h186so1649799oia.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 14:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BHG4TYBGUM8mRqbFS1NNbdiyoOplgNrJ+uifM+z4mdw=;
        b=Uru9QFOH3376MEkTBl0rSZZ8ZXUzDqTE2rzSAjnKdSY6XdL5KqMz3RQuQW608eRxbS
         vU9EdZr7EP68Z/LMVZdkbZc/zSrpVxta5c0GSIoVrzSRmqt/k9fiIVWePlLnkvrWDBg+
         DbXy8k44t4pjmm582BTERjxDTXxML2u+aPJfNkjRx68vKJ/v0V24GfKVozFyBwZrUfge
         iTNsYa4YJCIXkTwUA+r3luoredqO0ccI8eCXpj+sA3h0qI9XKUnFIelVG6P514EyhUpc
         Y2TlLBfm9sic9Hn/7K+oTGJ4XXqSsdRn6HZma8aul2l9DJqzU12KyhKv9anUSLF+1aQz
         ZWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BHG4TYBGUM8mRqbFS1NNbdiyoOplgNrJ+uifM+z4mdw=;
        b=X8mD8Ip2sLkBS7JIRRNYoIJBLwrMJ9coaly4amUahNbNIfozItbFZLwR3DBb1Y7zt1
         D0hnDeunLX3yPQ67B2pv5+7SVamuXamhk131oYFn8y5OSCYgUxvUXlvDxU8FewzUGxMx
         8nZxrO3MCgvvntX9zrY29gImb0U6MM2KWqtdiwrcMzS2irraB2rgbfn/UiES3EetsK/a
         EAB4QA+G7kGsNSaLddxdl5/BjVXjMB3DUwDeACJn5DYDrp3ZQNItnIm+iHUe3FLOf1NZ
         uj6jWsFwJt3FrGB8C3z11dOLVr1dtCsY+sEgBwEuOwOqfWihBm8mMKChPqW+20nQsdgi
         e25Q==
X-Gm-Message-State: AA6/9RmUsWfujUOxvuxSuuyQUUHW9j8NvdEJGGtC84sFe8oUx+fD+M7j/3lhJgG7xqSwZH3o9rydcD1SNbOzKA==
X-Received: by 10.157.34.135 with SMTP id y7mr2842558ota.108.1475186022078;
 Thu, 29 Sep 2016 14:53:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 14:53:41 -0700 (PDT)
In-Reply-To: <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 14:53:41 -0700
X-Google-Sender-Auth: h3cVs06PkmZcfwDtt21-xzGxntk
Message-ID: <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=94eb2c047e2ad31e69053dac8284
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--94eb2c047e2ad31e69053dac8284
Content-Type: text/plain; charset=UTF-8

On Thu, Sep 29, 2016 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I think that is a reasonable way to go.
>
> #define DEFAULT_ABBREV get_default_abbrev()
>
> would help.

So something like this that replaces the previous patch?

Somebody should really double-check my heuristics, to see that I did
the pack counting etc right.  It doesn't do alternate loose file
counting at all, and maybe it could matter.  The advantage of the
previous patch was that it got the object counting right almost
automatically, this actually has its own new object counting code and
maybe I screwed it up.

                Linus

--94eb2c047e2ad31e69053dac8284
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_itovmyk50

IGNhY2hlLmggICAgICAgfCAgMyArKy0KIGVudmlyb25tZW50LmMgfCAgMiArLQogc2hhMV9maWxl
LmMgICB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDMg
ZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9jYWNoZS5oIGIvY2FjaGUuaAppbmRleCA2ZTMzZjJmMjguLmEwMjJlMWJkMiAxMDA2NDQK
LS0tIGEvY2FjaGUuaAorKysgYi9jYWNoZS5oCkBAIC0xMTg2LDggKzExODYsOSBAQCBzdGF0aWMg
aW5saW5lIGludCBoZXgyY2hyKGNvbnN0IGNoYXIgKnMpCiB9CiAKIC8qIENvbnZlcnQgdG8vZnJv
bSBoZXgvc2hhMSByZXByZXNlbnRhdGlvbiAqLworZXh0ZXJuIGludCBnZXRfZGVmYXVsdF9hYmJy
ZXYodm9pZCk7CiAjZGVmaW5lIE1JTklNVU1fQUJCUkVWIG1pbmltdW1fYWJicmV2Ci0jZGVmaW5l
IERFRkFVTFRfQUJCUkVWIGRlZmF1bHRfYWJicmV2CisjZGVmaW5lIERFRkFVTFRfQUJCUkVWIGdl
dF9kZWZhdWx0X2FiYnJldigpCiAKIHN0cnVjdCBvYmplY3RfY29udGV4dCB7CiAJdW5zaWduZWQg
Y2hhciB0cmVlWzIwXTsKZGlmZiAtLWdpdCBhL2Vudmlyb25tZW50LmMgYi9lbnZpcm9ubWVudC5j
CmluZGV4IGMxNDQyZGY5YS4uZmQ2NjgxZTQ2IDEwMDY0NAotLS0gYS9lbnZpcm9ubWVudC5jCisr
KyBiL2Vudmlyb25tZW50LmMKQEAgLTE2LDcgKzE2LDcgQEAgaW50IHRydXN0X2V4ZWN1dGFibGVf
Yml0ID0gMTsKIGludCB0cnVzdF9jdGltZSA9IDE7CiBpbnQgY2hlY2tfc3RhdCA9IDE7CiBpbnQg
aGFzX3N5bWxpbmtzID0gMTsKLWludCBtaW5pbXVtX2FiYnJldiA9IDQsIGRlZmF1bHRfYWJicmV2
ID0gNzsKK2ludCBtaW5pbXVtX2FiYnJldiA9IDQsIGRlZmF1bHRfYWJicmV2ID0gLTE7CiBpbnQg
aWdub3JlX2Nhc2U7CiBpbnQgYXNzdW1lX3VuY2hhbmdlZDsKIGludCBwcmVmZXJfc3ltbGlua19y
ZWZzOwpkaWZmIC0tZ2l0IGEvc2hhMV9maWxlLmMgYi9zaGExX2ZpbGUuYwppbmRleCBjYTE0OWE2
MDcuLjI4YmEwNGI2NSAxMDA2NDQKLS0tIGEvc2hhMV9maWxlLmMKKysrIGIvc2hhMV9maWxlLmMK
QEAgLTM3MjAsMyArMzcyMCw0NiBAQCBpbnQgZm9yX2VhY2hfcGFja2VkX29iamVjdChlYWNoX3Bh
Y2tlZF9vYmplY3RfZm4gY2IsIHZvaWQgKmRhdGEsIHVuc2lnbmVkIGZsYWdzKQogCX0KIAlyZXR1
cm4gciA/IHIgOiBwYWNrX2Vycm9yczsKIH0KKworc3RhdGljIGludCBpbml0X2RlZmF1bHRfYWJi
cmV2KHZvaWQpCit7CisJdW5zaWduZWQgbG9uZyBjb3VudCA9IDA7CisJc3RydWN0IHBhY2tlZF9n
aXQgKnA7CisJc3RydWN0IHN0cmJ1ZiBidWYgPSBTVFJCVUZfSU5JVDsKKwlESVIgKmRpcjsKKwlj
aGFyICpuYW1lOworCWludCByZXQ7CisKKwlwcmVwYXJlX3BhY2tlZF9naXQoKTsKKwlmb3IgKHAg
PSBwYWNrZWRfZ2l0OyBwOyBwID0gcC0+bmV4dCkgeworCQlpZiAob3Blbl9wYWNrX2luZGV4KHAp
KQorCQkJY29udGludWU7CisJCWNvdW50ICs9IHAtPm51bV9vYmplY3RzOworCX0KKworCXN0cmJ1
Zl9hZGRzdHIoJmJ1ZiwgZ2V0X29iamVjdF9kaXJlY3RvcnkoKSk7CisJc3RyYnVmX2FkZHN0cigm
YnVmLCAiLzQyLyIpOworCW5hbWUgPSBzdHJidWZfZGV0YWNoKCZidWYsIE5VTEwpOworCWRpciA9
IG9wZW5kaXIobmFtZSk7CisJZnJlZShuYW1lKTsKKwlpZiAoZGlyKSB7CisJCXN0cnVjdCBkaXJl
bnQgKmRlOworCQl3aGlsZSAoKGRlID0gcmVhZGRpcihkaXIpKSAhPSBOVUxMKSB7CisJCQljb3Vu
dCArPSAyNTY7CisJCX0KKwkJY2xvc2VkaXIoZGlyKTsKKwl9CisJZm9yIChyZXQgPSA3OyByZXQg
PCAxNTsgcmV0KyspIHsKKwkJdW5zaWduZWQgbG9uZyBleHBlY3RfY29sbGlzaW9uID0gMXVsIDw8
IChyZXQgKiAyKTsKKwkJaWYgKGNvdW50IDwgZXhwZWN0X2NvbGxpc2lvbikKKwkJCWJyZWFrOwor
CX0KKwlyZXR1cm4gcmV0OworfQorCitpbnQgZ2V0X2RlZmF1bHRfYWJicmV2KHZvaWQpCit7CisJ
aWYgKGRlZmF1bHRfYWJicmV2IDwgMCkKKwkJZGVmYXVsdF9hYmJyZXYgPSBpbml0X2RlZmF1bHRf
YWJicmV2KCk7CisJcmV0dXJuIGRlZmF1bHRfYWJicmV2OworfQo=
--94eb2c047e2ad31e69053dac8284--
