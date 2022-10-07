Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AA4C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 20:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJGU3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGU3T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 16:29:19 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BBC127BC1
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665174508; bh=OtbXTbyd97LbjCvdslZRBoiDZGi0EaRpcuEOfH1Ne5g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=c0Ngjbftf3idlCEI1k7KU+BcR15QMllmokWq3v+X/kAmKjtibxBr3CcS3Ky8qRHI5
         FTdPLy4Rsw+uQvZg8GeG+SfkNkRvxsnv3haggOo8d4M5Z7ZPC9LEJCSzxnWP0+27Lo
         Ux8ASB7EgxmJmVAx59mQYkk0UavN6hBayv5AqUH67RbvTbdCz3m1ZTlCzfNZElXFFu
         cOrox/Y8OkiH+h8D/tqHxW8qvj1a+5LIQ1CavKmcv8t9F9b+YEIsjf0UOr9z9sPt9a
         xX/i785qhJKLa7W+P/OG6NA8Tuts8QOlUiQsVLh2bZL8uOsZnqbFmHETC0/nW//PGC
         EwW1ntwxP1qoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1u6n-1p9jIg48nB-0120HH; Fri, 07
 Oct 2022 22:28:28 +0200
Message-ID: <ec920650-4334-a6f2-6d6f-241899dd79ec@web.de>
Date:   Fri, 7 Oct 2022 22:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
 <0f67ca77-f17f-d844-e689-ca9a9bdf7993@jeffhostetler.com>
 <xmqqpmf3frr5.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqpmf3frr5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lET/EWBpPYfxpJavk6chLWL0KAbikmAfgBQmolle1uW5tIoA+AE
 H94JJoK0GHuH7RhDlXiaHiZ4pDS4BZe6TP0DNVAzHkI5s4lmhYV185R4FPJn7D/BkbdF84i
 3NY79csROkZVE2kRK6rD6q2RKZgf1isOsoSskOVxXm2Vh7eA4NA251jL5G4wcuHN8nSVITS
 ZFwf59ClaRG06qzUDcZjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oVGsV8JdGDI=:Mlmy7Ih80UGxRSM2yLlFjw
 m9MX0pfP7qb8Dhy3jGDx79rMB+8wMjpQb7LqRr+NFjQYt+GXogY+yqVMkh2BB4uV9xfjJXXQo
 QfixHpL0KdC2OxabH2xHkuIQWreDiQbF+3EtSNW++/B4mpoF+grNE08GFpGPhkYQCALgEEqy9
 n81qDBycyxrhua2plgvQG+6sDcw2VSrxqtoaqtmZRo6p8WL6lPM5SiSch7t+ZheQ6IsRslidQ
 IEG/IRBmddbzHbZT9DzyOSzEFrTaIA0HdgzJHovEnvX7qjTldwZO+aJafLbXX+7tcVHMkypNC
 1HES2i1lbWxteRh9VeGuUFlt7L7CLdwbtZb+tRlwvatviQyXHeieVfPN+Fb8FZoybKLGX+saX
 ek/aFi4jNGmDkJJF/H4rkqv+TsrjGDb1aE+33AwT2Oee7aoHkRImZsyGdNIVTK+ifh/DWjiKh
 zj/tUqq+tiAmJYzA6173ie+nwntoJskCUOt8Qcy6ZazWeDfG5dm95wyzzBesfBixDDWUIZPdU
 +W03R3OYRyQmw2vITuJLzQ9CfizXvedNBO9h8HG7AYBB0TEBpLZXzp0x5DJrm+xu6hYM+3RB7
 xA2Yqc+1IQQRBrcoz/3gPENUtLnXy2Z6IWHuzLVDr6w8opifnidAMQW5tYQOCnoGtOXQ6dRMW
 X8Awi2JfLGCC3mdjwY2wgzf7njjYIROEapjsuyyRFcehc1bG7yGtw7XhcO6qkGzAZlcDWaffl
 1OzOzZjUzkAczwIwN0IG8gGRxBF62hfXk9hq7c3JCyUkovQInmdbELEcfV70msHgYs3EsZvz0
 4ztpks0uXdfWPoyGzQKX6E0G656SkIIqeAabbsMnQKNDg/Sa8qki9tk9YscL0/xZDelMZpn0E
 hLr7cE/qUowkziMkVc2f1N78KyZwvgxys1ACFLqcn7kgq8tsrBIDLM/4yRFDuOTixRPbyfcDh
 lFPB/KsCJUQi1DbAoqEOkfyfZPQ23WX+5iW4EDEP4bDQQx1Et2XIGganWqKqAK1yK3nAAdS7e
 ULCdpsc0scf9jSmVZqA1gPA2076QadUQaCUB4u0Jb8gj6nPmdAnMziqrstCY1SxjDeGhHaB01
 S8zMCi9JbvAbZTsxM3433Lz2KO+IH6ILqLrXoQTx/ZDtncl9WxcfBLkdojJt8V7GjPcyqh9to
 ND1UNLV+9SRw5w5o9w/8eyqJeURgpaT6T8/hJDRXOJrE5zAUKttijAZU9RaJLGYl6xH1Tv/Wu
 lzYO+ENFhsGHzxnX/88MkyH7miWcOpIpkh/DdcucwZFr7HRtKgVzzSPpXMf9dMier7viJDpio
 E7542MOuuwk2WNU+EFlYw9uW3dnv/JkpytRjGKj9dgAyu0BAu+bWBkannBwPg6L/bTAipdyG6
 c9lGl0WmtW+6OxTfTmqFuj4tAeemJmVsIcFyUB/J17xWTJuqTimjq0gOr7dIcsTXmnybXGB5J
 LOTgcYlR0IEbpmeHWv3aAe+U21900EObrqg0LW4gib5BWcPf+INlQPQzuiv5FlIfdpj8RGf7p
 ELHXal+hHx1DDe4VDEGceP1Lz+d8IYdLGyJ7PI53x02s6
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.10.22 um 19:49 schrieb Junio C Hamano:
>
> My preference is to flip the -Wno-missing-braces bit in
> config.mak.uname only for folks who use the version of clang on
> macOS when that clang claims to be clang11 (my understanding of
> Ren=C3=A9's experiment[*] is that versions of (real) clang 9 or newer
> perfectly well understand that {0} is an accpetable way to specify
> zero initialization for any structure, with possible nesting).
>
> [Reference]
>
> * https://lore.kernel.org/git/36cd156b-edb2-062c-9422-bf39aad39a6d@web.d=
e/

Wikipedia has a map that says Apple calls the LLVM clang 8 (i.e. the
real one) "11.0.0" and clang 9 "11.0.3":

https://en.wikipedia.org/wiki/Xcode#Xcode_11.0_-_14.x_(since_SwiftUI_frame=
work)_2

Perhaps like this?  (No sign-off because I'm not comfortable with that
make function syntax, but feel free to steal salvageable parts.)

diff --git a/config.mak.dev b/config.mak.dev
index 4fa19d361b..4d59c9044f 100644
=2D-- a/config.mak.dev
+++ b/config.mak.dev
@@ -69,6 +69,14 @@ DEVELOPER_CFLAGS +=3D -Wno-missing-braces
 endif
 endif

+# LLVM clang older than 9 and Apple clang older than 12 complain
+# about initializing a struct-within-a-struct using just "{ 0 }"
+ifneq ($(filter clang1,$(COMPILER_FEATURES)),)
+ifeq ($(filter $(if $(filter Darwin,$(uname_S)),clang12,clang9),$(COMPILE=
R_FEATURES)),)
+DEVELOPER_CFLAGS +=3D -Wno-missing-braces
+endif
+endif
+
 # https://bugzilla.redhat.com/show_bug.cgi?id=3D2075786
 ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS +=3D -Wno-error=3Dstringop-overread

