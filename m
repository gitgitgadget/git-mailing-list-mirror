Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FDEC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 12:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiF2Mng (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiF2Mne (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 08:43:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F21218E
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:43:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b125so11817430qkg.11
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=W7phvFoTd+vUbouXVWGcdhvZk0BlkOpGSs0j3bMj7Gs=;
        b=ZULl6Mn8pOtFZzUYnAY1qmN5qWxsMyMjhOPlvpA+1W9MM7oKK5ws6i8bLPmwOrzL02
         noQ/64JSOhY99AwEbZWCRf6Bw7g2jHW9DvKSknnwH/b9FzUsUYhNg8hz/TnwZY8tEAuC
         1wRf+NneG44vb1tACNJWR/t/ySxN845HVkUlDthCBZCk0XOKxs1TqUTd2HfXPUj4umGc
         XTdfpHtWXCZlTobfPpGh/10B7jL43J31DYk12+a3nNWQ8C6Joc66p1f77tmFwkViP8ZY
         nQsCePwMVAMS8Qk6h4ZXV7x2lSGGoEZuko6ezRvRNmXc0XJEwIw5QkyJZc97PUDsR+NU
         Lb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W7phvFoTd+vUbouXVWGcdhvZk0BlkOpGSs0j3bMj7Gs=;
        b=UQBYf9/CVCiTmbus+OrU6SW+VMTUSuZKrdG9vhAu+i/oGr7DbK9RWI7FcfRPXMRvle
         ujWTKhLywfijyeZI/YdyIqtrsaIPvYnkQjynDTmYsyo5bZhWMiLmyJAiWAUXJ1SSO3rq
         HLlOiThvIKFXrQatoV+GyRDKvfODvQRBK30WIq2MZl67fw+pH8AjovFGTW6zqIVcne3r
         ObPMDgbN+jK8mvIlP/OlElqdAw6mEeoV9BB41Pl+BnmEShsr89H8aftHH//g+w/eet6h
         ZS3LBmMKx/+5D7qOaQnd+Ti57Nrq8NqoUKtbMmL1QKI+/dFZoh+q+7pVGbRAhlIWtNhp
         mkig==
X-Gm-Message-State: AJIora/re70bwPgCatg2gRhhQV7cB3LrPkS5GrtxsTbpM+DyC+7ZDz8Y
        lL5QZT4RDrkQGm4tZSvT088p
X-Google-Smtp-Source: AGRyM1uSAoGgqZrheQCW1XCGTXRxdjvotPwwNp/p4MvbrqJMygSO0KkdlctVoD2G68Y6q6vcc/EUQQ==
X-Received: by 2002:a05:620a:5d:b0:6af:65e:b879 with SMTP id t29-20020a05620a005d00b006af065eb879mr1727304qkt.364.1656506612448;
        Wed, 29 Jun 2022 05:43:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d803:95aa:58b0:8205? ([2600:1700:e72:80a0:d803:95aa:58b0:8205])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8480b000000b003051ba1f8bcsm10402609qtq.15.2022.06.29.05.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 05:43:32 -0700 (PDT)
Message-ID: <45869a54-5106-0223-b116-c3f390780ccf@github.com>
Date:   Wed, 29 Jun 2022 08:43:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2] git-rebase.txt: use back-ticks consistently
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
 <pull.1270.v2.git.1656446577611.gitgitgadget@gmail.com>
 <xmqqwnd0h30t.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwnd0h30t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/22 5:49 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> -apply backend: When applying a patch, ignore changes in whitespace in
>> -context lines. Unfortunately, this means that if the "old" lines being
>> -replaced by the patch differ only in whitespace from the existing
>> -file, you will get a merge conflict instead of a successful patch
>> -application.
>> +apply backend:;;
> 
> Hmph, I am surprised that you took this, with an extra colon.  Does
> it format nicely?

Well, this is somewhat of an "oops" because I honestly thought you
had kept the colons in your comment, but it turns out that I misread
it.

I had replied with this doc-diff:

-           apply backend: When applying a patch, ignore changes in whitespace
-           in context lines. Unfortunately, this means that if the "old" lines
-           being replaced by the patch differ only in whitespace from the
-           existing file, you will get a merge conflict instead of a
-           successful patch application.
+           apply backend:
+               When applying a patch, ignore changes in whitespace in context
+               lines. Unfortunately, this means that if the "old" lines being
+               replaced by the patch differ only in whitespace from the
+               existing file, you will get a merge conflict instead of a
+               successful patch application.
 
-           merge backend: Treat lines with only whitespace changes as
-           unchanged when merging. Unfortunately, this means that any patch
-           hunks that were intended to modify whitespace and nothing else will
-           be dropped, even if the other side had no changes that conflicted.
+           merge backend:
+               Treat lines with only whitespace changes as unchanged when
+               merging. Unfortunately, this means that any patch hunks that
+               were intended to modify whitespace and nothing else will be
+               dropped, even if the other side had no changes that conflicted.

So, we do have a render that doesn't look awful, but since we already
have formatting that makes it clear these are subsections, the colons
are not needed.

Thanks,
-Stolee
