Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01AA01F453
	for <e@80x24.org>; Mon, 11 Feb 2019 21:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfBKVIq (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 16:08:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37556 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfBKVIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 16:08:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so708219wmg.2
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FA1BCHEiD39RB9T85SQSF8x/AG5uJpkQkJcZk9Ee5ys=;
        b=Dw7/enGecU4CXmYrcNkDvUW37llisPwlGFuRFufyKsnzYCfwiH8q1LfGCiRyMfP41I
         kM+FfJJA/sB7uksyGRXqHlO8EEGAT/VbCtcTERtX4YQsnwP6251Y7xf4KgoqUoBNUqa5
         sph+gO5klWSbaobczgeZANA6EligTjH4G3Y88NVFX0X2Ob3bjZT4//sI9Vxy9q8wLloY
         9Pgh2tpdvJljGvVVM1CguSgeWLsL8WfOMV3dM6ZGYK6Nb2BSQjCvJ2FrpkVOLKrqhgW4
         ybqQ8A4Wqf6GnrSbhfYG2rZsg/DjEKTnsyVmOnX5FiN1S4nxWl2TpwPjPCMJc57kvqYI
         rJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FA1BCHEiD39RB9T85SQSF8x/AG5uJpkQkJcZk9Ee5ys=;
        b=Uwf5KFQO3TUlR9/QTSLiJ0cUdr12GCpaMG4YPDExpKYcR+bKgbScIYmWEe5Zy2MiD9
         u4LS0vgdXHSFz5+fHoL58kBfqr51YwM5y5P7U4XbmO1xgfFrH1uzkGwemquZUU2PKsuB
         6A06BQQ8a3CT+rVrIATTrWDbCDirVMY8Ka+hKoOZ1Lz5fwEFZRn0K2u1jQ4qfOcpO7Oy
         trUkpTWt/2TOsEB9OO/pzBuZKCTs8GGRHUjRfJ3Y6TmMlXtt5DWwvpc4Sb0MnAf8Sk5O
         c+d6TjkTjPMxZhBxEvlLBdDjGs1whDFgLtBTLyOgZrdW6EIoodFwtVKIsBsN4PGPVmiw
         3MwQ==
X-Gm-Message-State: AHQUAuZQr6xof/vuwGsRzjHrB/UgPjon4ko5BnHIdmJTDD1rBBV58jGo
        IH6ptPD+HCDUw907r5XtJbd+sTXO
X-Google-Smtp-Source: AHgI3IY3x9QXqvVHfAyNgF/R+LrC9WJO5+hY/+F2aUrjoKaFnTPSSiKz9+twuq3s2rI4cUqbBoLHeg==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr120554wmj.145.1549919324752;
        Mon, 11 Feb 2019 13:08:44 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 65sm39451966wrb.62.2019.02.11.13.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 13:08:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer: make sign_off_header a file local symbol
References: <93b23b5a-7fcd-e9ec-3411-f8362b601732@ramsayjones.plus.com>
Date:   Mon, 11 Feb 2019 13:08:43 -0800
In-Reply-To: <93b23b5a-7fcd-e9ec-3411-f8362b601732@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 11 Feb 2019 17:16:58 +0000")
Message-ID: <xmqqbm3ighic.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> This has been hanging around for a while. I sent it to the list last
> time in [1], but it seems to have been dropped. (Found while attempting
> to rebase loads of old branches to a newer base!)

Thanks.  Will apply.
