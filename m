Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40B220248
	for <e@80x24.org>; Thu, 18 Apr 2019 01:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfDRBv1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 21:51:27 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51076 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDRBv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 21:51:27 -0400
Received: by mail-wm1-f42.google.com with SMTP id z11so836603wmi.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 18:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RWgq4yvOBbE4VV5kOvc84dGPbZ5gYgsiD9gt3SBjVg4=;
        b=IyKWtq6qYQy0b0DfRcYHpl7p2p7mXXXMfSJ1G6UuSAa3VoZlh6gkOtGL7Nr1DM3u4u
         O5mSk2AhPVFquNKFCnpg5IMrO6Tve+RdOtyk4Y8zvUMMDjjHZitzrWpmHBOlO/ijJf+p
         /KY2EU5ML/C5jBzMNJOPpuG0z49AdBdWr8jY/6jHbOMdZ+7XqV1L7P9d0eoBT1fuyl+T
         LqhheokH7Bhx+984Z5t2S7qQ2Yb/sxKNvre190Qm4dtGGzH5N6sC2rEVGlMcyo9oxvaW
         yXtgNnAdvT2WSxNAsiEOUqqHrbre67ZVyuWGAlT8yFHh7K6YGhZqYdDO6fqlpQtZp88u
         K2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RWgq4yvOBbE4VV5kOvc84dGPbZ5gYgsiD9gt3SBjVg4=;
        b=TGgk1ZMJmp21+0mA6H+jR/4+cDGjjQr1AnbYGOJih9wB2nLvCTokIluIaWkXUi/7Bk
         Ubxye7rGXQgKNH1tI0/Em52w3Q/ukGqc4jOQ2plIq2wPcdAJKgoBlBNOAzCrnrGQeBXq
         YEcng9wsrzabeO5tkA8B9MVcVMDJb/A5is+639jK3kzAP2lmZLEYhE1+0VGhIpOzMcG+
         t0CIWk5U0hiJ12k/zGN2+IxY+X3CnMj3jVB6KSLo7WCXsRQsy+3QM7bPwXnIcFrauYNh
         WdfOhVu55RfxrhncLA4t+S+lLU594CLiWReSZCSvDZ8jcvkKAelP+aRs/4sfPXjSuftP
         Ls6g==
X-Gm-Message-State: APjAAAXg88X1jEC1fDqw1ojDmCWt4iumj/lgI7M2XqPuoUWWgFe8JYH0
        W+cmzFzbkO3jPkjyNhqKc8A=
X-Google-Smtp-Source: APXvYqz6hm+SqvoYc2Txr8dx6IeidfPwAQOcdCKR2w1mcANc7U+b0ImfRS4i3osxwDexIN0pavKcXA==
X-Received: by 2002:a1c:f909:: with SMTP id x9mr1072569wmh.18.1555552285089;
        Wed, 17 Apr 2019 18:51:25 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r9sm453820wmh.38.2019.04.17.18.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 18:51:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: jt/clone-server-option (was What's cooking in git.git (Apr 2019, #03; Tue, 16))
References: <xmqqy349nyn6.fsf@gitster-ct.c.googlers.com>
        <20190417161840.261934-1-jonathantanmy@google.com>
Date:   Thu, 18 Apr 2019 10:51:24 +0900
In-Reply-To: <20190417161840.261934-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 17 Apr 2019 09:18:40 -0700")
Message-ID: <xmqq36mghyhv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> >> * jt/clone-server-option (2019-04-15) 4 commits
>> >>  - SQUASH???
>> >>  - clone: send server options when using protocol v2
>> >>  - SQUASH???
>> >>  - transport: die if server options are unsupported
>> >> 
>> >>  "git clone" learned a new --server-option option when talking over
>> >>  the protocol version 2.
>> >>
>> >>  Getting there.
>> >
>> > With the two "SQUASH???" commits, I think that all outstanding comments
>> > have been addressed, and Jonathan Nieder has given his Reviewed-by [1]
>> > [2].
>> 
>> OK, so do you want me to do the squashing or are you sending the
>> final version with jrnieder's reviewd-by's?  Either is fine, but
>> I need to know to avoid waiting for an update that will not come.
>
> Please do the squashing, if you don't mind.

Will do; thanks.
