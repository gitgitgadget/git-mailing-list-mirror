Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAADC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 07:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346707AbiBDHAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 02:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346401AbiBDHAW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 02:00:22 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE12C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 23:00:21 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id j24so4049750qkk.10
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 23:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hp6kQgk6ChBnEO1FVlO+/fR1Tg3y/Xx9RDSX72k1b8w=;
        b=iD359BPCtu4y/6d4egCEJe/7mo1mWqMWrj92xlzs1mo4oTMJFXlaNbrjfa0zH2iKkX
         QWmpbP7v3i2fHDxAc5PRsMq2rjef5+PELSxC+Sf0OFdLpA1xXDXK9TJjkFJA7665dA7d
         A2tA0B5i1hPpBJYBobGD5QyhZFSrOoFTBTM/9px81pzHkIM+JZ3AwD6KzA7ysHzyHT+U
         KDIyErxERD3RV6Vs1E9yn8me/87Wzc5GZ+siCpKspKzAiRyZkCnECZy5Uq+pLWbnRAwP
         fSt4O/mF9OyFNAm4XYxanBJxe7Q6zuA9mJ6oI+IW03fmHXzNP1tcvqQhCFCLQBSj6v5H
         FQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hp6kQgk6ChBnEO1FVlO+/fR1Tg3y/Xx9RDSX72k1b8w=;
        b=a9nBFrI7Sb87BwKU1lkMT8wSF52H5dBUS/XMECDhPwR3kb5Rg3SBMTO6OoUE7hjvCR
         y3s4IRAhndKZRjEIW5Tzj471kn+xsoz2wEB4wm1NvYn2kl33f+H7JqO9fQOJnFoegR7n
         v0yJgS2E/qTtYj3c21ncONJZ+DGVDF8uyEZ/+Kn3aC28AFh0u/eHjkt/GOz1jgmx7jMM
         OMOfpDl5BmSazMoqU4uF18615UOJr6jUe5+ke9zsVbGNMwOGDlVHcfaiChF+CAMR5muk
         D1Dw+9N12t1N37z9uZyXx/WeWVxMNsdFkTHRS+7qqB1IuZrAbQnmZ1BIXoLViKKDaq4l
         3gpQ==
X-Gm-Message-State: AOAM533AZ5ImETC4buurTNuX49T2wuHix1XwpfxbAh6i/gGi7RA1teX1
        Dbk8NcNbzTDAC9C0X3EGxUAo5St5yQU=
X-Google-Smtp-Source: ABdhPJzpgMm3E6KmKOdKqMnc7ctXg4370D7o6wZIwDPo+fRG44UJCZGUNxNcnJUMojebLU4AUz6rPQ==
X-Received: by 2002:a05:620a:d93:: with SMTP id q19mr776101qkl.437.1643958020845;
        Thu, 03 Feb 2022 23:00:20 -0800 (PST)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id z19sm725855qtj.77.2022.02.03.23.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 23:00:20 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <6916de1c-12f6-6f45-99c7-ffe8dd08b244@sunshineco.com>
Date:   Fri, 4 Feb 2022 02:00:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: What's cooking in git.git (Feb 2022, #01; Thu, 3)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr18jnr2t.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <xmqqr18jnr2t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/22 12:22 AM, Junio C Hamano wrote:
> * en/keep-cwd (2022-01-26) 1 commit
>    (merged to 'next' on 2022-01-26 at b2518a683c)
>   + sequencer, stash: fix running from worktree subdir
> 
>   Fix a regression in 2.35 that roke the use of "rebase" and "stash"
>   in a secondary worktree.

s/roke/broke/
