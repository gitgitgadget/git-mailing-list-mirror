Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B77E1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 22:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933423AbeFVWhX (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 18:37:23 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:43531 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754519AbeFVWhW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 18:37:22 -0400
Received: by mail-wr0-f174.google.com with SMTP id d2-v6so8020315wrm.10
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 15:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cPkGcaiZIzqRNka8g+x8YDffKfksJ99trYMxeU85+lU=;
        b=Z4ZphdlYnaE9ov7yUd/gKQo3tDF5mVwTmOnvfaVbxQuxtvkWCTwR9jS24RLdTfCgNJ
         qm0zFVQyevu1ehQNgAGRSFpuhH7Nzm9fSwFjDetXm1D8QkzmfoOtIpeRDtBMH3O5UR7R
         Wv1h+itjWTy8LcKI+q7FVkqEindk/47UDsxpZn+9pgCoe7ZVR2IXy4xlI8RTN7MnwEHz
         VL++CUtKpGScBf3shgZvJx1AdIRYOU5V8X9Xr6g9WlhX31WywvCDOqn7Y8Wq81OvriPj
         +wUXEZDeRRrvRbbhTZrR9Twxne7xToAgcMTyqbq1CtPtD9tyNGjfenezesZBjCEDT24j
         1wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cPkGcaiZIzqRNka8g+x8YDffKfksJ99trYMxeU85+lU=;
        b=RfLNRPrk+IkkCcbXZY6+yxaVAK+rW2BRDuWkq/liLzYziZgdZqnOVuzeR82TMBCEfy
         +mzXGrTyA6sSrag9rHpi1tWIHovFDorMlomhMTkdZj1A2s3ciFIy9R2SAJCNNhRtz1Nf
         YEioA0fqKmGOq43WZMAR7gpap2MHKXEhmRNq3hoODg2hvru4FG5tYZBqyqqIIsKJIizV
         m21k6Nd1CHLwwEYgmALQ7AtiEXQPyjB6p+7yVFIsmfmi7pWRW7xAM95urJW8Gsz0RLXL
         xXB5owWyQ4DHNBRH79YXM/Ho9AyUzuq2y/1Zr0YZf+LDnsXDuIXp3l48sLm/IIKMdzB8
         Wn4g==
X-Gm-Message-State: APt69E1rTIz384H5QzZU2ixOdIUiUlpqCuvy3CgaHLNcUC4GL3ckLZEv
        9JaKRXip8PCSezuN3aemXV4=
X-Google-Smtp-Source: ADUXVKJ30CnsLX6nQDTrphZpkTuZAL8fR7ucQHmkzAN7Q2DtFC6FuDoIewVRFFOucGaWVJXuhOdENQ==
X-Received: by 2002:adf:ae8b:: with SMTP id y11-v6mr3226887wrc.234.1529707041228;
        Fri, 22 Jun 2018 15:37:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w67-v6sm2740767wmw.0.2018.06.22.15.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 15:37:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org
Subject: Re: [PATCH v3 0/8] Moved code detection: ignore space on uniform indentation
References: <20180622015725.219575-1-sbeller@google.com>
Date:   Fri, 22 Jun 2018 15:37:20 -0700
In-Reply-To: <20180622015725.219575-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 21 Jun 2018 18:57:17 -0700")
Message-ID: <xmqqvaaaphwf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This seems to break the documentation build rather badly; I have a
monkey-fix queued at the tip fo the topic branch for tonight's push.
