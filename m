Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CB7C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D7764E55
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhB1LY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 06:24:26 -0500
Received: from mout.web.de ([212.227.15.3]:34807 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhB1LYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 06:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614511347;
        bh=QYXQyOI+NYjUyG/N4eLl/UNEJVDnrxjCQhA2J73Sa5M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KSaFUrqrNkn9szvTNRJnUCR01y8/TnYm8oSzUnxCsH/2eOAlvjErrCAHasg4fKOiJ
         t/bDWpc0qB9BG+W7pdsuF8NglaVzFd+E2X1aCSt5qS6nJp2lnaTGSPhGLIkA+vkAeb
         iGu0P4RpbM0OTWh/DeJsDx7itWPR1xwq4e4hJfSI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MIeCm-1lE7ER2Deq-002GaE; Sun, 28 Feb 2021 12:22:27 +0100
Subject: Re: [PATCH 1/2] pretty: add %(describe)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <87k0r7a4sr.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <b70e1b3a-dd5f-1fbc-22d5-e2bca4c00e79@web.de>
Date:   Sun, 28 Feb 2021 12:22:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87k0r7a4sr.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BHG6eu1iarn7JrBkP/J6ooJZ2mILNd5a0oVW4czFDqPiuiACyy2
 Hiz2hqOGWI6JJQyy3HSsm6FAAlor86UCJdWgDgLhsrCj2BJ8ulhjGnOLzF0s13bppDS8gQT
 Wi76TWIcDlVWIeVFO+gPRf2vMozkvZqLp2B/89nyaX2G4s5s8VmMC8sxJieuvYCIpKMZ3/k
 plol8yxEbZGxzo7y5iKdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J/O6/QsQSZk=:UImhAgxJsGDnUtgN37X1eL
 vLhhR8AXUzuUku7fvet4FKaya9bfvRI2pfMgmG/2gZozLh1AcJ/9kQqqGu1/GV7Zq+uQmdHBy
 EIoe3AkMKpWKREnTG8rS0pLpeqmkwYHNYAOfBPinNy+oJhHED50lhLmDE0D2+RHOTqMxhpO78
 KRc6TFxwmFqSs75UZCj8u1mKbKemOhWki8S7NBFa9Jh6XaUjR3zLb864qcbDMNnmoHDN/RVyQ
 /fpg++7+uQJGT8uJkiv+1hKs3RtuDJICva9JxKFwacaAOsq5w2iVs6P1sIRRqjh1MagZKkInK
 k2xn/FPxycETmTHmiv2iCnhtIp62+QZbWI4vGIk7X1y3ptz0bJR7flk2LnWL1WHt5swemuw24
 hLOULmN0dPhufJ0xJ/8NlPFfFIXuIrshWRFKCZFopvmesoeNXMYmuZFD06vfkE1oqLWvpmcp4
 orSiry3Il6uTPUR8QRIYFggnyLM97rMBhugcclGj+TeVHjE0FuTHltYYQdXvoXzUHi9V4kYX2
 cFPi90qdNiRnz3nNyKZlbu/cGgqeWgv/sshX8v0JEjd1OinK6vIfIGga+HjAd83XbMN4bt0Cf
 FORlR35U+6BEgcX07DGEKHGLAmstnanLkoSeSCKNj7UssHAu5s2yDKhCebSjNGdkc2wLaKJS4
 x1ZE2klXFjKk6DVPBNrVJHifHeF+oVlezmnjenzOZowfyN8YVQoHW1cCKVNWf0aT30dPnXDjm
 Adpb38/yFou2siIel9UnyUTOiRmuHYH5iRbSvpE0zOE32k1mAY76PQ1RyUznHJa/XeNeogOGV
 TwPYLaFGW5kMz1ubCwPSJbXydwfj6wICVBA4s3MUBat+bThYtv8M/FDeOZoQOKCP5vHxNaxVg
 x49jdCJhXSbfi61CzlWQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.02.21 um 01:58 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sun, Feb 14 2021, Ren=C3=A9 Scharfe wrote:
>
>> +'%(describe)':: human-readable name, like linkgit:git-describe[1];
>> +		empty string for undescribable commits
>
> In the case of undescribable we've got the subcommand exiting non-zero
> and we ignore it. The right thing in this case given how the rest of
> format arguments work, but maybe something to explicitly test for?

The test convers it, but we can surely make that easier to see.

=2D- >8 --
Subject: [PATCH] t4205: assert %(describe) test coverage

Document that the test is covering both describable and
undescribable commits.

Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t4205-log-pretty-formats.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index b47a0bd9eb..cabdf7d57a 100755
=2D-- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -965,8 +965,17 @@ test_expect_success 'log --pretty=3Dreference is colo=
red appropriately' '
 test_expect_success '%(describe) vs git describe' '
 	git log --format=3D"%H" | while read hash
 	do
-		echo "$hash $(git describe $hash)"
+		if desc=3D$(git describe $hash)
+		then
+			: >expect-contains-good
+		else
+			: >expect-contains-bad
+		fi &&
+		echo "$hash $desc"
 	done >expect &&
+	test_path_exists expect-contains-good &&
+	test_path_exists expect-contains-bad &&
+
 	git log --format=3D"%H %(describe)" >actual 2>err &&
 	test_cmp expect actual &&
 	test_must_be_empty err
=2D-
2.30.1
