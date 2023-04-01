Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A427C761A6
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 00:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjDAAWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 20:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjDAAWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 20:22:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C27F1115F
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:22:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so96025556edb.13
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680308524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9RaHKYbtme95uMjGicNRfmb+bRanm0OUeszzCdOJkU=;
        b=fQ//zIAswQY2JoMtBL2NOpGBGo3SP/VLZMKh/bGv9vNVoH1Cm6wOiqgxL10l0/mbRk
         CdHAY7KP0OGjYLFRsbSiGsynXpVHMBWRUFdMYmWlZeXAxIMISShp7lpiZ2oZhDvC5b+9
         So3cXHwxOjpklzMlwXs8fQ41EZsZP91aG3vUNK9VmhoiL7waDHBqkZgiwibOpqbBxH4J
         GX8BTpTbmrgVB6v7lUk1shRHqACg8wqgn1N52Z92CteHVWxV9+j6/x2iAP7c7iauo684
         wcj5977kKFknV7qzp+o35t6WmiS0JsSKYub3LR+pSnAdtPIhXLg7pCCvoX/D6tKPShix
         WJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680308524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9RaHKYbtme95uMjGicNRfmb+bRanm0OUeszzCdOJkU=;
        b=tcEHC6TaqznxPB2Z/akyR/+p2gCzQhR4ldX7m70UrdOnf5L3E4jP3kR3jNcie/JVwA
         R+/Bql8Kagbv6s9hFWD+/SKBMP9bsFtXaW/N/EVhti39/3IazqDOvxQuOwBdXriPrcH5
         gO5p58BhKs39z/O2mXwJS7YjFsiZ52pF524TuWb7IJMrKzx3bQ2mt89ipKLq02yW6DVE
         mSyec/KgFI6OwJlJ6qvyAVJG4q74p+36zMG0DC+rY4cdNLVXvkiMn8cZuGxl4UdvKxCY
         Ko+6+1msIPSR+ZP7yEj5QStqD1nweMxO/eEhwdM/JO531BDJ55qx6LLgoEEkYki4983h
         qr6Q==
X-Gm-Message-State: AAQBX9d/sYVUHclZQOKFts2jPXzgKfjGZAiYnyTlcHrJ2O0PEKswpdY4
        l23xDExHAVRvFhMqyFV2OSY=
X-Google-Smtp-Source: AKy350YjgxgowESonh4KKInQ+gn3ras2eaWhIvTU9qYUwrvGrulVyAgYv16IoeqgzVW7plmFNGhCMA==
X-Received: by 2002:a05:6402:411:b0:502:251b:3a4c with SMTP id q17-20020a056402041100b00502251b3a4cmr24389292edv.20.1680308523615;
        Fri, 31 Mar 2023 17:22:03 -0700 (PDT)
Received: from [10.15.18.25] ([45.88.97.21])
        by smtp.gmail.com with ESMTPSA id j8-20020a508a88000000b00501d39f1d2dsm1586522edj.41.2023.03.31.17.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 17:22:03 -0700 (PDT)
Message-ID: <21ac6dc4-3d1d-0075-cee7-bdaebaae36a6@gmail.com>
Date:   Sat, 1 Apr 2023 02:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/3=5d_doc=3a_interpret-trailers=3a_don?=
 =?UTF-8?Q?=e2=80=99t_use_deprecated_config?=
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>
References: <20230331180817.14466-1-code@khaugsbakk.name>
 <20230331181422.15409-1-code@khaugsbakk.name>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <20230331181422.15409-1-code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've noticed a discrepancy in this patch

On 31/03/2023 20:14, Kristoffer Haugsbakk wrote:
> explicitly trigger the command by passing in `--trailer=sign`, since

Commit message mentions "sign" as the value for "--trailer=" ...

> -$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
> -$ git interpret-trailers <<EOF
> +$ git config trailer.see.cmd "glog-ref"
> +$ git interpret-trailers --trailer=see <<EOF

... but the new sample code uses "see" as the value.

>   > subject
>   >
>   > message

