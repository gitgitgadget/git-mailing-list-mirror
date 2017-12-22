Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52371F406
	for <e@80x24.org>; Fri, 22 Dec 2017 12:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbdLVM6b (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 07:58:31 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:21288 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdLVM6a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 07:58:30 -0500
Received: from ms17nec.int.opaltelecom.net ([10.103.251.117])
        by smtp.talktalk.net with SMTP
        id SMuBeT1FpAp17SMuBeuwa9; Fri, 22 Dec 2017 12:58:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513947508;
        bh=POoItAZrFLW9g2gDmgFIn8WQ2kMfGkU4yhGBq67ihRA=;
        h=Date:From:To:Subject:Cc:In-Reply-To:References;
        b=GPRacnmoE31J9Zl0L8vhcr4LjtxGS8O8bZeNawWQXDYv/Grd2CYkWUdSxXV4MjI2a
         a+tU4gg2Re4jP9xnRJmzpozKj+iqLD8AB1ySGYdQt9C5xHsd5f00qeAQT3caNwQcw0
         pehPb4RKMaGdZoI+D6ujP8e2aL+XbHgp+X2KlN9A=
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=EGPEdrDQpk0PV5/BYmBFfw==:117
 a=wcpVQE0W4qLcfTC1YB9uxQ==:17 a=9Ui_ZxslVaMA:10 a=IkcTkHD0fZMA:10
 a=ocR9PWop10UA:10 a=VwQbUJbxAAAA:8 a=ybZZDoGAAAAA:8 a=evINK-nbAAAA:8
 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=b6Kcit8S0wAJPAic8eEA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=RfR_gqz1fSpA9VikTjo0:22
Received: from (82.10.83.37) by webmail.talktalk.co.uk;  Fri, 22 Dec 2017 12:58:27 +0000
Message-ID: <17655681.1077671513947507373.JavaMail.defaultUser@defaultHost>
Date:   Fri, 22 Dec 2017 12:58:27 +0000 (GMT)
From:   "phillip.wood@talktalk.net" <phillip.wood@talktalk.net>
To:     <johannes.schindelin@gmx.de>, <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer: assign only free()able strings to gpg_sign
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <f4420880aa4ee73b7c8e435de1efccf9a969fd41.1513943347.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
References: <f4420880aa4ee73b7c8e435de1efccf9a969fd41.1513943347.git.johannes.schindelin@gmx.de>
X-Originating-IP: 82.10.83.37
X-Username: phillip.wood@talktalk.net
X-CMAE-Envelope: MS4wfCaXMF9P/zfdyzsXSKfEJidbKIRbvSn2SzAxsH9xpnhzCS8ZhwZN3CBxxpSgDP9ewL/xZCFj1kHEbRfdMjSjFDbXhy+YyAZ7ci6AQbQ0GH5aOb4cFb4L
 x8FU3LmFzaOyk5RPd0ib35By5E9j4b65VapiwbovQESTdSg5+YFAnAEYl1LGSOR0/2I1KBlmkOxPhW8k5PGepNKYKQg/dPjA/oFK1NzUfmBhdCQErnNAQqR+
 J08x93pUntLTBZ2NYPQGUnnifG1Q7nB376+9cREgNbuiVSpTFyBXP0xXsyR9urT0XgmJ3vWZoSsSPuNqOWgwkZy3wjKQ77Fvmc/Igii1/qKFArY32+XIfC5v
 Eazsp7d/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>----Original Message----
>From: johannes.schindelin@gmx.de
>Date: 22/12/2017 11:50 
>To: <git@vger.kernel.org>
>Cc: "Junio C Hamano"<gitster@pobox.com>, "Phillip Wood"<phillip.
wood@dunelm.org.uk>, "Kaartic Sivaraam"<kaartic.sivaraam@gmail.com>
>Subj: [PATCH] sequencer: assign only free()able strings to gpg_sign
>
>The gpg_sign member of the replay_opts structure is of type `char *`,
>meaning that the sequencer deems the string to which gpg_sign points 
to
>be under its custody, i.e. it needs to be free()d by the sequencer.
>
>Therefore, let's only assign malloc()ed buffers to it.
>
>Reported-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>---
>
>	Phillip, if you want to squash these changes into your patches,
>	I'd totally fine with that.
>

Hi Johannes, thanks for putting this together, the patch it fixes is 
already in next so I think it'd be best to leave this one separate. I 
wonder if it would be worth adding another test, see below.

Best Wishes


Phillip

>Based-On: pw/sequencer-in-process-commit at https://github.com/dscho/git

>Fetch-Base-Via: git fetch https://github.com/dscho/git pw/sequencer-
in-process-commit
>Published-As: https://github.com/dscho/git/releases/tag/sequencer-owns-gpg-sign-v1

>Fetch-It-Via: git fetch https://github.com/dscho/git sequencer-owns-
gpg-sign-v1
> sequencer.c                   |  2 +-
> t/t3404-rebase-interactive.sh | 10 ++++++++++
> 2 files changed, 11 insertions(+), 1 deletion(-)
>
>diff --git a/sequencer.c b/sequencer.c
>index 7051b20b762..1b2599668f5 100644
>--- a/sequencer.c
>+++ b/sequencer.c
>@@ -160,7 +160,7 @@ static int git_sequencer_config(const char *k, 
const char *v, void *cb)
> 	}
> 
> 	if (!strcmp(k, "commit.gpgsign")) {
>-		opts->gpg_sign = git_config_bool(k, v) ? "" : NULL;
>+		opts->gpg_sign = git_config_bool(k, v) ? xstrdup("") : NULL;
> 		return 0;
> 	}
> 
>diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-
interactive.sh
>index 9ed0a244e6c..040ef1a4dbc 100755
>--- a/t/t3404-rebase-interactive.sh
>+++ b/t/t3404-rebase-interactive.sh
>@@ -1318,6 +1318,16 @@ test_expect_success 'editor saves as CR/LF' '
> 
> SQ="'"
> test_expect_success 'rebase -i --gpg-sign=<key-id>' '
>+	test_when_finished "test_might_fail git rebase --abort" &&
>+	set_fake_editor &&
>+	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
>+		>out 2>err &&
>+	test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
>+'
>+
>+test_expect_success 'rebase -i --gpg-sign=<key-id> overrides commit.
gpgSign' '
>+	test_when_finished "test_might_fail git rebase --abort" &&
>+	test_config commit.gpgsign true &&
> 	set_fake_editor &&
> 	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
> 		>out 2>err &&


I thought the bug could be triggered when commit.gpgsign was true and 
it was not overriden on the commandline, is it worth adding a test for 
that?


>base-commit: 28d6daed4f119940ace31e523b3b272d3d153d04
>-- 
>2.15.1.windows.2
>


