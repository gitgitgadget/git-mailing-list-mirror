Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826071F404
	for <e@80x24.org>; Thu,  8 Mar 2018 17:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeCHRx0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 12:53:26 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:46030 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeCHRxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 12:53:25 -0500
Received: by mail-wr0-f179.google.com with SMTP id p104so6527551wrc.12
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 09:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N+nt7so0n0eX9eWW3v9GMcrXmwvGKqSiDCgkfs8+un8=;
        b=LJKfjrZ7u5tMKa/plQQdmwzsgoffzclua3FIf+nvpxCfCiLUzij5VVQllWyN5KdpUU
         2CriZRRqfmQn/RwjJemUat2+OZHomBQm1J1SNAfXSoOnSPytJTzjP7N/B5a1Gx+EF5I8
         xDMj31P8c3iq6ARp1dclIrfohoIUOsdiGCLdL5sK2laGxqTQXOTvevZcYPZNW/mE/AMF
         QOGKlWHIIMb4do10r1QMRp4Tfc6hBeTKsA9vipWLW4yBQQZ1q9h1sHJpZTE/VxXhTg+j
         T2Jq6GMyfgwma2FEyOLygi3caKReNWzxfQ8imYi5GkxTMfY64rokv0d/F2kARcqkMovw
         d42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=N+nt7so0n0eX9eWW3v9GMcrXmwvGKqSiDCgkfs8+un8=;
        b=dpxu9VhyGZhNxM9230q+f+UWuw/O4TXGJZ8oT7Xri3HUyF950QRgPRI4CNhr4KMclb
         TVfW4bckzIFpAcYmFITSf8p9fsFztmUGODkvbccw1LJJIAQQquwz/CKhzc1Z29H7RO5b
         WVM9rZvy/+LABYcHwJ2u8FYF7J5+xQ5pd7AEZlJ9ODBWJ066FVckoSBeSeWDcC9iNoZd
         ZwhtKHeu7rwEUGT7Xjim1gxbMitiDZVTEHXZ0JIWTX5mUqi0KCHlXfqPUFEy2uTgmu6D
         mHZwR4Gx+uQ1ZuhquyWjqoOPLYa2x4lpNp1rAuH5xM5ndxXc11YfBW3AeqZe2Hvn/Q+K
         iQsA==
X-Gm-Message-State: APf1xPAFdnxKf4qeR0XFM2ikSKqjz0CJELs4vtzb1Yi3LbYGTNjpwmlY
        guQvnCJ4JEXHLg4P3BmqHmMO3+2L
X-Google-Smtp-Source: AG47ELtIJnoNS0AiDtn3Fn5D9gav5Zv/ME/m+aNPLfnGZTkDtHTYlkcckmWozvd18tqRSfruODDLTg==
X-Received: by 10.223.161.77 with SMTP id r13mr24450013wrr.1.1520531604051;
        Thu, 08 Mar 2018 09:53:24 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w74sm112498wmd.1.2018.03.08.09.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 09:53:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Gustavo Leite <gustavoleite.ti@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/3] add -p: allow line selection to be inverted
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180306101750.18794-1-phillip.wood@talktalk.net>
        <20180306101750.18794-3-phillip.wood@talktalk.net>
        <xmqq371d3rjz.fsf@gitster-ct.c.googlers.com>
        <6476d776-dbf7-09cf-1c65-e413798b9987@talktalk.net>
Date:   Thu, 08 Mar 2018 09:53:22 -0800
In-Reply-To: <6476d776-dbf7-09cf-1c65-e413798b9987@talktalk.net> (Phillip
        Wood's message of "Thu, 8 Mar 2018 11:05:52 +0000")
Message-ID: <xmqq371axxm5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> and use a leading '-' for inversion. I'm tempted to keep supporting 'n-'
> to mean everything from 'n' to the last line though.

Thanks for double checking.  It would be a better endgame to follow
up with an update to existing "range selection" code to also support
"n-", if you go that route.

