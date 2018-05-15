Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4229B1F42D
	for <e@80x24.org>; Tue, 15 May 2018 08:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeEOIRt (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 04:17:49 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38964 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeEOIRr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 04:17:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id q3-v6so14973283wrj.6
        for <git@vger.kernel.org>; Tue, 15 May 2018 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+t5TEG3Cv28zBzy25xc/yBRyX7YuLMyQmCK6/nlX2pg=;
        b=CAp+HIH32Ik2yTdTA1nEaSsviAYK1Rkkm1rLJ6JNJcXS8xNm4GQWRGfYkedfH69R9W
         g5WlyU+/KLRVEMfUs5IZcv/2RQnDPi82zpmyzQn2SqsyTKwfNC7BsJ4oZLJl9/j56npb
         oG8v/cqK7o06VPXUWU7GD8k3Ci/yEpBKORrPRSha4PA70ue/GTWg3TS1HZT32dLxCj3G
         Bvw3RgUK4BdWvZgfIH+sbtNTwsZUTM2VEDQyXzAR23ejStuxsJ07bFAnfXO92lvXRFJM
         67lC7Rkvv2rU0dAaajhkjiXL+37eESJdynvpTCXED4HOyuXYl9/Szp8KhO25VkQnpOVj
         MhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+t5TEG3Cv28zBzy25xc/yBRyX7YuLMyQmCK6/nlX2pg=;
        b=a3TXUItoUCkLNeOQgmnHykXJERB+SNY6Qkw63WoxP4wklTdF/TwKpSyBzJ9+iLQ5+s
         vfurwTnemO8xU9JdPRSV8CI5CBQ4ExoCgEz/vqCMLKdC6tH08MR2VghDpS10wkDB+Pxb
         yV7lZPYLjtcoh0M6TByzBQNUlCRVK/S8x1baMKL4HMxom9Y1U3Y818gNfokc26tZwn9s
         8jtzdGl+sYwpgzyApOm8p2eNn8ypUcvf0qbgrUDeitChys7ICe8jQWiGEUHTOb2MgthW
         PHJr/8s2A1c6W0K9b6Kzp2kPCtYzSr6dZSQk6283JT/OaBwl/U+N9VBDx0uxZxfSEH2v
         rK/A==
X-Gm-Message-State: ALKqPwdYHIoES8ZEADszYXV4PVtx03V1zujscpgUKyMyYzFypzFWwgsm
        giDeOeyha3tkWH3hT8bNxBC/rY6R
X-Google-Smtp-Source: AB8JxZq7z+I59RUpGHv9t01HWQwupsRqWs1m6yutMuBWQMh7ZZIdQ1+ouISHmDxWYS2e7Z8osI99Zw==
X-Received: by 2002:adf:a075:: with SMTP id l50-v6mr10394385wrl.227.1526372266410;
        Tue, 15 May 2018 01:17:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f10-v6sm9988905wmc.0.2018.05.15.01.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 01:17:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/35] refspec: rename struct refspec to struct refspec_item
References: <20180514215626.164960-1-bmwill@google.com>
        <20180514215626.164960-4-bmwill@google.com>
Date:   Tue, 15 May 2018 17:17:45 +0900
In-Reply-To: <20180514215626.164960-4-bmwill@google.com> (Brandon Williams's
        message of "Mon, 14 May 2018 14:55:54 -0700")
Message-ID: <xmqqlgcl8h92.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> In preperation for introducing an abstraction around a collection of
> refspecs (much like how a 'struct pathspec' is a collection of 'struct
> pathspec_item's) rename the existing 'struct refspec' to 'struct
> refspec_item'.

Makes sense.

>  /* See TAG_REFSPEC for the string version */
> -const struct refspec *tag_refspec = &s_tag_refspec;
> +const struct refspec_item *tag_refspec = &s_tag_refspec;
>  
>  /*
>   * Parses 'refspec' and populates 'rs'.  returns 1 if successful and 0 if the
>   * refspec is invalid.
>   */
> -static int parse_refspec(struct refspec *rs, const char *refspec, int fetch)
> +static int parse_refspec(struct refspec_item *rs, const char *refspec, int fetch)

The new comment given to the function in the previous step talks
in terms of the variable name and not type, so technically it is
still valid after this change without updating.

I however wonder if it makes more sense to go one step further and
rename the "const char *" variable that is a string form of a single
refspec item to something other than "refspec".  Which would
invalidate the commit you gave to the function and make it necessary
to be updated in this step.

I wonder if the early part of the series becomes easier to read if
patches 2 and 3 are swapped.  That may result in less code/comment
churn.
