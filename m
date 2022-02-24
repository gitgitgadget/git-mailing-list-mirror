Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB23C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 14:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiBXOxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiBXOxB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 09:53:01 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4213CEF5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:52:31 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id fc19so3909922qvb.7
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2JEoP38FoZVyh5Pba2BAMhUK4/lz/oHGiXvSlOedc98=;
        b=FO3tjr4bYrT8X/KSRhRfeLanhq+qEgYKumuXGcBUwP6HRRwpX5AyLbUHdlxXVjLokl
         hghXsoyEDOcB4coIuiuQOfxuvl6Ky3BewrOwnxb3hdaHo+2v51rBVxzQ4X7JYvEnkGwl
         HDVLjoqLkVnR5nZ4FI123ByR24uUdgtKOFtAQ9nTo6fdxfoTIMSGPzLwbbFporBcM9mx
         xet951yRRKs/qJtdlpq4wG4Z3B8/VWq5hIpo6lqFVC5wB1Y+c8NYrfhV18YOCcnyz9Ov
         kyeL8g/OityzJYQEJLTzsiQ87hCtMZXL4JEe+Vi0V8dpNPX9SkPwlGLiEgwbRvZf21qj
         CutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2JEoP38FoZVyh5Pba2BAMhUK4/lz/oHGiXvSlOedc98=;
        b=uAQiTtv4JoTGZQr2h3yrJbKorIyzhjeGAinSa+qplzm/+6YOkXvdBMcdC4ZlM3evzP
         fSzHL7aLLpp2XthIMU1cr4/kFx78b580TMUQj9mYd1sgQvFRo9YK/7MDcKIH62stNvU8
         sAPM3zc29p4Td1XCxA/uDFctsAmjTp0LOGEyXTTdb4zlJIlPAbKD28KfgDRTOe4SSr+L
         eR2apdHSsn1GVexu9MjqNVf+dZ4rMGYjwhGFT6ZQF55KeOAVQ6SnWXmPHT6AzoGYePOC
         adakoFnFiO7+ZD491gPo30fHpe7z67WUSHelbM7ZUnRCv5QgFXs/+lH01UakVcfVXYTH
         1niA==
X-Gm-Message-State: AOAM533fekeNJKsZNjXOyZROB5zV1ddRzKvik4hH4VDCCEf2vT0474KZ
        EDNQsdqkLOPTHi+OPBsdsOq7
X-Google-Smtp-Source: ABdhPJyeLFqvU5uVeJ81KOBmrql0ur5V7eOHgm0EzOLl/S/5UzPFZ/tDeJiZ3kussUqiTQ3x+jxFNg==
X-Received: by 2002:ad4:4f47:0:b0:432:bb7c:32c3 with SMTP id eu7-20020ad44f47000000b00432bb7c32c3mr123150qvb.15.1645714350678;
        Thu, 24 Feb 2022 06:52:30 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z3sm1316006qkl.13.2022.02.24.06.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:52:30 -0800 (PST)
Message-ID: <c7ee2394-cda0-a997-3b9d-fb8c3d65b312@github.com>
Date:   Thu, 24 Feb 2022 09:52:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 02/23] t7527: test FS event reporing on macOS WRT case and
 Unicode
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <ad8cf6d9a47b61d9fe41a961466122be16e4f041.1644940773.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ad8cf6d9a47b61d9fe41a961466122be16e4f041.1644940773.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Confirm that macOS FS events are reported with a normalized spelling.
> 
> APFS (and/or HFS+) is case-insensitive.  This means that case-independent
> lookups ( [ -d .git ] and [ -d .GIT ] ) should both succeed.  But that
> doesn't tell us how FS events are reported if we try "rm -rf .git" versus
> "rm -rf .GIT".  Are the events reported using the on-disk spelling of the
> pathname or in the spelling used by the command.

Was this last sentence supposed to be a question?
 
> NEEDSWORK: I was only able to test case.  It would be nice to add tests

"I was only able test the APFS case."?

> that use different Unicode spellings/normalizations and understand the
> differences between APFS and HFS+ in this area.  We should confirm that
> the spelling of the workdir paths that the daemon sends to clients are
> always properly normalized.

Are there any macOS experts out there who can help us find the answers
to these questions?

> +# Confirm that MacOS hides all of the Unicode normalization and/or
> +# case folding from the FS events.  That is, are the pathnames in the
> +# FS events reported using the spelling on the disk or in the spelling
> +# used by the other process.
> +#
> +# Note that we assume that the filesystem is set to case insensitive.
> +#
> +# NEEDSWORK: APFS handles Unicode and Unicode normalization
> +# differently than HFS+.  I only have an APFS partition, so
> +# more testing here would be helpful.
> +#
> +
> +# Rename .git using alternate spelling and confirm that the daemon
> +# sees the event using the correct spelling and shutdown.
> +test_expect_success UTF8_NFD_TO_NFC 'MacOS event spelling (rename .GIT)' '
> +	test_when_finished "stop_daemon_delete_repo test_apfs" &&
> +
> +	git init test_apfs &&
> +	start_daemon test_apfs &&
> +
> +	test_path_is_dir test_apfs/.git &&
> +	test_path_is_dir test_apfs/.GIT &&
> +
> +	mv test_apfs/.GIT test_apfs/.FOO &&
> +	sleep 1 &&

This sleep is unfortunate. Do we really need it? Or does this test
become flaky without it?

> +	mv test_apfs/.FOO test_apfs/.git &&
> +
> +	test_must_fail git -C test_apfs fsmonitor--daemon status
> +'
> +

This test is helpful in that it will help us discover if HFS+ or
any future filesystem would break these assumptions.

Thanks,
-Stolee
