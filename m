Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD78C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 15:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A073060FBF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 15:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhJYPeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 11:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhJYPeK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 11:34:10 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB93C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 08:31:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p142so16126580iod.0
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7CrhOgu/54puucsiLhoifKHlQGxn6UAF2CgMvJQ7kmI=;
        b=H9GWKFrtfXvwwY2wTxNO7Dm3NOIDpuxK6Ag9E5QqEexkWNc60n/Z+J+bWiMvajYpDx
         aljhMpI+MU/OX4/i37Fgr059cjXnYq/MDWchr5dD4IbJAe72tE3+8oFcmN5p8oNeXhEr
         vqHWcsQXQJhNf0IqoyGmXWVDNyy7zagfE+d40sMJzAMZ8SifUI6YrTE4xHBslQK/jgYr
         jkOj8PPGEheHSEXtILR6bndV0PnKbkRgfTzolY3be13foZUVlq0yale6aKht0bANYWr5
         lt3OpEKIWXWhfMY2T11LeaUVR8YqeEQgJSts8lnTJZ9qd1nyAZP5WI/fm44mKYvC69Ht
         lBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7CrhOgu/54puucsiLhoifKHlQGxn6UAF2CgMvJQ7kmI=;
        b=rG6kQAYhzwLAbHEktJvkYU3c34r6Efe+V93LXLwtSyYfL1wb7py5RE2eNKd9pxPLSU
         bHu1g3v0hYzlzDuP3NBHtTzX3ZG52MkNzyB1ngclkI8JtrQlREFzXtxnSsBqpVL0cmrq
         1Qoik/sHJcrvoNiTCqLbgGQ06K2MtxmjcTow2sdOEtJ1hEUN4qVMLZmkpxdngchq/vJh
         qKfMuTyjP95KW0oEnAmvNU5ctBLyPMaRnymNQlIFxW0oLfvuKJtsUbc/GmiqLFUMzJGO
         oyHSDHcg9rQX39gyKrE+vvjxGUlK0wCTPxRUQ6eswdvqkCsCY12MrdBC0Cv3KphZ9fQh
         oxpw==
X-Gm-Message-State: AOAM531Rbxz2EsHmVQrFOmM8asTSvpsL6I9VhOivubpk/ZdGc5k+U2rB
        sWaIT44BK3f1TGMYZn9zqL4=
X-Google-Smtp-Source: ABdhPJyncln6hPfMrRm1nMaxYBP7XzKYJSqbAriw9BWajRD0zES5oXimxRBHBy/2xPExTneVMNN33Q==
X-Received: by 2002:a05:6638:2188:: with SMTP id s8mr11113926jaj.87.1635175907440;
        Mon, 25 Oct 2021 08:31:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b594:8626:d264:bb0? ([2600:1700:e72:80a0:b594:8626:d264:bb0])
        by smtp.gmail.com with ESMTPSA id 188sm8737653ioa.22.2021.10.25.08.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:31:46 -0700 (PDT)
Message-ID: <74e5e039-b259-644a-9566-c866d72cf638@gmail.com>
Date:   Mon, 25 Oct 2021 11:31:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 0/3] Documentation: change "folder" to "directory"
Content-Language: en-US
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        "Dr . Adam Nielsen" <admin@in-ici.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <cover.1635094161.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1635094161.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2021 1:09 PM, Martin Ågren wrote:
> It is my understanding that we prefer "directory" over "folder" when
> discussing the file system concept. (Whereas "folder" is commonly used
> for the GUI view of such a directory, or for an IMAP folder.)
> 
> I stumbled on a mention of the ".git folder" when going through the
> doc-diff between v2.33.0 and 9d530dc002 ("The fourteenth batch",
> 2021-10-18), and started looking around. This series is the outcome.

Thanks for these changes, in particular for the ones that I had
introduced in git-multi-pack-index.txt.

Thanks,
-Stolee
