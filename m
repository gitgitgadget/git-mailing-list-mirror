Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5601FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 03:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdBHD2X (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 22:28:23 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33729 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdBHD2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 22:28:22 -0500
Received: by mail-oi0-f65.google.com with SMTP id j15so10136149oih.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 19:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mAX6kMrrgbBMgAO/AeSqR6XT4roQrv5VkBdSuXcb23U=;
        b=bWPJsifeVTUZXkecVRLoJ+OIHRNaA2N/7sz1r15JkBT1V0/GmYqDSYotl7rDAilOgX
         C9QtsO6ArO+In6J3ik38IK1Yif81EujnuyMrcXawnE8XZjMHJed/TgvAePSa9GSgefZs
         hriv+zlsOV3Vy2KxsJiLq95jLc7iRcVZgsvYSdWUE0beUB84NNRNfutcZZkqNCPlMYsb
         P7BnkFEqIM7xcO/aOeItW4ugx6npcr2Q3Kho4UsBrJYAOXSV2WY4WCWTkEFlG+gsk00y
         sWWW4XPYaM6KB6XylIYx4JidrjyDge8y6+hS9IQw9sPQpf9MZKs9kWwdaG+PSwj/rdXH
         1pMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mAX6kMrrgbBMgAO/AeSqR6XT4roQrv5VkBdSuXcb23U=;
        b=KWhGnHQrt9TrtQfJRdA8xzDy8MCMu4WHrJe75FJCphi05nRLE/3pF9e5rCNHjQYx/u
         cSUbENfZJzbpHc00xlJYfUG4ARRWHl+dPexGutJnxjyK2KBvUsfcREdGl8KedeNhioa5
         sIAkANAuTdT88E46AUy9DxVtIZuf1UeXqi8+cdINRv7jXenYKuB4OTiVH/B0/hXwVG4S
         0EzVmpTOqOlGOT/RUeawxq7pSwFUw7GO88jnWAKqz4kPwBKAr2e9HqWtWJmNuUG+GFqy
         lqLTMAR1fyBYIqTMLPZV3L/YCEJi7ol5Ls45EDPCoYSs1fEwhmQp4b6tUoCldaGZnr6G
         Z5uQ==
X-Gm-Message-State: AMke39kZdUrZUqxkwH1tPCBOt6s7MBY2ZhYze5SIOfIcGzsNB7xoQ9BxI74M9F8WnHr+Soab0XgQDjZOMUpZ5w==
X-Received: by 10.202.219.9 with SMTP id s9mr10216547oig.88.1486524485798;
 Tue, 07 Feb 2017 19:28:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Tue, 7 Feb 2017 19:28:05 -0800 (PST)
In-Reply-To: <xmqqa89xxtnd.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
 <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
 <alpine.LFD.2.20.1702071739060.17609@i7.lan> <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com> <xmqqa89xxtnd.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2017 19:28:05 -0800
X-Google-Sender-Auth: wDryedc8x6kaizP47l_WvmdB-vY
Message-ID: <CA+55aFyAEaMKA+2oPJct4ffJ0-_z2vrYxmQ9yrkbxzB3Hk6WfQ@mail.gmail.com>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a113d3d2eed32da0547fc7305
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a113d3d2eed32da0547fc7305
Content-Type: text/plain; charset=UTF-8

On Tue, Feb 7, 2017 at 7:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> But that is not what I was talking about.  Let's simplify.  I'd say
> for any command that acts on "everything" when pathspec is not
> given, the two sets of actual paths affected by these two:
>
>         git cmd -- "net/"
>         git cmd -- ":!net/"
>
> should have no overlap (obviously) and when you take union of the
> two sets, that should equal to
>
>         git cmd --
>
> i.e. no pathspecs.

Well, as mentioned, I won't ever care. I'm certainly ok with the "make
the default positive entry be everything".

I just suspect that from a user perspective that actually delves into
the subdirectories, the much bigger question will be: "I gave you a
pathspec, and suddenly you start giving me stuff from outside the area
entirely".

And then you can say "well, just add '.' to the pathspec", and you'd
be right, but I still think it's not what a naive user would expect.

People don't expect set theory from their pathspecs. They expect their
pathspecs to limit the output. They've learnt that within a
subdirectory, the pathspec limits to that subdirectory. And now it
suddenly starts showing things outside the subdirectory?

At that point no amount of "but but think about set theory" will
matter, methinks.

But I really don't feel strongly about it. The path I sent out (and
the slightly modified version attached in this email) actually acts
the way you suggest. It's certainly the simplest implementation. I
just suspect it's not the implementation people who go down into
subdirectories would want/expect.

>>>  2. I am not sure what ctype.c change is about.  Care to elaborate?
>>
>> I didn't see the need for it either until I made the rest of the
>> patch, and it didn't work at all.
>>
>> The pathspec.c code uses "if (is_pathspec_magic(..))" to test whether
>> a character is a short magiic pathspec character.  But '^' wasn't in
>> that set, because it was already marked as being (only) in the regex
>> set.
>>
>> Does that whole is_pathspec_magic() thing make any sense when we have
>> an array that specifies the special characters we react to? No it does
>> not.
>>
>> But it is what the code does, and I just made that code work.
>
> Ah, OK.

Side note: here's an alternative patch that avoids that issue
entirely, and also avoids a problem with prefix_magic() being uphappy
when one bit shows up multiple times in the array.

It's slightly hacky in parse_short_magic(), but it's smaller and
simpler, and avoids the two subtle cases. No need for ctype changes,
and no issues with prefix_magic() being somewhat stupid.

               Linus

--001a113d3d2eed32da0547fc7305
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iywe17pv0

IHBhdGhzcGVjLmMgfCAyMCArKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcGF0aHNwZWMuYyBi
L3BhdGhzcGVjLmMKaW5kZXggN2FiYWJiMzE1Li4yYTkxMjQ3YmMgMTAwNjQ0Ci0tLSBhL3BhdGhz
cGVjLmMKKysrIGIvcGF0aHNwZWMuYwpAQCAtMjI0LDYgKzIyNCwxMiBAQCBzdGF0aWMgY29uc3Qg
Y2hhciAqcGFyc2Vfc2hvcnRfbWFnaWModW5zaWduZWQgKm1hZ2ljLCBjb25zdCBjaGFyICplbGVt
KQogCQljaGFyIGNoID0gKnBvczsKIAkJaW50IGk7CiAKKwkJLy8gU3BlY2lhbCBjYXNlIGFsaWFz
IGZvciAnIScKKwkJaWYgKGNoID09ICdeJykgeworCQkJKm1hZ2ljIHw9IFBBVEhTUEVDX0VYQ0xV
REU7CisJCQljb250aW51ZTsKKwkJfQorCiAJCWlmICghaXNfcGF0aHNwZWNfbWFnaWMoY2gpKQog
CQkJYnJlYWs7CiAKQEAgLTUxNiw3ICs1MjIsNyBAQCB2b2lkIHBhcnNlX3BhdGhzcGVjKHN0cnVj
dCBwYXRoc3BlYyAqcGF0aHNwZWMsCiAJfQogCiAJcGF0aHNwZWMtPm5yID0gbjsKLQlBTExPQ19B
UlJBWShwYXRoc3BlYy0+aXRlbXMsIG4pOworCUFMTE9DX0FSUkFZKHBhdGhzcGVjLT5pdGVtcywg
bisxKTsKIAlpdGVtID0gcGF0aHNwZWMtPml0ZW1zOwogCXByZWZpeGxlbiA9IHByZWZpeCA/IHN0
cmxlbihwcmVmaXgpIDogMDsKIApAQCAtNTQwLDEwICs1NDYsMTQgQEAgdm9pZCBwYXJzZV9wYXRo
c3BlYyhzdHJ1Y3QgcGF0aHNwZWMgKnBhdGhzcGVjLAogCQlwYXRoc3BlYy0+bWFnaWMgfD0gaXRl
bVtpXS5tYWdpYzsKIAl9CiAKLQlpZiAobnJfZXhjbHVkZSA9PSBuKQotCQlkaWUoXygiVGhlcmUg
aXMgbm90aGluZyB0byBleGNsdWRlIGZyb20gYnkgOihleGNsdWRlKSBwYXR0ZXJucy5cbiIKLQkJ
ICAgICAgIlBlcmhhcHMgeW91IGZvcmdvdCB0byBhZGQgZWl0aGVyICc6Lycgb3IgJy4nID8iKSk7
Ci0KKwkvKgorCSAqIElmIGV2ZXJ5dGhpbmcgaXMgYW4gZXhjbHVkZSBwYXR0ZXJuLCBhZGQgb25l
IHBvc2l0aXZlIHBhdHRlcm4KKwkgKiB0aGF0IG1hdGNoZXMgZXZlcnl0aW5nLiBXZSBhbGxvY2F0
ZWQgYW4gZXh0cmEgb25lIGZvciB0aGlzLgorCSAqLworCWlmIChucl9leGNsdWRlID09IG4pIHsK
KwkJaW5pdF9wYXRoc3BlY19pdGVtKGl0ZW0gKyBuLCAwLCAiIiwgMCwgIiIpOworCQlwYXRoc3Bl
Yy0+bnIrKzsKKwl9CiAKIAlpZiAocGF0aHNwZWMtPm1hZ2ljICYgUEFUSFNQRUNfTUFYREVQVEgp
IHsKIAkJaWYgKGZsYWdzICYgUEFUSFNQRUNfS0VFUF9PUkRFUikK
--001a113d3d2eed32da0547fc7305--
