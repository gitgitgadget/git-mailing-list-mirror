Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7259DC7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 21:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjDUVLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 17:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUVLv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 17:11:51 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7565B3
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 14:11:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 5DC5B3C097AFB;
        Fri, 21 Apr 2023 14:11:49 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id F0Dk__KggKPm; Fri, 21 Apr 2023 14:11:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id D51853C097AFC;
        Fri, 21 Apr 2023 14:11:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu D51853C097AFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1682111508;
        bh=zQdaZsDa8s9krdsZy85097kC9CndnSxNNUbdc/Og1Tc=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=NA3myyvxvu5fOWnmyLbEJP2ylrYSmTPN5p0nv6jFcM4mydg+m5rFsMnBDmdj8vu/P
         VfuWcSFrQtp7HkGEBXmd2Z96AfXgwviuIfFXGST+oKv+I3PRYUBSyFC2wHlp72YKpI
         ZjPoB2CJNLH/Vhk2QAwAYhcMmH/BrjIfJI178kdu3TNQqBBzxb39iFIPhWAZKlhy2T
         P+PwZc30FH1fn4J/4O0G4K8ElJJqlRVko38QG/7ApZndjjv/hl3JXtYxD4CW4FDpGO
         sSXMtQgzJTrXS6+8uePrIDY4C5AM2ulcixoA4gzmySm183YRdR1mivhwQ0LJ0STVbN
         BPWuUr/xdqyQw==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cI4CcMjK-_sC; Fri, 21 Apr 2023 14:11:48 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id 9766E3C097AFB;
        Fri, 21 Apr 2023 14:11:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------jZipCDUV888HYNke1Si3HurA"
Message-ID: <508ca102-63a9-6334-fee8-7a1ae84c7a23@cs.ucla.edu>
Date:   Fri, 21 Apr 2023 14:11:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Jim Meyering <jim@meyering.net>
Cc:     grep-devel@gnu.org, demerphq <demerphq@gmail.com>,
        pcre2-dev@googlegroups.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <m28rf0pa2m.fsf@meyering.net>
 <4322c414-2bb7-924f-0f6d-dbf517599c3f@cs.ucla.edu>
 <CA+8g5KFqgtKadru7g0LMPpoNDO0vxGGsva_+hQAUcOOfMTd22w@mail.gmail.com>
 <c5j7tduynkzhqpcgqc7iei4mmlnlwvfohmj7ryfhifpay6hhtn@ha3apuuzhxzz>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Compatibility between GNU and Git grep -P
In-Reply-To: <c5j7tduynkzhqpcgqc7iei4mmlnlwvfohmj7ryfhifpay6hhtn@ha3apuuzhxzz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------jZipCDUV888HYNke1Si3HurA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

In <https://lists.gnu.org/r/grep-devel/2023-04/msg00017.html> Carlo=20
Marcelo Arenas Bel=C3=B3n wrote:

> After using this for a while think the following will be better suited
> for a release because:
>=20
> * the unreleased PCRE2 code is still changing and is unlikely to be rel=
eased
>    for a couple of months.
> * the current way to configure PCRE2 make it difficult to link with the
>    unreleased code (this might be an independent bug), but it is likely=
 that
>    the wrong headers might be used by mistake.
> * the tests and documentation were not completely accurate.

Thanks for looking into this. I'm concerned about the resulting patches,=20
though, because I see recent activity in on the Git grep -P side here:

https://lore.kernel.org/git/xmqqzgaf2zpt.fsf@gitster.g/

Bleeding-edge (i.e., "master") GNU grep uses PCRE2_UCP |=20
PCRE2_EXTRA_ASCII_BSD with unreleased PCRE2 (which introduces=20
PCRE2_EXTRA_ASCII_BSD), and it uses neither flag with the current PCRE2=20
release. You're proposing to change GNU grep to never use either flag,=20
regardless of PCRE2 release.

In contrast, bleeding-edge (i.e., "next") Git grep -P always uses=20
PCRE2_UCP and never uses PCRE2_EXTRA_ASCII_BSD. I.e., it disagrees with=20
GNU grep regardless of whether your proposed changes were adopted.

Given Jim's strong desire that \d should match only ASCII digits, I=20
doubt whether GNU grep will simply use PCRE2_UCP without=20
PCRE2_EXTRA_ASCII_BSD.

If we want the two grep -P's to stay compatible, I see two ways forward:

1. Leave GNU grep alone and modify Git grep to behave like GNU grep (see=20
attached patch to Git).

2. Adopt your proposed change to GNU grep, and revert the recent change=20
to Git grep so that it never uses PCRE2_UCP.

Either way, we should see what the Git folks say about this.
--------------jZipCDUV888HYNke1Si3HurA
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-grep-be-compatible-with-GNU-grep-P.patch"
Content-Disposition: attachment;
 filename="0001-grep-be-compatible-with-GNU-grep-P.patch"
Content-Transfer-Encoding: base64

RnJvbSA1ZjVlNTQxNTdhMDFjNTQwYmRlMDJjMzA1YzhlZTVlMWEzOWQ0ZjFjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsIEVnZ2VydCA8ZWdnZXJ0QGNzLnVjbGEuZWR1
PgpEYXRlOiBGcmksIDIxIEFwciAyMDIzIDE0OjA2OjI1IC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gZ3JlcDogYmUgY29tcGF0aWJsZSB3aXRoIEdOVSBncmVwIC1QCgpVc2UgUENSRTJfVUNQ
IG9ubHkgd2hlbiBQQ1JFMl9FWFRSQV9BU0NJSV9CU0QgaXMgZGVmaW5lZCwKZm9yIGNvbXBh
dGliaWxpdHkgd2l0aCBHTlUgZ3JlcC4KLS0tCiBncmVwLmMgfCA5ICsrKysrKystLQogMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9ncmVwLmMgYi9ncmVwLmMKaW5kZXggMDczNTU5ZjJjZC4uZTlkYzhkYzBiYyAxMDA2
NDQKLS0tIGEvZ3JlcC5jCisrKyBiL2dyZXAuYwpAQCAtMzIwLDggKzMyMCwxMyBAQCBzdGF0
aWMgdm9pZCBjb21waWxlX3BjcmUyX3BhdHRlcm4oc3RydWN0IGdyZXBfcGF0ICpwLCBjb25z
dCBzdHJ1Y3QgZ3JlcF9vcHQgKm9wdAogCQl9CiAJCW9wdGlvbnMgfD0gUENSRTJfQ0FTRUxF
U1M7CiAJfQotCWlmICghb3B0LT5pZ25vcmVfbG9jYWxlICYmIGlzX3V0ZjhfbG9jYWxlKCkg
JiYgIWxpdGVyYWwpCi0JCW9wdGlvbnMgfD0gKFBDUkUyX1VURiB8IFBDUkUyX1VDUCB8IFBD
UkUyX01BVENIX0lOVkFMSURfVVRGKTsKKwlpZiAoIW9wdC0+aWdub3JlX2xvY2FsZSAmJiBp
c191dGY4X2xvY2FsZSgpICYmICFsaXRlcmFsKSB7CisJCW9wdGlvbnMgfD0gKFBDUkUyX1VU
RiB8IFBDUkUyX01BVENIX0lOVkFMSURfVVRGKTsKKyNpZmRlZiBQQ1JFMl9FWFRSQV9BU0NJ
SV9CU0QKKwkJLyogQmUgY29tcGF0aWJsZSB3aXRoIEdOVSBncmVwIC1QICdcZCcuICAqLwor
CQlvcHRpb25zIHw9IChQQ1JFMl9VQ1AgfCBQQ1JFMl9FWFRSQV9BU0NJSV9CU0QpOworI2Vu
ZGlmCisJfQogCiAjaWZuZGVmIEdJVF9QQ1JFMl9WRVJTSU9OXzEwXzM1X09SX0hJR0hFUgog
CS8qCi0tIAoyLjM5LjIKCg==

--------------jZipCDUV888HYNke1Si3HurA--
