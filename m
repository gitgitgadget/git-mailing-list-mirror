Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E703B20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 18:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbdK2SyJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 13:54:09 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:42689 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdK2SyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 13:54:09 -0500
Received: by mail-pl0-f46.google.com with SMTP id bd8so2627495plb.9
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 10:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxX1Qdb+uStWOyn8gjJp1XRVHn1Dntq86Kd9LyYT/xM=;
        b=re8Jv3Hog12akf9HS0KCldYx9beVT+p5ww0bpYepPHeTOCgP7fCwavgALwNQbrbr5f
         FrrX0qld1DNgVDeO6W0xrqOgb+XHyAoDJMNmVt4pJp4anR+EHtAIKP5tOL1vlbzkkU57
         ngRFNb2m24TBC000YqPK3MKkIF+h0Iae6iPL7PBnCiGZfXZVF1EJHQIljYDKK+oGso34
         py0W21MZ5bwxLt9fmUoYJtXDyF1Owktb8J389GqY/ebTMmcgTfB0NpcQwTYQ/UWfNhzW
         37YUtfsFANXo/XrdoDWvehWrZACs14rAZYLPyaYCnmSP1Zrfjd8LbCz3IqAStg/Fn2u7
         z7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxX1Qdb+uStWOyn8gjJp1XRVHn1Dntq86Kd9LyYT/xM=;
        b=ANbAHWQrHO3NShUiKWhwkXS5ubEgdgbNA961BX0IxLWQbO8rTrLmHd3bNKhValuuhu
         bQaAHjn5XylToUbdP0Y66N7V0daWhnlnTsWZgiKRUymcRuy/5zsPTOfWU7X02h5UqjD4
         ib0G8YYkjYIuuFTQAQhkSTvR1JsFd+NGPZMdFeRjhw4dS3jVoFTM0Yra5ZWa4eCQ3S9C
         1OVuaTVvNE+NDlnowyOf+eUN65iuI3IkMq5tFK2ZpHEbhLiF8xcQQBNCQfKvrjnWb2OS
         hU5lLMOpH9t3SqukFr9VJffTqLsuHPkkqhsZCgLL8EmVQHe7Eqiynircdchps2gQs0n8
         usAw==
X-Gm-Message-State: AJaThX7XVhIkU85OMdLylfwn0d5a5XNbMK7lUqj3O1q5FZiskOYweMhq
        WDd6VzWCq2Ev+mpCYcu4DUqAOQ==
X-Google-Smtp-Source: AGs4zMbyxhpgGI9pY7SQHFe3r6H0wMnCVC+TxUbbS7UVOBrWzWGWLO0gp80+nA//ErVZEMkBCvu70w==
X-Received: by 10.84.229.5 with SMTP id b5mr3867972plk.405.1511981648394;
        Wed, 29 Nov 2017 10:54:08 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:c49c:fd46:209a:1ecb])
        by smtp.gmail.com with ESMTPSA id h69sm4426268pfe.107.2017.11.29.10.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Nov 2017 10:54:07 -0800 (PST)
Date:   Wed, 29 Nov 2017 10:54:07 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH on en/rename-progress] diffcore-rename: make diff-tree
 -l0 mean -l<large>
Message-Id: <20171129105407.d4232fdb6fce2b99ba75ab9b@google.com>
In-Reply-To: <CABPp-BHEyXcjFzGvLHToz+2FRMM3g-mUTxn2uf8exQV61qff9w@mail.gmail.com>
References: <20171129183200.178183-1-jonathantanmy@google.com>
        <CABPp-BHEyXcjFzGvLHToz+2FRMM3g-mUTxn2uf8exQV61qff9w@mail.gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 29 Nov 2017 10:51:20 -0800
Elijah Newren <newren@gmail.com> wrote:

> Thanks for testing that version and sending along the fix.
> 
> I suspect the commit referenced twice in the commit message should
> have been 9f7e4bfa3b ("diff: remove silent clamp of renameLimit",
> 2017-11-13) rather than b520abf ("sequencer: warn when internal merge
> may be suboptimal due to renameLimit", 2017-11-14).

Ah...yes, you're right. I'll update the commit message if I need to send
out a new version or if Junio requests it (so that it's easier for him
to merge it in).

> Other than that minor issue, patch and test looks good to me.

Thanks.
