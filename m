Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EAEE1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 16:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeCMQka (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:40:30 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:42526 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbeCMQkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 12:40:25 -0400
Received: by mail-pg0-f45.google.com with SMTP id x2so86133pgo.9
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XIX7wvcVCvOLahFOj8smxe6vTLVSMQfvXVWTG1XC3Dg=;
        b=JsMR/fkoQC4NOQ3yEzpG0d9mY9o4Zah+il/KabUJ6FPqW2TZXZDOtcSemPNQYVNbEy
         q/zTM9maio3ibTlxXsqfG89zOxBpVuPJlObbC/hC578hmkByKnftsijI3IPGIFgFVPeG
         QxxaDOEDsmOInY0BVwdrnV4AYiVGPQgFQlGq5XkBRAKc3EUKBnKnkdB8BBd+VpkbItIE
         HRChORm7SoGMhnCFyEBG1TVVORSGO7+iQaNEZvvQMbg+HKHsCHB7V98MskKJ/jhpLM6G
         Zoprxv706Ge0FgSun5LnacXQXUzs4nwOmMdOwiAGd4x6o0hz4MLNStXPE9VqmJY740Nz
         rDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIX7wvcVCvOLahFOj8smxe6vTLVSMQfvXVWTG1XC3Dg=;
        b=B86YVcSBU9kqFIXgfnbvcdLK5XkCEKNrMJMsDF0JcAo+SVgpU0Y+nVcKF4vtWpZ6s8
         L2IN9EcyrBnZg2zyjxhEe+5Y1YhlQ9iFm4GNNbLtNFDGALRRZr8kxrIlaVAd7LMStOSI
         5lQUqGdA34MlAT2AMZnWX1epTWm5CnmQaGjIDFmsJNHI3VHuCkHo9ERGXj/+OPenah2t
         jvdzwASsh6+tJODFFe+yR2LG+QCXVlvbPhY5y9pYbEQ8HHxi8Dk1qrKFJlVRU8NdwD/t
         HQLRbb8IAdTyOFvQdnAAbD2/ucqeUl9zb0NIRopMKJnKLDubhNg5HJQO5Up29RhYcwNZ
         8mRA==
X-Gm-Message-State: AElRT7FYFwp3mjkkNWFJbjuLdgDKcFALkL5JaZRMpE7p8J9PIdsD12ab
        4ebvn0ZSucrzD1F0Js/il8857w==
X-Google-Smtp-Source: AG47ELt7F6ZgWqG1Ab4HyKVf3g3XvFKOG4qUsSEbqDVxOyA+blUtC6z/5C47ZxF3WfITC93UI3drPg==
X-Received: by 10.98.178.17 with SMTP id x17mr1248230pfe.2.1520959224757;
        Tue, 13 Mar 2018 09:40:24 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id n10sm1107080pff.131.2018.03.13.09.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 09:40:23 -0700 (PDT)
Date:   Tue, 13 Mar 2018 09:40:22 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 04/35] upload-pack: convert to a builtin
Message-Id: <20180313094022.6cbe51d765e2eec61e0cd04c@google.com>
In-Reply-To: <20180228232252.102167-5-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-5-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Feb 2018 15:22:21 -0800
Brandon Williams <bmwill@google.com> wrote:

> In order to allow for code sharing with the server-side of fetch in
> protocol-v2 convert upload-pack to be a builtin.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

I suggested updating the commit message in my previous review [1], but I
understand that my comment might have been lost in the ensuing long
discussion.

[1] https://public-inbox.org/git/20180221134422.2386e1aca39fe673235590e7@google.com/
