Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E9B0207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 18:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933306AbcI3SVL (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 14:21:11 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36157 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932972AbcI3SVK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 14:21:10 -0400
Received: by mail-oi0-f66.google.com with SMTP id h186so3381698oia.3
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=H8Hie1oJ6xPVrFzM0K2bNeIxBCsIEnTKirVE663dd5o=;
        b=RXKWBM5eLM7gLNjw3GCsCI2/B2sPmwAJjKNezP9C/E/4kOkfRHYVufsq/fjB3ohOaj
         LWTmqjpymBcp/7vEytZQIeke2GzdA3R6OWp/jPf0wYnPVb4fWiA+u7zdnrNbYeXhrv2/
         PxE4w1zvUk0jfbYffNhdut/BGGr008ZY7fHWe+YOS0KSDg7sZhfqt2G/ffXcTeQdIpxR
         Smo/a9Cfr90jvp5MYyI8YzGefEfj5kjgpY9yzwYCYVOTKspKlsD1accQgZ1LRMPZAZU4
         fVIjLURVZZb8OOiFQiGfXK5m1DQb3Urkis2j9Vnw9M0vQyGiEL/3Z5pni75Z8uAdpBCY
         HCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=H8Hie1oJ6xPVrFzM0K2bNeIxBCsIEnTKirVE663dd5o=;
        b=lfoyuD1UK0hye5LNtnnfXfeMyKmAcPv+7KjfD0raV4MK767rw5Hoa2o/i32ejvPMte
         6i35yhEH1zZuUwLYtW86jvLTl38ge4XrHf/mq0JJFtsH9L6getN/Jzv0FJfM6wJrArjQ
         IJv2GZU7OYJf6oUB7EkCD16L2Nns6lqasAdh8veB5XD+Bor6+KyLpgE5oZjsW9b6KTpc
         cmB7Z4yUT1lvVBL42DSoUEKHruoFr6147sbx0FX7S1up/uO7yPoJ4rwirJ5fOngwDIXC
         QWZB3bTNTpOqziV6UwIFQotSoeIsnLwm2yu37N1UoAbI4IUsJr46Kn868lW0N6VgoFge
         KGfA==
X-Gm-Message-State: AA6/9Rl3+yOQsDN8wCQ3mf9UDMbeCpmU3jO9R0CFyZ046CvpBlhHecNrKzOxKTeQDs0GROrr/Pwb5gGHcCt3uw==
X-Received: by 10.202.69.67 with SMTP id s64mr8530209oia.1.1475259669391; Fri,
 30 Sep 2016 11:21:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Fri, 30 Sep 2016 11:21:08 -0700 (PDT)
In-Reply-To: <CA+55aFxW1S6FNUh8YjSXkfC8=F5dka1rY-As6PWfG2rqmrsXXA@mail.gmail.com>
References: <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com> <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com> <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
 <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
 <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
 <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
 <20160930080658.lyi7aovvazjmy346@sigill.intra.peff.net> <CA+55aFxW1S6FNUh8YjSXkfC8=F5dka1rY-As6PWfG2rqmrsXXA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Sep 2016 11:21:08 -0700
X-Google-Sender-Auth: vYzC1j8bQxeRd2wLMK3bxc9Uf9A
Message-ID: <CA+55aFxyF=xX84AXr8MG14MRHwdrQw00PBM20UfqBdidaeqdMg@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a113dd1d48bcc34053dbda815
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a113dd1d48bcc34053dbda815
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 30, 2016 at 10:54 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>> So IMHO, the best combination is the init_default_abbrev() you posted in
>> [1], but initialized at the top of find_unique_abbrev(). And cached
>> there, obviously, in a similar way.
>
> That's certainly possible, but I'm really not happy with how the
> counting function looks.  And nobody actually stood up to say "yeah,
> that gets alternate loose objects right" or "if you have tons of those
> alternate loose objects you have other issues anyway". I think
> somebody would have to "own" that counting function, the advantage of
> just putting it into disambiguate_state is that we just get the
> counting for free..

Side note: maybe we can mix the two approaches, and keep the counting
in the disambiguation state, and just make the counting function do

    init_object_disambiguation();
    find_short_object_filename(&ds);
    find_short_packed_object(&ds);
    finish_object_disambiguation(&ds, sha1);

and then just use "ds.nrobjects". So the counting would still be done
by the disambiguation code, it just woudln't be in get_short_sha1().

So here's another version that takes that approach. And if somebody
(hint hint) wants to do the counting differently, they can perhaps
send an incremental patch to do that.

(This patch also contains the few setup issues Junio found with the
new "default_abbrev is negative" model)

              Linus

--001a113dd1d48bcc34053dbda815
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_itq3id0j0

IGJ1aWx0aW4vcmV2LXBhcnNlLmMgfCAgNSArKystLQogZGlmZi5jICAgICAgICAgICAgICB8ICAy
ICstCiBlbnZpcm9ubWVudC5jICAgICAgIHwgIDIgKy0KIHNoYTFfbmFtZS5jICAgICAgICAgfCAz
OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDQgZmlsZXMgY2hhbmdl
ZCwgNDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9idWlsdGlu
L3Jldi1wYXJzZS5jIGIvYnVpbHRpbi9yZXYtcGFyc2UuYwppbmRleCA0ZGExZjFkYTIuLmNmYjBm
MTUxMCAxMDA2NDQKLS0tIGEvYnVpbHRpbi9yZXYtcGFyc2UuYworKysgYi9idWlsdGluL3Jldi1w
YXJzZS5jCkBAIC02NzEsOCArNjcxLDkgQEAgaW50IGNtZF9yZXZfcGFyc2UoaW50IGFyZ2MsIGNv
bnN0IGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpwcmVmaXgpCiAJCQkJZmlsdGVyICY9IH4oRE9f
RkxBR1N8RE9fTk9SRVYpOwogCQkJCXZlcmlmeSA9IDE7CiAJCQkJYWJicmV2ID0gREVGQVVMVF9B
QkJSRVY7Ci0JCQkJaWYgKGFyZ1s3XSA9PSAnPScpCi0JCQkJCWFiYnJldiA9IHN0cnRvdWwoYXJn
ICsgOCwgTlVMTCwgMTApOworCQkJCWlmICghYXJnWzddKQorCQkJCQljb250aW51ZTsKKwkJCQlh
YmJyZXYgPSBzdHJ0b3VsKGFyZyArIDgsIE5VTEwsIDEwKTsKIAkJCQlpZiAoYWJicmV2IDwgTUlO
SU1VTV9BQkJSRVYpCiAJCQkJCWFiYnJldiA9IE1JTklNVU1fQUJCUkVWOwogCQkJCWVsc2UgaWYg
KDQwIDw9IGFiYnJldikKZGlmZiAtLWdpdCBhL2RpZmYuYyBiL2RpZmYuYwppbmRleCA1OTkyMDc0
N2QuLmM2ZDQ0NTkxNSAxMDA2NDQKLS0tIGEvZGlmZi5jCisrKyBiL2RpZmYuYwpAQCAtMzQyMSw3
ICszNDIxLDcgQEAgdm9pZCBkaWZmX3NldHVwX2RvbmUoc3RydWN0IGRpZmZfb3B0aW9ucyAqb3B0
aW9ucykKIAkJCSAqLwogCQkJcmVhZF9jYWNoZSgpOwogCX0KLQlpZiAob3B0aW9ucy0+YWJicmV2
IDw9IDAgfHwgNDAgPCBvcHRpb25zLT5hYmJyZXYpCisJaWYgKG9wdGlvbnMtPmFiYnJldiA+IDQw
KQogCQlvcHRpb25zLT5hYmJyZXYgPSA0MDsgLyogZnVsbCAqLwogCiAJLyoKZGlmZiAtLWdpdCBh
L2Vudmlyb25tZW50LmMgYi9lbnZpcm9ubWVudC5jCmluZGV4IGMxNDQyZGY5YS4uZmQ2NjgxZTQ2
IDEwMDY0NAotLS0gYS9lbnZpcm9ubWVudC5jCisrKyBiL2Vudmlyb25tZW50LmMKQEAgLTE2LDcg
KzE2LDcgQEAgaW50IHRydXN0X2V4ZWN1dGFibGVfYml0ID0gMTsKIGludCB0cnVzdF9jdGltZSA9
IDE7CiBpbnQgY2hlY2tfc3RhdCA9IDE7CiBpbnQgaGFzX3N5bWxpbmtzID0gMTsKLWludCBtaW5p
bXVtX2FiYnJldiA9IDQsIGRlZmF1bHRfYWJicmV2ID0gNzsKK2ludCBtaW5pbXVtX2FiYnJldiA9
IDQsIGRlZmF1bHRfYWJicmV2ID0gLTE7CiBpbnQgaWdub3JlX2Nhc2U7CiBpbnQgYXNzdW1lX3Vu
Y2hhbmdlZDsKIGludCBwcmVmZXJfc3ltbGlua19yZWZzOwpkaWZmIC0tZ2l0IGEvc2hhMV9uYW1l
LmMgYi9zaGExX25hbWUuYwppbmRleCAzYjY0N2ZkN2MuLjY4NGIzNmRiYSAxMDA2NDQKLS0tIGEv
c2hhMV9uYW1lLmMKKysrIGIvc2hhMV9uYW1lLmMKQEAgLTE1LDYgKzE1LDcgQEAgdHlwZWRlZiBp
bnQgKCpkaXNhbWJpZ3VhdGVfaGludF9mbikoY29uc3QgdW5zaWduZWQgY2hhciAqLCB2b2lkICop
OwogCiBzdHJ1Y3QgZGlzYW1iaWd1YXRlX3N0YXRlIHsKIAlpbnQgbGVuOyAvKiBsZW5ndGggb2Yg
cHJlZml4IGluIGhleCBjaGFycyAqLworCXVuc2lnbmVkIGludCBucm9iamVjdHM7CiAJY2hhciBo
ZXhfcGZ4W0dJVF9TSEExX0hFWFNaICsgMV07CiAJdW5zaWduZWQgY2hhciBiaW5fcGZ4W0dJVF9T
SEExX1JBV1NaXTsKIApAQCAtMTE4LDYgKzExOSwxMiBAQCBzdGF0aWMgdm9pZCBmaW5kX3Nob3J0
X29iamVjdF9maWxlbmFtZShzdHJ1Y3QgZGlzYW1iaWd1YXRlX3N0YXRlICpkcykKIAogCQkJaWYg
KHN0cmxlbihkZS0+ZF9uYW1lKSAhPSAzOCkKIAkJCQljb250aW51ZTsKKworCQkJLy8gV2Ugb25s
eSBsb29rIGF0IHRoZSBvbmUgc3ViZGlyZWN0b3J5LCBhbmQgd2UgYXNzdW1lCisJCQkvLyBlYWNo
IHN1YmRpcmVjdG9yeSBpcyByb3VnaGx5IHNpbWlsYXIsIHNvIGVhY2ggb2JqZWN0CisJCQkvLyB3
ZSBmaW5kIHByb2JhYmx5IGhhcyAyNTUgb3RoZXIgb2JqZWN0cyBpbiB0aGUgb3RoZXIKKwkJCS8v
IGZhbi1vdXQgZGlyZWN0b3JpZXMKKwkJCWRzLT5ucm9iamVjdHMgKz0gMjU2OwogCQkJaWYgKG1l
bWNtcChkZS0+ZF9uYW1lLCBkcy0+aGV4X3BmeCArIDIsIGRzLT5sZW4gLSAyKSkKIAkJCQljb250
aW51ZTsKIAkJCW1lbWNweShoZXggKyAyLCBkZS0+ZF9uYW1lLCAzOCk7CkBAIC0xNTEsNiArMTU4
LDcgQEAgc3RhdGljIHZvaWQgdW5pcXVlX2luX3BhY2soc3RydWN0IHBhY2tlZF9naXQgKnAsCiAK
IAlvcGVuX3BhY2tfaW5kZXgocCk7CiAJbnVtID0gcC0+bnVtX29iamVjdHM7CisJZHMtPm5yb2Jq
ZWN0cyArPSBudW07CiAJbGFzdCA9IG51bTsKIAl3aGlsZSAoZmlyc3QgPCBsYXN0KSB7CiAJCXVp
bnQzMl90IG1pZCA9IChmaXJzdCArIGxhc3QpIC8gMjsKQEAgLTQ1NSwxNyArNDYzLDQ2IEBAIGlu
dCBmb3JfZWFjaF9hYmJyZXYoY29uc3QgY2hhciAqcHJlZml4LCBlYWNoX2FiYnJldl9mbiBmbiwg
dm9pZCAqY2JfZGF0YSkKIAlyZXR1cm4gcmV0OwogfQogCitzdGF0aWMgaW50IGdldF9hdXRvbWF0
aWNfYWJicmV2KGNvbnN0IGNoYXIgKmhleCkKK3sKKwlzdGF0aWMgaW50IGxlbjsKKwlzdHJ1Y3Qg
ZGlzYW1iaWd1YXRlX3N0YXRlIGRzOworCisJaWYgKGluaXRfb2JqZWN0X2Rpc2FtYmlndWF0aW9u
KGhleCwgNywgJmRzKSA8IDApCisJCXJldHVybiA3OworCisJZmluZF9zaG9ydF9vYmplY3RfZmls
ZW5hbWUoJmRzKTsKKwlmaW5kX3Nob3J0X3BhY2tlZF9vYmplY3QoJmRzKTsKKworCWZvciAobGVu
ID0gNzsgbGVuIDwgMTY7IGxlbisrKSB7CisJCXVuc2lnbmVkIGludCBleHBlY3RfY29sbGlzaW9u
ID0gMSA8PCAobGVuICogMik7CisJCWlmIChkcy5ucm9iamVjdHMgPCBleHBlY3RfY29sbGlzaW9u
KQorCQkJYnJlYWs7CisJfQorCXJldHVybiBsZW47Cit9CisKIGludCBmaW5kX3VuaXF1ZV9hYmJy
ZXZfcihjaGFyICpoZXgsIGNvbnN0IHVuc2lnbmVkIGNoYXIgKnNoYTEsIGludCBsZW4pCiB7CiAJ
aW50IHN0YXR1cywgZXhpc3RzOworCWludCBmbGFncyA9IEdFVF9TSEExX1FVSUVUTFk7CiAKIAlz
aGExX3RvX2hleF9yKGhleCwgc2hhMSk7CiAJaWYgKGxlbiA9PSA0MCB8fCAhbGVuKQogCQlyZXR1
cm4gNDA7CisKKwlpZiAobGVuIDwgMCkgeworCQlzdGF0aWMgaW50IGF1dG9tYXRpY19hYmJyZXYg
PSAtMTsKKworCQlpZiAoYXV0b21hdGljX2FiYnJldiA8IDApCisJCQlhdXRvbWF0aWNfYWJicmV2
ID0gZ2V0X2F1dG9tYXRpY19hYmJyZXYoaGV4KTsKKwkJbGVuID0gYXV0b21hdGljX2FiYnJldjsK
Kwl9CisKIAlleGlzdHMgPSBoYXNfc2hhMV9maWxlKHNoYTEpOwogCXdoaWxlIChsZW4gPCA0MCkg
ewogCQl1bnNpZ25lZCBjaGFyIHNoYTFfcmV0WzIwXTsKLQkJc3RhdHVzID0gZ2V0X3Nob3J0X3No
YTEoaGV4LCBsZW4sIHNoYTFfcmV0LCBHRVRfU0hBMV9RVUlFVExZKTsKKwkJc3RhdHVzID0gZ2V0
X3Nob3J0X3NoYTEoaGV4LCBsZW4sIHNoYTFfcmV0LCBmbGFncyk7CiAJCWlmIChleGlzdHMKIAkJ
ICAgID8gIXN0YXR1cwogCQkgICAgOiBzdGF0dXMgPT0gU0hPUlRfTkFNRV9OT1RfRk9VTkQpIHsK
--001a113dd1d48bcc34053dbda815--
