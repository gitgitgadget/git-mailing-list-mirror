Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82533C433E1
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 08:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E08206F4
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 08:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=neanderfunk.de header.i=@neanderfunk.de header.b="xYNWQl+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGLIl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 04:41:58 -0400
Received: from mail.nadeshda.org ([51.255.233.210]:37136 "EHLO
        mail.nadeshda.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgGLIl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 04:41:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7ECB117684D;
        Sun, 12 Jul 2020 10:41:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=neanderfunk.de;
        s=default; t=1594543315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1DNjYCVaJgX4JTT5cQRvdvN3VbY1ksp19lFVABmAS/c=;
        b=xYNWQl+Lz6KnS0Tlwj3x7SEeQGQI9piRGRNpgjYWhxCPV2PQtWOMLYw00Hnsh6NmegRTk4
        6QdO/djDhC3LeOdO+kiEpKpgvWHwdYK87tDW2CXqQerxfe34/BsIH7V6xzsYKYARydfkro
        0jfXaSvxtzC9/Ws1bLKpOscrNRoqe1bJc3HGsLbHsNpf7BxZJFkfaSLM+B3inWb9F2gGUH
        1+zGhJ6vQFcc8SBJpURlvHFpmnO+Q4pG6K7drFSZTNQGM/Nn96Bnv4esvd8Lnt34HAUNIM
        VyREVanwSv3sxT86mPGwmydbKHB4jhEYaVDzhtoEMxqn+NbOSqSqKlFPs9RlPQ==
Subject: Re: Interrupted system call
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <14b3d372-f3fe-c06c-dd56-1d9799a12632@yahoo.de>
 <c8061cce-71e4-17bd-a56a-a5fed93804da@neanderfunk.de>
 <20200701162111.GA934052@coredump.intra.peff.net>
From:   "R. Diez" <rdiez@neanderfunk.de>
Message-ID: <39d520fd-5b46-0163-e7af-ff13d647b133@neanderfunk.de>
Date:   Sun, 12 Jul 2020 10:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200701162111.GA934052@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> fatal: failed to read object cf965547a433493caa80e84d7a2b78b32a26ee35: Interrupted system call
 > [...]

In case anybody else has the same problem and finds this thread in the future, the workaround I am using is to disable progress messages.

For "git pull", "git gc" and "git push" the appropriate option is "--quiet", but for "git fsck" it is "--no-progress".

Best regards,
   rdiez
