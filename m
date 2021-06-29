Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B95C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4528361DC8
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 17:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhF2R4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 13:56:34 -0400
Received: from mout.web.de ([212.227.17.11]:56671 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhF2R4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 13:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624989236;
        bh=+qbhCyJ2nfgbg4Cox6YVu0NTmmcgHMRsYS+oJsLhi04=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XA7+JgOFrKZWs+0JFAoZBQeBAz/Xqz0hr9JQgn01a476zwGV8KUqx7ELoWr2xHTch
         0u6P9x8wxYsywZI7U/JZXzjzZAwtWWzq4/IJvL/Qgmbyd/fyr0FlW/MqRQTqN6YiNC
         cxzdF9eP4MqF/1ApRChDvq/gOC19r/zOfGApRkHo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MIya8-1ldrP42vQg-00KM6C; Tue, 29 Jun 2021 19:53:56 +0200
Subject: Re: [PATCH 3/3] hook-list.h: add a generated list of hooks, like
 config-list.h
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
 <patch-3.3-f343fc7ae6-20210617T100239Z-avarab@gmail.com>
 <20210618170550.GE6312@szeder.dev>
 <648321ed-bda9-d7fc-73e1-7ccf48addf9c@web.de>
 <nycvar.QRO.7.76.6.2106221642560.57@tvgsbejvaqbjf.bet>
 <xmqqv95x4ijd.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <20b1bfb6-8881-2a21-1753-0e2e508a7861@web.de>
Date:   Tue, 29 Jun 2021 19:53:55 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqv95x4ijd.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8lztWQZP+yd+kMj+VBdsPBe3wfLPhhRP7ldFxSxBz3yJO03sakW
 acQKPUBwv4b3hSUoox/YAdpGgh4breYtKpub5siDJ/B0k0RPirzBmSKmr2g8HvhFORxmhxE
 JVZVHuIM5U0duI2NI8/QDEAdAX3EBsgRkaJUXScRT3xlj8kVDvwkWIl8VgiCyqxFxNJYDR1
 ALOGPcpVJqoapWGnboCjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/EFjpwh4Kos=:k2V9T4zjSomKlvrmlJRTik
 1SDvM9L3GgwCPumQ7hmaQjBqx55ig1bVYdGH3laa+7NyYMbUnPChTljQs85TZVKH/eQrtKgKA
 MZ8m4ySEvUdGEDz0EE4OfVKscspfj8b3JWFqX1vy+Sil9CirGv1sg6X1Rogae/jWoQp4bAOhI
 1xJt30VTbcROByQo9p0chMz0Mcac0lQzVpWjk31q9ytoL0ufe4NEcOjZ/PXuU5xiTAluOxv7b
 jzdABDcfJZk50GHzwlVYwEIaNJiyNTzvRkcGtfO0Y27jOJzOB2whT2P8e27mKUTmY/ML/CWDy
 zb70JhLz1xkLbXcLd0jg7H+dsPpxYP/mMn6o9bAgFrKFIpfZJQGWvozCyE0DQPQ5i4YHUH8n1
 hB0PGmXXN0cGYcip4sXUFg9sqKYsZ8tooQqSHukOAlCz0jBLcFTE0DP8Iw+w/lHsuz8QJvhgE
 Q6ltRDtMT+Z82/YUxSD8WE0urc/ef1wwy2VlW3UrJyAF5YkAPajX2LiyCYKSAGo1gcxBsWD3m
 07rrcU/a4kuFEjyphJ7erdYtZCcnjeBPMnDUpLSsCvfqz/3/UvQu45bk3pCxrOQcrZFPd8C3i
 F/J29POXr5QZ2b0VTJ4RCsOoe6DvkhykdVQkM05WyYs9wQLOumBlXNCoCgmnfUbifgBlNOYi2
 FWczd6tRac1gjtF8y2dITegPEsScLs7AKtEh5o/4DsQxVBRbrkXp4D2/zywhcahkWu3fjlLwn
 sL+6syJIFK1y3piLi3G6/T1c1FGwymwM/z/xJOa0csT4bFI5eCIPSjLYGVHZxuXqsUw/q7t1g
 zbDDwFBz+OiUFCN9jGa1TN4Psyhof6+ZnrUVx0FgPF/yjDN/iKjlMsr7TOPd8fm3s+bwZ37Yr
 kRilcrlSkClyJWgrDJlBDUsvi4nCU657ZEfgXxSMXugQ3g0r+aSAgjMuoQgUgviuBYu6a5U1J
 oDibkptCjzlh9T7J3Nky59IPTHqr7F7tONlK9Z9zjJ7/zunv8v7qkBWHSVvvG0ck+klqnzeH/
 uo7ZnDlo++wsRYTGfwR+neo4NdGwW78VE3WQNNxreCoNWGYRTToDwPs8obySb8KSSksg7qDG/
 E0YW3cQJm7sF86aPzN3lyKq9yAF6BofeFiI
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.06.21 um 02:32 schrieb Junio C Hamano:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Sun, 20 Jun 2021, Ren=C3=A9 Scharfe wrote:
>>
>>> How about something like this?
>>>
>>> 	sed -n '/^~~~~*$/ {x; p;}; x' Documentation/githooks.txt |
>>> 	sort |
>>> 	sed 's/^.*$/	"&",/'
>>>
>>> sed is already used by generate-configlist.sh.
>>
>> I do like me a good sed script.
>>
>> Thanks,
>> Dscho
>
> Yup.
>
> This is buried below the 27-patch series, so the whole thing cannot
> advance until this gets sorted out.

If it helps: You can add the patch below as number 28 or squash
it in.

=2D-- >8 ---
Subject: [PATCH] generate-hooklist.sh: use sed instead of Perl

Allow hooklist.h to be built without Perl by finding, sorting and
formatting hook names using two short sed(1) scripts and sort(1).

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 generate-hooklist.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/generate-hooklist.sh b/generate-hooklist.sh
index 5a3f7f849c..6f3de0a2ec 100755
=2D-- a/generate-hooklist.sh
+++ b/generate-hooklist.sh
@@ -6,14 +6,9 @@ print_hook_list () {
 	cat <<EOF
 static const char *hook_name_list[] =3D {
 EOF
-	perl -ne '
-		chomp;
-		@l[$.] =3D $_;
-		push @h =3D> $l[$. - 1] if /^~~~+$/s;
-		END {
-			print qq[\t"$_",\n] for sort @h;
-		}
-	' <Documentation/githooks.txt
+	sed -n '/^~~~~*$/ {x; p;}; x' Documentation/githooks.txt |
+	sort |
+	sed 's/^.*$/	"&",/'
 	cat <<EOF
 	NULL,
 };
=2D-
2.32.0
