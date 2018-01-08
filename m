Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347BC1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 18:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755956AbeAHSpq (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 13:45:46 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:38133 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755939AbeAHSpn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 13:45:43 -0500
Received: by mail-qk0-f169.google.com with SMTP id j185so4599166qkc.5
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 10:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kUCDZpzxGjAnYMms3cSBzQmkYVhIBQvQBl6Scmon0Z8=;
        b=FsnNaOKuXFmT5jIdZwHPmFnfVQdNpfcY23ur91VemhPJX7IJw6p9ssAmG3eOGq5mYM
         hEVmcXrD6u20BSz++MzhSvzBTEAe7rdRQ6vfhctM9IR8+dUZlGyYuhrnR+tO8c0aoD1s
         DDdI+WW6cNUxsCVCqctlfD9tMGdzYKEVe91E0czpHUApUrFrSIZTsAby8VeI6qc2FbyJ
         OFzEttw09/yEuIcvPHJ2oipIsEV3XP+NV24iUOK8h+FVjz1wVc9Afp6l0rPaMJ/cwQzT
         wjSpfst/SJRWvI8RX1+eTTu3JsdSv/qqA0A54nVOcxxUOWf6BYspLn+b/PXxg6vatZZ+
         10PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kUCDZpzxGjAnYMms3cSBzQmkYVhIBQvQBl6Scmon0Z8=;
        b=aeRKlPSC2UDbgoRWGBHW7ak5yinwVLoE/uepSSONKDhDhK3rDlnN/26j+QNclPcyaZ
         v/5QueJY0EkyNlImYVlniv2tfG7UjbUioczQCHYCsLWSQx2OTrgFAROgS0g3ksrTqsrX
         s+exDIbwWt50RWiLiVDQUAVW4kvvVwt45fQIykmpaIB3+TQ2CKimJM2f/tkAtRBb+GkZ
         tIU2AINiUv+6OLm9ixCsIQZux47WRB/ApqR1gMi8ebfIxqz9kBKYIH55qpSnuI4yoF7a
         uPoGIutLDVKP851ZZ3K7GixMRkwE4lfByvnBfwu3GlVDH50Dxn82WjtI3ZRkFpYj46ja
         hBJw==
X-Gm-Message-State: AKwxytfjP/WngXd5ZGGXhyuofDukp863NZEvNe+aOpOEvSI8wmM2ZGs5
        4gu9Y+XFXOLid9j1QfS/z5gJUUf8VTSW+BYYozquEesS
X-Google-Smtp-Source: ACJfBovgCk9INbSiSGhkYa/K7d7KqDhTJrJI0kQdgFg4jgLFfgXKHFF/1doJrS7v6bE5R9alvJBBN5cvlSw87KSQSbA=
X-Received: by 10.55.19.162 with SMTP id 34mr17600753qkt.40.1515437142841;
 Mon, 08 Jan 2018 10:45:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 10:45:42 -0800 (PST)
In-Reply-To: <CAPig+cRX6uJWzPNMaMoWdjcDGQqjMUz8Z5b3Gnhg3OOgHBBWOg@mail.gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-6-kaartic.sivaraam@gmail.com> <CAPig+cRX6uJWzPNMaMoWdjcDGQqjMUz8Z5b3Gnhg3OOgHBBWOg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 10:45:42 -0800
Message-ID: <CAGZ79kaLLk-Fy+doj_SA4fQAVAvR3LmKgix1292S4Hs41VwxJA@mail.gmail.com>
Subject: Re: [PATCH 5/8] Doc/gitsubmodules: use "Git directory" consistently
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 4:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jan 6, 2018 at 1:46 PM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>> ---
>> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
>> @@ -113,7 +113,7 @@ obtain the submodule from is configured here for example.
>>  This file mainly serves as the mapping between name and path in
>> -the superproject, such that the submodule's git directory can be
>> +the superproject, such that the submodule's Git directory can be
>>  located.
>
> There are two more instances of this capitalization inconsistency
> later in the file. This patch probably ought to address all of them.

Thanks for fixing the capitalization!
