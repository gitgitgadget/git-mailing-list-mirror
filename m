Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E567B207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 01:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935357AbcI3BSG (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 21:18:06 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33868 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755519AbcI3BSF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 21:18:05 -0400
Received: by mail-oi0-f65.google.com with SMTP id r132so2652427oig.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 18:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nMTeUhueNJlFiU4LVwIkNvcqiKgZlm3ViyN20aKTeQE=;
        b=l0B+/BFXIZ201TUmT74uMmdEUoKS7R10Q0YPORtw5bO8CcVRafFud/OYHcMOMyrz/7
         /WynVnRPzZp9pX8ZIDsyUkjghtTSTse5Glz1iglsBk2B1kb/5IViNR5GTKw+6XGFiNoo
         IlBH9vwgkaQVealyByORFUayWeVWxUZ4CGOVCDP6O7qaWldSAVuqcWI92Q6vQ8L/BW+/
         sio6x8z79TLo7Id8AL3KHZu+MWF338UMlFmi4aetYk3tIeSok9NOg3ftqLzmjiX1Rwla
         BNu1ym4uIVuWedLd4m6jo25PTGnHsIr52cCgU6iZ2XNXPZbMEB+lazvKBicTVdK/7uPS
         u75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nMTeUhueNJlFiU4LVwIkNvcqiKgZlm3ViyN20aKTeQE=;
        b=dRevKEeoXVabYAyL0GESShss/awvCOLpLx9iWZ5OUdM3LKlPF4Gcp5qmkaZtWaqfJ+
         dGlaHArS7GUPNILTIZ8KS6/bYHo+KZHpBqufXCUxr0163FcPwCRYOiqDnYBek/dyZf9s
         sCM03KnAnf6Ik26RwDVJf7KzF9wQmzj70Y/C/w7Y38drDSmuooYTg/q7XBdQWK4uUW+Q
         rLpRCx1hPwmLcIFocXQ2fysr53E92VaLt11QPc84mEZ3v0h15kS9n7d0G8oGCfi2ZEBX
         +ad55VT/Wtq/voEeaK/v9XLOTfBlz2KVlA8pIx6d4kBUP+LJJyD7ncHf3hvFHzA/kLjR
         DOww==
X-Gm-Message-State: AA6/9RlCbvGNAd4L4zKql0Pzk5jUojhe5g2RXYW0sega99tAkHELWvvQyGmzcQxNb6sa9jnwi5vD/v8NyBNehg==
X-Received: by 10.157.39.2 with SMTP id r2mr3293372ota.103.1475198284081; Thu,
 29 Sep 2016 18:18:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 18:18:03 -0700 (PDT)
In-Reply-To: <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com> <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com> <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
 <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com> <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 18:18:03 -0700
X-Google-Sender-Auth: gS4SUo8nBg41xdnNAgHj8NfGW_c
Message-ID: <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a113d0a24b2538f053daf5dde
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a113d0a24b2538f053daf5dde
Content-Type: text/plain; charset=UTF-8

On Thu, Sep 29, 2016 at 5:57 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Actually, all the other cases seem to be "parse a SHA1 with a known
> length", so they really don't have a negative length.  So this seems
> ok, and is easier to verify than the "what all contexts might use
> DEFAULT_ABBREV" thing. There's only a few callers, and it's a static
> function so it's easy to check it locally in sha1_name.c.

Here's my original patch with just a tiny change that instead of
starting the automatic guessing at 7 each time, it starts at
"default_automatic_abbrev", which is initialized to 7.

The difference is that if we decide that "oh, that was too small, need
to repeat", we also update that "default_automatic_abbrev" value, so
that we won't start at the number that we now know was too small.

So it still loops over the abbrev values, but now it only loops a
couple of times.

I actually verified the performance impact by doing

      time git rev-list --abbrev-commit HEAD > /dev/null

on the kernel git tree, and it does actually matter. With my original
patch, we wasted a noticeable amount of time on just the extra
looping, with this it's down to the same performance as just doing it
once at init time (it's about 12s vs 9s on my laptop).

So this patch may actually be "production ready" apart from the fact
that some tests still fail (at least t2027-worktree-list.sh) because
of different short SHA1 cases.

                     Linus

--001a113d0a24b2538f053daf5dde
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_itp2yi990

IGNhY2hlLmggICAgICAgfCAgMSArCiBlbnZpcm9ubWVudC5jIHwgIDIgKy0KIHNoYTFfbmFtZS5j
ICAgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrLQogMyBmaWxlcyBjaGFuZ2VkLCAyNyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NhY2hlLmggYi9jYWNo
ZS5oCmluZGV4IDZlMzNmMmYyOC4uZDJkYTZkMTg2IDEwMDY0NAotLS0gYS9jYWNoZS5oCisrKyBi
L2NhY2hlLmgKQEAgLTEyMDcsNiArMTIwNyw3IEBAIHN0cnVjdCBvYmplY3RfY29udGV4dCB7CiAj
ZGVmaW5lIEdFVF9TSEExX1RSRUVJU0ggICAgICAgICAgMDIwCiAjZGVmaW5lIEdFVF9TSEExX0JM
T0IgICAgICAgICAgICAgMDQwCiAjZGVmaW5lIEdFVF9TSEExX0ZPTExPV19TWU1MSU5LUyAwMTAw
CisjZGVmaW5lIEdFVF9TSEExX0FVVE9NQVRJQwkgMDIwMAogI2RlZmluZSBHRVRfU0hBMV9PTkxZ
X1RPX0RJRSAgICAwNDAwMAogCiAjZGVmaW5lIEdFVF9TSEExX0RJU0FNQklHVUFUT1JTIFwKZGlm
ZiAtLWdpdCBhL2Vudmlyb25tZW50LmMgYi9lbnZpcm9ubWVudC5jCmluZGV4IGMxNDQyZGY5YS4u
ZmQ2NjgxZTQ2IDEwMDY0NAotLS0gYS9lbnZpcm9ubWVudC5jCisrKyBiL2Vudmlyb25tZW50LmMK
QEAgLTE2LDcgKzE2LDcgQEAgaW50IHRydXN0X2V4ZWN1dGFibGVfYml0ID0gMTsKIGludCB0cnVz
dF9jdGltZSA9IDE7CiBpbnQgY2hlY2tfc3RhdCA9IDE7CiBpbnQgaGFzX3N5bWxpbmtzID0gMTsK
LWludCBtaW5pbXVtX2FiYnJldiA9IDQsIGRlZmF1bHRfYWJicmV2ID0gNzsKK2ludCBtaW5pbXVt
X2FiYnJldiA9IDQsIGRlZmF1bHRfYWJicmV2ID0gLTE7CiBpbnQgaWdub3JlX2Nhc2U7CiBpbnQg
YXNzdW1lX3VuY2hhbmdlZDsKIGludCBwcmVmZXJfc3ltbGlua19yZWZzOwpkaWZmIC0tZ2l0IGEv
c2hhMV9uYW1lLmMgYi9zaGExX25hbWUuYwppbmRleCAzYjY0N2ZkN2MuLjEwMDNjOTZlYSAxMDA2
NDQKLS0tIGEvc2hhMV9uYW1lLmMKKysrIGIvc2hhMV9uYW1lLmMKQEAgLTE1LDYgKzE1LDcgQEAg
dHlwZWRlZiBpbnQgKCpkaXNhbWJpZ3VhdGVfaGludF9mbikoY29uc3QgdW5zaWduZWQgY2hhciAq
LCB2b2lkICopOwogCiBzdHJ1Y3QgZGlzYW1iaWd1YXRlX3N0YXRlIHsKIAlpbnQgbGVuOyAvKiBs
ZW5ndGggb2YgcHJlZml4IGluIGhleCBjaGFycyAqLworCXVuc2lnbmVkIGludCBucm9iamVjdHM7
CiAJY2hhciBoZXhfcGZ4W0dJVF9TSEExX0hFWFNaICsgMV07CiAJdW5zaWduZWQgY2hhciBiaW5f
cGZ4W0dJVF9TSEExX1JBV1NaXTsKIApAQCAtMTE4LDYgKzExOSwxMiBAQCBzdGF0aWMgdm9pZCBm
aW5kX3Nob3J0X29iamVjdF9maWxlbmFtZShzdHJ1Y3QgZGlzYW1iaWd1YXRlX3N0YXRlICpkcykK
IAogCQkJaWYgKHN0cmxlbihkZS0+ZF9uYW1lKSAhPSAzOCkKIAkJCQljb250aW51ZTsKKworCQkJ
Ly8gV2Ugb25seSBsb29rIGF0IHRoZSBvbmUgc3ViZGlyZWN0b3J5LCBhbmQgd2UgYXNzdW1lCisJ
CQkvLyBlYWNoIHN1YmRpcmVjdG9yeSBpcyByb3VnaGx5IHNpbWlsYXIsIHNvIGVhY2ggb2JqZWN0
CisJCQkvLyB3ZSBmaW5kIHByb2JhYmx5IGhhcyAyNTUgb3RoZXIgb2JqZWN0cyBpbiB0aGUgb3Ro
ZXIKKwkJCS8vIGZhbi1vdXQgZGlyZWN0b3JpZXMKKwkJCWRzLT5ucm9iamVjdHMgKz0gMjU2Owog
CQkJaWYgKG1lbWNtcChkZS0+ZF9uYW1lLCBkcy0+aGV4X3BmeCArIDIsIGRzLT5sZW4gLSAyKSkK
IAkJCQljb250aW51ZTsKIAkJCW1lbWNweShoZXggKyAyLCBkZS0+ZF9uYW1lLCAzOCk7CkBAIC0x
NTEsNiArMTU4LDcgQEAgc3RhdGljIHZvaWQgdW5pcXVlX2luX3BhY2soc3RydWN0IHBhY2tlZF9n
aXQgKnAsCiAKIAlvcGVuX3BhY2tfaW5kZXgocCk7CiAJbnVtID0gcC0+bnVtX29iamVjdHM7CisJ
ZHMtPm5yb2JqZWN0cyArPSBudW07CiAJbGFzdCA9IG51bTsKIAl3aGlsZSAoZmlyc3QgPCBsYXN0
KSB7CiAJCXVpbnQzMl90IG1pZCA9IChmaXJzdCArIGxhc3QpIC8gMjsKQEAgLTM4MCw2ICszODgs
OSBAQCBzdGF0aWMgaW50IHNob3dfYW1iaWd1b3VzX29iamVjdChjb25zdCB1bnNpZ25lZCBjaGFy
ICpzaGExLCB2b2lkICpkYXRhKQogCXJldHVybiAwOwogfQogCisvLyBXaHkgc2V2ZW4/IFRoYXQn
cyBvdXIgaGlzdG9yaWNhbCBkZWZhdWx0IGJlZm9yZSB0aGUgYXV0b21hdGljIGFiYnJldmlhdGlv
bgorc3RhdGljIGludCBkZWZhdWx0X2F1dG9tYXRpY19hYmJyZXYgPSA3OworCiBzdGF0aWMgaW50
IGdldF9zaG9ydF9zaGExKGNvbnN0IGNoYXIgKm5hbWUsIGludCBsZW4sIHVuc2lnbmVkIGNoYXIg
KnNoYTEsCiAJCQkgIHVuc2lnbmVkIGZsYWdzKQogewpAQCAtNDI2LDYgKzQzNywxNCBAQCBzdGF0
aWMgaW50IGdldF9zaG9ydF9zaGExKGNvbnN0IGNoYXIgKm5hbWUsIGludCBsZW4sIHVuc2lnbmVk
IGNoYXIgKnNoYTEsCiAJCWZvcl9lYWNoX2FiYnJldihkcy5oZXhfcGZ4LCBzaG93X2FtYmlndW91
c19vYmplY3QsICZkcyk7CiAJfQogCisJaWYgKGxlbiA8IDE2ICYmICFzdGF0dXMgJiYgKGZsYWdz
ICYgR0VUX1NIQTFfQVVUT01BVElDKSkgeworCQl1bnNpZ25lZCBpbnQgZXhwZWN0X2NvbGxpc2lv
biA9IDEgPDwgKGxlbiAqIDIpOworCQlpZiAoZHMubnJvYmplY3RzID4gZXhwZWN0X2NvbGxpc2lv
bikgeworCQkJZGVmYXVsdF9hdXRvbWF0aWNfYWJicmV2ID0gbGVuKzE7CisJCQlyZXR1cm4gU0hP
UlRfTkFNRV9BTUJJR1VPVVM7CisJCX0KKwl9CisKIAlyZXR1cm4gc3RhdHVzOwogfQogCkBAIC00
NTgsMTQgKzQ3NywxOSBAQCBpbnQgZm9yX2VhY2hfYWJicmV2KGNvbnN0IGNoYXIgKnByZWZpeCwg
ZWFjaF9hYmJyZXZfZm4gZm4sIHZvaWQgKmNiX2RhdGEpCiBpbnQgZmluZF91bmlxdWVfYWJicmV2
X3IoY2hhciAqaGV4LCBjb25zdCB1bnNpZ25lZCBjaGFyICpzaGExLCBpbnQgbGVuKQogewogCWlu
dCBzdGF0dXMsIGV4aXN0czsKKwlpbnQgZmxhZ3MgPSBHRVRfU0hBMV9RVUlFVExZOwogCisJaWYg
KGxlbiA8IDApIHsKKwkJZmxhZ3MgfD0gR0VUX1NIQTFfQVVUT01BVElDOworCQlsZW4gPSBkZWZh
dWx0X2F1dG9tYXRpY19hYmJyZXY7CisJfQogCXNoYTFfdG9faGV4X3IoaGV4LCBzaGExKTsKIAlp
ZiAobGVuID09IDQwIHx8ICFsZW4pCiAJCXJldHVybiA0MDsKIAlleGlzdHMgPSBoYXNfc2hhMV9m
aWxlKHNoYTEpOwogCXdoaWxlIChsZW4gPCA0MCkgewogCQl1bnNpZ25lZCBjaGFyIHNoYTFfcmV0
WzIwXTsKLQkJc3RhdHVzID0gZ2V0X3Nob3J0X3NoYTEoaGV4LCBsZW4sIHNoYTFfcmV0LCBHRVRf
U0hBMV9RVUlFVExZKTsKKwkJc3RhdHVzID0gZ2V0X3Nob3J0X3NoYTEoaGV4LCBsZW4sIHNoYTFf
cmV0LCBmbGFncyk7CiAJCWlmIChleGlzdHMKIAkJICAgID8gIXN0YXR1cwogCQkgICAgOiBzdGF0
dXMgPT0gU0hPUlRfTkFNRV9OT1RfRk9VTkQpIHsK
--001a113d0a24b2538f053daf5dde--
