Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FBDC77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 16:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbjEOQ7I convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 15 May 2023 12:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243329AbjEOQ7A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 12:59:00 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F187AAD
        for <git@vger.kernel.org>; Mon, 15 May 2023 09:58:58 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7577ef2fa31so2751213085a.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 09:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169938; x=1686761938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5zSsydcFRqcp0Y1DH4wo5OSLPWUi9jqzh9onoxZs7Q=;
        b=TF9AWZmwviDNi12O8jPZiwOuYaKu1y67wY8q1UDsIgfRIqNStMBk1oSl1+INhEyc1d
         Bq4Jap6iq/9cGUZxJjUEWTVbMdVENe0iKQ14ZLWW7g8iIkxgZvE9mWw2AIu44CWqrK63
         5oFe6snl7bcdeE0bsnmZ394rdczhOG9MQEfzSvHIdKyFpHUOeSmEkjQPudwahqiiAEj8
         Xi0T8feYQCaa9hCXCZnXgehso9uJdQEtQllroNybFZRyp9nAbEKw2WPFhqGAfdXEE6TI
         dVYlsR+fjc4GnyalQqf4xoxk1MblkDII2ZyPHTk0obhhRQzYMzcU8PFXlbAYZ3XjaiHx
         rGOw==
X-Gm-Message-State: AC+VfDyOqJnPfUJ32tkfqWgQz/bSSVF4ParA9TtEZY0scsfJZW3oqoFZ
        qNsxnZicd6/WRKIOLqiamX8sAu/hYF5BQQye4f0NI2Z/
X-Google-Smtp-Source: ACHHUZ5t2OudCztfkzKnrpFe2wGrb+VkNKbp0lAIx2p9nfPWTC4sJOHzYsHvyCk9HxrotoQZrPK/DG4xnJA06dEQb3s=
X-Received: by 2002:a05:6214:d87:b0:616:49fe:f150 with SMTP id
 e7-20020a0562140d8700b0061649fef150mr61054830qve.18.1684169937593; Mon, 15
 May 2023 09:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
 <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com> <fe442c2041b01985a4ecb0f2e9651231af2a439b.1684152793.git.gitgitgadget@gmail.com>
In-Reply-To: <fe442c2041b01985a4ecb0f2e9651231af2a439b.1684152793.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 May 2023 12:58:46 -0400
Message-ID: <CAPig+cTSp3+RDbULeOXpfXwXw35tj3o-CTrpaeRPSB8remKk4A@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] show-ref doc: update for internal consistency
To:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2023 at 8:13 AM Sean Allred via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> - Use inline-code syntax for options where appropriate.
> - Use code blocks to clarify output format.
>
> This patch also swaps out 'SHA-1' language for the implementation-
> agnostic 'OID' term where appropriate in preparation for supporting
> different hashing algorithms.
>
> Signed-off-by: Sean Allred <allred.sean@gmail.com>
> ---
> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
> @@ -96,7 +96,13 @@ OPTIONS
> -The output is in the format: '<SHA-1 ID>' '<space>' '<reference name>'.
> +The output is in the format:
> +
> +------------
> +<oid> SP <ref> LF
> +------------
>  $ git show-ref --head --dereference
> @@ -110,7 +116,13 @@ $ git show-ref --head --dereference
> -When using --hash (and not --dereference) the output format is: '<SHA-1 ID>'
> +When using `--hash` (and not `--dereference`), the output is in the format:
> +
> +------------
> +<OID> LF
> +------------
>  $ git show-ref --heads --hash

Is the difference in case ("<oid>" vs. "<OID>") intentional between
these two examples?
