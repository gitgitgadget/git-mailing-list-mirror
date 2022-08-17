Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68ABC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 10:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiHQKHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 06:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHQKHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 06:07:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C7A5246D
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 03:07:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 20so3004677plo.10
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=skcIiwN34r5upqYxq1Bv0yiyi0lloqz6xqwCUtEYark=;
        b=WEijAz+mznsVNyMkI32L5zuvLTXW7WZCDEIF77NkV+x5Qlo8DoqcvGRvVu0qVdIi8A
         gA3T7rCB0Nuq91o6Wrkz+r/Yj8dzeUID0NzyeFoXeqo6OSQUzuxV1rZfF0PGo4VMF08Y
         nKFFTGXhKdA4yOnMWg1BR8QzVkkuGTtwCyQ0dtdl5Y70q+A201/DsMFYk+ppDhuk1eoi
         /wCtp6I57W/O30jjNd5O4ZFsCBDt/cz3QQfX1kATJObRw6qVvejASozSABYBtMrzvQ1F
         Pkqs3lFn2qOB2Cv+sNfuwni6Tr+tTUuJZS3wmPRDTYgBt1BA5fskKSu+QRMTUFC8Z9xV
         SGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=skcIiwN34r5upqYxq1Bv0yiyi0lloqz6xqwCUtEYark=;
        b=Ab2DWhSb0BhTZOqdg0FKkC2BTr6lWMe6GDZfY+4cAAcYMzvEL54dBfPOkinfuY7AFK
         Ir3SmDi1MLOMfZWp2amDlQQXm3SvFcqo7o/p7JWYHxMhcvnUIpOj9AVAbttxY1RyhWEM
         q0PdKsFUdPfBstH/38ZZip9ZB97JyPH9Rjw7RJrKl/gJPWYEIO+ZllYqosyivGQM5sM3
         BtDw5sdnFKzYD4hYY+R4xOUlDzUJ6my/3fb43hDZkjkZcPDud4SpUDPUwgnTPYNKpt+R
         Iw3L2cu2vvMD++x2r8WEJuWVqAlqndWKhTo+ErKtdk01T/bEXFP2z5iqO0fQ7e7hGe6u
         k09w==
X-Gm-Message-State: ACgBeo24OydHTmwKABYaaFSPPilaLsQ+VY4DeY/EO++vUGfV0jnF/wsb
        0EJnsD8TCn7IlFpMx1sdLeFvo6FvrV5Tuw==
X-Google-Smtp-Source: AA6agR5edjyjKAOmfpwS9ruU4V82jw1kjpmU2MXvGnEd3cRz0Y1M0B8NfJsuIvlmXvuHTlPN+MFKbw==
X-Received: by 2002:a17:902:a511:b0:172:97a7:6f5d with SMTP id s17-20020a170902a51100b0017297a76f5dmr3035271plq.159.1660730828995;
        Wed, 17 Aug 2022 03:07:08 -0700 (PDT)
Received: from [127.0.0.1] ([8.37.43.37])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170903048a00b00162529828aesm1069047plb.109.2022.08.17.03.07.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 03:07:08 -0700 (PDT)
Message-ID: <0738a754-eedf-31f0-e450-31565c980d91@gmail.com>
Date:   Wed, 17 Aug 2022 18:07:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: [GSoC] Week 9 status update
Content-Language: en-US
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
In-Reply-To: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,

Here is Shaoxuan Yuan.

I'm writing to share my latest progress [1] from GSoC week 9.

You can read it when you are free, and generously give me some
advice if possible!

[1] https://ffyuanda.github.io/blog/GSoC-week-9/

---
Summary

In week 9, I did two things:

1. Send out a v3 for `git mv` (from-in-to-out).
2. Explore `git grep` and try to integrate with sparse index.

Good news this week:

1. `rm` is in the `next` branch, hooray!

I found that a verbatim development log is both hard to write and read,
so I decided that I should only catch the interesting moments which may
be educational or amusing :)

-- 
Thanks,
Shaoxuan

