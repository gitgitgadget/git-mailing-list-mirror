Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 623FD20401
	for <e@80x24.org>; Thu, 15 Jun 2017 23:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbdFOX3R (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:29:17 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34852 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbdFOX3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:29:16 -0400
Received: by mail-pg0-f67.google.com with SMTP id f127so3114860pgc.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pGVzZf+5aL21HKphi+rGbdFR37XngHFS6c1T8LG6/sc=;
        b=noLbFwXNYmJyi5q99k19Dm29S14jvoyGMcoOvAHY9yIdaoI0aUbR0JBsMmKUmFQWz2
         J135vBZZ+WC1RG0up1ADnTxfVDkHIszg4qJfkkvWwC8uskJODapQTfEgmY+xV/NaWT21
         ufVRRpZmi1+yYvsFG1EHg0FYb45gCUyLFOdDTJfGXElMP/yDNi03HPwRMbYPQ4L5wGFt
         icGZCLx9ycv143uYMvPeYR/6SqvYQ93yQfAu5HKCIcNAI4PhejTQaQodPzHjd4cOLRqg
         XofsP3gDS+LpOHnmS1MuPTP0dl22rMEjTkHcbUowNKCWFASFzZsum3ZbcyCTEpddI570
         Nq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pGVzZf+5aL21HKphi+rGbdFR37XngHFS6c1T8LG6/sc=;
        b=fX7nFGVpv7yBqwObQbU+j9YLq8FmX+OQY3hdwD0nE0R31w6ntkXSlG9B3h9U7JX+Ij
         5XxbeftgOEcQ7yS6Mfa8dygdbbiKtjz/6jWbExxbSb/HbZu2O0ud1ar8W4X7dpDbJFSr
         Nnk4II1Suver8w6suAgynD40U5ZvM/mPaMmSJzyD+KXCjBNDg0FHCHRAKfYbgHXtrFVh
         ruDGm6uL1m35HBTEG/0VkJ9VG18aKj77IOvEoZxV+gFPJRvplazRdwA02VH/nxWGrMzY
         WwyLRmjLTvoDkE9gOZK/u8tGhf7V6p0KaNnBQeoK2x8i3K64LmoTYGQ8IHnD3pxtNzta
         0uLA==
X-Gm-Message-State: AKS2vOwvseeynu3tFM45JPQ6+Yk6bPqcEoAOx/vz6rRSDc/Rs4L5iAKl
        yen59CY07pzLbpE1oPE=
X-Received: by 10.84.208.102 with SMTP id f35mr8967947plh.53.1497569354860;
        Thu, 15 Jun 2017 16:29:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id e63sm654905pfb.18.2017.06.15.16.29.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 16:29:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] Add regression tests for rectent rebase -i fixes
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170614102427.5220-1-phillip.wood@talktalk.net>
        <xmqqshj0yhq1.fsf@gitster.mtv.corp.google.com>
        <xmqqk24cygvm.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 15 Jun 2017 16:29:13 -0700
In-Reply-To: <xmqqk24cygvm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 15 Jun 2017 16:23:57 -0700")
Message-ID: <xmqqfuf0ygmu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> I've revised the second two tests as Johannes suggested to drop the
>>> sed script. The first one is unchanged.
>>>
>>> Phillip Wood (3):
>>>   rebase -i: Add test for reflog message
>>>   rebase: Add regression tests for console output
>>>   rebase: Add more regression tests for console output
>>>
>>>  t/t3404-rebase-interactive.sh |   7 +++
>>>  t/t3420-rebase-autostash.sh   | 138 ++++++++++++++++++++++++++++++++++++++++--
>>>  2 files changed, 141 insertions(+), 4 deletions(-)
>>
>> Thanks (and thanks for Dscho for reading it over).
>>
>> Unfortunately this breaks unless your shell is bash (I didn't have
>> time to look further into it), i.e. "make SHELL_PATH=/bin/dash test"
>
> This is the bash-ism that broke it, I think.
>
>     create_expected_success_interactive() {
>             cr=$'\r' &&
>             cat >expected <<-EOF

FYI, I've queued the following as a fix-up and pushed the result
out.

 t/t3420-rebase-autostash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 325ec75353..801bce25da 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -45,7 +45,7 @@ create_expected_success_am() {
 }
 
 create_expected_success_interactive() {
-	cr=$'\r' &&
+	cr=$(echo . | tr '.' '\015') &&
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
 	HEAD is now at $(git rev-parse --short feature-branch) third commit
@@ -103,7 +103,7 @@ create_expected_failure_am() {
 }
 
 create_expected_failure_interactive() {
-	cr=$'\r' &&
+	cr=$(echo . | tr '.' '\015') &&
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
 	HEAD is now at $(git rev-parse --short feature-branch) third commit
-- 
2.13.1-591-gf514f8f1c0

