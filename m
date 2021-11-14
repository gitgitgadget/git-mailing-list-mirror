Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074E4C433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 07:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D0661037
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 07:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhKNHVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 02:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNHUX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 02:20:23 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF6C061570
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 23:17:28 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b68so12137600pfg.11
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 23:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ir6lR53MTDhefL6jkr+w8n40fZPEEdgkFsOAsAGVhac=;
        b=qn8SXxT/kaVnXwmltSYvWDQy8YXr6ViSnD2Lvf9h1QoaZRZTMxy/nDu2onGMVVAwlW
         aseAKsxezjqiszVTqKAJnrhlQ55yD7KMEH9sqblAxPNBjZ1jYfmxJk5YVakvUtZKMSkC
         NP8s2neTtxdIv9AOkwbWizPdIHlbGZhoCVrm0k+tRxUCpZXiA2+ZByiN96ctXW5pWuWu
         uJTcpHCwSwDj8s50h0U64M7gbXzUXb6Aip3ZsagpjwM3Y/iE89d6S6zl1eedRXhLE+dj
         1TGnLAC5YN0lCtn2efPXCO+k2bRBIfHByPIQRmHq/GxLJ1wLpKNFiMjBvt5gX6u9kzed
         mreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ir6lR53MTDhefL6jkr+w8n40fZPEEdgkFsOAsAGVhac=;
        b=YJZrCzKat9Q8P4jbBsVfbld6JZGIFx6HCLFfqB0OaOqKi1hsNuIhB7zOOW3F0/NB0j
         t1D665QQ3Es1RQzFmlrgy5Uc0SZiQ1ZHFQ8p3ev2A3EkKxVK59tEyd7EjM/kEjdLz57Y
         4Q3upsYTrdIyxOs/Qi224OjI1QpWUHEeDZOh+RMTChSNUwI6ckOXsBCsy1bw/dB/9kJM
         b926D6fIimYV7267fkuvP4R06gNfldMv4ZwrHTp+HcUIMFegEbgerNU/ubAPtBhgIlzx
         GVyRQRQNDGGK2VqRtY8nIVZJ4G5GV7O96C8+t8oJJ0I/kZidq1dHT2dxVydHgbhDetmt
         yntw==
X-Gm-Message-State: AOAM532QN/uI3GlyH3qiaMkbYkRwuCeys7yqvYqcRb6aRdGSNmmkqUfQ
        vy2gJOmco2U6r6RpxNqr0Lc=
X-Google-Smtp-Source: ABdhPJywylQ87r5EqHJerdmm/7gfAKLU4u4iBAaaMhf/Y5jbp5in2YDX500cq8GIAJLvINIo/sw8Ww==
X-Received: by 2002:a63:e214:: with SMTP id q20mr18288920pgh.431.1636874247612;
        Sat, 13 Nov 2021 23:17:27 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id m9sm10785460pff.43.2021.11.13.23.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 23:17:27 -0800 (PST)
Message-ID: <98f2d5f1-4282-4011-ee56-0756da24b1a8@gmail.com>
Date:   Sun, 14 Nov 2021 14:17:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Suggested Project Ideas (was Re: Anything I can contribute?)
Content-Language: en-US
To:     Saksham Mittal <gotlouemail@gmail.com>,
        Deng Kaisheng <kaisheng.deng@u.nus.edu>, git@vger.kernel.org
References: <AF2AC77C-EA0B-468B-9B31-24CCC3DF70A3@u.nus.edu>
 <547972d2-36fe-4acd-b9fa-747320addfa6@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <547972d2-36fe-4acd-b9fa-747320addfa6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/11/21 17.41, Saksham Mittal wrote:
> Most searches of the mailing list for "[BUG]", "bug" etc. yield scores
> of results for patches other people have already submitted, which are
> likely being looked over by experienced maintainers anyway. How do we
> find issues in the mailing list, especially ones that are better suited
> to a beginner?

Breaking the thread.

I think you should check for open bugs against Git package for your
distribution first, then come up here with bugfixes.

For project ideas, you can try converting/rewriting git-request-pull.sh in C.
When converting, you can also add `-o/--output` option to write PR message
to a file instead of stdout. You may want to mark PR message strings for
i18n if you want.

-- 
An old man doll... just what I always wanted! - Clara
