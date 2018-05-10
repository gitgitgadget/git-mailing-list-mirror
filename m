Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7655F1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964991AbeEJOLa (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:11:30 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40396 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeEJOL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:11:28 -0400
Received: by mail-wr0-f195.google.com with SMTP id v60-v6so2173333wrc.7
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Lc6mK9J5/usr+3FaorjRhJaKEecq/8dCwZpZOAwCVk=;
        b=O8J+Lqk8mac6UmdVVbR36G/yXr1ba3JffAbvj0CvUO0Vap+vmRoTt91vAHVDB2cV11
         EWo55GE6CkbVNBDCg/GUeT28bIVw+UhwgXonR4j0Ie5UUVWq//mOa1eHCiwzCpqehK2y
         e/ebvcRaqyo3Tvz6u0Ng0U3XDsFRl9WET7WIn+NDBWC558IcbwM11/ZT3UKd7uvrHqx5
         hxByus48MjTNuf5yYj0v2LThi+YUnAVYizyHT2mMbQxSI+LKq+Ai6D3nqlyQj/19GZUY
         h0aGH2HhFRHw4DA40od2pbQYNzDQHviipYpq5sBVLqWZr0jrKM7meM1Qw/PBy2mthTN2
         uDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Lc6mK9J5/usr+3FaorjRhJaKEecq/8dCwZpZOAwCVk=;
        b=txMf96QCUAzEggg+k2rTGkIztgs8FpYykPQJ5t+nXh1dAm9BSMtEEs+gf8QlraJTqJ
         0mG/xrSZFjpRZn0+66s4IGaaatE0hwIe2KARXIRbq1Nn6QjOMhkV62JWl9Sjy0ZHxoR1
         EmWdpyoS3POhbPr7WNa0PAe6D1i2lriBMOFLVJMAsPi7Ydg365MYesipyDk0LsnSI1Io
         2MBYx6MocYFt8+Hnbhr9IeWRieAB4wmvilsX30DxbcXIKQEBRVSAc9tFgGTMnQqT2ASR
         7EuVTczq5D3ati3qoXd/kfTqq1mQvBjZiowq2RJib/Zrg9JStk7Cdkb/J3ItjpU69FbE
         93UQ==
X-Gm-Message-State: ALKqPwfNHjIFciGh0/xh/++XFsiyyDoli87D++pXuZlBUbM/mshyrJ9y
        gtKd2rV17SoPBKeiNrxnnlE=
X-Google-Smtp-Source: AB8JxZoz5fb3hLxPoroRsVU+S3CdsVr7CWSFVVdj1KirI5WubXh4f5tZ1rpahiEfxQnnlrZRjzXNjg==
X-Received: by 2002:adf:c5cb:: with SMTP id v11-v6mr1414556wrg.151.1525961487693;
        Thu, 10 May 2018 07:11:27 -0700 (PDT)
Received: from localhost.localdomain ([94.10.164.188])
        by smtp.gmail.com with ESMTPSA id l69-v6sm1530687wmb.6.2018.05.10.07.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 07:11:26 -0700 (PDT)
From:   Oliver Joseph Ash <oliverjash@gmail.com>
To:     phillip.wood@talktalk.net
Cc:     git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        mqudsi@neosmart.net, oliverjash@gmail.com,
        phillip.wood@dunelm.org.uk
Subject: Re: Regression in patch add?
Date:   Thu, 10 May 2018 15:11:25 +0100
Message-Id: <20180510141125.21677-1-oliverjash@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <be321106-2f10-e678-8237-449d2dd30fee@talktalk.net>
References: <be321106-2f10-e678-8237-449d2dd30fee@talktalk.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You found the problem Phillip! My editor was trimming trailing white space, which breaks the context line.

I had tried to use an alternative editor to account for any editor specific behaviour, but it turns out both the editors I tested in were doing this!

I suspect this change in behaviour will effect a lot of users? If so, it would be good if `git add -p` allowed for this behaviour, in the same way `git apply` does.

Meanwhile, I can easily configure my editor not to do this for `*.diff` files.

Thanks for your help, Phillip and Martin!

Mahmoud, does this also explain your problem as per your original post?
