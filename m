Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFC31FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 15:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932715AbdBPPv1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 10:51:27 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34625 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932430AbdBPPvW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 10:51:22 -0500
Received: by mail-pf0-f174.google.com with SMTP id e4so6520184pfg.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=5tXRYKVBwaitK52C1ukdHXnZS2UGbkjgMwoDUQggGrQ=;
        b=Jni+e49HTiunXe4m4h7z834KjYvr/Hx2bvDcRicSpvB1h9At2pQnCsajKx9ZzXBkZR
         AJ5ILj74EBtrMdp3wz6NLZ/8V88ryxxyhnk18uE3Kbk9D9XTM2mWUU45yZffhi39OyVx
         QEjj5N5Tr2+8Q2glxgFYhf7HQBJx0B2UZlFcWEseyc8NOOKKiCbJfZcbL6GeE02rt4Vb
         7djRoRWaKjMvudWY2jBfDSyhJgvUrZzKPZLfVm+MHHZ747Vdko8R/GpeyVPssyaaCJnf
         LJ936O0jKGNXdW1MmmxuIBr9ShughDrBi+9+ZJVwuKoP2eLAH3hQe+oLyDtWEpGEm81D
         rKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5tXRYKVBwaitK52C1ukdHXnZS2UGbkjgMwoDUQggGrQ=;
        b=ieDeZkvZYWSwuhc8xBEgFlCa2tOUM0PFNdZFwpoJa41wzJkACVVFUdLoK30f4NqqEq
         X1EzfGG2ussNkiXKLnfNAtpdSHMZ5j5b1L5X4xEmNh7cQzgP051/dSSQcXVV4+ekfFTe
         tWhSyMMw7EEVErKJZG6+QB7AgUZG8zqFoLnazWJf4464ziLIpyOD6RqiT6Yep3+Sx2Gv
         xRpOEB3SZzem2h7vfb9hJt452kTLi9W6oL+I+IBoVEx4w7jYZDvDL8a2Fp0+ES6tQDts
         nCQv+CIzHx4DdccYIyJXUIA8Tx4kwJ6PDKBfvC8mLHCZ1lgkxDB4UYRZj9dPvuc3ompj
         MMqA==
X-Gm-Message-State: AMke39kHsWmY9Lwsf+K5Wuz8oFVSTvXWNQVi0L+Cn34vWtni/pkX1O1XjPgidGmRsyn86B8B
X-Received: by 10.99.161.17 with SMTP id b17mr3704293pgf.72.1487260276391;
        Thu, 16 Feb 2017 07:51:16 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:e4ca:e8f7:5d37:7899])
        by smtp.gmail.com with ESMTPSA id n8sm14642448pgc.16.2017.02.16.07.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 07:51:15 -0800 (PST)
Subject: Re: [PATCH 1/3] add git_psprintf helper function
To:     Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>,
        git@vger.kernel.org
References: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
 <20170216112829.18079-2-franchesko.salias.hudro.pedros@gmail.com>
Cc:     peff@peff.net
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <616a2b08-71f9-d594-d46c-2687bf20ae2b@google.com>
Date:   Thu, 16 Feb 2017 07:51:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170216112829.18079-2-franchesko.salias.hudro.pedros@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/16/2017 03:28 AM, Maxim Moseychuk wrote:
> There are a number of places in the code where we call
> xsnprintf(), with the assumption that the output will fit into
> the buffer. If the buffer is small, then git die.
> In many places buffers have compile-time size, but generated string
> depends from current system locale (gettext)and can have size
> greater the buffer.
> Just run "LANG=ru_RU.UTF8 git bisect start v4.9 v4.8"
> on linux sources - it impossible.
>
> git_psprintf is similar to the standard C sprintf() function
> but safer, since it calculates the maximum space required
> and allocates memory to hold the result.
> The returned string should be freed with free() when no longer needed.

If I understand this correctly, xstrfmt (in strbuf.h) should already do 
what you need, so you do not need a new function.
