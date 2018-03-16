Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED9B1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeCPVb2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:31:28 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:44594 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCPVb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:31:27 -0400
Received: by mail-pf0-f169.google.com with SMTP id m68so4649139pfm.11
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fTmwX5TQev8b4e+nL90bwO1YVyD+tls/pYFemM5HuUo=;
        b=eV3YqFeeM9qjsXqSUlT6lDDnPpbljdbjYGpt2drGPpm5V37Q0p9zK53QEyd2qhq2Qo
         sQ/d7rOsiGfg3G8Dm7MMNAWR2vNieZPCWoHlzuTJvBB5PD0NBB8o2CLH/0qZRw3pkoiZ
         ighCgWftSW7plPXuE3amzaimvhsocWl+QlADP5EBuDfm1lc1otK1rM7KW9qUgeWtR2wi
         V0PBLAOVruknm1B4aQZlhwlxWWHymd7iaXPqiNBX1FqximGOkk0OF5d+TkqQd9XIkJaR
         zSvN2ehMNvbqnIkdXRkk+YxLQ6MbDWCMBtBZSHDpnd7g/DsXx6jkYFaRzQqACpelmH9f
         YEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fTmwX5TQev8b4e+nL90bwO1YVyD+tls/pYFemM5HuUo=;
        b=pisyIr0iAlJWR3TrbpsvBZ4ha2adIhUrguKErn+zzftpckpPI1pLsxLHfPTRzXCjl7
         YEtvB4HxWa8/U28RtUyP4QFvjOrKYshzfxRLOEVvU46UkKDA7pScNNIHsT6C1KUz3+XU
         GwzaNJDdHU5qk9dZ1YymB8I2fhxliLR974Mx3c82tYDkX/J8egy2AUJOdMEVqpmF/RXl
         mw7cpinRFxUXNN4TsiXyEJfcgjEuck7k5ndFXfrmlnA1L4eimUZNXRPjY6SkGiSSZuEG
         Pt5Ney4YNlj4Fm8HxL34FziJkPQgnTW8pec7iMU+QlVLoKdJgg1xCoXunTR4Mc9yi4dn
         QmLg==
X-Gm-Message-State: AElRT7Fhtn5aXnAFJ3nQxKLXJ1Hm8+N6fxVm28whVRJr3vDaisERBkTV
        cx5Lz+kF9/i8JVRcwh8q7BJUPQ==
X-Google-Smtp-Source: AG47ELsrseKWI3dyMzyv+fSxgtHD5QAyPJAWj4+SX+cqocdE+JdYAGbtKVvjSRvXUV8O6Fre4Ee5pA==
X-Received: by 10.98.16.131 with SMTP id 3mr2868067pfq.188.1521235886433;
        Fri, 16 Mar 2018 14:31:26 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id q15sm15966165pff.65.2018.03.16.14.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:31:25 -0700 (PDT)
Date:   Fri, 16 Mar 2018 14:31:24 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
Message-Id: <20180316143124.5b22d70861344cbcbbad46dd@google.com>
In-Reply-To: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 14 Mar 2018 18:34:49 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> * sb/object-store (2018-03-05) 27 commits

[snip list of commits]

>  (this branch is used by sb/packfiles-in-repository; uses nd/remove-ignore-env-field.)
> 
>  Refactoring the internal global data structure to make it possible
>  to open multiple repositories, work with and then close them.
> 
>  Rerolled by Duy on top of a separate preliminary clean-up topic.
>  The resulting structure of the topics looked very sensible.
> 
>  Waiting for a follow-up discussion.

Would it be possible for this set to go in independently of
nd/remove-ignore-env-field? I understand that some patches might be
cleaner if ignore_env is first removed, but this patch set has already
undergone several rounds of review and (I think) is an improvement to
the codebase on its own.
