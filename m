Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6635B1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeHKADU (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:03:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33155 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeHKADU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:03:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id r24-v6so2475810wmh.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 14:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ssNy2rV4RvsaAK0SEQ4GOidtOBobpjxpeEUiD+qz1NY=;
        b=AMZMjFSuad/CqgMfT/0uaVmN149n9feLwBGKmu54Lleb8MNbuLksuuyMJBOM0jhzVT
         Y5CR9A+A8mdjZsdoKJX1loy6YaSuROvnSPt3kp4wR3QGHikWPk/TCpRvOe0JFZAJVV1l
         nayj2dlMnh6sSOVdwHLfAekkrknvMFknBFCAt3lAQ7S/Nv8mmdUD40LiRqvIs0Rri9w0
         l32HEm4aDHbNCbszfuLGPMNjghZpsujufYkYEEoPJgq1efp6C3460EtElyOuXZGy+zIb
         tvaEkI004ju3aV6ksIpXWQfMvrYfJ6zgnvwWN3F83736vcxTv2bbY3X5qzTjzRxZyDJ9
         fEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ssNy2rV4RvsaAK0SEQ4GOidtOBobpjxpeEUiD+qz1NY=;
        b=Yt2r5RtdMgG1wT3BjtEa0NGuczPwjDqGOJMxtZmI5xxsey8gi4LcUUBwUQaEbMr4Za
         nEjr9fGvjdLJcOoSAPlcG6FytKROwx2AeV3gTfnB4vTf1eYMArRkaY6VSroTL6wN5Ium
         QruU3pj50vaKju2Qg/Ug2WXhqcwdxhLB9hBCOBcKylZXcJcglB110jQspk47sYUszB1O
         NWuAE+UHmH0lCXA0dMAL7J0Nz5P+Bo518i3Q7E22lN+SFlpC6FGpMb7tSB4Zi/nhcD5q
         Fuv4TPbuk8yWaMub4O83dmJNa3Qs8+LrWtWn/ULF/RQvhxx+YZAsVyod4OHkpTJYt2Mb
         m5iA==
X-Gm-Message-State: AOUpUlHNLDAF4Uh3A3WNXT8ls5TZISTJoEbKPh1GrqQW1nCK+L4T0Rzy
        /A0l64lO2PG6GfukU1UCtGg=
X-Google-Smtp-Source: AA+uWPziaIzNPIX6eDwV//zraFZCzce0M2JIPi0fl7L4E8DEorR6eVQD3P2cuAgmquIeiYa48P55xw==
X-Received: by 2002:a1c:aa0c:: with SMTP id t12-v6mr2360662wme.109.1533936702366;
        Fri, 10 Aug 2018 14:31:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g133-v6sm197171wmf.44.2018.08.10.14.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 14:31:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 00/21] Add `range-diff`, a `tbdiff` lookalike
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
        <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com>
        <nycvar.QRO.7.76.6.1808081422160.71@tvgsbejvaqbjf.bet>
        <CAGZ79kbj2sgKOmouvLDuXic3vq9RG1LZ_retOqMwX_YZtMP+1Q@mail.gmail.com>
        <nycvar.QRO.7.76.6.1808102313070.71@tvgsbejvaqbjf.bet>
Date:   Fri, 10 Aug 2018 14:31:41 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808102313070.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 10 Aug 2018 23:18:59 +0200 (DST)")
Message-ID: <xmqqlg9d7vsy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'll just try to get that option parsing change in that Eric suggested,
> force-push, then wait for macOS and Linux builds to pass (trusting that
> Windows will follow suite) and hit /submit.

OK.  Obviously receiving, applying and inspecting that result will
not be done in time for today's integration cycle, but having a
version that limits its cope and is suitable for 'next' is a good
thing to have at this point during the cycle.  Correct whitespace
error colouring, etc., can be done on top after the basics settle,
and the basics were good in a few versions ago already IIRC.

