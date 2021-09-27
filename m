Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E8C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 10:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878B46101A
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 10:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhI0KlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbhI0KlS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 06:41:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFAC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 03:39:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s11so17361292pgr.11
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dJ8f2Ugo57sR2fd9QeineGtq8LDDeaHyfs+fIUD96Ro=;
        b=GFCI6v5NZrVxWikG7RpG2YnaoOoODobOm15+jdt60phWheCOr4f3htw4G5cRXACxn/
         UonqRHE4+9CCw/wHEj/G4N0YoxGgct7szfq6dWYHWsW8c4b4seS7YEsUihLYTDYiO7gW
         CLAd0Ru2Wg3ClwGHWycBrt06+WHaCsQfwSVh4q56xH+pif3bfs+3s/ewLRwV4yd6usJ2
         L78z3i8DgACYJNswlhFjLQqQx8GS6dNOlEx4vPhdJq/6FCDvng0FpqxyTbZoAzBm4gMz
         ISK+Ig4ZLNwNorToOoonIjgw9qGnqeITnFJUAhkbv7ryhKUS44ODGUQ7oGM6l66/V46F
         bQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJ8f2Ugo57sR2fd9QeineGtq8LDDeaHyfs+fIUD96Ro=;
        b=CnI4abamp9bFQUO2ACIP/d2XfRa15tZKri2A60Db2OrRdnrgaJoR0BWqpadDXNSg5X
         G4errbH2KGg9uX2sRpQWsR5KnmhVK91pldwEcqlInoX3NCyO+2Z82uUUcVFMZs85+aVB
         sxIBSpADllvCW+bLEm38A4fpNNSuUAR3JpjqoPCE9d6IBQlMHCZVLyecx7aZnUobR1XO
         I90pCIGWLaPUc/7b1qOJI2cgD8THxhUM1V3+OUHsidqnf7LpKzHhWcNo8xPWK8gIC+3g
         5U+jlbiwUmLI6rqRoXQ17MbT5dkqKlqWTi1/IYyRWW3cPgwCsuQ41uSVSPcu7N75mQVB
         PwTg==
X-Gm-Message-State: AOAM531QLcSGruzFrHfLx7/gB7yDAJLZ3DgZz/UxM2dvfKXNBDhTUpIp
        9/fV3kXsZEz8r8jjxLMScF8=
X-Google-Smtp-Source: ABdhPJzrOsMrYlWTceyePaCm+W3V9hTpXrJMEWqgPI3Yj/oIPhTricl5ap/L9P8Yf1g1ylTOGc1qUg==
X-Received: by 2002:a63:ac57:: with SMTP id z23mr16024517pgn.239.1632739180422;
        Mon, 27 Sep 2021 03:39:40 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id o15sm17732917pfg.14.2021.09.27.03.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 03:39:40 -0700 (PDT)
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Sashank Bandi <bandi.rao999@gmail.com>, git@vger.kernel.org
Cc:     me@yadavpratyush.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com>
 <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com>
Date:   Mon, 27 Sep 2021 17:39:36 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/09/21 17.19, Sashank Bandi wrote:
> I'm currently planning to convert this into a C++ program as there is no
> way from the Tcl itself to change the color and background color of the title
> bar or menu of the Git GUI window.
> 
> I also CCed Pratyush Yadav as he is the official maintainer of the project.
> 

Regarding GUI toolkit, you should pick the replacement carefully - 
tooling used in Git for Windows will need to be adapted in order to 
compile your chosen toolkit (whether it is Qt, GTK, or wxWidgets) for 
Windows.

CC also Johannes Schindelin for comments.

-- 
An old man doll... just what I always wanted! - Clara
