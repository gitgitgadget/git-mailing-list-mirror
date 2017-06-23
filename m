Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2DC2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 19:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754871AbdFWTBH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:01:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35711 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754806AbdFWTBG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:01:06 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so7178796pgc.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bkCQ2CrnnQt9uUCm+q07jw5tu1aMpLUmWhBo+cb/dxQ=;
        b=XfNl/XBSRQ57m/OEgsHItT5IresbTk6XjSIgkHQ8EM7nivZTMfGRtgJ0lEY0Rodou1
         vIpv1V5oyS37r7I3J8rifVOwCuGZ3HXrNG2N+iFX9XrHbqyUGW+50K0p3Y1GRaU4NQYP
         zeaUfEFa2N19R27qcZxcU2EHgwLVIiYhxO62GJirLQWgOB+AUbEtioS23h3iuMgyTfTq
         dE7XdZA0EfNaEM2S3jrCcZBB/ObKbkDLl4Bvx5hYH7YdR1V+A9cQBoJhhWzw92FX9oiE
         YbHH4gJj1GC8QdzPLUElCmIGCQ1caGdb4dneJKo+aRof/OEo1nuTxsD6tcEw+uVBlSBE
         7Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bkCQ2CrnnQt9uUCm+q07jw5tu1aMpLUmWhBo+cb/dxQ=;
        b=KjRS9WWqFGPviWcZqsYf2zaJgUcVevISrEiVDi87wsHo9N0NbqqB4GwZ92ZCVUSG8C
         dFYRXOjCQp7WTRCXupWYbrtZY0fTMaB7NrFHi32t35qwIvKoInbir6hNzPpa/sY8ZAmf
         KQcYCagcgAobI8UCYdpA0iGZ2lCZaycg/nCUM6bAX0WJ8DSrTG+E+0q3mmSiPVdLOHgx
         PKt1G9JqXY+Olb2uZc4dalq6EHmf4U7ADbvqEuGwbQrq1nonO4mBET0EO9sm6Li6Qxmd
         wiwQpQik+akM3EmojsInqKmGYZMfrRkSW/nHPirgw4dIQUPRMo97SEn8ViW3evVw+eMB
         A0VQ==
X-Gm-Message-State: AKS2vOz+nigRIJRprXXuB1smp3Y8q1TTSuMRsHN0pH+oiSBZki3SvQdi
        d2e1EkLS7br3/A==
X-Received: by 10.84.209.234 with SMTP id y97mr10501118plh.200.1498244465024;
        Fri, 23 Jun 2017 12:01:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id f10sm12107652pfd.69.2017.06.23.12.01.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 12:01:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/4] Add regression tests for recent rebase -i fixes
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170619175605.27864-1-phillip.wood@talktalk.net>
        <xmqqa84zgwx9.fsf@gitster.mtv.corp.google.com>
        <xmqqwp83fg0h.fsf@gitster.mtv.corp.google.com>
        <bc0c32fa-2df6-a4a3-5966-8efabfa349cd@talktalk.net>
        <xmqqfueqfxfv.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 23 Jun 2017 12:01:03 -0700
In-Reply-To: <xmqqfueqfxfv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 23 Jun 2017 10:03:48 -0700")
Message-ID: <xmqqmv8yedg0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> For 3420, I can wrap the two-liner patch I showed here earlier into
> a commit on top of the series.  

So, here is what I'll queue on top before merging the topic down to
'master'.

-- >8 --
Subject: [PATCH] t3420: fix under GETTEXT_POISON build

Newly added tests to t3420 in this series prepare expected
human-readable output from "git rebase -i" and then compare the
actual output with it.  As the output from the command is designed
to go through i18n/l10n, we need to use test_i18ncmp to tell
GETTEXT_POISON build that it is OK the output does not match.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3420-rebase-autostash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 6826c38cbd..e243700660 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -178,7 +178,7 @@ testrebase () {
 		test_when_finished git branch -D rebased-feature-branch &&
 		suffix=${type#\ --} && suffix=${suffix:-am} &&
 		create_expected_success_$suffix &&
-		test_cmp expected actual
+		test_i18ncmp expected actual
 	'
 
 	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
@@ -275,7 +275,7 @@ testrebase () {
 		test_when_finished git branch -D rebased-feature-branch &&
 		suffix=${type#\ --} && suffix=${suffix:-am} &&
 		create_expected_failure_$suffix &&
-		test_cmp expected actual
+		test_i18ncmp expected actual
 	'
 }
 
-- 
2.13.1-678-g93553a431c

