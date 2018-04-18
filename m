Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA741F404
	for <e@80x24.org>; Wed, 18 Apr 2018 20:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeDRU5Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 16:57:16 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:42582 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeDRU5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 16:57:16 -0400
Received: by mail-wr0-f178.google.com with SMTP id s18-v6so8347884wrg.9
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/MEhH1RVqs8XrhnLY2X0dIHW5YN+KXyci/RB8UX3FIM=;
        b=qum+pW83pTBcL2IxqXdSuSXi/ylpCGbncUiPn3M5F+4wcxchf9vplxBBQlY7QQ10q3
         6vocQfR+Fa3mofwPvsGyS7m/4raR2CimnhOs/K4/xqHuQ43NCR/QZHPBZrM/vU8Dt+9z
         ITLMZ9ENb69dvQM9rXHRhjoGHVpjUfmbwX2XS3qiT3Y2/fxvqhErPUzBIjlegtosSS0L
         1mmq6KqcTvr7KiOmyDxLnSAFZdqHYV1HA/hhkr7QhF62R5aNicQZF2h3EOGVDqx5HJVz
         5Qc8zn+PkxsIps9bIxFv4a6ubPDh/lqwzx7Bas7J3uGbxZJE6Y3Fk8tJ3sHN4BooWgzW
         NMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/MEhH1RVqs8XrhnLY2X0dIHW5YN+KXyci/RB8UX3FIM=;
        b=UDulf2SPmp4OKsr+JJYvgjMlmOIpmkI2ir1w1YHYFYU3JOKEj6sYMN+qx7cIGreTjk
         GEfUdBOehaaEQV3eKHoNrgb121meiK07mtM6bdPk+NT2OOA19UqdXLtHnLRI/EPzEISr
         67cc8v2N3xvKgQ+KBnoo1QN/sAZd786Z8aVwZVH6scq/ggSOW3Vf2KuT5DcXQ1XnQQYt
         IgWqg6SWhYjvd+zFS35/d9KSzkikU5dOT+rLPc1kc6vMByNGn1riDr/ib9ZBoCx3W/Yc
         FaHOWlEwvQXLdm+rvWAm9TEbe/jGHjmDJbGW6S9mifovRGBcWkiDxMVpKf2syCQ0hCtF
         c6/Q==
X-Gm-Message-State: ALQs6tBE/cMAfPmcWW3OFHOfdRqrjGI88CytUW69bb4FVYP7FLYh+CY5
        9HyYOHD8UxMgJaGA03pzNBc=
X-Google-Smtp-Source: AIpwx4+FXPlGWo7LSQqzxOPXQOFczT5Rqv14ZtdxiGt80MihU84XMioQ6rID/487B/njpljtp0sYxQ==
X-Received: by 10.28.232.202 with SMTP id f71mr2980814wmi.136.1524085034546;
        Wed, 18 Apr 2018 13:57:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 60-v6sm2003217wrj.62.2018.04.18.13.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 13:57:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kb=A6BsdrtH=2F0634+r5ejG9Ce9U0mry65jkNnscu1nA@mail.gmail.com>
        <CAGf8dgLrWx0dNX5W=2_aonaG55jzhzOBTcr8u=36xSPvtVp8kQ@mail.gmail.com>
Date:   Thu, 19 Apr 2018 05:57:13 +0900
In-Reply-To: <CAGf8dgLrWx0dNX5W=2_aonaG55jzhzOBTcr8u=36xSPvtVp8kQ@mail.gmail.com>
        (Jonathan Tan's message of "Wed, 18 Apr 2018 06:09:47 -0700")
Message-ID: <xmqq8t9ki66u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> I considered this done a long time ago,
>>
>>     "All 6 patches look good to me, thanks.
>>      Reviewed-by: Jonathan Tan <jonathantanmy@google.com>"
>>
>> https://public-inbox.org/git/20180328161727.af10f596dffc8e01205c41dd@google.com/
>
> To add to this, I sent this in reply to version 3 of this patch set,
> after Stefan addressed my comments. Most of my in-depth comments were
> in reply to version 1 of this patch, which are the grandchild replies
> to [1].
>
> [1] https://public-inbox.org/git/20180327213918.77851-1-sbeller@google.com/

Thanks for helping out.  Very much appreciated.
