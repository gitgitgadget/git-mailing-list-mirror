Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73204FA373D
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJ3LpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3LpX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:45:23 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62B247
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130315; bh=Cfb8QYuM+IvFuTs6O759WFqIR9u3UgE/B8Eanz9QL2w=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=icJTYrYizpNa0Ra0TLb3pEHTL6V/Pa0iwEfc/6rfz6NiUFNIu4X5LfiAOzLY0Dqzl
         IahANsfIWzle2ur8XqB9VbB61L9r1whAG7z9fM8OPtZUFaaxX4S/j9sROftg+c7f7i
         4YUQgDdNDJSburRIZS/Bjzych7Kg0v4P2Et9yE1oUZa9Y+JV195gQyYEHzZb4BEtcA
         nPYgJSXrW1yqsjk2cWXKCP9DVK64vtuHukyUT9lDiy+qzfvWLCDyC5eslo2sWIm+PJ
         pqcHDDzhDfllR5xtJHRrOdLVpFXDoYPQv/41NuTtNZ51Zng7IZn2/xOP84i1W8RxOb
         sf+AGPnTUS1Ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRF3I-1oRxhW3lye-00NB32; Sun, 30
 Oct 2022 12:45:14 +0100
Message-ID: <a9b56eb8-1ef9-0e28-1ea2-85ccad7903d2@web.de>
Date:   Sun, 30 Oct 2022 12:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 02/12] run-command: fix return value comment
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
In-Reply-To: <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GXdil/9ckvGQqECzEah0Ni6Bd85u4g1IwVzS3/gl9NPu22YUs9e
 rv9sOO6CykAutKWjyixRbrw8yX+ltMhG+ys10XoZCf+SvzyVJU4E0NvHwSecBkdcAMoHbol
 osAYG667SdOraRggE41usimvE8fG/ATaSXvuwWaeATq94VUh5FPhxVKui9AiGV0iG6aKOgs
 qNjfU/R2AklAYPn2oE6dA==
UI-OutboundReport: notjunk:1;M01:P0:JIvtRHG7yjI=;2u3RMIm1MYCJ3BuS5knZZoDlqqw
 hc5WRcHlfXlMPkq8VAEon70d22dOPjuTzUxy6hT02G3IuUfhZcGhhWJfGTzlY63zTKUHtX5uQ
 /1yd+TbckG6Yj3ND0qPu3ddtrTK27RDlOgtI1EYuRcyZWJsKT7VY85au86oCj5aF9jBohIsO8
 DQ2kvxbGWH+Sf0pdE913Iy4AiepStimLPhThHmFmOQ7hzfoHOZ1SrgwhBcMjCXpap1rL4GxpE
 PUVrKm6OakX4JGJHDUF+MwnFDECoxyUFNF235BRqFs470br1RHslrSthNIwgwcNlXme3pNIeb
 KhWZDNmcVm7uG6YSfwpSqF56IsQYJvD3NVnIvnVehUdP39nbP9TDHqBgonoJyPcwUcgMPoXh6
 B+FrNsjegcz4EfLAUTBmINlJbxEeZgYkskwi+pFryPt5nK0Ts0qjDEivOWHQJuvlk1osRkE0x
 o8w7D99W6SivWLaaIsINNFCDay+yNw8L6YLWY0U2Q2cDkAqTe6E900l0etx/jLOFMDLbhTzEJ
 cWSAOBBl3plPFxpSCdMbYH1BioWiDnSRazTrx3pwfv9sTpV/cyn9s9lZotdBbrPF2TyOB1e+i
 pFoBAWSwTtEx/+fuvSxWpf1xtmo0wWBKqYIAGqhznjzM1RmN1EfhaO/oVGpeT+j2wm06N2Mtg
 VaabzHdbjTJFBA+5riU/WlJPshvo5n9FOd0vK61klSv9g+4++Sc2IXckb0lnVE/kTVBpQWmPk
 wzFh7YsYkVZqetR4COxLdLbyuPIv4QDOgSS5Lthm0tbHOF+i0cqOc59FmAgLlbDxzem5mkHtA
 CF+QeKY/vVyRGi//Pit1g6nlKg6kQji/zB7t8XOsE4bXBVgT1heTV6u2n8gjfRBlNs4us2F+C
 ELB0Mm2kbBJbGRSIn/m30mxHzPyYIEQm39xaNNpGsR1jivJhj2UelskKsXxCIgBo8B2TNBjSq
 eeOHNC7YRXIfICn35LOKNZaC8Mw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

483bbd4e4c (run-command: introduce child_process_init(), 2014-08-19) and
2d71608ec0 (run-command: factor out child_process_clear(), 2015-10-24)
added help texts about child_process_init() and child_process_clear()
without updating the immediately following documentation of return codes
that only applied to the preexisting functions.

4c4066d95d (run-command: move doc to run-command.h, 2019-11-17) started
to list the functions explicitly that this paragraph applies to, but
still wrongly included child_process_init() and child_process_clear().
Remove their names from that list.

Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 run-command.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/run-command.h b/run-command.h
index e3e1ea01ad..820fc25b02 100644
=2D-- a/run-command.h
+++ b/run-command.h
@@ -150,9 +150,8 @@ struct child_process {
 }

 /**
- * The functions: child_process_init, start_command, finish_command,
- * run_command, run_command_v_opt, run_command_v_opt_cd_env, child_proces=
s_clear
- * do the following:
+ * The functions: start_command, finish_command, run_command,
+ * run_command_v_opt, run_command_v_opt_cd_env do the following:
  *
  * - If a system call failed, errno is set and -1 is returned. A diagnost=
ic
  *   is printed.
=2D-
2.38.1
