Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1361F404
	for <e@80x24.org>; Sat, 15 Sep 2018 15:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeIOVOs (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:14:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33602 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeIOVOs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:14:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id r1-v6so1980255wmh.0
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lr/OqjjicbPIeEb8a3pWrILED4GfbEJ0JwUlpwuRogY=;
        b=s2wresawAQ2EstC2mjWTdKTv495bsfnTlh9M2rucWeMee+GnCuv98XNdpvgTxP4eRI
         X6kMju8UYag/rKH5ib3YFEh5pOBvomGFYW02R9wRWGtBhTnVjtj+NiO/IzA8mI9Ueox+
         sXCSWanEUUf0cF45gYiv3YRoh710MsQmZTvsWx5636ZL080w1P5iChLvGrTM3kVh2bHl
         9cJYJBO+5ntybkTN8FUjEwbEi5+GhJfmCphk3ZKr79A5/nJhlsgoLZ1Kj3UArX4nW6Ld
         0OWi1CcPtBhPvWBujB/g8022UfveTfGRHA9NEkSMRxzgGdHKYOXuW8vDEQ7MIPBH9Zc6
         Q70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lr/OqjjicbPIeEb8a3pWrILED4GfbEJ0JwUlpwuRogY=;
        b=oB2K3XA2A29DtRRP4FnvC0+KkuE7PK5T3BWdNESSf7MYgRZkk2qlAA1b8ge9R2WbN7
         ++aZcDYQmZg17xb+zd014dnUl4GeAgZ6xEr1/4J9iSWZFTnza1V/qGjvIBOwQcW1Fdt1
         z3qbZMrspbq/n2sw7PdRmX7s0tmp1fdFKhJBXCCUC3PocCSn5npjlM4pWrBgnpL7Eb2V
         LZCO7tXYUMo+EZEbDU/GcQdkwQeCC6RPjX5rkBHIhIhlikBAndr04P2FjeghBLdwfzJe
         GS9Fm671+4I2Mdpo3WqjwrFgaKRINClwSH9ceHK5Gzr6c0b3cvKaksm/qFvPy0HR5rSp
         2opg==
X-Gm-Message-State: APzg51DnGpqlDCsWYBoIkuIlIoCzO0bkOGKCw590rL0lqpjTVBB+dr0B
        vJizl48/DTPpeQWiUUXbGlA=
X-Google-Smtp-Source: ANB0Vdb2g59k+yBlPxvyn16iTQTkzF8qRE6s2u85f7oTI6CAGoO2NFfe36SQ2VbRsP/SYibJ09oJBA==
X-Received: by 2002:a1c:ac07:: with SMTP id v7-v6mr5954450wme.110.1537026922519;
        Sat, 15 Sep 2018 08:55:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z184-v6sm3416837wmz.0.2018.09.15.08.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 08:55:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com
Subject: Re: [PATCH v1 0/2] Cleanup tests for test_cmp argument ordering and "|" placement
References: <cover.1536969438.git.matvore@google.com>
Date:   Sat, 15 Sep 2018 08:55:21 -0700
In-Reply-To: <cover.1536969438.git.matvore@google.com> (Matthew DeVore's
        message of "Fri, 14 Sep 2018 17:02:34 -0700")
Message-ID: <xmqqlg82ah7a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> As requested in:
>  https://public-inbox.org/git/xmqqmuskas3a.fsf@gitster-ct.c.googlers.com/
> this patchset corrects ordering of test_cmp arguments and | placement.
>
> The request didn't explicitly state whether all the tests should be cleaned up,
> but I did clean up as much as I reasonably could.

I was only suggesting a clean-up of the test scripts you are going
to touch anyway in your series, and not the ones outside that
original scope.  Your going above and beyond what is necessary to
make sure your primary changes will be protected against future
breakage is surely appreciated but it would of course require more
review resources ;-).

