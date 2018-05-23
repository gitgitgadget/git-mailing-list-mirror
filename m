Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958FC1F51C
	for <e@80x24.org>; Wed, 23 May 2018 02:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753711AbeEWCFO (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 22:05:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34577 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753629AbeEWCFN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 22:05:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id j1-v6so12522515wrm.1
        for <git@vger.kernel.org>; Tue, 22 May 2018 19:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RvyC5dNPjg5RRKNmAuKLl24dPhSD6kr1kouRKjM6BN4=;
        b=hwHN/41s1/FTj9z1anlOjGpwvjEyV+s3uK5xNaFVS5pxv+a5IkGiY9RP9a0VPf2qxb
         g47/JM1BAE1GZH4me1mTc6UUQf3IAe/oJYhSCoYdrDeLBdRFibY5V2jaGGR7Xj8L01C7
         LUlhYSQ67tPyQP+soW2ZrL1PkveyXFLEMcOsGJcOddBHwDDCWgVXvz0eCzpKW/ITOrqN
         xDNFUwq3gGnO1uZBPO/JFBGUSJI5DQS1N1+jd2fR5kaqODwWF+CM/AaNS2A2Ksg3DtTT
         jpsKe9wXpK+Lg9ad4VskeVNuWODjNFdYP28p/vzqg5BHdnuCanu1rkflmebghPw3IG80
         xnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RvyC5dNPjg5RRKNmAuKLl24dPhSD6kr1kouRKjM6BN4=;
        b=MwPZ1+towfPZW5lh8rTm0dQdNn8eICVIW1TIlrDYPlvCMKCgVds3sHNq9AGu74dTn5
         sOgh7Z7pj3JiwIEyvt3ucP2d4ibO1U4XzrqIxkLXG3G0RLqLRJ+0DQpDIUIIeyBPooCb
         mPqQcH42aTyfak2IbcDLOG2JI6i7MLFJuOLsaWEKoPBy91cxA530fwfXkm0ZjouQ855+
         hQwdk5GFuliaBWp36VN77hzOyzCFbnvtYAjCreP/T2jJXobvRawRom2qOG73AjXkJ/sG
         Tz0xGZIayaa0qB+ugkW1qcEUoOlONukuuXnXm/hOdUsF3YLnscbmn3+5E+aD3vXdbX75
         iZdA==
X-Gm-Message-State: ALKqPwfj8bZeKG49Wt4FsSlCkNyP4NTvC6GEUnkAwrukw0Kx9TgacWPO
        QLSdK07HaTxRfbLIi1BoUwBf/Xe/
X-Google-Smtp-Source: AB8JxZr52c45Wv2e+RoCtE4SD3oyHGNvo+xW0bqP0ZkcjJiPvnNOCodULgMcSd6jHX8DDGAcMZ7A8Q==
X-Received: by 2002:adf:b839:: with SMTP id h54-v6mr562553wrf.141.1527041112112;
        Tue, 22 May 2018 19:05:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 141-v6sm2192528wmf.35.2018.05.22.19.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 19:05:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Subject: Re: [PATCH 1/1] git-p4: unshelve: use action==add instead of rev==none
References: <20180522084109.29787-1-luke@diamand.org>
        <20180522084109.29787-2-luke@diamand.org>
        <CAM0VKjkdGByfTtj5cunUzqeneu4Bi8Qw4vj428zV1h3ezHXyQg@mail.gmail.com>
        <CAE5ih79_Ai8F48zFpJ09e8saGrySoiyVdsgkk8ZpRrQAd15a4g@mail.gmail.com>
Date:   Wed, 23 May 2018 11:05:10 +0900
In-Reply-To: <CAE5ih79_Ai8F48zFpJ09e8saGrySoiyVdsgkk8ZpRrQAd15a4g@mail.gmail.com>
        (Luke Diamand's message of "Tue, 22 May 2018 14:02:31 +0100")
Message-ID: <xmqqk1rvw2i1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

>> However, instead of a separate patch, wouldn't it be better to squash
>> it into the previous one?  So 'make test' would succeed on every
>> commit even with a newer p4 version.
>
> Junio?
>
> I can squash together the original commit and the two fixes if that
> would be better?

Among the three hunks in this fix-up patch, the first two are
strictly fixing what you had in the previous patch, so it make sense
to fix them at the source by squashing.

The last one (i.e. "even if it is verbose, if fileSize is not
reported, do not write the verbose output") does not look like it is
limited to the unshelve feature, so it might, even though it is a
one-liner, deserve to be a separate preparatory patch if you want.
But I do not feel strongly about either way.

Thanks.
