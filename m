Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A53EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 17:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjFORdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 13:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjFORdo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 13:33:44 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B3F1BC3
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686850420; x=1687455220; i=l.s.r@web.de;
 bh=aHCItuGTa0V/5uWnbBfgeVEJ7CuZNlJ1VTUyoBRNUeI=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=SlhRuVYw2fd2fCAdzs3juXMsnnLK7XO0WOa2XK8j9MUoGKLbXOT7Vwrh/3Aw6Tg24OZqu/G
 T0V3TA/V3xjHAI9OjHBttCtZKQQSGFF+x+fzgfcw+cEAAU9pivGSi7vu5obPXdREJmDbFWTQN
 /vTKzdXOnOFt1EhoP5zA2FyPiJp33kS6cYZxDV9yas8RSAm//iMy2b8v2MkZiXNAX1+6SNIvG
 EH1cznJewAPq9IyeW1GZ68et5nUmKWF4tdF1WVPxxPMj1dq3j5DS7Vq1Sne2j8/hrOlgFWsco
 +9fhTAU/871VqsbrF5iTmPoj5Q99ZVNC8ddc5ztG0g5q+JWutODg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.195]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2ggX-1q7v2p0Kul-0047vQ; Thu, 15
 Jun 2023 19:33:40 +0200
Message-ID: <23e54256-9ad5-e978-d0b8-abb511232fd1@web.de>
Date:   Thu, 15 Jun 2023 19:33:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] ls-tree: fix documentation of %x format placeholder
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vq4yVYVCik+NSnbrxL2MW7RtulhL/1FBJ3F2RuIla8qH+xs6k62
 GCYQixcZ40vACax02kpykleBD57wTGVmulAHXvxa2BY3BvXd1OniTpNqkxQF6QcOt9EsF2J
 lWe8g1Z+d/fhHNfqoZoA+H6p5O4uW+ExLaqf2ABAzy0rHQ0tHfvMBH4YSojYJqeFwlJu8eb
 KOnDPOtif1gayxJAkd4lA==
UI-OutboundReport: notjunk:1;M01:P0:aiYhSpxysLU=;W+8SXnYy730BnUDWUVCm8C8bqVE
 ocuqxHeKHSUCJkbwHQcr7kL8qEgzRTZZU10VKcAGqKQxJxggQXoVV3Q5UOpx8BVsZppfra4Lh
 feEODCC6Z9b787ahA9x6fTpEuo1S1wWBJXg09nHxci5UbeZo1siXnOlRPZgdIJqrvLf/b4RJr
 CQEJM/Ppc/MN52nbn66++JSBP5R8INRzDEtPgx09fNeGYRGUh6elj9vQK19nQp+aZ6uNujI6E
 g0YD4gbz1emLRHMpSe5KslViiwub5rIcaUwtjm3Ct41Ma0MFSTFXTM3lvheg5FWs1axgIw+iw
 fOzWi8tolKQ+KjwuCgfquyIPi72blrh77EH2fEO9HWZhW+pOlMQjIcNXUcSjPqk5Sq9+/Goad
 Bhl5Frgw+LUNwNp/56JzXaTTGxbuJugrvwDZ9BMDebkQlLMpsxtdFSmBVuBJv16uvntg+6xAK
 svbnuW8vyrSz9j8fFR9F63BHouDEXecoekTRi3ckqj3sASRPb2CBQsKY9rif22xP0gk8L0YXK
 VROxUU6oY8+0U/yhKdTzMIUoD/mXiHXL4IsRJq3kGj8FJTOKeSVp8z/kJrHZ+DbAmXRd7vaFU
 LWmosXz7kCPoFj76ERvR7rDUap+RB0u1ZYe5d8H5iBav/x2BIQt5vFGRPABXBXomOVy79iYrr
 KRpHDUdG/55QMYCy/YoWqftvEeIIU38lItg1OCOxX2kJiP4w2lieGTY5XUyOils2tRxI3CslX
 MNZq5j/tnjyZLgR2n49KFK4I96QSEqrFJY/RO+ibM2jo2aXrKWJ7I/3m2jWu5zhlMz79Qt2/I
 nIo0T6d4tx0VZMHTXXAfouDv2XDJMLBlq0VxotGpYMLLspRSZszNkhp1ybQSDRtKcZjl7s752
 vmxAMI+4x8/ItjJ/EhMTKKHAgBKKIjETFG0J/pySGiIRtYh1GqG/0HGB6RlbHw89Fwuu8vSMw
 dfp66A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ls-tree --format expands %x followed by two hexadecimal digits to the
character indicated by that hexadecimal number, e.g.:

   $ git ls-tree --format=3D%x41 HEAD | head -1
   A

It rejects % followed by a hexadecimal digit, e.g.:

   $ git ls-tree --format=3D%41 HEAD | head -1
   fatal: bad ls-tree format: element '41' does not start with '('

This functionality is provided by strbuf_expand_literal_cb(), which has
not been changed since it was factored out by fd2015b323 (strbuf:
separate callback for strbuf_expand:ing literals, 2019-01-28).

Adjust the documentation accordingly.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-ls-tree.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 0240adb8ee..af06ce14ed 100644
=2D-- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -86,9 +86,9 @@ OPTIONS
 --format=3D<format>::
 	A string that interpolates `%(fieldname)` from the result
 	being shown. It also interpolates `%%` to `%`, and
-	`%xx` where `xx` are hex digits interpolates to character
-	with hex code `xx`; for example `%00` interpolates to
-	`\0` (NUL), `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
+	`%xNN` where `NN` are hex digits interpolates to character
+	with hex code `NN`; for example `%x00` interpolates to
+	`\0` (NUL), `%x09` to `\t` (TAB) and `%x0a` to `\n` (LF).
 	When specified, `--format` cannot be combined with other
 	format-altering options, including `--long`, `--name-only`
 	and `--object-only`.
=2D-
2.41.0
