Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4840DC83F19
	for <git@archiver.kernel.org>; Sat, 26 Aug 2023 19:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjHZTfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Aug 2023 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHZTec (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2023 15:34:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DE410FF
        for <git@vger.kernel.org>; Sat, 26 Aug 2023 12:34:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf3a2f4528so16197905ad.2
        for <git@vger.kernel.org>; Sat, 26 Aug 2023 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693078469; x=1693683269;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9RwHg+ponZRsJAwM/GrmWZrMM4woP4M3KUjvLU8iZU=;
        b=Pyn5uCDEEwdHShM9f4sp7HtVqv3eIkl6gP5rSZ4DgF2dWvSpJuQ7Vx2s9Nq81dSH8B
         i+il98L+D+WYW6usy0I8IkPgoSqv4fvzAMMJT6flhkrh959Rxy1SiZ2Kyi18s53b5cXm
         fLwx9O/9Bzn63ZXQcjFncHsp7SPtU90qcfV2ktKp5Wg2XFKaEvBrYggxpcT8QwM1CEIS
         gmFvuV2WGKC+XsZ0jnc1/ywQ/Vmt2guLKHOnw8cHI5uxXqvOawb8dUqYJof67YFQJkUx
         L2dQ97xS6K/rFQTmcxSKQkVFwFKnQZYm6FgggR3tIQjAvUVXuc5/UuVqDFXKytUDQizl
         S8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693078469; x=1693683269;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9RwHg+ponZRsJAwM/GrmWZrMM4woP4M3KUjvLU8iZU=;
        b=QyvGF58NTis9pCtqI0Acop8XVkDXa3cDLdZm8IqHyrHrgIcJDb4cC00eFdOIE/d2Og
         X6RbxvzX83DbHiPBWzs0FBMHcw0toByi2VYFOmuu2ifxXdWX3Psjf+Z9IUpjBbXdTXCR
         X5KpdFDWVkLXkn+jl3HLE1urujhs+Gf7RCh89knGQqfApjhuM3iRrJ2ilaTlWnRK0ulg
         H1yanAmdE6e2WMCNz0IA1MEUJrkF54JfCPRanu70VK5OpyujLVKTOdPfAvMXmDiA2h/C
         bJYSeWYx6ldeASN43dwx9S6MAgxCf9j8ZihRqHSWMQs3A+UgnnaDnMDgzXWLCV0/+3zK
         FR6g==
X-Gm-Message-State: AOJu0YzIwQz51VWKL69UGegzcypjV3JvO0bmN9EWc5Q2rsP1DcDJFFnM
        xMf2hN4guZ5BBg5FhpnN2ZIeLhGyNEh/bQ==
X-Google-Smtp-Source: AGHT+IHJBqUkQAcqPRH7YmOm4UNes7cGco//roxH+tSL2ga/yT+5inEHfgfyqYjS/ugnjjSn77FC9g==
X-Received: by 2002:a17:902:db0e:b0:1bf:a41:371e with SMTP id m14-20020a170902db0e00b001bf0a41371emr28017358plx.56.1693078468998;
        Sat, 26 Aug 2023 12:34:28 -0700 (PDT)
Received: from five231003 ([49.37.158.191])
        by smtp.gmail.com with ESMTPSA id iy20-20020a170903131400b001b89466a5f4sm4085393plb.105.2023.08.26.12.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 12:34:28 -0700 (PDT)
Date:   Sun, 27 Aug 2023 01:04:24 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZOpTwBznQowe8PEL@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
The final week of GSoC post and the final report are here

	Weekly post: https://five-sh.github.io/2023/08/26/GSoC-it-is-a-wrap

	The Final Report: https://five-sh.github.io/2023/08/26/the-final-report

I have decided that I will continue to post on this blog even after GSoC, as and
when I have something interesting to write about.

As usual, feel free to suggest any changes or comment on or off list.

Thanks
