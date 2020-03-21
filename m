Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6598EC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C72320739
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz6KqOu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgCUJt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:49:26 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:46664 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgCUJt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:49:26 -0400
Received: by mail-pg1-f174.google.com with SMTP id k191so3214688pgc.13
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GCKdOiKWNKiMW1tx0Ow0S+COhOOvHZVhUEbTdZPWYEA=;
        b=gz6KqOu9oYlgoQb9Yd3dn44jhlhcfn6iEh/y1+Y3kD5bye/DqEWfWHN10+/jNk1kuy
         q1uD5Q2h4357+o1CWd3XwTWUhwiyo33HwsPNFw0pOWT48z2D3GsVfDhOllPIb+pcRo0Z
         WTu8pRdibHTsRuF3aq18YY5W0D7mFpdY0R/CpbHoI2dtgDxyHeKuRi4yyHoZX9k+9Vd2
         eCiad7iMgt3yhTqQKSCTiuGH8Lby3fwTnd/TWT5okc6m37tvntQ7oUl5kBJrYS0g2Ext
         z6ExaNODmxDCBuAb0wRHNJW6y9+abdi+rYpgv/uOphRlmGfqKTVIWmlGCtLY4XqCp513
         I9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GCKdOiKWNKiMW1tx0Ow0S+COhOOvHZVhUEbTdZPWYEA=;
        b=K805PDSL04HkdoRAb65vsJiBZAW7NCsmxHbgub/I11bfBKFhJyikYuv3z6kaDcw7rT
         aV9VdfJ/Dx2UxBnVTtjRK5yXUbyeo31bnD5sk/8syYsA9dYtMHFyaaSdLDFEuNsLplN0
         qPP2ohlqXxue+BYYceDBLKrZZgvy6SsYU3XdRWwNyI4hlgaAJX2GobQU050t3+Soj3QZ
         WnUKOf0G4bho7nshh7yZ3kY+6GBWBM0Ktuv3hzHgN81DzADY0eEQBffj/1fwVc1tgJH2
         QlVl3X5rNESeP5mCk7s45Jq9sbhJ6Se+luLyaUwPlhCbCgMUW5hDzgfofMihivCQ3F1n
         I1yQ==
X-Gm-Message-State: ANhLgQ3OP2hFtZ1M1PfZ/LJ/8JjQ4PD/s6pOAU3NIAzfHQzeUOrf1xcS
        3OTlzTLNXWAqir0zpPlsnPmwbC6RHm4=
X-Google-Smtp-Source: ADFU+vtszBRJ+6xIZXnPIkHpr6R8FHTya0Upj8ZFzXq+U+lzbNKPTaN0e4tZRrkq0e8QRpUCG2z32A==
X-Received: by 2002:a63:140f:: with SMTP id u15mr12166265pgl.277.1584784163625;
        Sat, 21 Mar 2020 02:49:23 -0700 (PDT)
Received: from [192.168.2.6] ([43.247.159.138])
        by smtp.gmail.com with ESMTPSA id l62sm7350457pgd.82.2020.03.21.02.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 02:49:23 -0700 (PDT)
Subject: Re: [GSoC] Query regarding Microproject
From:   Shanthanu <shanthanu.s.rai9@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <CAGNOEmugZDWpvAHsOzmm_Fqo_Vj5GcC--GfTg3JHPm701HjBXA@mail.gmail.com>
 <CAP8UFD2bgzvc2K2Sj4HSeXo16kB8D8se=+=Y7gp6FN+4Y3C1BQ@mail.gmail.com>
 <47a1db25-914a-2e59-c0a6-6d0ff77bc2aa@gmail.com>
Message-ID: <d676674d-7ab5-b476-8dbb-2b3323db2c89@gmail.com>
Date:   Sat, 21 Mar 2020 15:19:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <47a1db25-914a-2e59-c0a6-6d0ff77bc2aa@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found the solution to my issue. The main error message I had got was

> Expected FS format between '1' and '6'; found format '7' at
> {hidden}/git/perl/build/lib/Git/SVN.pm line 310.
After some online searches, I found out that file system format 7
was 'understood' by subversion 1.9 (Filesystem formats section in
https://svn.apache.org/repos/asf/subversion/trunk/subversion/libsvn_fs_fs/structure).
That's when I realized I was using version 1.9 of subversion.

When I downgraded to subversion 1.8 (which understands file format 6),
all tests passed.

So shouldn't the test file itself have mentioned (say as a comment at 
the top
or in a separate README) that it was expecting subversion 1.8 or lesser on
the system? I am using Ubuntu 18.04 and by default the package manager
installs subversion 1.9.

This issue might also be present in other git-svn test files. (I haven't 
checked
though, not sure how to run just git-svn tests)

