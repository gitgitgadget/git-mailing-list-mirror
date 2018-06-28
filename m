Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PYZOR_CHECK,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAFE61F516
	for <e@80x24.org>; Thu, 28 Jun 2018 16:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935705AbeF1Qrb (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 12:47:31 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34152 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932809AbeF1Qrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 12:47:31 -0400
Received: by mail-wr0-f177.google.com with SMTP id a12-v6so6208206wro.1
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=BYCWqhc2Rlhh2pwcCwy8BLHhmOBHFVWsOQdJqaT5rTOHP4lsHY4qkd06Ya4DYfV2xY
         JZsEHXlyN9UU/4PTyCdeVfuamkwnkDcExj2tgOskktYTMVA6dx9Gez8EarVRpsgC8RA9
         9s0WrJR8ASPJCXMhz89Nw+8shyWqZCW0K2gDei5AnWQ1QVGXxKh6RWCoFJQimVeqU5Q/
         ugBipycrb5CdRkLH8EmZ2lW9wjNDJqu+KAITVMHwmh8Dy9qARBCmjQVVNd2UcoOWc8CA
         cC878uVwDS9AOgexnR2gQFDyWLclbp8z/gsSbfHv54ESLVHLswApEcpjaas9PMCAaqTr
         p3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=dNBdGa3hRj3Mj4TuQVjVMLADjTc+TeW/p3A1/PfnMEJMIQZ0nXDJ46j2QHw0hD45Qs
         25gI4PcXLPqE/L0O4SK2upS3OgtsMKkdjXtjRW9TBMKvNEvNIv17zJA6/b5XzXQxVzej
         nRs7VMf93K3Z4SoPSetOTSN114UG1IlhC2og47qzpRACet7AIhVlsunfKmAXwJlvD5Za
         uytNqGy0ku13LlI+zVWLEOIRhJ57I0oa5HkdplCHvFGY57eCHdpuI8s2/4Ps+/OKvEUi
         HntkfnRJ3ebVLHfLuprC8m8031vn/avtuIOv+2zVw9TdJnN3AS8acBM07pOJRCiWE3pA
         A37A==
X-Gm-Message-State: APt69E2KCr/BXikthol9iJzOuSGn/EaTOwE/2FOVmRl2D/pwpiAJiUNC
        aNVc7Zqm3VJX2qCTeIAUqhyuBjPb
X-Google-Smtp-Source: AAOMgpdF9iPM3+VWvKTfMWaI/PyLHv9s+oavL4InWOpjfzL8FqyzLsMcKBwusHQTiBt35OqjQOYqUQ==
X-Received: by 2002:adf:a645:: with SMTP id k63-v6mr9951905wrc.231.1530204449685;
        Thu, 28 Jun 2018 09:47:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s12-v6sm7496021wmc.2.2018.06.28.09.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 09:47:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, bturner@atlassian.com
Subject: Re: [PATCH v4] Documentation: declare "core.ignoreCase" as internal variable
References: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
        <20180628112157.17176-1-marc.strapetz@syntevo.com>
Date:   Thu, 28 Jun 2018 09:47:28 -0700
In-Reply-To: <20180628112157.17176-1-marc.strapetz@syntevo.com> (Marc
        Strapetz's message of "Thu, 28 Jun 2018 13:21:57 +0200")
Message-ID: <xmqqmuveyi1r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.
