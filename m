Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE66420281
	for <e@80x24.org>; Tue, 19 Sep 2017 02:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbdISCq1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 22:46:27 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:53712 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdISCq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 22:46:27 -0400
Received: by mail-pg0-f41.google.com with SMTP id j70so1242041pgc.10
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 19:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ufLYyJMiz8qkiy6tFXF5ITx70DOWVCpCOHCqqhTZgAQ=;
        b=mv6Z1b4XnMSWmpEEc8cGa5Syz8Ka96EXyu0bxKAF7NLRXAesxsZw3twCjaeIydg2wu
         e/CM0NkCWEzxzTwmBKH8lNIK7Tq7QinAFrxR2qiuv9q1VfjeY4mnRNCUWIGlPXzAfMHw
         vMEiUXVB14RyQtsr9Nxr5J9bYmDhf6p/9/UZbuATDVDjav80FQLft6C4hcpxSoCSBcFP
         X+3+w06g7RbbYLpo1RIdUqKJM00mf0Mg6amP+u5UWg5xg8+94r+Ra/OrVVeJpfvigUuM
         BXL0lIrwINGn6oZ/gDUn2EmYKeZgGRKE7vPkDOpspS375c6PsexT1NvfRDIQPQvNB43T
         nGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ufLYyJMiz8qkiy6tFXF5ITx70DOWVCpCOHCqqhTZgAQ=;
        b=b8yz4En2YgHbrHCT6oiarB3X9L4r/b5WwZA9y0K23E0HDyJSDbQIxV+18HvaeHgGqg
         tnz7aNktS8gACN1l/CZdOK+g3Ash/Z7PtPKyRXxmyQIcbh2Kw49B36mqVSiqQ9kkSpDR
         neKRMIky/BP6xfW7dzLbEMox4UkbGpDUJeo0J7ReeLdAiq1FFRVbhuQ85sEG9dPeu22I
         15g8F8tIlEaWUj2y2NN8o5eDg7FV5+MqKUiSMvkSlbA62ImH1PB9N8R1No6zdr6+s7x7
         jv88WUli2EYB+x35tHbTmgTI0f/pBiW26RahU8MVcSqf2HU6V6pByaFy+lWchLJ8mAWV
         mVJA==
X-Gm-Message-State: AHPjjUgA0q7WhloS3JvFFYyfm/KmDY1J9JRuynDLLV4V9jnoSCHrrQ3U
        +l6Cz3i6XSpiZA==
X-Google-Smtp-Source: AOwi7QB70J32QBCwW4vLPKvuyjV5UpCB26GO1c5wVbxRylvoj55Y5HhdTgL1emKnmcpB96gqEXTBeQ==
X-Received: by 10.98.24.69 with SMTP id 66mr576236pfy.296.1505789186432;
        Mon, 18 Sep 2017 19:46:26 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:288c:7217:eb8c:bacc])
        by smtp.gmail.com with ESMTPSA id w2sm867428pgp.37.2017.09.18.19.46.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 19:46:25 -0700 (PDT)
Date:   Mon, 18 Sep 2017 19:46:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] read_info_alternates: warn on non-trivial errors
Message-ID: <20170919024623.GD175206@aiede.mtv.corp.google.com>
References: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
 <20170918155519.llmetd2ylebzokrl@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918155519.llmetd2ylebzokrl@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> When we fail to open $GIT_DIR/info/alternates, we silently
> assume there are no alternates. This is the right thing to
> do for ENOENT, but not for other errors.
>
> A hard error is probably overkill here. If we fail to read
> an alternates file then either we'll complete our operation
> anyway, or we'll fail to find some needed object. Either
> way, a warning is good idea. And we already have a helper
> function to handle this pattern; let's just call
> warn_on_fopen_error().

I think I prefer a hard error.  What kind of cases are you imagining
where it would be better to warn?

E.g. for EIO, erroring out so that the user can try again seems better
than hoping that the application will be able to cope with the more
subtle error that comes from discovering some objects are missing.

For EACCES, I can see how it makes sense to warn and move on, but no
other errors like that are occuring to me.

Thoughts?

Thanks,
Jonathan

> Note that technically the errno from strbuf_read_file()
> might be from a read() error, not open(). But since read()
> would never return ENOENT or ENOTDIR, and since it produces
> a generic "unable to access" error, it's suitable for
> handling errors from either.
