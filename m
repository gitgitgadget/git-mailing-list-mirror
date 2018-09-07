Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770CB1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 09:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeIGOdq (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 10:33:46 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:46305 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeIGOdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 10:33:46 -0400
Received: by mail-wr1-f50.google.com with SMTP id a108-v6so14274780wrc.13
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8VUOJl57QeYsweaHz0Kplkn2/srQFvO8624ou+o0poE=;
        b=KC26Qyi3elEqU7/h/cGwkpUz6wZshe6UXr6YnxGf9aPTOgszcIdP4VB4E6XVg+IIcs
         At2Kr1q5t1Pd+v9HsBkBfaUVuD3qlXE5aHdZ0cB3hErXIozp3aA42stm9T9Zlu0I1Y3N
         y0cpR3O5BVxUzclfSuUEixZSKXlTrTo7X1Y9onkBEHHQp4dN8FH9oBI8Ur6Cy1f+W8Ag
         zOk9TjQxbM5cO4GpFcUyEiMfqBXQvLq0oWsld26V8iSwJRkEY7zMf6UwIg1U4bo0is3u
         uL6Ei1I9hQRqTqUlLfIu3MztOgg3SrYjKxI1H3mO9O38/sFMBWIcujMRMOyVE5wZsDvN
         lEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8VUOJl57QeYsweaHz0Kplkn2/srQFvO8624ou+o0poE=;
        b=a7K209fgQbh/3Yv9hwO6NFh0jVGKHObG6IcCOt6oYqKL8Z4I1Umr3Dl960v+CqUbJb
         v7+nU+rzP0hCzyJnCtwCTNZH1Xi0SoeEsbhGEs9ghIh4EFCMYxpVnanLQVr7ZcpwwQft
         Zhjqtdzv2bN+o2YbRPqw5XrETUGMBH3/p8EK0TNR0vtb+ImbFihqQCfpHJjmhDc07aLJ
         beceMw4C4++Bcg+FZ0WB0WnHd1XEbp1zp4TnEhoeGocxbOK+GaN1zFS3tpruHjpE1i7R
         JO4UdYjlCY3rIVaJtEWPOpfdk464PcYnsyKdFj/HF8/MtMoL2p7sdNIVa9RiVpACze9C
         +5eA==
X-Gm-Message-State: APzg51BE7QqlDh6qVT9urMj8F+MG0kSSUpWzQfE7HBRhBYBk2N9vQ3+K
        Lw/3/+8Ey+HEnSq24Bi8uQLAKbv1
X-Google-Smtp-Source: ANB0VdZOGLqCUzNkDHB/5fxT3vTmkMlZf3M4TGwxMC6+EFk+F3wix2EB0rSeIiAXdnRKDxfU0myNIQ==
X-Received: by 2002:adf:8205:: with SMTP id 5-v6mr5383064wrb.160.1536314014985;
        Fri, 07 Sep 2018 02:53:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v133-v6sm10113332wma.36.2018.09.07.02.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 02:53:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 01/11] string_list: print_string_list to use trace_printf
References: <20180904230149.180332-1-sbeller@google.com>
        <20180904230149.180332-2-sbeller@google.com>
        <xmqqh8j236wj.fsf@gitster-ct.c.googlers.com>
        <20180906165602.GA19367@sigill.intra.peff.net>
        <CAGZ79kbRyVZ_1QpX0pPigN+2Pt2dV1eYvLyoWeSWejbLxko4YQ@mail.gmail.com>
        <20180907000423.GA16764@sigill.intra.peff.net>
Date:   Fri, 07 Sep 2018 02:53:33 -0700
In-Reply-To: <20180907000423.GA16764@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 6 Sep 2018 20:04:24 -0400")
Message-ID: <xmqqo9d9y6oy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I guess the question is: is this a thing we would want to make available
> to code to leave in all the time? Or is it just for sticking in
> temporarily for a quick dump?
>
> If the former, then I think it needs the early-return at the least (and
> probably _should_ have the key parameter).
>
> But I get the feeling that you really just want the latter, and are only
> grudgingly being pushed into the former by Junio's suggestion.

Well, if that is the case, I'd change "my suggestion" (although I
didn't mean to suggest anything concrete).  If this was needed
and/or was useful only during the defvelopment of the remainder of
the series, and if this is known to be a half-hearted change that is
not meant to be useful as a general solution, then let's not take
the main part of the series a hostage to this step; rather, we
should drop this change and leave it to another series that is
willing to do it right.  It would save both author's and reviewers'
time if we did so.

