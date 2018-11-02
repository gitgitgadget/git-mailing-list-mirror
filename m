Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F89F1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 03:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeKBMNQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 08:13:16 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:50186 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeKBMNP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 08:13:15 -0400
Received: by mail-wm1-f45.google.com with SMTP id h2-v6so739233wmb.0
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9goHeuBM3a6cVZpzXzHK6N1uJ50nj/oCeQyFJ/wgm4E=;
        b=Sl86I9akjjWjcmui6BOylfSiC7jVrGq3OVqwSH3VzOEP88MLbtHtZcUdA51mn5hjKu
         mYPbQ1rkebXBGE60eXtX10SDPWQM7ZsFiYMeOprjUtfSxwcJ0+e9fKhr069lwm3UU+ck
         tElQ/wZFhrwmb9MQiMTk1ahFKyUAGZ2atbDIs/is7+YHnYStnaEKNa+8EBzQyLfysbyz
         Bi/haIOioKL4NNd0eX0wJrvpZ7obpMxcucFIFqHwBbA4sM33lt8geeExkpNxJ3I3AF2n
         e7NTv6fe6l4u/uAyG7jBnTiYMgruDlew+UHMzxjtrdWMwJ1+7pLA2DxaYieLNcnBUd2T
         EEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9goHeuBM3a6cVZpzXzHK6N1uJ50nj/oCeQyFJ/wgm4E=;
        b=DkataXbSWGl9ZclwkZ7SNNaGwzB5EVC+bUc1qvPE2PW72jv8YedsjxlO9v1NqRZ2qc
         NDq9EUdPc0n39mnUxAXfif6GqSJex+oS7xtt5VIxuRrnEAVcfAchke4EQ7owuZOciVdg
         5tStaI0a3CbsPp0ZY9yowpVz/ZOUxnIvvP1LpxYz6YdfAaN73xQ+Gn3t945ncxVUbUlc
         iV86LFwumrPzIV5isVsNCkBM4MRmpgiSGkAT85Iz06LvEVQ4pFsE9PLyLVbWm0oTqakw
         JxNo66GfMWSqchFCokLEqNwvDnwg4LnERtFEPLoQjTUc73E+6uNn1RraXR340fr9DxV4
         VWmA==
X-Gm-Message-State: AGRZ1gJFRUn/f5IJbFWnrurC0Ck9xpJzvmvyvKV/Z0/x5IZDKiauTtAd
        bSsPYB6X8cIaBlZwXv6CQNo=
X-Google-Smtp-Source: AJdET5dyfJsC2LckoxYG9Zoclp5xYNJfeWJqkzWwAexyQtkVMbFo/R/z18K75skMMu1wFT6SYwS4nQ==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206-v6mr7659828wmc.78.1541128061268;
        Thu, 01 Nov 2018 20:07:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x13-v6sm5794518wrq.56.2018.11.01.20.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 20:07:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sirio Balmelli <sirio.bm@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git appears to ignore GIT_CONFIG environment variable
References: <3389BCF7-6170-4242-82D3-0FE7FB2EA5F2@gmail.com>
Date:   Fri, 02 Nov 2018 12:07:38 +0900
In-Reply-To: <3389BCF7-6170-4242-82D3-0FE7FB2EA5F2@gmail.com> (Sirio
        Balmelli's message of "Fri, 2 Nov 2018 02:32:52 +0100")
Message-ID: <xmqqpnvoqirp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sirio Balmelli <sirio.bm@gmail.com> writes:

> It appears that git ignores the GIT_CONFIG environment variable,
> while git-config *does* consider it.

Yup, that is exactly how it is designed and documented.  These
dasys, with "git config" taking "--file" to work on any arbitrary
filename, you do not necessarily need GIT_CONFIG enviornment.

