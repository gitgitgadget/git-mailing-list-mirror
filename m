Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C50B2035F
	for <e@80x24.org>; Tue,  8 Nov 2016 23:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbcKHXdV (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:33:21 -0500
Received: from mail-yb0-f173.google.com ([209.85.213.173]:33316 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbcKHXdU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:33:20 -0500
Received: by mail-yb0-f173.google.com with SMTP id o7so73055517ybb.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lVxwWLgz6a5AA6C1Kmzqs5SEeBGr5hMZ0+0MsZqRpwE=;
        b=0CMFCXAXA1yQog6eh2LT12657lRPFhgn7psWfOhLoFBOMk4uih3cQYgqs9mJNdrME5
         6ZXQsVHSpdWMRyUbufB0G11g2kgTMXezzQn1im+9cegA4FdsIa3cxaHMdnxyo+1L4jCy
         spdvlYGHAVN4NCjc5o34rguPrmy87z9KyE5zqmEyvIxeRacK5i7twHAk97VDXUKa2d7W
         deFrHCMJXdr1dG5qFYd58rgMaPIHA5z+xALc6dqLYLxw4ufzE3zCZ7RFLmrphzlxf5z2
         UZp2bDswpIcTKvrl99oQXvNdT+5xAIaPWR0XIzV+D40C5zTF5lDj0ddXq3AzYQQsx6MN
         DTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lVxwWLgz6a5AA6C1Kmzqs5SEeBGr5hMZ0+0MsZqRpwE=;
        b=FmD1U6JMhJJAIkA7lbRZf560xLIcOBVb/DQsY4twChsOviKHUlEkoEEYPzXPiSN9IC
         dIvramKY9Y598KoOfOf2Gi1cBupgiMCANWQ1InHIUqyhzAiLE5fLU2vSrISD3kz59otS
         UQup2wHbFGP+fAlTdt8zM00hQTYSipXlIo7hy7A0xHIHCp2S14uPWSpMsqF/Q5RdNIxs
         a+u4UQzyFdV0sx64qfNIfny04okxOZLwjXGYy+giHjdl0Y/eAZjChP+kERBpL6W9dqzn
         XJ72o3G1yzx0dY5VaBX0XnTp5lh/kNXZdE4a3xCNwiy0lJLlRhiE9tUf9j03hcgILZ2/
         ynEg==
X-Gm-Message-State: ABUngvd8h4U+hOGYD2rB70nM1hv8/+IMjOUn1dQ9wkh/bkASZ836sjZC1O6p8H4rOkWmTPxQ7fYV+IX5p0kJUg==
X-Received: by 10.37.79.3 with SMTP id d3mr15202934ybb.6.1478647999519; Tue,
 08 Nov 2016 15:33:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:32:59 -0800 (PST)
In-Reply-To: <20161108201211.25213-7-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-7-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:32:59 -0800
Message-ID: <CA+P7+xo=QSgBPtLaZx1e+GujjtTop7LaTwsRJ5aMD3JJ3bqBMw@mail.gmail.com>
Subject: Re: [PATCH v7 06/17] ref-filter: introduce format_ref_array_item()
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> To allow column display, we will need to first render the output in a
> string list to allow print_columns() to compute the proper size of
> each column before starting the actual output. Introduce the function
> format_ref_array_item() that does the formatting of a ref_array_item
> to an strbuf.
>

Makes sense.

Thanks,
Jake
