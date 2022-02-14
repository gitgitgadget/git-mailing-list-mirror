Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC7EC433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 18:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiBNSrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:47:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiBNSrY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 13:47:24 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDFC70F5A
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:47:07 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id e22so843020qvf.9
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bR+x/oZ/h1ePsw9MdtdXY4cItonDWuibMvKMcTElqY8=;
        b=HGFJTDbqkz9diz5XG5ZJ1aRtNbyj5Ot+XlswoApn4GlnfAJ0fOSVKre8mojA0VHCAS
         zrLpRwbg8UJUjuOawX53KKyjHYYWkSZL5fpg0OYqfeNp1AzuN6MeBByHvCiLsDBZszsP
         AYLWV9x6d0Xt5wYNpSzniJdNKjCYj+w1Etm19sRqUUwAoVrYkxYuALNsaO4E/Xq+ZJzm
         FmOsL2tehTKqZzGGwVotC5NKAvucjaAmY5aajCRf/xOM7/X1RXIfME3TzJat/QnEGih4
         2UrSN67v4UecuLiDY/LKmxKhoK/0Js4jIY9l3QTBGLTVkKSfK0nWGGOfPH+sYzSi1tTy
         FIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bR+x/oZ/h1ePsw9MdtdXY4cItonDWuibMvKMcTElqY8=;
        b=zLG4ggWJo8hLaHz/TNrWsqKklfdaUdq5IUR0GCQfLQVnT7GR/cmFm0cDg4S3cKXnN7
         34ku+7Nyzq4CleFJvGM9tXA5vvc7qnNPn1jvNz0APCQeu0qIKKHWEuh9pfYRZr0iT9rV
         60NNzNRY0YUkKrr0W98pFAiNf0Qze7IzqP/MjAFrZdqhbQ+yRmoYTT8eTsss0NtevR8M
         wgimgSvZ16uCXh3HTEh1epxj10NhaacuN0zbIpr97HdotrvBtaFdH/0z64tmZCBsk+xx
         U1aJUmFLM2G6YVrpEXQEgFfUMSs6oSZ2xZZec5o718MpJnBNhQ91529v3ZdJ268832GA
         kTXQ==
X-Gm-Message-State: AOAM531uRlLO+QRUuhzeotncpyOsF8Nma41Vg4BLF4Y65zX1KRpJavBQ
        NQ4nrR5iHGqL121Qw7CgRtI=
X-Google-Smtp-Source: ABdhPJxzJQ3xuaNO58GG9kYxLhkSYL4B2WCBQxXpz4W1A7kgTMn8vzgsUEFQa7QrjQrxkNKuR4jESQ==
X-Received: by 2002:a05:6214:5095:: with SMTP id kk21mr203062qvb.86.1644864318151;
        Mon, 14 Feb 2022 10:45:18 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id o13sm18662437qtx.22.2022.02.14.10.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 10:45:17 -0800 (PST)
Subject: Re: [GSoC] Interest in "More Sparse Index Integrations" project idea
To:     Derrick Stolee <stolee@gmail.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     vdye@github.com, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, kaartic.sivaraam@gmail.com
References: <CAJyCBOTuNn24_WvHv-xQsCdtr9-4_fdrMrOC7ZApg1xFp4RNWQ@mail.gmail.com>
 <d6286f84-642d-7448-0d2e-dd4c20bdb289@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e81f044d-8c3a-90df-ff9e-719b613807d6@gmail.com>
Date:   Mon, 14 Feb 2022 13:45:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d6286f84-642d-7448-0d2e-dd4c20bdb289@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> But of course, this doesn't show the full history of the work in
> each of these branches, so you can do a history walk from each
> merge to get a picture of the full series:
> 
> $ git log --oneline --graph 3c0e4178277 -6
> *   3c0e4178277 Merge branch 'ds/fetch-pull-with-sparse-index'
> |\  

Or even better (you do not have to guess the number of commits in 
each series):

git log --oneline --graph 3c0e4178277^-

(see [1]). Why that syntax seems to completely ignore '--graph',
though is beyond me!

Philippe.

[1] https://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-emltrevgt-ltngtemegemHEAD-HEAD-2em
