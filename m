Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6F9C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCLUYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjCLUYp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:24:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA09A31E2D
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:24:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id fd5so6993489edb.7
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678652678;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFlKptqYNEOKAvOu0DhpS+8L2BI59/8bHZSFHD9PLZc=;
        b=KJJSJrsu2PCzPEECExkTroaF7QvflunDBF+9WOsXS0Ll8M8dX5GOVm+0Hczee96ztp
         xVUu5YXBY6nwRMVRcleruXSoOQ1tA2IPcpbqew2+CwYLHs4URvDtvZOGJlt+DLEC0Z5T
         q7NSFq8YU/xqcXlol2IniKjBuP8hatamfo0GrzKiv+Idx6rTnDW2cN8e7x2zK9SB5hsZ
         aJ4oOGye+W8ja/Bei3iGo42cSFtPlMKdTsryvpFaIoWJXHhX+wgtRL3af184tFNWSLgy
         1+asM7vAVN+NbwJ5b5Pbmi8thuxz5XVU+te65YR7P/D3hj2wQlvRfPZSKXWSFyWSeEDX
         j5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652678;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFlKptqYNEOKAvOu0DhpS+8L2BI59/8bHZSFHD9PLZc=;
        b=gUHTOCTRdxWOq7m3DwFopa815msbKfgMzykgd8PO4yucl1zX138d5uVkfAsHkF/yxf
         u24juBPJgU2GsXEaYtgTJURuXx+HGzzKTCjDpL5nBFWDUypLI1dOtszJMsQvGcT9R10C
         RxaTgXlXISvXS2/tFr0T8RNGeFL5b4lSC2ql+Sl2pch4kSkx3j9BhrCuWZOxyUyhEFfG
         LrniRXPCyHxov0xF6m+JhyTWT3l29xZ1feqWAK5r9JXh0tx5Vt9h5rDwVgscQ99/H1MC
         7Mpxp7AuOwUyUZzjyruGeF56k+bOuVQPIwiokq5PKhfBzpAIUvKwtVhvuvn1AfZPPVvW
         jHJA==
X-Gm-Message-State: AO0yUKWow6SLC19iv2Mj72FODu0H+83EXKrcdBD8I6upvdUPNsdUBk4k
        3MxwOIvBAbybXtAtn/Mbp9WPNSrZAEU=
X-Google-Smtp-Source: AK7set/hM/rkG4JH+XHm+0aYwDT6hNqsPeIGg/8yOqx62vwfSbyTe7xeBKcfmacj7GpkAdaLlozIHw==
X-Received: by 2002:a50:ee92:0:b0:4fb:2060:4c1c with SMTP id f18-20020a50ee92000000b004fb20604c1cmr4297180edr.4.1678652678107;
        Sun, 12 Mar 2023 13:24:38 -0700 (PDT)
Received: from [10.10.18.218] ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id ud25-20020a170907c61900b008c979c74732sm2545017ejc.156.2023.03.12.13.24.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 13:24:37 -0700 (PDT)
Message-ID: <ab612514-1dbd-e5e4-204c-cc77f896ccb6@gmail.com>
Date:   Sun, 12 Mar 2023 21:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/1] t1507: assert output of rev-parse
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
 <20230312201520.370234-3-rybak.a.v@gmail.com>
Content-Language: en-US
In-Reply-To: <20230312201520.370234-3-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've sent this patch twice by accident.  Please ignore this version.

The correct version has subject "[PATCH v1 7/7] t1507: assert output of rev-parse".
https://lore.kernel.org/git/20230312201520.370234-9-rybak.a.v@gmail.com/
