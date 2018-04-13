Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D6C1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 17:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbeDMROa (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 13:14:30 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:44913 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeDMRO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 13:14:29 -0400
Received: by mail-io0-f177.google.com with SMTP id d7so11016931ioc.11
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FLIQAhWaKW9EMW5WFbJF24mpc7w+AT2Fvv/X7P0tyCc=;
        b=BnMko167LYihyGR1AAtmjQVnf+rlMFnJ1LnGEfTpvw0TyPxdpTxrW9rb9nq1LvQFbx
         ESnnIZUdsGD9DQlRdEqPl5Nq5Gp3Bx610GF68uRPuVJ08quygsxda6O97j0YT8fZ66H8
         1v0lTyYXcsBE2Dg9tW7RFRKTJlZlOaMSTQBl+MCRvqHm2ROziubDV69gZOCs4HlnmpkF
         UggwcbFOtCb9aW42NMaRVMRvGHQcqPSrqo6IX43O+qkZ0FUpD/sMZaH6c2aqyxlh5TRJ
         cBVudBIx7P2SxhqWzgtXWFTuXEWDykdhfl+vcDd88cpkiQD6Av9NStJHSKrA7lliPKYx
         KyCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FLIQAhWaKW9EMW5WFbJF24mpc7w+AT2Fvv/X7P0tyCc=;
        b=JN9r7V1e1ovPGprmxOI6LAUihpUQyyjNtw9I+YEJcsCons3fadWN9QPxusemUQ7Y2L
         hzacWtQn8Tg7RLHK+bJfIVO9fhkyGT31OR3NtWOaJomHH6FPYNFG9LcW58M/JqE5VHnL
         N8XOm0O5jQ2wMhra9zALYjXjQm9EQi4CRPyOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FLIQAhWaKW9EMW5WFbJF24mpc7w+AT2Fvv/X7P0tyCc=;
        b=PvE2dPPdQ46XZBW446XLnoUXdl/phIhnJRhpZLnln/3pw/Xr2llO7jO0pjEew9gFl4
         G7njcZ/MKmn2jfjGrxc0fjqCXtBMkp24P0DLYVYLSrEcL2K5zlbq9HwXsmiuzotl6/OK
         Y6nRLVrRiqSqQM2U+ayfbrFwv+TEMS0xlNfkwmZRde92GeyOCOizh1kPdHmwnzhs4zWt
         M7pLIeKorjaZXlb/aATa1MWHjRK6JGMVzPSAx9inxOkcEMsPXIzaAuZJJ+hn/8IoPeWn
         I/2Jy11FqvFBU50PMu03Ghi5jo4dX1qjGOCNsKkKbPoE5k7X+Gi1Zb+oji+5bzU20e+J
         eazg==
X-Gm-Message-State: ALQs6tB/umgLX87WoTZaTUHsEcst7gEfm2+cq+hWihIGv5M2HOp4gxlZ
        5tWYRNkAaP91lpwW/6fw6NUdQnSi3XbQ7Acqz3x+8A==
X-Google-Smtp-Source: AIpwx4+OG1dDkkq8elgpQxZ4bMQTMo3tRK9J9SunUhvo5JYMzriQgvYl+igItMbz7YwcVweRGdYA6C+VmZPQxTCYEt4=
X-Received: by 10.107.175.219 with SMTP id p88mr13928523ioo.257.1523639668625;
 Fri, 13 Apr 2018 10:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Fri, 13 Apr 2018 10:14:26 -0700 (PDT)
In-Reply-To: <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com> <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Apr 2018 10:14:26 -0700
X-Google-Sender-Auth: 3sGMfZ8zFADYooI1eSAo9tFJDEg
Message-ID: <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="001a114461a83717600569be01c4"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a114461a83717600569be01c4
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 13, 2018 at 12:02 AM, Elijah Newren <newren@gmail.com> wrote:
>
> I hope you don't mind me barging into your conversation

I was getting tired of my own rambling anyway..

> However, it turns out we have this awesome function called
> "was_tracked(const char *path)" that was intended for answering this
> exact question.  So, assuming was_tracked() isn't buggy, the correct
> patch for this problem would look like:

Apparently that causes problems, for some odd reason.

I like the notion of checking the index, but it's not clear that the
index is reliable in the presence of renames either.

>   A big series
> including that patch was merged to master two days ago, but
> unfortunately that exact patch was the one that caused some
> impressively awful fireworks[1].

Yeah, so this code is fragile.

How about we take a completely different approach? Instead of relying
on fragile (but clever) tests, why not rely on stupid brute force?

Yeah, yeah, it's bad to be stupid, but sometimes simple and stupid
really does work.

See the attached patch. It gets rid of all the subtle "has this been
renamed" tests entirely, and just _always_ does that final
update_file().

But instead, it makes update_file() a bit smarter, and says "before we
write this file out, let's see if it's already there and already has
the expected contents"?

Now, it really shouldn't be _quite_ as stupid as that: we should
probably set a flag in the "hey, the oid matches, maybe it's worth
checking", so that it doesn't do the check in the cases where we know
the merge has done things.

But it's actually *fairly* low cost, because before it reads the file
it at least checks that file length matches the expected length (and
that the user permission bits match the expected mode).

So if the file doesn't match, most of the time the real cost will just
be an extra 'open/fstat/close()' sequence. That's pretty cheap.

So even the completely stupid approach is probably not too bad, and it
could be made smarter.

NOTE! I have *NOT* tested this on anything interesting. I tested the
patch on my stupid test-case, but that'[s it. I didn't even bother
re-doing the kernel merge that started this.

Comments? Because considering the problems this code has had, maybe
"stupid" really is the right approach...

[ Ok, I lied. I just tested this on the kernel merge. It worked fine,
and avoided modifying <linux/mm.h> ]

                     Linus

--001a114461a83717600569be01c4
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfy7mpd30

IG1lcmdlLXJlY3Vyc2l2ZS5jIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvbWVyZ2UtcmVjdXJzaXZlLmMgYi9tZXJnZS1yZWN1cnNpdmUuYwpp
bmRleCAwYzBkNDg2MjQuLmVkMjIwMDA2NSAxMDA2NDQKLS0tIGEvbWVyZ2UtcmVjdXJzaXZlLmMK
KysrIGIvbWVyZ2UtcmVjdXJzaXZlLmMKQEAgLTgxNSw2ICs4MTUsMzIgQEAgc3RhdGljIGludCBt
YWtlX3Jvb21fZm9yX3BhdGgoc3RydWN0IG1lcmdlX29wdGlvbnMgKm8sIGNvbnN0IGNoYXIgKnBh
dGgpCiAJcmV0dXJuIGVycihvLCBtc2csIHBhdGgsIF8oIjogcGVyaGFwcyBhIEQvRiBjb25mbGlj
dD8iKSk7CiB9CiAKK3N0YXRpYyBpbnQgd29ya2luZ190cmVlX21hdGNoZXMoY29uc3QgY2hhciAq
cGF0aCwgY29uc3QgY2hhciAqYnVmLCB1bnNpZ25lZCBsb25nIHNpemUsIHVuc2lnbmVkIG1vZGUp
Cit7CisJaW50IGZkLCBtYXRjaGVzOworCXN0cnVjdCBzdGF0IHN0OworCisJZmQgPSBvcGVuKHBh
dGgsIE9fUkRPTkxZKTsKKwlpZiAoZmQgPCAwKQorCQlyZXR1cm4gMDsKKwltYXRjaGVzID0gMDsK
KwlpZiAoIWZzdGF0KGZkLCAmc3QpICYmIHN0LnN0X3NpemUgPT0gc2l6ZSAmJiBTX0lTUkVHKHN0
LnN0X21vZGUpICYmICEoMDcwMCAmIChzdC5zdF9tb2RlIF4gbW9kZSkpKSB7CisJCWNoYXIgdG1w
YnVmWzEwMjRdOworCQl3aGlsZSAoc2l6ZSkgeworCQkJaW50IG4gPSByZWFkKGZkLCB0bXBidWYs
IHNpemVvZih0bXBidWYpKTsKKwkJCWlmIChuIDw9IDAgfHwgbiA+IHNpemUpCisJCQkJYnJlYWs7
CisJCQlpZiAobWVtY21wKHRtcGJ1ZiwgYnVmLCBuKSkKKwkJCQlicmVhazsKKwkJCWJ1ZiArPSBu
OworCQkJc2l6ZSAtPSBuOworCQl9CisJCW1hdGNoZXMgPSAhc2l6ZTsKKwl9CisJY2xvc2UoZmQp
OworCXJldHVybiBtYXRjaGVzOworfQorCiBzdGF0aWMgaW50IHVwZGF0ZV9maWxlX2ZsYWdzKHN0
cnVjdCBtZXJnZV9vcHRpb25zICpvLAogCQkJICAgICBjb25zdCBzdHJ1Y3Qgb2JqZWN0X2lkICpv
aWQsCiAJCQkgICAgIHVuc2lnbmVkIG1vZGUsCkBAIC04NTYsNiArODgyLDggQEAgc3RhdGljIGlu
dCB1cGRhdGVfZmlsZV9mbGFncyhzdHJ1Y3QgbWVyZ2Vfb3B0aW9ucyAqbywKIAkJCQlzaXplID0g
c3RyYnVmLmxlbjsKIAkJCQlidWYgPSBzdHJidWZfZGV0YWNoKCZzdHJidWYsIE5VTEwpOwogCQkJ
fQorCQkJaWYgKHdvcmtpbmdfdHJlZV9tYXRjaGVzKHBhdGgsIGJ1Ziwgc2l6ZSwgbW9kZSkpCisJ
CQkJZ290byBmcmVlX2J1ZjsKIAkJfQogCiAJCWlmIChtYWtlX3Jvb21fZm9yX3BhdGgobywgcGF0
aCkgPCAwKSB7CkBAIC0xNzgyLDIwICsxODEwLDggQEAgc3RhdGljIGludCBtZXJnZV9jb250ZW50
KHN0cnVjdCBtZXJnZV9vcHRpb25zICpvLAogCiAJaWYgKG1maS5jbGVhbiAmJiAhZGZfY29uZmxp
Y3RfcmVtYWlucyAmJgogCSAgICBvaWRfZXEoJm1maS5vaWQsIGFfb2lkKSAmJiBtZmkubW9kZSA9
PSBhX21vZGUpIHsKLQkJaW50IHBhdGhfcmVuYW1lZF9vdXRzaWRlX0hFQUQ7CiAJCW91dHB1dChv
LCAzLCBfKCJTa2lwcGVkICVzIChtZXJnZWQgc2FtZSBhcyBleGlzdGluZykiKSwgcGF0aCk7Ci0J
CS8qCi0JCSAqIFRoZSBjb250ZW50IG1lcmdlIHJlc3VsdGVkIGluIHRoZSBzYW1lIGZpbGUgY29u
dGVudHMgd2UKLQkJICogYWxyZWFkeSBoYWQuICBXZSBjYW4gcmV0dXJuIGVhcmx5IGlmIHRob3Nl
IGZpbGUgY29udGVudHMKLQkJICogYXJlIHJlY29yZGVkIGF0IHRoZSBjb3JyZWN0IHBhdGggKHdo
aWNoIG1heSBub3QgYmUgdHJ1ZQotCQkgKiBpZiB0aGUgbWVyZ2UgaW52b2x2ZXMgYSByZW5hbWUp
LgotCQkgKi8KLQkJcGF0aF9yZW5hbWVkX291dHNpZGVfSEVBRCA9ICFwYXRoMiB8fCAhc3RyY21w
KHBhdGgsIHBhdGgyKTsKLQkJaWYgKCFwYXRoX3JlbmFtZWRfb3V0c2lkZV9IRUFEKSB7Ci0JCQlh
ZGRfY2FjaGVpbmZvKG8sIG1maS5tb2RlLCAmbWZpLm9pZCwgcGF0aCwKLQkJCQkgICAgICAwLCAo
IW8tPmNhbGxfZGVwdGgpLCAwKTsKLQkJCXJldHVybiBtZmkuY2xlYW47Ci0JCX0KKwkJLyogV2Ug
Y291bGQgc2V0IGEgZmxhZyBoZXJlIGFuZCBwYXNzIGl0IHRvICJ1cGRhdGVfZmlsZSgpIiAqLwog
CX0gZWxzZQogCQlvdXRwdXQobywgMiwgXygiQXV0by1tZXJnaW5nICVzIiksIHBhdGgpOwogCg==
--001a114461a83717600569be01c4--
