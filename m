Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460EF1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 16:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbdLUQ6d (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 11:58:33 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:10936 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbdLUQ6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 11:58:33 -0500
Received: from ms15nec.int.opaltelecom.net ([10.103.251.115])
        by smtp.talktalk.net with SMTP
        id S4AxeZ9sRmITaS4AxeqQAT; Thu, 21 Dec 2017 16:58:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513875511;
        bh=cM/GcpQziMpds6O7tdmx3gNSfCF+rLmHs32Q8k2pqO4=;
        h=Date:From:To:Subject:In-Reply-To:References;
        b=nU2nHy+Q1teeVHELCqC32Vndd+5Ue9BFvgjaEcj8caMXGcmWs8M/Ox4g9k0OQ0yYN
         mla4YNJJGA783nQiMEstLke0lMtp0HOUK5aEB5s4roNKw8LqZxctJXX0/k2crmn1YG
         V8VsjpRWGyj1JOdYUDeTJExxPmjqUMdTDUrIy1FI=
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=tnicxU7Iw+JYU+lE0AfxUQ==:117
 a=wcpVQE0W4qLcfTC1YB9uxQ==:17 a=9Ui_ZxslVaMA:10 a=IkcTkHD0fZMA:10
 a=ocR9PWop10UA:10 a=ybZZDoGAAAAA:8 a=VwQbUJbxAAAA:8 a=-cIDcBCyoJ4R4ce6hVYA:9
 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=AjGcO6oz07-iQ99wixmX:22
Received: from (82.10.83.37) by webmail.talktalk.co.uk;  Thu, 21 Dec 2017 16:58:31 +0000
Message-ID: <27972213.1048151513875511767.JavaMail.defaultUser@defaultHost>
Date:   Thu, 21 Dec 2017 16:58:31 +0000 (GMT)
From:   "phillip.wood@talktalk.net" <phillip.wood@talktalk.net>
To:     <junio@pobox.com>, <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2017, #04; Tue, 19)
In-Reply-To: <xmqqshc6tm26.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
References: <xmqqshc6tm26.fsf@gitster.mtv.corp.google.com>
X-Originating-IP: 82.10.83.37
X-Username: phillip.wood@talktalk.net
X-CMAE-Envelope: MS4wfP7euvhrRgh6UC+5j5Gz6SseCEfPWDcmdtad2UIOMzpNrNCX96QwscUc3JMEql4IhmXiY9ULmsKkDGzaW7Ij0lSWaO4t+pKd29XH5h7n7kuAERjsW5Qo
 xSvR8m5qh4+LPTLx684Zbs8vZyWUzDjChQoBistbrhwSgO36+4oCP6/bfAtUyLuOGDx6gTTcOOftltWOrnvokOZgAnYIyl+sSpTvvzTVMeZhD4LFImYrcZo2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>----Original Message----
>From: junio@pobox.com
>Date: 19/12/2017 22:00 
>To: <git@vger.kernel.org>
>Subj: What&#39;s cooking in git.git (Dec 2017, #04; Tue, 19)

>* pw/sequencer-in-process-commit (2017-12-13) 10 commits
>  (merged to 'next' on 2017-12-13 at ec4d2b9c84)
> + sequencer: improve config handling
>  (merged to 'next' on 2017-12-06 at a4212f7ebd)
> + t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
> + sequencer: try to commit without forking 'git commit'
> + sequencer: load commit related config
> + sequencer: simplify adding Signed-off-by: trailer
> + commit: move print_commit_summary() to libgit
> + commit: move post-rewrite code to libgit
> + Add a function to update HEAD after creating a commit
> + commit: move empty message checks to libgit
> + t3404: check intermediate squash messages
>
> The sequencer infrastructure is shared across "git cherry-pick",
> "git rebase -i", etc., and has always spawned "git commit" when it
> needs to create a commit.  It has been taught to do so internally,
> when able, by reusing the codepath "git commit" itself uses, which
> gives performance boost for a few tens of percents in some sample
> scenarios.
>
> Will merge to 'master'.

Can you hold this one in next for now please, I think there is a 
problem with freeing a statically allocated variable. I'll sort it out 
after Christmas

Thanks

Phillip

