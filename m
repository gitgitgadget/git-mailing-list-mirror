Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD421F453
	for <e@80x24.org>; Fri,  8 Feb 2019 04:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBHEOO (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 23:14:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46334 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBHEOO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 23:14:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so2044901wrt.13
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 20:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B5cbiNrofVroZPrNJIOCXSBDqc0UI+2PYCwo6/B8aBU=;
        b=o/YjtAsxQSUYUnwgnMn0VVk55s8dHJROqDAKHPRHWqCqzcoYPPIcTSyVsW5OgGoW6k
         V8u1sjuT7KeiXNkJ9RetY2mMbGWha4AADEIOwPuCr39M83KEJciSBzzkhnvFClzde6Iv
         FWt+lbjB3aqTK95poizZob4Qoi8P4tvEKqCDu1eCKjzC3ms1kYpX/6hymvkRVBcnd60i
         QmWW318fWIZOvdKYKsduELQhclDgQvZ2poryrkbysySPYVMq0oreaAd4CYIv8dE9v+0m
         6Usfeuicu6InazmfKGEM8my4i8RJ6Gn1mXxGpw+T4DO5WBH11m4T/O39APagn4nE45YG
         klpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B5cbiNrofVroZPrNJIOCXSBDqc0UI+2PYCwo6/B8aBU=;
        b=DvOMOUdQ+AIdjDgUWz7On3PVDcycXYX3dOJm9F4mP+SgiRsN7NXOrUYK2rn5o1E4Og
         Qdagm418W3Z62E6FgXo6fjp9i6dmYa9ZkLCJ2oscJuMXsfBn6VoEA/oXyakKl5bE8Q56
         dGaT18vkhi576/zfPMTPCmYk6x2vSiZAaXfzlm+3co+u0YZQJ0lXkWvrOBAZThJYv0Eg
         xEMOVZ+OFd0pScph+JF3o2TTGWpXI0JRSBg5kLOoSO2DplUxv7anbJRjdtuSQedbmPCO
         PAGPqo8U8nXcW/5DtVE+JePwSFBRbN5CrXome7vhZz1N81oHB2O//IUWnzZpD2lZk7jf
         o+PQ==
X-Gm-Message-State: AHQUAuaggkq/NVnotY9CTBD3dG65rGeAObXPCX8ZCl+Eu1NvV1C49ATo
        N3lHcKmPF3wgssQL/wqFhKs=
X-Google-Smtp-Source: AHgI3IZ5bZ8EFhdIdKDgMcPCrK5/oMXUx6h1LB+pmyWOgwd0BKaWvb82IKvIQSXcHRQnlGU5tjSF7A==
X-Received: by 2002:a5d:4a89:: with SMTP id o9mr6945674wrq.323.1549599252446;
        Thu, 07 Feb 2019 20:14:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a187sm1716246wmf.33.2019.02.07.20.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 20:14:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 2/2] squash! log,diff-tree: add --combined-all-paths option
References: <20190204200754.16413-1-newren@gmail.com>
        <20190208011247.21021-1-newren@gmail.com>
        <20190208011247.21021-3-newren@gmail.com>
Date:   Thu, 07 Feb 2019 20:14:11 -0800
In-Reply-To: <20190208011247.21021-3-newren@gmail.com> (Elijah Newren's
        message of "Thu, 7 Feb 2019 17:12:47 -0800")
Message-ID: <xmqq4l9ench8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +	for (i = 0; i < num_parent; i++) {
> +		switch (elem->parent[i].status) {
> +		case DIFF_STATUS_COPIED:
> +			dump_quoted_path("copy from ", "",
> +					 elem->parent[i].path.buf,
> +					 line_prefix, c_meta, c_reset);
> +			break;
> +		case DIFF_STATUS_RENAMED:
> +			dump_quoted_path("rename from ", "",
> +					 elem->parent[i].path.buf,
> +					 line_prefix, c_meta, c_reset);
> +			break;
> +		}
> +	}

The explanation for this addition was that it is hard to tell from
which side a rename happened in the three-dash lines alone:

    --- a/packages/search/ete/src/test/resources/test-suite.yml
    --- a/packages/search/src/geb/resources/test-suite.yml
    +++ b/packages/search/ete/src/test/resources/test-suite.yml

and your hope was that adding:

    rename from packages/search/src/geb/resources/test-suite.yml

would help especially when the path is overly long.

But I am not sure if that single "rename from" is all that helpful.
You cannot tell relative to which parent the rename happened without
going back to the three-dash lines.  A loop that iterates over all
parents but shows only a line for a parent that actually had copy or
rename loses "the line is talking about the change from this parent"
which is a fairly important piece of information, doesn't it?

If we attempt to clarify it by adding some more information on the
line, e.g.

    rename relative to parent #1 from packages/search/src/geb/...

the line gets even longer, and going back to look at

    --- a/packages/search/src/geb/resources/test-suite.yml

may turn out to be an easier way to learn that information.
So,... I dunno.
