Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67AC51F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbeHJANX (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:13:23 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38595 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeHJANW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:13:22 -0400
Received: by mail-wr1-f49.google.com with SMTP id v14-v6so6431469wro.5
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=15kLjVXT0cHLEwILFMm/1UJR4RygQC2YC+rMgw1mngc=;
        b=dBbMA6APOq0G+y8brOdBB4RzL4MmuaW1gHVJn4/2tvD1tZD3p7VYsOy3L8mC0mTplt
         rLE6hOhxYXfrObZQDl3hJ1eP8rOpDK6GvU/jH+LD7aqjqXlg6yfU/ePbC7Swyh3ywXAJ
         Sw2yE9tsC1lPyNeSJDFGXzVyIxKxbrW4qcrkGn6mNGXQbWtxxzRFDThiS1E1ApMOCt0t
         HZBeG1Rkw6OycvAoJHrQ3Er+/iaS2tIZXFCDGoVY9nvdml4s47WfK0/giz4Zq3xXnTGl
         ZPl0YoT5urkNy4SKERJlWcWHtVkTFKr71qNPgo6PFKZAuSSM4vBQyTUfDwOJVjQRvDFM
         NgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=15kLjVXT0cHLEwILFMm/1UJR4RygQC2YC+rMgw1mngc=;
        b=ZA9mX6aGHrn3hR7vti/vWlE283q0nOz8hmQkJNbaVczgkwipXdzv05z1r473L1Qywe
         JEht374JAGy15kpjZOjgjl82xnS5pyBEp+txPXoEbfUCr1B9PnD0s0OCxcC0QVyVTvpS
         j3LDg+5HL8lg/monCanfJ4cJcn4Zco5Q11GXQf2/gzTRBVmIBs8x3hwoORUrwYzJbWrp
         JY1eoiXZ068Qw8MQTy4DnrArXofWHiS8/DqjnZZuoHJ0dF08fMDhY6LzBlnzuPYDGxKS
         C8xZ2wpRAbjvZ03SAGVu/NBKbGVjldQ5kDVQBvp8E00SpiQAuuwCn6+kG1ovkY/0UGkr
         wLlw==
X-Gm-Message-State: AOUpUlHIlxWuPBVNzpK4G+BD/XH5zum7uj3kOPCjR6v2+cY021DKEBiO
        hs7IuHGTxD8TzdIZOTyi7fM=
X-Google-Smtp-Source: AA+uWPz1aowrmKoHG3tpq14ZLv/nxKhiuNx3U2yalrprkRLA88O3J0K+90yvTGn3DP1BTIRaGc67aA==
X-Received: by 2002:adf:f850:: with SMTP id d16-v6mr2369444wrq.172.1533851195254;
        Thu, 09 Aug 2018 14:46:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h5-v6sm9084697wrr.19.2018.08.09.14.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 14:46:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 03/10] sha1-array: provide oid_array_remove_if
References: <20180808221752.195419-1-sbeller@google.com>
        <20180808221752.195419-4-sbeller@google.com>
        <CAN0heSqwGoFwn34nRp3i09ExnjDPSY8WD=81M9jN5OW-ccpiTg@mail.gmail.com>
        <CAGZ79kYtKZJ0Dm0ejxrotnoaNERtR0J6=DMCgweCObdJr0K6-w@mail.gmail.com>
        <20180809192454.GB32376@sigill.intra.peff.net>
Date:   Thu, 09 Aug 2018 14:46:34 -0700
In-Reply-To: <20180809192454.GB32376@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 9 Aug 2018 15:24:54 -0400")
Message-ID: <xmqqo9eb9ps5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Even with keeping the order this can be done in a single linear pass.
> See filter_string_list() for an example.

Heh, I just wasted a few minutes saying the same; I should have
pointed him at these two lines ;-)
