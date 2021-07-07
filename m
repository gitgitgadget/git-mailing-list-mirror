Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72994C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 16:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1D261CC3
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 16:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhGGQ0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 12:26:48 -0400
Received: from 84-20.comp.nus.edu.sg ([137.132.84.20]:53464 "EHLO
        mailgw1.comp.nus.edu.sg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229519AbhGGQ0s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 12:26:48 -0400
Received: from localhost (avs2.comp.nus.edu.sg [192.168.49.6])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id B7EAEF8087;
        Thu,  8 Jul 2021 00:24:06 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.6]) (amavisd-new, port 10024)
        with ESMTP id fLuH29XHP9TX; Thu,  8 Jul 2021 00:23:59 +0800 (+08)
Received: from mailauth0.comp.nus.edu.sg (mailauth0.comp.nus.edu.sg [192.168.49.2])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP;
        Thu,  8 Jul 2021 00:23:59 +0800 (+08)
Received: from hujialun-ThinkPad-X240.nus.edu.sg (unknown [172.21.128.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hujialun)
        by mailauth0.comp.nus.edu.sg (Postfix) with ESMTPSA id 8765E200946FD;
        Thu,  8 Jul 2021 00:23:58 +0800 (+08)
From:   Hu Jialun <hujialun@comp.nus.edu.sg>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Hu Jialun <hujialun@comp.nus.edu.sg>
Subject: Re: [PATCH] commit: remove irrelavent prompt on `--allow-empty-message`
Date:   Thu,  8 Jul 2021 00:23:06 +0800
Message-Id: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706022438.580374-1-hujialun@comp.nus.edu.sg>
References: <20210706022438.580374-1-hujialun@comp.nus.edu.sg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The existing code may want to see a preliminary
> clean-up patch (PATCH 1/2) to move these messages to a set of
> variables, so that the fix (PATCH 2/2) can swap the contents of
> these variables based on the value of allow_empty_message, if it
> makes the resulting code easier to follow (I haven't tried it, so
> please tell me if that improved the code or not after trying to do
> so ;-)).

Tried to do this and the code does seem more maintainable. I'm not
exactly sure if I did it the right way, though, so please do feel free
to point out where I have done improperly.

Also, sorry about the previous email -- I forgot to put one newline and got
the quoted text truncated. I am really new to mailing lists and might make
some silly mistakes :E

Hu Jialun (2):
  commit: reorganise duplicate commit prompt strings
  commit: remove irrelavent prompt on `--allow-empty-message`

 builtin/commit.c                          | 31 ++++++++++++++---------
 t/t7500-commit-template-squash-signoff.sh |  4 +--
 t/t7502-commit-porcelain.sh               |  4 +--
 3 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.32.0

