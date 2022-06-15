Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F1C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 16:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349950AbiFOQ7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349729AbiFOQ7T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 12:59:19 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0342DD7C
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655312321;
        bh=xVyn0C+GKzuVSsXqWWA3P9r89IIV36g9KYMrsH2j2bc=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=PriwAmP84S14yzh5MpnjH9JlTWY11gtBQIvh84eaSp9S4aOmhZLQdrYYJBP/IrCoL
         opSaXMu4RkFnxF3Kr/oC26Z6T50wjI8ORQ3z2mYzUHYcofmPLr1Mo82f71QNqaCjyi
         kHcMkjn5XYFS1HpYmZWke4HZsaXB8oW9jQ7DrvQY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UkQ-1nd1ER224A-0173oY; Wed, 15
 Jun 2022 18:58:41 +0200
Message-ID: <56205881-ccb1-165b-889e-3aa641117981@web.de>
Date:   Wed, 15 Jun 2022 18:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v4 1/6] archive: update format documentation
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
In-Reply-To: <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mNrqFMzXn/7JH/BpKxTN9KCqTsI7jlIDNPoaAKjexnffhAMAHem
 PAsi9XXLlQ15zu6z9FXVsJB6gi7TjGHS2BYKOW6D416uL9M4lbgpE8xOk1m+9svIVS/4u3Y
 j8331ClMzYtHSmqJYPFpcVChAwd4hgGgeEywgu4Ug5uTN59iH4vV98h0kYrXixLoNQpiidm
 LJp6eBFJiAJSykPjcheeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CVLKGiOPzjc=:rvwSk4p7p37GWSKfHIdlIT
 e9gsrl0sL5fQ5hLhCNCduh4wvECRD7J09w9i3TEEFRoDTGt9ecMunDRPFB//jysPA2H+inbSl
 RxXhhfY0ixxJokJMskrSQsNNtxLhjER+t3hL9Mkurwb9uupyT6zRTCDlhnR75leWwmcoA8uSO
 fzn2l9y0u5d6uQCZ5md8XEoGmf1sZT09ToANJR+3StdYyWESAune4f41T/vMGzxeYPy0sWuZY
 jg6nEHW6jRkwQkGyV0lZSUtJI8zoqXQLnL8heeHCxZ6qNZDE5YECUDH1h/c7USlm4tq/W8cji
 LxzhBYB1iNk8G1WN+BuaWQZwFCeNFF4SUj3H3XcmHeUl4RQPdsXwa9prXbOwK/qHO/VlVPjzi
 M/SvV94uFIgjgpr7dUdh1XmqO4VI/iZynYi+4nN9p+D1RyOf1gtk0HlX+aTF8QN4JBVxqwdG4
 ZxZTusOHZJ9Qx8Tt1MUvyCWMvuRHIGfHwdNwPCSddFvMzHxd0C1lFD9nlsX7G0bB/JPVeGlTl
 Ys/9Sg5o02gJ2tdqVgfa/Syvpp07RDI+cVpCVxVSvJrISgnsCBdkslQLKt+8WH51XORx2JIui
 Z1BI7R1jMj13RN7NVK509jD04QypSWC5Zlp7BTcbyXm4yWbKuoLKOljSaTwp1529yqHdrFcsb
 w8qYeNO0wgQ9rOEszJXrD+L17BKNNUE7OdyPQKJhD91w7mbuz5gSG8VK4fWa7awjkNQ1iPsMf
 UxmOmierQJ5MDXp1Ir7fleFpB/UffAJLx5Wzc4vS10SQzjKUCE6wq76kp0FD0Ru5Gdxx/pJrG
 rqdOpOL8aJa/x4Bb0KuHSxefsAFiUFuc1U7q1JKmE8Q4OnZLQV/HXBwGukEvpwaWEo057jSyc
 Mn6AvB5ArUFlZzcV6x9XaUjm6v5K93rNuvyGbvkiyiryLHOsahPJC5ZpRnJQgpIfdhwGN/XEd
 WEw8PYcIoT55OPsBHyFVU3uHWSq/HgLX+s3jMrOKYBI5fjhe307mGckD/9CkFyQCSpLyGL25k
 PONkIgJjWfo+4/2o6W8dcVacynMjufgUDBYsBTkt5lDKwxvx93HHEaCSnfHcZtpC8LAJi1edK
 AVb/AijcsgYaq7omvXpL35px1DCPwjagJnH
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mention all formats in the --format section, use backtick quoting for
literal values throughout, clarify the description of the configuration
option.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-archive.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 56989a2f34..ff3f7b0344 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -34,10 +34,12 @@ OPTIONS
 -------

 --format=3D<fmt>::
-	Format of the resulting archive: 'tar' or 'zip'. If this option
+	Format of the resulting archive. Possible values are `tar`,
+	`zip`, `tar.gz`, `tgz`, and any format defined using the
+	configuration option `tar.<format>.command`. If `--format`
 	is not given, and the output file is specified, the format is
-	inferred from the filename if possible (e.g. writing to "foo.zip"
-	makes the output to be in the zip format). Otherwise the output
+	inferred from the filename if possible (e.g. writing to `foo.zip`
+	makes the output to be in the `zip` format). Otherwise the output
 	format is `tar`.

 -l::
@@ -143,17 +145,15 @@ tar.<format>.command::
 	is executed using the shell with the generated tar file on its
 	standard input, and should produce the final output on its
 	standard output. Any compression-level options will be passed
-	to the command (e.g., "-9"). An output file with the same
-	extension as `<format>` will be use this format if no other
-	format is given.
+	to the command (e.g., `-9`).
 +
-The "tar.gz" and "tgz" formats are defined automatically and default to
-`gzip -cn`. You may override them with custom commands.
+The `tar.gz` and `tgz` formats are defined automatically and use the
+command `gzip -cn` by default.

 tar.<format>.remote::
-	If true, enable `<format>` for use by remote clients via
+	If true, enable the format for use by remote clients via
 	linkgit:git-upload-archive[1]. Defaults to false for
-	user-defined formats, but true for the "tar.gz" and "tgz"
+	user-defined formats, but true for the `tar.gz` and `tgz`
 	formats.

 [[ATTRIBUTES]]
=2D-
2.36.1
