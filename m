Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6343A1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 16:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406111AbfJPQrN (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 12:47:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33079 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404582AbfJPQrN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 12:47:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so28894653wrs.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rZIlXpg81sDQFvOeN2JbTnMK3E2SoKV+lkYiX6K36MA=;
        b=W0WrPDMBg628x3RDa8mnRyeSgkPwV5tHFZkC5nUpaCWY2ud+HWklpum5zn6IbELuJL
         CZPAgZquO3/72tuItJFIJqk5fs5T21EOHD1fO584jiZyRm/GXp3bdANsKvQl21yenHbB
         aRykmalNT2mJW2uVgU/RBJWQ1jpwTxevNjjMz9ic0MRVqeR/Q/pbqdn0pt65NjJGKkjN
         7rW+P1A43d7WVMxBmsAytJFciqbf2RVDAwjp6S5Mmb12vKstTzrOGNpX99qC+W8pJlvG
         EHKrkCVAHA+93twXSCJVzaLaHAQHxzbArnmrRm1wLq/mmxk9NsmtOpACnhYo7xv51x46
         aB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rZIlXpg81sDQFvOeN2JbTnMK3E2SoKV+lkYiX6K36MA=;
        b=Pbnm4HC4X6eQeEHKNSYzb3jT75U0eXLJUSDA+o5U+wYCxdkskBXGt5OpImh738cHoC
         EWKkk8AxnO6CKdOKnXVpLyAThfTQ0r1z5L/WLL2CFeVYGt+6jRkjrV/JE+E0JGvHolkO
         F+yQyzZhdDACE1eNPAyg6MBKl25oEjlvWU1pCD6RCI+pV0lMB0ib+aka3KKqwAvWH8s6
         DzgE/gNyNDk9AtYRq8LT3qQNdDr3d4TgQcWPIQttoF/w2pTJc5wWWLKdTmaZRmG4LdcX
         ZnQv4Npd30pj+sXdYvlvl93Qw1J3X58dT+XdPAmGHIyp+2Gis4PvsxhtaCKugNVgC6lJ
         mT3A==
X-Gm-Message-State: APjAAAWdMlVCrWsDDqXSabajjUgaJQygk9MlN5igHKYRPQRVomkKYExz
        GYeZ/PIFWHqC+Kd/i6OAegm/YUXu
X-Google-Smtp-Source: APXvYqz2N6iBvBKBmB7oTrBfZRinixWIu1bA6spqdJVlIsxnmVnP8PuEICa8K39g7s0pFmCYPo6HgA==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr3716999wrw.318.1571244430756;
        Wed, 16 Oct 2019 09:47:10 -0700 (PDT)
Received: from szeder.dev (x4d0c5ad0.dyn.telefonica.de. [77.12.90.208])
        by smtp.gmail.com with ESMTPSA id a204sm4133785wmh.21.2019.10.16.09.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 09:47:10 -0700 (PDT)
Date:   Wed, 16 Oct 2019 18:47:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>
Subject: Re: [RFC PATCH v1] t/README: the test repo does not have global or
 system configs
Message-ID: <20191016164707.GW29845@szeder.dev>
References: <20191016124515.1807-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016124515.1807-1-philipoakley@iee.email>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 16, 2019 at 01:45:15PM +0100, Philip Oakley wrote:
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
> 
> While tring to get to grips with some Git-for-Windows config settings
> for testing >4GiB files, I couldn't find any note in the readme about
> the test system config file sources. 

The path of the system config file is determined at compile time, with
no way to override it at runtime.  Since we don't want external config
files influencing our tests, the only choice we have is to ignore the
system config file; that's why our test framework sets
GIT_CONFIG_NOSYSTEM=1.

> Is this the right place for the information, is it complete enough,
> and is the default config template special?
> 
>  t/README | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/t/README b/t/README
> index 60d5b77bcc..3daa1fa182 100644
> --- a/t/README
> +++ b/t/README
> @@ -485,6 +485,9 @@ This test harness library does the following things:
>     the --root option documented above, and a '.stress-<N>' suffix
>     appended by the --stress option.
>  
> + - The --global and --system config files are ignored, and
> +   a basic --local config is created in the tst repository.

s/tst/test/

However, note that the global config file isn't really ignored, but
different.  The path of the global config file depends on the values
of the env variables $XDG_CONFIG_HOME and $HOME, and, again, to avoid
external influences, our test framework unsets the former, and
overrides the latter with HOME="$TRASH_DIRECTORY".  IOW the global
config file in our tests is '.../t/trash directory.t1234-foo/.gitconfig'.

> +
>   - Defines standard test helper functions for your scripts to
>     use.  These functions are designed to make all scripts behave
>     consistently when command line arguments --verbose (or -v),
> -- 
> 2.23.0.windows.1.21.g947f504ebe8.dirty
> 
