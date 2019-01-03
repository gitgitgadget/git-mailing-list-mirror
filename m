Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D80121F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 19:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfACTpS (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 14:45:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39988 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfACTpS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 14:45:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so34649114wrt.7
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 11:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Gx0IiajAs8PgJMmbg40pkuz/qR7uh7nsuqNg/KDHfO0=;
        b=s295fprGbrof3ystixv6Yqgzbja5N1SIgvVelBoDRvFNwPNM2Y5/cxAaXCkbbBzJ8J
         7T9SaafnunUXjnk2O8JTMlSoiFVRrDL13YPJ65HnSFl28XRzwW9TzIWOL0WhnK6IHbf1
         DVsjshKfMhnAu0EI48GAp6Pt+Vn8313gy9THm4A+BN1cfbyR9tzu2YjoiQH58eytnP8l
         PdjSewFIvVp3YhQ9ornDFki0QQE7oa2Tt0/ODoHunSjjufagoetADhWq+gldIA3CovUy
         N1HD5bTRbdlYtRWgnKV+53G2GMymMLu7jNlwnkLexUhJct1hT0R0+n0QVUP/NAanvb72
         3u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Gx0IiajAs8PgJMmbg40pkuz/qR7uh7nsuqNg/KDHfO0=;
        b=EMFbcL7+9XRUcxh2VdOgVhk5LVLjXBcTUkLDvdO+iRsxj27XLYiVtYZ1Ez4SJQ+H8d
         i0dzQHhGmzPDp4c+jYYMb74VAxTPszb5DlzhKk1vFYa37Dx2rWOiQS3vJvfG+N/Gw6kp
         IH83GiTYR8DIGFIQcshk+l8BYNl7X6FOmL1MB4Nz+0O5J4CX62YMxUMjtAc7ik+6G5Ew
         1uxyXYWwATcY/Q4rkDgDIcK2y3KpVDTIL0IYUMuaAsK5L2zHwxQV++rLKjFukrlCmxXR
         aOGxDx1aXHadZ0O46zS6mlVWWVIRZs7/axxRF3Dh22fLGQBBKoO9OSqtIqts3eEfmUOh
         CLSg==
X-Gm-Message-State: AJcUukcnO1+lvcCnslDJwv8SY/vd22L04lJX3BVbipsJTO6c0saoedhc
        rGoIa2HsGTnDbNJOrVNoSU4=
X-Google-Smtp-Source: ALg8bN6JV6suTOyvTN+ayeLIU4OsvuJlxs4bc+y20MtN6wHc38NXiaHJn6qmhG7XvTTPDeT4S1y32A==
X-Received: by 2002:adf:b783:: with SMTP id s3mr44363489wre.274.1546544716141;
        Thu, 03 Jan 2019 11:45:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 10sm45554504wmy.40.2019.01.03.11.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 11:45:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4 2/4] config.mak.uname: support for modern HPE NonStop config.
References: <20181228200243.19728-1-randall.s.becker@rogers.com>
Date:   Thu, 03 Jan 2019 11:45:14 -0800
In-Reply-To: <20181228200243.19728-1-randall.s.becker@rogers.com> (randall
        s. becker's message of "Fri, 28 Dec 2018 15:02:43 -0500")
Message-ID: <xmqqimz5h6et.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> @@ -470,8 +489,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	NO_MKDTEMP = YesPlease
>  	# Currently libiconv-1.9.1.
>  	OLD_ICONV = UnfortunatelyYes
> -	NO_REGEX = YesPlease
> +	NO_REGEX=NeedsStartEnd
>  	NO_PTHREADS = UnfortunatelyYes
>
>  	# Not detected (nor checked for) by './configure'.
>  	# We don't have SA_RESTART on NonStop, unfortunalety.

The hunk header claims that the preimage has 8 lines while the
postimage has 13 lines, adding 5 new lines in total.  But that is
not what we can see in the hunk.

It is unclear to me if the numbers on the hunk header are bogus, or
the patch text was truncated, so I cannot use these two patches with
confidence.  The first hunk had the same issue, and 1/4 too.

I do not see v4 3/4 and v4 4/4, either.  It's not like you are the
only person who sends patches to the mailing list, and not having
the patches as responses to a cover letter for proper threading
makes it very hard to see which patches belong to the same series
and if all the necessary patches in a series have become available.
Is it possible to arrange that to happen?

Thanks.
