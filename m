Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41CA2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 05:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbdFWFIB (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 01:08:01 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36388 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbdFWFIB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 01:08:01 -0400
Received: by mail-pg0-f46.google.com with SMTP id u62so16986545pgb.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 22:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CyiMohDZfvLRu8v+tri3XV3XWn0vD6uPQns6I2p00LI=;
        b=AZkN9F+u0tCWH5qGU1+TGXVEMjnnldUCVoWY66b27RhGNKqK3w2bm6s77YDBCOH2WP
         I1ODjrvNR9elRe1/Ia3J/Y5T2HvNtI6NGcgEyFt6TKRmFJTx5RYHGtfFc8A1gWDxbHLE
         zfJ/3v3hQn3LgfmWxzwMLekiW3m4Wg58T4hgurLAmdWC8RQ6Hb4t6BWjb5ur/LsJnxWj
         OEJV4n/cSSdma46ICKBiGDoWmX4JkVuY/caFEH5i6m43Q/Y6LDN3icH4lz/I/2rZeG01
         s3bcF8Q+jpjWFjkC6IyqAaZCiedkSkltPTrgWj4UuCxyVQNGfELWrg1KjSayIXJt+yL4
         C85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CyiMohDZfvLRu8v+tri3XV3XWn0vD6uPQns6I2p00LI=;
        b=jrknlDilrAFc40xEDRE4H2stLZMQjEBjzt1g70DNDPm1JmrTbZauHnBLiQChmaRzGL
         Sa9mEah7tYQFQ9glUoWVlKtMykbwprAtigc/RbxIUuhLE9Mmg8ZFGByC7Y2GFBCw/2IM
         Ftz4MRAK3jSi3tTFsE/A3zIcCjb5T4zGRrXacWaibb55vg9yWfwQ2amks0cYsXBvWqCv
         bEzQ15tjneoLB/aucveICdf6oP+MLC++MsNyWdK4AMTnD4uS9VSU6cPDCJT68ZVbTT/T
         R9yWF8mU6i60CGUb8A2u5ca9fo87mjpKpQnhszjAQOqGyNf+tqlCFJ90+3w6OGEk9T+V
         yrtQ==
X-Gm-Message-State: AKS2vOyfZUI5YR/Tkp+wSDagOqheUvfmJNEZiIvLuVXx18PBdFMboDrr
        312PTfvXb2u29BVMXIkWCQ==
X-Received: by 10.99.60.28 with SMTP id j28mr6202473pga.18.1498194480104;
        Thu, 22 Jun 2017 22:08:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id z4sm6683761pgs.21.2017.06.22.22.07.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 22:07:59 -0700 (PDT)
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
Date:   Thu, 22 Jun 2017 22:07:58 -0700
In-Reply-To: <xmqqa84zgwx9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 22 Jun 2017 21:17:22 -0700")
Message-ID: <xmqqwp83fg0h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  git-rebase.sh                 |   4 +-
>>  sequencer.c                   |  11 ++--
>>  t/t3404-rebase-interactive.sh |   7 +++
>>  t/t3420-rebase-autostash.sh   | 136 ++++++++++++++++++++++++++++++++++++++++--
>>  4 files changed, 147 insertions(+), 11 deletions(-)
>
> I've merged this to 'next' but I probably shouldn't have before
> making sure that Travis tests passes 'pu' while this was still in
> there.  
>
> At least t3420 seems to fail under GETTEXT_POISON build.
>
>   https://travis-ci.org/git/git/jobs/245990993

This should be sufficient to make t3420 pass.  It seems that t3404
is also broken under GETTEXT_POISON build, but I won't have time to
look at it, at least tonight.

    $ make GETTEXT_POISON=YesPlease
    $ cd t && sh ./t3404-*.sh -i -v

to see how it breaks.

Thanks.

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
 
