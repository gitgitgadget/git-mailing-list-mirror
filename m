Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65411F453
	for <e@80x24.org>; Fri, 28 Sep 2018 18:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeI2BIP (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 21:08:15 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41562 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeI2BIP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 21:08:15 -0400
Received: by mail-wr1-f51.google.com with SMTP id j15-v6so7383012wrt.8
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Iipf5QdAHT2TtV2/c8xF6QWUDyyIKXCTS8qkgTE7+g0=;
        b=vNVwyYoB8wt2fREzDppcwDRToqRY86mNR/di7nezT3Bi68qZWMCt81mj767ujH9mcS
         p5khmUj0soRIM/Z8yKpRVnewyqgL5YMHWkQ9e6Fj3prhfcgHsxGURwlIGnnXWdD2JBRs
         M6f5yi7+DgznT4kQSd1IBAU5hK6jL8sHQNJ0txUJQsZ68XDHdEYDuNtdotk8jE4wO8hg
         avRiQpzHiW4RkX4AIPLrHUDX2LpHYeKZIl1rd9cs2vojZy1iAQTmBb/lSvqOv5eHCFMH
         FdK5AHedsEIFxb78bIM/KHVu2m5B5FGqZ139lCP7sasxY3ibu130OGf+N16iZIy1WB6l
         BM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Iipf5QdAHT2TtV2/c8xF6QWUDyyIKXCTS8qkgTE7+g0=;
        b=Dwqqy26ABDNZ8276mzdtLFJDUB3IHE15rSUuGgaGBsK0h26mgHlEP9YYgwLv0c9x0D
         hynhx6Rr9vuU0AMuFZnMe9rH/38jhVIJiKwdEvppDNm22Mfx3KigQmM46KFlSih8xZ4w
         rmysFOReYUlrSNs6iAkn9w3Z7PBZdRm/+cnDvZor0QaqO3Qm++p42l7Dp8E0PToCbURM
         FVQwB8E1s9GMKWlYY3rwL3Sn5GK+Qgz895WqW8xiigQVkEDX2GdYmJN+fRhDaxatwLh9
         CVo4+rG8HOdxgxIIncTQrZ4mKkEfbH69v/3RBYJ8bRKvCH2En0OfcCoJy0ta4Hkp8o3R
         TmWA==
X-Gm-Message-State: ABuFfojxpjcLiJDw3j9BmuBQ8b0pjqLv9hup4DU9TQhOUEUC+gnvXXWa
        DamQCPsLPeV1TfQaILglWIg=
X-Google-Smtp-Source: ACcGV60TwSfhm+olrJX8IS2i0c8Pjfi7OUKfkJm1KLKZj1O+rTYVbsgKhtEexmB4a/1/qs5EOfcvmQ==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr4828625wrx.315.1538160188408;
        Fri, 28 Sep 2018 11:43:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 62-v6sm7767203wra.48.2018.09.28.11.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 11:43:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jrnieder\@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v3 3/5] fsmonitor: update GIT_TEST_FSMONITOR support
References: <20180914143708.63024-1-benpeart@microsoft.com>
        <20180918232916.57736-1-benpeart@microsoft.com>
        <20180918232916.57736-4-benpeart@microsoft.com>
        <20180928100143.GA23446@localhost>
        <653f4fbd-ed32-4cf8-b1bb-9cfef4f8deaa@gmail.com>
        <efe7ae90-d0c2-9223-cdab-8b6c64f818bd@gmail.com>
Date:   Fri, 28 Sep 2018 11:43:07 -0700
In-Reply-To: <efe7ae90-d0c2-9223-cdab-8b6c64f818bd@gmail.com> (Ben Peart's
        message of "Fri, 28 Sep 2018 10:27:16 -0400")
Message-ID: <xmqqzhw1bgzo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Junio, can you squash in the following patch or would you prefer I
> reroll the entire series?

Squash it to f8cd77d5 ("fsmonitor: update GIT_TEST_FSMONITOR
support", 2018-09-18) and use the two new lines in the log message?

I can do that.

Thanks.
