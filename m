Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD95201A8
	for <e@80x24.org>; Mon, 20 Feb 2017 01:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbdBTBsb (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 20:48:31 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:33879 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbdBTBsa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 20:48:30 -0500
Received: by mail-ot0-f175.google.com with SMTP id x10so20531330otb.1
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 17:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WU4rCU5hMeeN86g5HROHHOCDp5txzRdzQpcnT/e1xdI=;
        b=cTbtFSWZT0caC0PgKyVyMWgdaKJ2qoHvQUmAB6Dnmm2efTiGWhKDYV1/TcGH5X1UgQ
         8tduyiDIeY/ep0GIe6DTsqtRAtch+MD/6CYp/Gxl8iqQncBuPiz85uLZYXWlAuQhAr8u
         bqcwNgq+lSTt2S4QcjkzogCML6gPX2ewZl4WK8hFcDJge+Ubn4g9+e3oh0KzUQSatUyj
         oxUBbQ1ughTC7+LS+5jLotizVHySQe8caARjjF4j38XJMPdr1CaIudsCkGS5Is9FhkYV
         33BZlQM8GcxSBOmecsW1h7csNbFoVVO0HsaCsa7O2XIIYQNkE3RJciIk+AKi60/7WqsR
         3iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WU4rCU5hMeeN86g5HROHHOCDp5txzRdzQpcnT/e1xdI=;
        b=jbr2/nqgvT5BhpbUtsa7iebttkeKaZcd9rI8x8fjdfujtBHMBSbjoR6HYK0NkmBFJW
         GYwMitUTlknw1zqC4tD1FmBS3AOgLUdCwvaAb7OlKK+SCyeD0jTrYZpF0KLBcmhHWUsB
         kVvlnB4ZD0qwSqOk6THJ68zoNG0g3ZtXEt9NtGY3luI+4okKLjYAOWfcssDJuctgDFT/
         gafVPpGi/APy7c7QPR/J+sok6lBHuTVNK0CmdVzlpG/HpN6SEfROWsnsdFGoHvf/2aXO
         SGWOgW5Si+J11s8Y9XR16toAltInWpArnWGb98kUjK6iR2ScMMV+9yW7XWnDvYfZXJpu
         D+mQ==
X-Gm-Message-State: AMke39kMmsUJcAhiiYVmEKwPZgb4y4B1BwpmQjDYm7ubeIXvK/NkTHKTcJEb2Fm7dpPDoC50dbeXVkdUl5FyYA==
X-Received: by 10.157.41.135 with SMTP id n7mr9083537otb.165.1487555308758;
 Sun, 19 Feb 2017 17:48:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Sun, 19 Feb 2017 17:48:28 -0800 (PST)
In-Reply-To: <20170220004648.c2zz6bm2hylvep6x@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan> <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
 <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com> <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
 <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com> <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
 <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net> <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
 <CA+P7+xqtPwzt3J6O05TP=E_hh-ko97adn+__Zmc0DNSDqEnEHw@mail.gmail.com> <20170220004648.c2zz6bm2hylvep6x@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Feb 2017 17:48:28 -0800
X-Google-Sender-Auth: ClL7uWarEYDAiPPWVErnU3OBmJc
Message-ID: <CA+55aFwdUxCvmi28T3yn1K4rqn2bZmJBdTRr7tSbMa-g5izHbw@mail.gmail.com>
Subject: Re: [RFC PATCH] show decorations at the end of the line
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a11429ed8c363c10548ec755a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a11429ed8c363c10548ec755a
Content-Type: text/plain; charset=UTF-8

On Sun, Feb 19, 2017 at 4:46 PM, Jeff King <peff@peff.net> wrote:
>
> I think there are two potential patches:
>
>   1. Add a custom-format placeholder for the --source value.
>      This is an obvious improvement that doesn't hurt anyone.

Right.

>   2. Switch --decorate to the end by default, but _not_ --source.

.. and in fact the whole "--source" printing should not even have been
mixed up with the decorations.

So (2) is actually easy to fix: just don't mix "show_source()" with
"show_decorations()", because they are totally different things to
begin with.

That source showing should never have been in "show_decorations()" in
the first place. It just happened to be a convenient place for it.

So this attached patch is just my original patch updated to split up
"show_source()" from "show_decorations()", and show it where it used
to be.

Maybe this works for Junio's alias?

              Linus

--001a11429ed8c363c10548ec755a
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-show-decorations-at-the-end-of-the-line.patch"
Content-Disposition: attachment; 
	filename="0001-show-decorations-at-the-end-of-the-line.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_izdg0hio0

RnJvbSA5N2FiYWI1NmZlZDQ1MTQ3NmY2ZWM2NzYzNDZiMWU2NjAwMWVmODY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgMTEgRmViIDIwMTcgMTA6MDM6MzMgLTA4MDAKU3ViamVjdDog
W1BBVENIXSBzaG93IGRlY29yYXRpb25zIGF0IHRoZSBlbmQgb2YgdGhlIGxpbmUKClNvIEkgdXNl
ICItLXNob3ctZGVjb3JhdGlvbnMiIGFsbCB0aGUgdGltZSBiZWNhdXNlIEkgZmluZCBpdCB2ZXJ5
IHVzZWZ1bAp0byBzZWUgd2hlcmUgdGhlIG9yaWdpbiBicmFuY2ggaXMsIHdoZXJlIHRhZ3MgYXJl
IGV0Yy4gSW4gZmFjdCwgbXkgZ2xvYmFsCmdpdCBjb25maWcgZmlsZSBoYXMKCiAgICBbbG9nXQog
ICAgICAgIGRlY29yYXRlID0gYXV0bwoKaW4gaXQsIHNvIHRoYXQgSSBkb24ndCBoYXZlIHRvIHR5
cGUgaXQgb3V0IGFsbCB0aGUgdGltZSB3aGVuIEkganVzdCBkbyBteQp1c3VhbCAnZ2l0IGxvZyIu
IEl0J3MgbG92ZWx5LgoKSG93ZXZlciwgaXQgZG9lcyBtYWtlIG9uZSBwYXJ0aWN1bGFyIGNhc2Ug
dWdsaWVyOiB3aXRoIGNvbW1pdCBkZWNvcmF0aW9ucywKdGhlICJvbmVsaW5lIiBjb21taXQgZm9y
bWF0IGVuZHMgdXAgYmVpbmcgbm90IHZlcnkgcHJldHR5OgoKICAgIFt0b3J2YWxkc0BpNyBnaXRd
JCBnaXQgbG9nIC0tb25lbGluZSAtMTAKICAgIDNmMDdkYWMyOSAoSEVBRCAtPiBtYXN0ZXIpIHBh
dGhzcGVjOiBkb24ndCBlcnJvciBvdXQgb24gIGFsbC1leGNsdXNpb25hcnkgcGF0aHNwZWMgcGF0
dGVybnMKICAgIGNhNGE1NjJmMiBwYXRoc3BlYyBtYWdpYzogYWRkICdeJyBhcyBhbGlhcyBmb3Ig
JyEnCiAgICAwMjU1NWMxYjIgbHMtcmVtb3RlOiBhZGQgIi0tZGlmZiIgb3B0aW9uIHRvIHNob3cg
b25seSByZWZzIHRoYXQgZGlmZmVyCiAgICA2ZTNhN2IzMzkgKHRhZzogdjIuMTIuMC1yYzAsIG9y
aWdpbi9tYXN0ZXIsIG9yaWdpbi9IRUFEKSBHaXQgMi4xMi1yYzAKICAgIGZhZmNhMGY3MiBNZXJn
ZSBicmFuY2ggJ2N3L2xvZy11cGRhdGVzLWZvci1hbGwtcmVmcy1yZWFsbHknCiAgICA3NGRlZTVj
ZmEgTWVyZ2UgYnJhbmNoICdwbC9jb21wbGV0ZS1kaWZmLXN1Ym1vZHVsZS1kaWZmJwogICAgMzZh
Y2Y0MTIzIE1lcmdlIGJyYW5jaCAncnMvb2JqZWN0LWlkJwogICAgZWNjNDg2YjFmIE1lcmdlIGJy
YW5jaCAnanMvcmUtcnVubmluZy1mYWlsZWQtdGVzdHMnCiAgICA0YmE2YmIyZDEgTWVyZ2UgYnJh
bmNoICdzYi9zdWJtb2R1bGUtdXBkYXRlLWluaXRpYWwtcnVucy1jdXN0b20tc2NyaXB0JwogICAg
NTM0ODAyMWM2IE1lcmdlIGJyYW5jaCAnc2Ivc3VibW9kdWxlLXJlY3Vyc2l2ZS1hYnNvcmInCgph
bmQgbm90ZSBob3cgdGhlIGRlY29yYXRpb24gY29tZXMgcmlnaHQgYWZ0ZXIgdGhlIHNob3J0ZW5l
ZCBjb21taXQgaGFzaCwKYnJlYWtpbmcgdXAgdGhlIGFsaWdubWVudCBvZiB0aGUgbWVzc2FnZXMu
CgpUaGUgYWJvdmUgZG9lc24ndCBzaG93IGl0IHdpdGggdGhlIGNvbG9yaXphdGlvbjogSSBhbHNv
IGhhdmUKCiAgICBbY29sb3JdCiAgICAgICAgdWk9YXV0bwoKc28gb24gbXkgdGVybWluYWwgdGhl
IGRlY29yYXRpb24gaXMgYWxzbyBuaWNlbHkgY29sb3JpemVkIHdoaWNoIG1ha2VzIGl0Cm11Y2gg
bW9yZSBvYnZpb3VzLCBpdCdzIG5vdCBhcyBvYnZpb3VzIGluIHRoaXMgbWVzc2FnZS4KClRoZSBv
bmVsaW5lIG1lc3NhZ2UgaGFuZGxpbmcgaXMgYWxyZWFkeSBwcmV0dHkgc3BlY2lhbCwgdGhpcyBt
YWtlcyBpdCBldmVuCm1vcmUgc3BlY2lhbCBieSBwdXR0aW5nIHRoZSBkZWNvcmF0aW9ucyBhdCB0
aGUgZW5kIG9mIHRoZSBsaW5lOgoKICAgIDNmMDdkYWMyOSBwYXRoc3BlYzogZG9uJ3QgZXJyb3Ig
b3V0IG9uIGFsbC1leGNsdXNpb25hcnkgcGF0aHNwZWMgcGF0dGVybnMgKEhFQUQgLT4gbWFzdGVy
KQogICAgY2E0YTU2MmYyIHBhdGhzcGVjIG1hZ2ljOiBhZGQgJ14nIGFzIGFsaWFzIGZvciAnIScK
ICAgIDAyNTU1YzFiMiBscy1yZW1vdGU6IGFkZCAiLS1kaWZmIiBvcHRpb24gdG8gc2hvdyBvbmx5
IHJlZnMgdGhhdCBkaWZmZXIKICAgIDZlM2E3YjMzOSBHaXQgMi4xMi1yYzAgKHRhZzogdjIuMTIu
MC1yYzAsIG9yaWdpbi9tYXN0ZXIsIG9yaWdpbi9IRUFEKQogICAgZmFmY2EwZjcyIE1lcmdlIGJy
YW5jaCAnY3cvbG9nLXVwZGF0ZXMtZm9yLWFsbC1yZWZzLXJlYWxseScKICAgIDc0ZGVlNWNmYSBN
ZXJnZSBicmFuY2ggJ3BsL2NvbXBsZXRlLWRpZmYtc3VibW9kdWxlLWRpZmYnCiAgICAzNmFjZjQx
MjMgTWVyZ2UgYnJhbmNoICdycy9vYmplY3QtaWQnCiAgICBlY2M0ODZiMWYgTWVyZ2UgYnJhbmNo
ICdqcy9yZS1ydW5uaW5nLWZhaWxlZC10ZXN0cycKICAgIDRiYTZiYjJkMSBNZXJnZSBicmFuY2gg
J3NiL3N1Ym1vZHVsZS11cGRhdGUtaW5pdGlhbC1ydW5zLWN1c3RvbS1zY3JpcHQnCiAgICA1MzQ4
MDIxYzYgTWVyZ2UgYnJhbmNoICdzYi9zdWJtb2R1bGUtcmVjdXJzaXZlLWFic29yYicKCndoaWNo
IGxvb2tzIGEgbG90IGJldHRlciAoYWdhaW4sIHRoaXMgaXMgYWxsIHBhcnRpY3VsYXJseSBub3Rp
Y2VhYmxlIHdpdGgKY29sb3JpemF0aW9uKS4KCk5PVEUhIFRoZXJlJ3MgYSB2ZXJ5IHNwZWNpYWwg
Y2FzZSBmb3IgImdpdCBsb2cgLS1vbmVsaW5lIC1nIiB0aGF0IHNob3dzCnRoZSByZWZsb2dzIGFz
IG9uZWxpbmVycywgYW5kIHRoaXMgZG9lcyAqbm90KiBmaXggdGhhdCBzcGVjaWFsIGNhc2UuIEl0
J3MKYSBsb3QgbW9yZSBpbnZvbHZlZCBhbmQgcmVsaWVzIG9uIHRoZSBleGFjdCBzaG93X3JlZmxv
Z19tZXNzYWdlKCkKaW1wbGVtZW50YXRpb24sIHNvIEkgbGVmdCB0aGUgZm9ybWF0IGZvciB0aGF0
IGFsb25lLCBhbG9uZyB3aXRoIGEgY29tbWVudAphYm91dCBob3cgaXQncyBub3QgYXQgdGhlIGVu
ZCBvZiBsaW5lLgoKU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4
LWZvdW5kYXRpb24ub3JnPgotLS0KIGJ1aWx0aW4vcmV2LWxpc3QuYyB8ICAxICsKIGxvZy10cmVl
LmMgICAgICAgICB8IDE3ICsrKysrKysrKysrKysrLS0tCiBsb2ctdHJlZS5oICAgICAgICAgfCAg
MSArCiAzIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvYnVpbHRpbi9yZXYtbGlzdC5jIGIvYnVpbHRpbi9yZXYtbGlzdC5jCmluZGV4
IDBhYTkzZDU4OS4uODgzM2YwMjlhIDEwMDY0NAotLS0gYS9idWlsdGluL3Jldi1saXN0LmMKKysr
IGIvYnVpbHRpbi9yZXYtbGlzdC5jCkBAIC0xMDcsNiArMTA3LDcgQEAgc3RhdGljIHZvaWQgc2hv
d19jb21taXQoc3RydWN0IGNvbW1pdCAqY29tbWl0LCB2b2lkICpkYXRhKQogCQkJY2hpbGRyZW4g
PSBjaGlsZHJlbi0+bmV4dDsKIAkJfQogCX0KKwlzaG93X3NvdXJjZShyZXZzLCBjb21taXQpOwog
CXNob3dfZGVjb3JhdGlvbnMocmV2cywgY29tbWl0KTsKIAlpZiAocmV2cy0+Y29tbWl0X2Zvcm1h
dCA9PSBDTUlUX0ZNVF9PTkVMSU5FKQogCQlwdXRjaGFyKCcgJyk7CmRpZmYgLS1naXQgYS9sb2ct
dHJlZS5jIGIvbG9nLXRyZWUuYwppbmRleCA4YzI0MTU3NDcuLjljYTNlOGMxYyAxMDA2NDQKLS0t
IGEvbG9nLXRyZWUuYworKysgYi9sb2ctdHJlZS5jCkBAIC0yNzksMTIgKzI3OSwxNiBAQCB2b2lk
IGZvcm1hdF9kZWNvcmF0aW9uc19leHRlbmRlZChzdHJ1Y3Qgc3RyYnVmICpzYiwKIAlzdHJidWZf
YWRkc3RyKHNiLCBjb2xvcl9yZXNldCk7CiB9CiAKK3ZvaWQgc2hvd19zb3VyY2Uoc3RydWN0IHJl
dl9pbmZvICpvcHQsIHN0cnVjdCBjb21taXQgKmNvbW1pdCkKK3sKKwlpZiAob3B0LT5zaG93X3Nv
dXJjZSAmJiBjb21taXQtPnV0aWwpCisJCWZwcmludGYob3B0LT5kaWZmb3B0LmZpbGUsICJcdCVz
IiwgKGNoYXIgKikgY29tbWl0LT51dGlsKTsKK30KKwogdm9pZCBzaG93X2RlY29yYXRpb25zKHN0
cnVjdCByZXZfaW5mbyAqb3B0LCBzdHJ1Y3QgY29tbWl0ICpjb21taXQpCiB7CiAJc3RydWN0IHN0
cmJ1ZiBzYiA9IFNUUkJVRl9JTklUOwogCi0JaWYgKG9wdC0+c2hvd19zb3VyY2UgJiYgY29tbWl0
LT51dGlsKQotCQlmcHJpbnRmKG9wdC0+ZGlmZm9wdC5maWxlLCAiXHQlcyIsIChjaGFyICopIGNv
bW1pdC0+dXRpbCk7CiAJaWYgKCFvcHQtPnNob3dfZGVjb3JhdGlvbnMpCiAJCXJldHVybjsKIAlm
b3JtYXRfZGVjb3JhdGlvbnMoJnNiLCBjb21taXQsIG9wdC0+ZGlmZm9wdC51c2VfY29sb3IpOwpA
QCAtNTU2LDYgKzU2MCw3IEBAIHZvaWQgc2hvd19sb2coc3RydWN0IHJldl9pbmZvICpvcHQpCiAJ
CQlzaG93X3BhcmVudHMoY29tbWl0LCBhYmJyZXZfY29tbWl0LCBvcHQtPmRpZmZvcHQuZmlsZSk7
CiAJCWlmIChvcHQtPmNoaWxkcmVuLm5hbWUpCiAJCQlzaG93X2NoaWxkcmVuKG9wdCwgY29tbWl0
LCBhYmJyZXZfY29tbWl0KTsKKwkJc2hvd19zb3VyY2Uob3B0LCBjb21taXQpOwogCQlzaG93X2Rl
Y29yYXRpb25zKG9wdCwgY29tbWl0KTsKIAkJaWYgKG9wdC0+Z3JhcGggJiYgIWdyYXBoX2lzX2Nv
bW1pdF9maW5pc2hlZChvcHQtPmdyYXBoKSkgewogCQkJcHV0YygnXG4nLCBvcHQtPmRpZmZvcHQu
ZmlsZSk7CkBAIC02MjIsMTAgKzYyNywxNCBAQCB2b2lkIHNob3dfbG9nKHN0cnVjdCByZXZfaW5m
byAqb3B0KQogCQkJICAgICAgIGZpbmRfdW5pcXVlX2FiYnJldihwYXJlbnQtPm9iamVjdC5vaWQu
aGFzaCwKIAkJCQkJCSAgYWJicmV2X2NvbW1pdCkpOwogCQlmcHV0cyhkaWZmX2dldF9jb2xvcl9v
cHQoJm9wdC0+ZGlmZm9wdCwgRElGRl9SRVNFVCksIG9wdC0+ZGlmZm9wdC5maWxlKTsKLQkJc2hv
d19kZWNvcmF0aW9ucyhvcHQsIGNvbW1pdCk7CisJCXNob3dfc291cmNlKG9wdCwgY29tbWl0KTsK
IAkJaWYgKG9wdC0+Y29tbWl0X2Zvcm1hdCA9PSBDTUlUX0ZNVF9PTkVMSU5FKSB7CisJCQkvKiBO
b3QgYXQgZW5kIG9mIGxpbmUsIGJ1dC4uICovCisJCQlpZiAob3B0LT5yZWZsb2dfaW5mbykKKwkJ
CQlzaG93X2RlY29yYXRpb25zKG9wdCwgY29tbWl0KTsKIAkJCXB1dGMoJyAnLCBvcHQtPmRpZmZv
cHQuZmlsZSk7CiAJCX0gZWxzZSB7CisJCQlzaG93X2RlY29yYXRpb25zKG9wdCwgY29tbWl0KTsK
IAkJCXB1dGMoJ1xuJywgb3B0LT5kaWZmb3B0LmZpbGUpOwogCQkJZ3JhcGhfc2hvd19vbmVsaW5l
KG9wdC0+Z3JhcGgpOwogCQl9CkBAIC03MTYsNiArNzI1LDggQEAgdm9pZCBzaG93X2xvZyhzdHJ1
Y3QgcmV2X2luZm8gKm9wdCkKIAkJb3B0LT5taXNzaW5nX25ld2xpbmUgPSAwOwogCiAJZ3JhcGhf
c2hvd19jb21taXRfbXNnKG9wdC0+Z3JhcGgsIG9wdC0+ZGlmZm9wdC5maWxlLCAmbXNnYnVmKTsK
KwlpZiAoY3R4LmZtdCA9PSBDTUlUX0ZNVF9PTkVMSU5FKQorCQlzaG93X2RlY29yYXRpb25zKG9w
dCwgY29tbWl0KTsKIAlpZiAob3B0LT51c2VfdGVybWluYXRvciAmJiAhY29tbWl0X2Zvcm1hdF9p
c19lbXB0eShvcHQtPmNvbW1pdF9mb3JtYXQpKSB7CiAJCWlmICghb3B0LT5taXNzaW5nX25ld2xp
bmUpCiAJCQlncmFwaF9zaG93X3BhZGRpbmcob3B0LT5ncmFwaCk7CmRpZmYgLS1naXQgYS9sb2ct
dHJlZS5oIGIvbG9nLXRyZWUuaAppbmRleCBjODExNmU2MGMuLjMzZDQxNTgyMCAxMDA2NDQKLS0t
IGEvbG9nLXRyZWUuaAorKysgYi9sb2ctdHJlZS5oCkBAIC0yMCw2ICsyMCw3IEBAIHZvaWQgZm9y
bWF0X2RlY29yYXRpb25zX2V4dGVuZGVkKHN0cnVjdCBzdHJidWYgKnNiLCBjb25zdCBzdHJ1Y3Qg
Y29tbWl0ICpjb21taXQsCiAJCQkgICAgIGNvbnN0IGNoYXIgKnN1ZmZpeCk7CiAjZGVmaW5lIGZv
cm1hdF9kZWNvcmF0aW9ucyhzdHJidWYsIGNvbW1pdCwgY29sb3IpIFwKIAkJCSAgICAgZm9ybWF0
X2RlY29yYXRpb25zX2V4dGVuZGVkKChzdHJidWYpLCAoY29tbWl0KSwgKGNvbG9yKSwgIiAoIiwg
IiwgIiwgIikiKQordm9pZCBzaG93X3NvdXJjZShzdHJ1Y3QgcmV2X2luZm8gKm9wdCwgc3RydWN0
IGNvbW1pdCAqY29tbWl0KTsKIHZvaWQgc2hvd19kZWNvcmF0aW9ucyhzdHJ1Y3QgcmV2X2luZm8g
Km9wdCwgc3RydWN0IGNvbW1pdCAqY29tbWl0KTsKIHZvaWQgbG9nX3dyaXRlX2VtYWlsX2hlYWRl
cnMoc3RydWN0IHJldl9pbmZvICpvcHQsIHN0cnVjdCBjb21taXQgKmNvbW1pdCwKIAkJCSAgICAg
Y29uc3QgY2hhciAqKnN1YmplY3RfcCwKLS0gCjIuMTIuMC5yYzIuNC5nOTdhYmFiNTZmCgo=
--001a11429ed8c363c10548ec755a--
