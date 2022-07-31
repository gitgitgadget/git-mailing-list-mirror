Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE53C00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 08:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiGaIln (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaIlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 04:41:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE812613
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 01:41:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so6010412wmb.5
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k3R+pSpr1pQFakRa+O2aEf7+xk1ikSv3MQKAi54lLnA=;
        b=LC7zhbJ/x2+EW13rOlzPw+a73h5qQHVYcjiHLV2zhVM3qHC/BLlr8VwZbBUAnGB2N6
         KXL58gZeEWJo8BqlZWoaywHExxdoBojWyN1NwP/YkHYyRfpfCgTb4g7Bn9ibxGaEFLES
         sSsn4j2DWTC7N0t29J3w8spar2ND4wrDvmWbrsVSj1Q7OT0OOx68Njk0D7mZvlSFejOD
         Pc2MI471ZCmuN/swfIWldxpZMpSnT0XFgO2OAqGMXL+Er604VgG7YGThMBUQnawjqAZX
         fXjDUhJ3dKhb98+vVNBIDc4LfxX/rSpb144JfZ5DzEhi9b6sI8wbHjiiTe+Xb7U1nn0d
         FTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k3R+pSpr1pQFakRa+O2aEf7+xk1ikSv3MQKAi54lLnA=;
        b=g4pteVxWzDBcbhvgoDHUlro2bNk7xHa9+zDs/Ubl/TU6xcOO1BS5MxRwFIRv1NciMd
         et0uQtK09LZe2MN6QnbII0VDo3Ckg29uDq3CF99wOggawq1i+NoKkZlcEAQA8zGh+F0k
         yuDiGP+hfYqBfKiZpI8jqrat698R7NnY/3EbTCMHZERJTXLvKj5zBGbXb3lpP6IUnDR4
         5+t+ZhyHznT7NurfC7Ldw6N/Ezb6Y/fSH+T4m8Z/m5XnOMPVIrcb9YTcxLgACbwyENvY
         ebckvCiKy2Ay+oFK8RnqKf+VS0IsebAliVF3Tf/q+UD1/xG1roLBqIRD5+FXIVQEVsP0
         lltg==
X-Gm-Message-State: AJIora962Y513XfTDgi7DlKT3SoRpMT9aCapPkwHrT560qGXCCwvIm23
        bCPGClZZUEnp0oyt1JAV8es=
X-Google-Smtp-Source: AGRyM1u/NU6K2YoAyH4ciP1JExHJuLnLeMw+BDOOFl/km3KF2kC/TlZN7Xv805o5Q4dLUkJrNa43Rw==
X-Received: by 2002:a7b:c3c5:0:b0:3a2:e327:ba6d with SMTP id t5-20020a7bc3c5000000b003a2e327ba6dmr7729538wmj.184.1659256899843;
        Sun, 31 Jul 2022 01:41:39 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c1c9300b003a31fd05e0fsm23360113wms.2.2022.07.31.01.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 01:41:39 -0700 (PDT)
Message-ID: <8a1ff659-2086-f3cf-469a-76f5e2bc60e3@gmail.com>
Date:   Sun, 31 Jul 2022 09:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/6] cat-file: add --batch-command remote-object-info
 command
Content-Language: en-GB-large
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-1-calvinwan@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220728230210.2952731-1-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 29/07/2022 00:02, Calvin Wan wrote:
> Sometimes it is useful to get information about an object without having
> to download it completely. The server logic has already been implemented
> as “a2ba162cda (object-info: support for retrieving object info,
> 2021-04-20)”. This patch implements the client option for it.
> 
> Add `--object-info` option to `cat-file --batch-command`. 

This part of the cover letter seems to have been left over from a 
previous iteration. I noticed that in patch 6 there is a reference to 
'--object-info' in an error message as well.

This might be a daft question but could we teach cat-file to check if an 
object is available locally and if it is not retrieve just the metadata 
from the remote rather than adding a new command to --batch-command? 
That way it would be transparent to the user and they would not have to 
worry about whether they might be querying a remote object or not.

Best Wishes

Phillip

> This option
> allows the client to make an object-info command request to a server
> that supports protocol v2. If the server is v2, but does not allow for
> the object-info command request, the entire object is fetched and the
> relevant object info is returned.
> 
> === Changes since v4 ===
>   - Instead of making 2 rounds trips to determine whether the server can
>     handle the client object-info request, the server now advertises the
>     features it can send back so the client can immediately fallback to
>     fetch if any feature is not supported
>   - Fixed nits and clarified some documentation/commit messages
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> 
> Calvin Wan (6):
>    fetch-pack: refactor packet writing
>    fetch-pack: move fetch initialization
>    protocol-caps: initialization bug fix
>    serve: advertise object-info feature
>    transport: add client support for object-info
>    cat-file: add remote-object-info to batch-command
> 
>   Documentation/git-cat-file.txt |  16 +-
>   builtin/cat-file.c             | 225 ++++++++++++++++-----
>   fetch-pack.c                   |  52 +++--
>   fetch-pack.h                   |  10 +
>   object-file.c                  |  11 ++
>   object-store.h                 |   3 +
>   protocol-caps.c                |   2 +-
>   serve.c                        |  10 +-
>   t/t1006-cat-file.sh            | 348 +++++++++++++++++++++++++++++++++
>   t/t5555-http-smart-common.sh   |   2 +-
>   t/t5701-git-serve.sh           |   2 +-
>   transport-helper.c             |   7 +-
>   transport.c                    | 110 ++++++++++-
>   transport.h                    |  11 ++
>   14 files changed, 734 insertions(+), 75 deletions(-)
> 
> 
> base-commit: 9dd64cb4d310986dd7b8ca7fff92f9b61e0bd21a
