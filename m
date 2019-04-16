Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B67220248
	for <e@80x24.org>; Tue, 16 Apr 2019 04:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfDPEMH (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 00:12:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40863 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfDPEMG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 00:12:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so23370588wmi.5
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 21:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V+fZw9tJbNRNPRMSWBnI9pAbgpW2/6KuPrudoLmg9Ig=;
        b=P8RkJ9W+ZcDSL9ouhAV5xSJtEff6rz7bDoqIRXIa8b5W+uQbWo4lY94CCj8Lwp8P9e
         vWfaGPtmaYJYVYBJyy6vsf17oOHyEF003w4qkcVDE+bAb8STPXvp4L6GkQrrQsTjEXGM
         kes+NAOcINMXLcDqM8dHf8qhKOGt+tEE2eN0389sAHLCGECty2u3GBvUXjz01VYVzFmP
         OpdgpD5qetrqwLark3FKzOU5OOljv938ymIwEgX4TSz3N5E6fmdCFa+jZchzIgk2gIDa
         F7spq1HoCIPTo+ZpPeDaryzZr5WKx8CAi/sHGz+0YOkZUerOwR2ieeN5i7DBst2Nu55W
         LL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V+fZw9tJbNRNPRMSWBnI9pAbgpW2/6KuPrudoLmg9Ig=;
        b=HHxujO76hOEu2K9yoESYOZbhmgBpwwTSyAfZY1CTlSikE/FTmJ80CrMJSNytYD5lvx
         qJjj8ZEOtLZpO2H/nTJcwn1vwwo5Hiu2JSSHYUmhb9d5TV23ndMtPnlJ7yqrYIBerx7x
         D8c9LNvldBqUzA8SApd0UDmrIPGqR11eaFvqpaOXnsvoLZWLIAA2d+sh5OPyuTCR5QB0
         yfeHS7kLMzA1sPPTPtMQNFYJQ6GXIQz8lKXKoAlb2ihi3xd40sd6HE5zq5uroyh4OtzD
         OgJEUcU1uQ0PI1LZrxSAy1gRO7fsV+xkbav4aQJa0/IkF7y+JDXb9MxE8NQAM6aAvL1b
         ljGg==
X-Gm-Message-State: APjAAAUY5i+bMZVP4XK8MPzcIMBDAfZ+fIsvpYmeQtsU4kTe214Dk13M
        K4/wYu8FBp7KAPcorYA1h6A=
X-Google-Smtp-Source: APXvYqzSfsW9v3XaAHzpV3t6glf8Qzqkd2kC2WOIIo7ERy+i2Zh7d2fhhwIo/NaSsA/K7eJYgMH3Yw==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr23790576wmb.94.1555387924709;
        Mon, 15 Apr 2019 21:12:04 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x5sm16357479wmi.37.2019.04.15.21.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 21:12:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/7] docs: exclude documentation for commands that have been excluded
References: <pull.168.git.gitgitgadget@gmail.com>
        <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com>
        <CAPig+cTiF-9+pXnx19y0PUs3Nwek7N2cEg2r2jAPzEXPTvpxpA@mail.gmail.com>
        <xmqqpnpoufp5.fsf@gitster-ct.c.googlers.com>
        <CAPig+cQ3drZ+iE=SkSXTdHVfTxLkPTi=VTJCMJn7LKLxcpC-pQ@mail.gmail.com>
        <20190415145042.GA27540@sigill.intra.peff.net>
Date:   Tue, 16 Apr 2019 13:12:03 +0900
In-Reply-To: <20190415145042.GA27540@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 15 Apr 2019 10:50:42 -0400")
Message-ID: <xmqqwojupp0s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> What about command-line options that influence the outcome? It sounds
> like this is the same problem we have in lots of other places (like say,
> compiler flags being updated), that we solve by generating the proposed
> file output unconditionally and comparing it to what's on disk.  E.g.,
> see the way GIT-CFLAGS or GIT-BUILD-OPTIONS is generated.

;-).
