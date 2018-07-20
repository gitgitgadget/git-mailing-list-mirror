Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1A11F597
	for <e@80x24.org>; Fri, 20 Jul 2018 18:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbeGTTLd (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 15:11:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46532 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388089AbeGTTLc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 15:11:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id s11-v6so12077259wra.13
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xY7kLqBwIdhwXnrSblDAmReF1CmezqfK/AAS/W95CeE=;
        b=AEpUVtYQYnFY89X/agmMcq4SAkWgFAQEXbZeuvRUpq8GAXBCQ5RTPoFvaxIlNEg9fl
         z3WRBRe3jTfq70IgtSZakeshr4Wz/rcfoDi2aD1bb1lFcUdOy1bE7l86H6fhwcoOSDtF
         iPNJC2FG08noY6r3g5Na4z8YIEbg3Oaut1diaZGjugETnQ1n0TJ4dAUKAQgaepkNsGDT
         PgbsBpyZrkcGMKHBbF7hZUBcaZD5UIlod7h5PbNwHrWfzcs3pNEaUksNbTMh0l8qS2GB
         +RE2P0khFRyyecfRRriJbJUBwAUObxQonIE1SKA2r+UbMCPpZ3Q6BueieCOmX/AUSs0v
         sdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xY7kLqBwIdhwXnrSblDAmReF1CmezqfK/AAS/W95CeE=;
        b=HiinS3uDwA00wBH2UzCxbFIcvjh4xivrHjhUUKTc9eu0RgYYgrCijY/2GTF1x6lLgz
         7NKQXfxDiu7+gLljWo/PNrj/aEWKOLnP1jj+hFoIV/I7CdiFUGlpOztXbu//za8kOhJn
         H9lINwSHqNWcnSsZKSuysRCJJrYWry83vFFuM/yYZ1uCtLq3ci/qwVcpZmJExxjH/mv2
         1VmsreED6v5F4irowUx05CKBpVusHaeOhD9iL+7FVq/tKaMdC3n8sqv/CzPafmUzlNRs
         gGUSUUOIsZVUtj1twxCjW8RKAQFHVmDrLiXjnuutkO2OZ6mDWFfQ/ix/k0ULcjYY6e1y
         03eA==
X-Gm-Message-State: AOUpUlGS8JUuRd+w1dBqIGhuCt0wJHcecaqsI8nntJygiGOCBhMOY6n4
        bKBf/tjeka0vSt27/BaxhM2wZDnO
X-Google-Smtp-Source: AAOMgpdARLTo7EVb+W9ybxMwVOaGrv4pEYoyRF6erAYzhlyhknozFVSXlVKtC7Xyg3T7Gm5tghlqdg==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr2230812wra.120.1532110924558;
        Fri, 20 Jul 2018 11:22:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 31-v6sm4220354wra.26.2018.07.20.11.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 11:22:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, sbeller@google.com,
        pclouds@gmail.com, avarab@gmail.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 03/23] multi-pack-index: add builtin
References: <20180706005321.124643-1-dstolee@microsoft.com>
        <20180712193940.21065-1-dstolee@microsoft.com>
        <20180712193940.21065-4-dstolee@microsoft.com>
Date:   Fri, 20 Jul 2018 11:22:03 -0700
In-Reply-To: <20180712193940.21065-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 12 Jul 2018 15:39:20 -0400")
Message-ID: <xmqqva99bwdw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> new file mode 100644
> index 0000000000..ec9982cbfc
> --- /dev/null
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -0,0 +1,36 @@
> +git-multi-pack-index(1)
> +======================

Isn't this underline too short by one column?  My copy of AsciiDoc
seems to be OK with it, but do other versions and reimplementations
groke this fine?
