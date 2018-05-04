Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C402200B9
	for <e@80x24.org>; Fri,  4 May 2018 16:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeEDQKl (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 12:10:41 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:41703 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeEDQKk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 12:10:40 -0400
Received: by mail-pf0-f179.google.com with SMTP id v63so17781515pfk.8
        for <git@vger.kernel.org>; Fri, 04 May 2018 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPEv+/5ezal58dbP0LNT9EIrHIFRswrSY+tSWDa50r0=;
        b=pXCEgKuZ2SU76TnHU5AJyJvNX3GHAQz9OiMZryxVjUg4QzKpUgeI4f00YqaHeay8P0
         5W0jAY96tDJMcTNkRSEcYg5g3z9fi0Wv6XBaPcMPBrRvbRjYXwwC5rQJiqIGvzAD8sa5
         zprBMAwLSKm8zGi0GETFoiqRzcCwp1QjL7S6n+jbLphkxnC7rtrloPUyfo6mi0+MqiWA
         6IITbA+NAR0vmmdzPVwhgISiN8vWqHxN22GV3mVTRzgCHcfORmPnPpv3XdZjDT9Ii+6i
         PM5R/lH5BMus8wwMbA2XqBIqxNho6wuCo2gJJp5huYYKBdJw+XBSIcjWwLiwFy7TFfpv
         PtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPEv+/5ezal58dbP0LNT9EIrHIFRswrSY+tSWDa50r0=;
        b=DtWYOd1h5n2WBojws5xLwOK9xxWhsb6DcC6Uau8GJ/nwS3CvwhQJif/zmXg7xuxhAz
         caLQBoH94z19LPugZ5Vb1h85NIJ/SBe5Zxo8v3riXOYyn04ONAq26aw2202HRG31DeK7
         /24/gHSc8H708wKGJ3Onmh+q+ehA7YV/GFxnetwtMxumGK646P6M1AAsfsIInEsOZf8Q
         +1RpB6GkauX0s4u8YhDH5h/W9WPX+xtQTnjDQrtNu/kPKkRA+A7o1qLuUivMby1vhLsa
         xIDv8YpB9mIqpNiVp55YbQ+yMdRk4CCHJ+mhxxlGwLsaRjW5EGgsKqxXMBXBejsfFFVT
         uj4Q==
X-Gm-Message-State: ALQs6tBK45M38dVaJo/9Unzd/8gew0wGRhq9sZmSxylbE+Dt4Ns8wBmO
        9v61e/j1moFr4fJXQ6888y6AoA==
X-Google-Smtp-Source: AB8JxZp8XarY/lUQterL+z8EJjqbr9J/E1NtPZLsw0WQjso57znTrhznGxCl5oxPDDIy2zbe3RhTdA==
X-Received: by 10.167.128.198 with SMTP id a6mr6144976pfn.120.1525450240128;
        Fri, 04 May 2018 09:10:40 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 184sm9940987pfg.89.2018.05.04.09.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 May 2018 09:10:38 -0700 (PDT)
Date:   Fri, 4 May 2018 09:10:37 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 1/3] upload-pack: fix error message typo
Message-Id: <20180504091037.ff633aaa412e925d4493ab3f@google.com>
In-Reply-To: <xmqqr2mstaxk.fsf@gitster-ct.c.googlers.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
        <cover.1525220786.git.jonathantanmy@google.com>
        <177c6eb7058adc1996f0595ddc3cc848c91b578f.1525220786.git.jonathantanmy@google.com>
        <CAGZ79kbTwqzKgZjN7GSXn-NpKX0kkDVYbXmdz6CC6TrDWbqyQg@mail.gmail.com>
        <20180503164155.6112764a927d50e23600dc49@google.com>
        <xmqqr2mstaxk.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 04 May 2018 11:24:39 +0900
Junio C Hamano <gitster@pobox.com> wrote:

> Hmm, when somebody breaks "git server serve", we probably would not
> want to see the binary spewed to the output while debugging it.  So
> I'd probably keep the redirection---it may be an improvement to use
> ">out" and then checking it is empty after the expected failure.

That's a good point - I've readded the redirection in my local copy.
I'll send out the new version if needed.

I checked the other patches and patch 3 has a similar situation but
still has the >/dev/null because I forgot to remove it when I removed it
in patch 1, so nothing needs to be changed in patch 3.
