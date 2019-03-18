Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2602020248
	for <e@80x24.org>; Mon, 18 Mar 2019 08:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfCRIDL (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 04:03:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37771 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfCRIDK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 04:03:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so7318856pfr.4
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 01:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6ZJSXW21rtchA1lM3d6gyR6rXVlZ0EZhieLTkmo1VWM=;
        b=Om0wjUPkoJOZjM4BLxJ63LKKE+MOrZ+/jAvcFQwK8O0PedUNKfhtD6BKttV9PeIqjv
         AmFuX+BppH8UP9bXo8qld6JT9LKH9P//LYhZjZ+PEgZ7rQhOg3fMi9vkbrfPw300rlCg
         4xv137ALjlrDDrBGGJsEQ0BkfJawKu3TOeldo11n5sPHFO7QdbVwhIA558mBWMjDh2pX
         xa4FEPwumMa5UPODwOeg+2cCoYSe0hcPNU9Y6SO2B2RC+j1FYqUeZjGjvfzvqd9VE1nl
         AMIHMyYtdsIUD05jETc6zZ/JAyjiTkeefnSE0cB7MBqDy9gM+Zs4wz+3jr8c+iAApAtL
         EM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6ZJSXW21rtchA1lM3d6gyR6rXVlZ0EZhieLTkmo1VWM=;
        b=GdHZPGk5Am2YzZ1rF8dkuZDLF0I6blo9Qg4qK4Rm230JCHVXmol6VLBYw/bYwlobxD
         tsoquATdylIwZM4tpmx+VUIyy1BQ/V2Kn+lVKp8LKfJ/DwozBJIPEuO3bvja7+z6PAii
         bWQGhcs8z5Wc6IkAO40rXMNUlEZtWBySK3Em+CsWQ2785l55wkvaYADAbgVI3LUaFEM8
         lX9elBG9Cfh1PVKfV4EwUr4WuBMfzwX2euqY9udioPAj4NlPCoe8yT3P4PNYH4uDQSbK
         QsKr81s8+phYQAUAvxkcLTMJCLY2RaFQKYszmhmm49oTMACn7ymzD9Z4iEzT9Is82tcm
         MDDg==
X-Gm-Message-State: APjAAAW7kwFXqmxlmzafJhGK58GDgXaG2VaS1rBgEgA/aCy4Q6ZFD+H9
        7aer3m5hNhg6QYpJ31hjsyU=
X-Google-Smtp-Source: APXvYqzUMTAa41EpdnHW5BPtdl+7KYk8W/7+Cyzms8kdFvDb6lpKfXxwCp0jBsgxyTA7PWTa43FaCQ==
X-Received: by 2002:a17:902:aa87:: with SMTP id d7mr17943182plr.146.1552896189986;
        Mon, 18 Mar 2019 01:03:09 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id x62sm18068372pfx.117.2019.03.18.01.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 01:03:08 -0700 (PDT)
Date:   Mon, 18 Mar 2019 01:03:06 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 00/11] Fix scissors bug during conflict
Message-ID: <20190318080306.GA28784@archbookpro.localdomain>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
 <20190317130539.GA23160@szeder.dev>
 <xmqqa7hs3d0z.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa7hs3d0z.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Mar 18, 2019 at 03:35:56PM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> +	git commit ${3+"$3"} -m "$2" >act &&
> >> +	head -1 <act >tmp &&
> >> +	mv tmp act &&
> >
> > Here you could swap the order of when you write to 'act' and 'tmp',
> > and thus make the 'mv' unnecessary, like this:
> >
> >   git commit [...] >tmp &&
> >   head -1 act >tmp &&
> >   [...rest of the test...]
> >
> > Note also that 'head' (or 'sed' in later tests) can open its input
> > file on its own, there's no need to redirect its standard input.
> 
> Yup, that is better with a slight fix
> 
> 	git testing-output-from-this-command ... >tmp &&
> 	head -n 1 tmp >actual &&
> 
> to actually read from the output kept in the temporary file.
> 
> Especially I think bare -<num> is a BSDism that has been
> removed from POSIX some time ago.

You mentioned in an earlier email that,

> The intermediary file may want a name better than 'tmp', if it is to
> be left behind, but this will do for now.

so I wrote it in a way temporary files wouldn't be produced, similar to
how 'set up mod-256 conflict scenario' in t7600 does it.

Would it be better to leave the temporary files behind like how v7 of
the patches did it or should keep the mv?

Thanks,

Denton
