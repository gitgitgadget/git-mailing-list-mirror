Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19218207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbcI2Szu (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:55:50 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35739 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbcI2Szs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:55:48 -0400
Received: by mail-oi0-f66.google.com with SMTP id n202so5708950oig.2
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I1NjXrEOJ9CEbEE8OttEkAzrPaYMG/iPOVLASRPuEbw=;
        b=vx08f5crVXyHSklljpY1uBmngzPZn5CigTmGYpYRY1ddlG/AFMu+s6esiRJK2WVUj3
         ln4zSFCChNvYw9wA/nxshzJcTsC/KfNQqaxNcdEh74rkbk8+0EeBbrQf1rYJAnyQkEIm
         KNkt1gqkcnLbYjeUBX4TlSA0aMgHf1Rz+Ciotzl+AZ9XXb7+fQRL1OfckYaY+v/kXTrd
         eODGruo0bfdobZZRma1mIrQzOpMPqJQWFVxa1LGZ+S2QZSkGsyO9GPX7DzyjQ3P27kxM
         gWhNQ2BBLIAKFDfHbxn2X/wQYV+2ksHFF9hmSGhAUDUqIJxnvD78bMK1q1FTNF2V2cal
         mcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I1NjXrEOJ9CEbEE8OttEkAzrPaYMG/iPOVLASRPuEbw=;
        b=cuCSpIX0SgdAxgVbdmRbJmbIgTDWFhzWfmRwnSL5cpgBrgqc3Awj8AjqNvfKmGepq8
         B8eD/ZKOy/B6QU490cRBLBhnowyKcnWPtu1FP0xWG5n/ahCTYd7lD8jC+jpeMjNkZfRl
         0Q8kURaIhdqYShYRYMl6R9gS5bFa+dcDyUbOo3Ons+i+0J+L1le1X5GUvKsIn8xfV9Ef
         DgJFHv0y/4bpHDkc7Oe6YoGipwLfuwCQ6YN7KgYdpMu+Nok+EOv10VKtLn5B+v8+W0oE
         237JJkHwBo052fBvSfWTHq1bfcX5lDIOasb0IVk6zjzlhF6L49bQNayVG9HjF9jAOIFp
         gKLg==
X-Gm-Message-State: AA6/9RkA44WGYtx4oarYLdPi6A3Es3oSlQWhLDRWiZhuM6tngLpdBb5XJoifR+Ra5YSv3VPt5UyVwO2OhIg4cQ==
X-Received: by 10.202.4.21 with SMTP id 21mr2873669oie.91.1475175347797; Thu,
 29 Sep 2016 11:55:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 11:55:46 -0700 (PDT)
In-Reply-To: <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 11:55:46 -0700
X-Google-Sender-Auth: Omw5MoG9Y_kc0sH5UxAnXbcn7IA
Message-ID: <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary=001a113c088096a473053daa0627
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a113c088096a473053daa0627
Content-Type: text/plain; charset=UTF-8

On Thu, Sep 29, 2016 at 11:37 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm playing with an early patch to make the default more dynamic.
> Let's see how well it works in practice, but it looks fairly
> promising. Let me test a bit more and send out an RFC patch..

Ok, this is *very* rough, and it doesn't actuall pass all the tests,
and I didn't even try to look at why. But it passes the trivial
smell-test, and in particular it actually makes mathematical sense...

I think the patch can speak for itself, but the basic core is this
section in get_short_sha1():

  +       if (len < 16 && !status && (flags & GET_SHA1_AUTOMATIC)) {
  +               unsigned int expect_collision = 1 << (len * 2);
  +               if (ds.nrobjects > expect_collision)
  +                       return SHORT_NAME_AMBIGUOUS;
  +       }

basically, what it says is that we will consider a sha1 ambiguous even
if it was *technically* unique (that's the '!status' part of the test)
if:

 - the length was 15 or less

*and*

 - the number of objects we have is larger than the expected point
where statistically we should start to expect to get one collision.

That "expect_collision" math is actually very simple: each hex
character adds four bits of range, but since we expect collisions at
the square root of the maximum number of objects, we shift by just two
bits per hex digits instead.

The rest of the patch is a trivial change to just initialize the
default short size to -1, and consider that to mean "enable the
automatic size checking with a minimum of 7". And the trivial code to
estimate the number of objects (which ignores duplicates between packs
etc _entirely_).

For the kernel, just the *math* right now actually gives 12
characters. For current git it actually seems to say that 8 is the
correct number. For small projects, you'll still see 7.

ANYWAY. This patch is on top of Jeff's patches in 'pu' (I think those
are great regardless of this patch!), and as mentioned, it fails some
tests. I suspect that the failures might be due to the abbrev_default
being -1, and some other code finds that surprising now. But as
mentioned, I didn't really even look at it.

What do you think? It's actually a fairly simple patch and I really do
think it makes sense and it seems to just DTRT automatically.

              Linus

--001a113c088096a473053daa0627
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_itop80km0

IGNhY2hlLmggICAgICAgfCAgMSArCiBlbnZpcm9ubWVudC5jIHwgIDIgKy0KIHNoYTFfbmFtZS5j
ICAgfCAyMSArKysrKysrKysrKysrKysrKysrKy0KIDMgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jYWNoZS5oIGIvY2FjaGUuaApp
bmRleCA2ZTMzZjJmLi5kMmRhNmQxIDEwMDY0NAotLS0gYS9jYWNoZS5oCisrKyBiL2NhY2hlLmgK
QEAgLTEyMDcsNiArMTIwNyw3IEBAIHN0cnVjdCBvYmplY3RfY29udGV4dCB7CiAjZGVmaW5lIEdF
VF9TSEExX1RSRUVJU0ggICAgICAgICAgMDIwCiAjZGVmaW5lIEdFVF9TSEExX0JMT0IgICAgICAg
ICAgICAgMDQwCiAjZGVmaW5lIEdFVF9TSEExX0ZPTExPV19TWU1MSU5LUyAwMTAwCisjZGVmaW5l
IEdFVF9TSEExX0FVVE9NQVRJQwkgMDIwMAogI2RlZmluZSBHRVRfU0hBMV9PTkxZX1RPX0RJRSAg
ICAwNDAwMAogCiAjZGVmaW5lIEdFVF9TSEExX0RJU0FNQklHVUFUT1JTIFwKZGlmZiAtLWdpdCBh
L2Vudmlyb25tZW50LmMgYi9lbnZpcm9ubWVudC5jCmluZGV4IGMxNDQyZGYuLmZkNjY4MWUgMTAw
NjQ0Ci0tLSBhL2Vudmlyb25tZW50LmMKKysrIGIvZW52aXJvbm1lbnQuYwpAQCAtMTYsNyArMTYs
NyBAQCBpbnQgdHJ1c3RfZXhlY3V0YWJsZV9iaXQgPSAxOwogaW50IHRydXN0X2N0aW1lID0gMTsK
IGludCBjaGVja19zdGF0ID0gMTsKIGludCBoYXNfc3ltbGlua3MgPSAxOwotaW50IG1pbmltdW1f
YWJicmV2ID0gNCwgZGVmYXVsdF9hYmJyZXYgPSA3OworaW50IG1pbmltdW1fYWJicmV2ID0gNCwg
ZGVmYXVsdF9hYmJyZXYgPSAtMTsKIGludCBpZ25vcmVfY2FzZTsKIGludCBhc3N1bWVfdW5jaGFu
Z2VkOwogaW50IHByZWZlcl9zeW1saW5rX3JlZnM7CmRpZmYgLS1naXQgYS9zaGExX25hbWUuYyBi
L3NoYTFfbmFtZS5jCmluZGV4IDNiNjQ3ZmQuLjg3OTFmZjMgMTAwNjQ0Ci0tLSBhL3NoYTFfbmFt
ZS5jCisrKyBiL3NoYTFfbmFtZS5jCkBAIC0xNSw2ICsxNSw3IEBAIHR5cGVkZWYgaW50ICgqZGlz
YW1iaWd1YXRlX2hpbnRfZm4pKGNvbnN0IHVuc2lnbmVkIGNoYXIgKiwgdm9pZCAqKTsKIAogc3Ry
dWN0IGRpc2FtYmlndWF0ZV9zdGF0ZSB7CiAJaW50IGxlbjsgLyogbGVuZ3RoIG9mIHByZWZpeCBp
biBoZXggY2hhcnMgKi8KKwl1bnNpZ25lZCBpbnQgbnJvYmplY3RzOwogCWNoYXIgaGV4X3BmeFtH
SVRfU0hBMV9IRVhTWiArIDFdOwogCXVuc2lnbmVkIGNoYXIgYmluX3BmeFtHSVRfU0hBMV9SQVdT
Wl07CiAKQEAgLTExOCw2ICsxMTksMTIgQEAgc3RhdGljIHZvaWQgZmluZF9zaG9ydF9vYmplY3Rf
ZmlsZW5hbWUoc3RydWN0IGRpc2FtYmlndWF0ZV9zdGF0ZSAqZHMpCiAKIAkJCWlmIChzdHJsZW4o
ZGUtPmRfbmFtZSkgIT0gMzgpCiAJCQkJY29udGludWU7CisKKwkJCS8vIFdlIG9ubHkgbG9vayBh
dCB0aGUgb25lIHN1YmRpcmVjdG9yeSwgYW5kIHdlIGFzc3VtZQorCQkJLy8gZWFjaCBzdWJkaXJl
Y3RvcnkgaXMgcm91Z2hseSBzaW1pbGFyLCBzbyBlYWNoIG9iamVjdAorCQkJLy8gd2UgZmluZCBw
cm9iYWJseSBoYXMgMjU1IG90aGVyIG9iamVjdHMgaW4gdGhlIG90aGVyCisJCQkvLyBmYW4tb3V0
IGRpcmVjdG9yaWVzCisJCQlkcy0+bnJvYmplY3RzICs9IDI1NjsKIAkJCWlmIChtZW1jbXAoZGUt
PmRfbmFtZSwgZHMtPmhleF9wZnggKyAyLCBkcy0+bGVuIC0gMikpCiAJCQkJY29udGludWU7CiAJ
CQltZW1jcHkoaGV4ICsgMiwgZGUtPmRfbmFtZSwgMzgpOwpAQCAtMTUxLDYgKzE1OCw3IEBAIHN0
YXRpYyB2b2lkIHVuaXF1ZV9pbl9wYWNrKHN0cnVjdCBwYWNrZWRfZ2l0ICpwLAogCiAJb3Blbl9w
YWNrX2luZGV4KHApOwogCW51bSA9IHAtPm51bV9vYmplY3RzOworCWRzLT5ucm9iamVjdHMgKz0g
bnVtOwogCWxhc3QgPSBudW07CiAJd2hpbGUgKGZpcnN0IDwgbGFzdCkgewogCQl1aW50MzJfdCBt
aWQgPSAoZmlyc3QgKyBsYXN0KSAvIDI7CkBAIC00MjYsNiArNDM0LDEyIEBAIHN0YXRpYyBpbnQg
Z2V0X3Nob3J0X3NoYTEoY29uc3QgY2hhciAqbmFtZSwgaW50IGxlbiwgdW5zaWduZWQgY2hhciAq
c2hhMSwKIAkJZm9yX2VhY2hfYWJicmV2KGRzLmhleF9wZngsIHNob3dfYW1iaWd1b3VzX29iamVj
dCwgJmRzKTsKIAl9CiAKKwlpZiAobGVuIDwgMTYgJiYgIXN0YXR1cyAmJiAoZmxhZ3MgJiBHRVRf
U0hBMV9BVVRPTUFUSUMpKSB7CisJCXVuc2lnbmVkIGludCBleHBlY3RfY29sbGlzaW9uID0gMSA8
PCAobGVuICogMik7CisJCWlmIChkcy5ucm9iamVjdHMgPiBleHBlY3RfY29sbGlzaW9uKQorCQkJ
cmV0dXJuIFNIT1JUX05BTUVfQU1CSUdVT1VTOworCX0KKwogCXJldHVybiBzdGF0dXM7CiB9CiAK
QEAgLTQ1OCwxNCArNDcyLDE5IEBAIGludCBmb3JfZWFjaF9hYmJyZXYoY29uc3QgY2hhciAqcHJl
Zml4LCBlYWNoX2FiYnJldl9mbiBmbiwgdm9pZCAqY2JfZGF0YSkKIGludCBmaW5kX3VuaXF1ZV9h
YmJyZXZfcihjaGFyICpoZXgsIGNvbnN0IHVuc2lnbmVkIGNoYXIgKnNoYTEsIGludCBsZW4pCiB7
CiAJaW50IHN0YXR1cywgZXhpc3RzOworCWludCBmbGFncyA9IEdFVF9TSEExX1FVSUVUTFk7CiAK
KwlpZiAobGVuIDwgMCkgeworCQlmbGFncyB8PSBHRVRfU0hBMV9BVVRPTUFUSUM7CisJCWxlbiA9
IDc7CisJfQogCXNoYTFfdG9faGV4X3IoaGV4LCBzaGExKTsKIAlpZiAobGVuID09IDQwIHx8ICFs
ZW4pCiAJCXJldHVybiA0MDsKIAlleGlzdHMgPSBoYXNfc2hhMV9maWxlKHNoYTEpOwogCXdoaWxl
IChsZW4gPCA0MCkgewogCQl1bnNpZ25lZCBjaGFyIHNoYTFfcmV0WzIwXTsKLQkJc3RhdHVzID0g
Z2V0X3Nob3J0X3NoYTEoaGV4LCBsZW4sIHNoYTFfcmV0LCBHRVRfU0hBMV9RVUlFVExZKTsKKwkJ
c3RhdHVzID0gZ2V0X3Nob3J0X3NoYTEoaGV4LCBsZW4sIHNoYTFfcmV0LCBmbGFncyk7CiAJCWlm
IChleGlzdHMKIAkJICAgID8gIXN0YXR1cwogCQkgICAgOiBzdGF0dXMgPT0gU0hPUlRfTkFNRV9O
T1RfRk9VTkQpIHsK
--001a113c088096a473053daa0627--
