Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ADAC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 14:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbiA0ORd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbiA0ORc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 09:17:32 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B80C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:17:32 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id g205so6098517oif.5
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4kXbungjkwFuSgvkl1p2DjxIR2Pg/Tkn4V+qzm2iR4g=;
        b=qyMXgrU9/dmjNMMvu/m954qs7p/6RfJHS3KHOhyPFJ8jImlmEAcoz1E5XZzy63vpUS
         2g4zPFAUHhHy4Y6qK93V5ujUQqw5sGxppxrJogf4XVhVghjK6lV1crljKwi17QRGQl3i
         jEZt5L8T/OZpCKB5nVhjfOGoahh+8HXbCvbdKfhDgq4T4pPgep58oB2AhOWPOulX3xpQ
         in3wnzEi7tq6WokJgMv3Xi8fEGR8cFZjZ1RAZjXfEDwt/l2FPBmR7BD2bO+fUJ/vjoqx
         5Nu3YV2ko9tf0PDIHw0Ww7EQR8w+PqoBJETaLJAQyQPNJDzeVQSBbc/zj+AMUJq5d7q2
         JZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4kXbungjkwFuSgvkl1p2DjxIR2Pg/Tkn4V+qzm2iR4g=;
        b=JLrRikpI8dnJkjCvz9xJUyeO5xHRH7K3hjIMnZq3ZY7SxJjNxOy8OuVx91aJWdFkbO
         R/LsBiQNDbtCDNiJ921eo1iFWh3RhN82b6lIUzQrSKaBbWusC7WxAUE+sLTN2KSogm4K
         5a1zQE8rawefYOkxOHEGpPuBBBdoSU3c3W4lTN322ysIKNJS7SIw+wr/SBc04Y6mL1zq
         FEhWJwl1cpkehEdkPDfq/dRptiJxRgn6Op3wmQDhGC1YjaNy/wIV/GwqhQsHwvexOWEr
         34CtjMtnN4xF0Yo6sElkdABjKdOTk7PT6OluSlOv4K1oW2EuJE5TirR6WtPqT2e+J6YB
         Fcrw==
X-Gm-Message-State: AOAM5332vbtXelPPe4prybcBNNNN8OVX1G7JuYBNapXCnAjxa0+0eYCS
        biQbv1fe/LVNkhmbX/1/KWs=
X-Google-Smtp-Source: ABdhPJxEPlGD4OxKqd+f9js5NDIKi388Iz8PlVU+Rt/DTZxI6NKcxRHElGiRtY3iZMQwEEZ9m0RAHQ==
X-Received: by 2002:a05:6808:1805:: with SMTP id bh5mr6929147oib.192.1643293051692;
        Thu, 27 Jan 2022 06:17:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id c13sm3723592otf.5.2022.01.27.06.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:17:31 -0800 (PST)
Message-ID: <58353c02-70bb-b05a-16e8-cfc37b290e29@gmail.com>
Date:   Thu, 27 Jan 2022 09:17:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/5] Documentation: add extensions.worktreeConfig
 details
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <459e09dedd71fcb64b9796bac52c3812d78f2405.1643136134.git.gitgitgadget@gmail.com>
 <CABPp-BFiJnB0u6N5JViS7T_QrC=247gRto7R8DJ5s+f2nP_bKA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BFiJnB0u6N5JViS7T_QrC=247gRto7R8DJ5s+f2nP_bKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2022 1:43 AM, Elijah Newren wrote:
> On Tue, Jan 25, 2022 at 10:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

>>  --worktree::
>> -       Similar to `--local` except that `.git/config.worktree` is
>> +       Similar to `--local` except that `$GIT_DIR/config.worktree` is
>>         read from or written to if `extensions.worktreeConfig` is
>> -       present. If not it's the same as `--local`.
>> +       enabled. If not it's the same as `--local`. Note that `$GIT_DIR`
>> +       is equal to `$GIT_COMMON_DIR` for the main worktree, but is of the
>> +       form `.git/worktrees/<worktree-name>/` for other worktrees. See
> 
> is of the form `$GIT_DIR/worktrees/<worktree-name>/`; .git isn't even
> a directory in other worktrees.

Thanks. I tried to catch all of these, but I missed one.
 
>> +       linkgit:git-worktree[1] to learn how to enable
>> +       `extensions.worktreeConfig`.
>>
>>  -f <config-file>::
>>  --file <config-file>::
>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
>> index 9e862fbcf79..ea0ee9f8bb5 100644
>> --- a/Documentation/git-worktree.txt
>> +++ b/Documentation/git-worktree.txt
>> @@ -286,8 +286,8 @@ CONFIGURATION FILE
>>  ------------------
>>  By default, the repository `config` file is shared across all working
>>  trees. If the config variables `core.bare` or `core.worktree` are
>> -already present in the config file, they will be applied to the main
>> -working trees only.
>> +present in the common config file and `extensions.worktreeConfig` is
>> +disabled, then they will be applied to the main working trees only.
> 
> "main working trees"?  Is that an accidental plural?

Yes. Thanks.

>>  In order to have configuration specific to working trees, you can turn
>>  on the `worktreeConfig` extension, e.g.:
>> @@ -307,11 +307,16 @@ them to the `config.worktree` of the main working tree. You may also
>>  take this opportunity to review and move other configuration that you
>>  do not want to share to all working trees:
>>
>> - - `core.worktree` and `core.bare` should never be shared
>> + - `core.worktree` should never be shared.
>> +
>> + - `core.bare` should not be shared unless the value is `core.bare=false`.
> 
> The double negative makes for harder parsing.  Perhaps
>     - `core.bare` should not be shared if the value is `core.bare=true`
> ?

That is cleaner. Excellent.

>>   - `core.sparseCheckout` is recommended per working tree, unless you
>>     are sure you always use sparse checkout for all working trees.
>>
>> +See the documentation of `extensions.worktreeConfig` in
>> +linkgit:git-config[1] for more details.
>> +
>>  DETAILS
>>  -------
>>  Each linked working tree has a private sub-directory in the repository's
>> --
>> gitgitgadget
> 
> Thanks for documenting these details; I had some very minor comments
> but this is well written and very helpful.

Thanks for your recommended improvements.
-Stolee
