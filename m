Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37AA3207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954705AbdDYVEX (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:04:23 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34717 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954682AbdDYVET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:04:19 -0400
Received: by mail-pg0-f45.google.com with SMTP id v1so22220678pgv.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6Hr+Ve87r4ZZSX2J1QwgD8nQdDDKZyKvCEYMUO8BuHU=;
        b=dz1tCS5ksW6pIg/KYY//aaUUHhs/0Mbl0iko1wG+Nr9w1E83P19xg6FVQsSr8ZIxvr
         JrSrwZe9oudcp4kNYVnX3dF8UJ3763bQgzozpASyqA1N5tXuHAM1PvKTQOLQXZ4cSGf6
         lzxLcWptLbbBi/EJ+kgVIFzdInkVF/Ui8w/SVhRBPPZGEjSCG+1IXsfJ3C/CWaaM8L2C
         thtP1p6zSTJCyQ7csVeyWkStcaPlzzfWZ2hVHNexy/W8VeLSQa1d8+2Yo0Hgaj/IgrQ7
         oRX/UNZxgIqM8R8AUeP85cnDTtK02hTQVPhI1Ykrs7sdAwsqaBfPImSEGEgkjPTu8nxl
         E0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6Hr+Ve87r4ZZSX2J1QwgD8nQdDDKZyKvCEYMUO8BuHU=;
        b=f074jepjYKWUd8GukyNRJFUz4oZ/AUnaD8fwFE96RpeZO9ioDWyXTI4FNIyXif2zlL
         lqa91iRq3R+3gRAYaUQFqriUh8+FE1YUe71p+qBA9RfAqAPJUoGtjhhCjQP4/YtbF4cB
         sr5WYTNOfcnQEaLkeW7LcdyGIshZ5DgqrueTn9k5p3QFDPyG+rNLjPa1xwt/HIHGjAoo
         Xw8FStS3gFgFiWKaB8ne5ySqqNwuv5S7cpi4HlacCkGtcvE+Y4H2dDPpfGKNYv6tffgl
         hIq1JAXRJtzV6mbYjpV0fkxnp9EBq71rMfLn6RBaoa4DWZapE7G//Rm1fFSz7i1xHwTl
         47IQ==
X-Gm-Message-State: AN3rC/4dTlQheMeYiyojxjHYJFcGO8p5xCmVqVTAqhhSCwHLFc7TU3qK
        FeiSFhmUC1giUUM8kv56K190JAMCgF4L
X-Received: by 10.99.44.140 with SMTP id s134mr29547631pgs.178.1493154258359;
 Tue, 25 Apr 2017 14:04:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Tue, 25 Apr 2017 14:04:17 -0700 (PDT)
In-Reply-To: <20170425190651.8910-1-jonathantanmy@google.com>
References: <20170421220155.GA142345@google.com> <20170425190651.8910-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Apr 2017 14:04:17 -0700
Message-ID: <CAGZ79kapU5AL_iPJXCavCKAQ0Fw=pqWZS4F6Vri-Q1M1WMVs_w@mail.gmail.com>
Subject: Re: [PATCH] sequencer: require trailing NL in footers
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 12:06 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> In commit 967dfd4 ("sequencer: use trailer's trailer layout",
> 2016-11-29), sequencer was taught to use the same mechanism as
> interpret-trailers to determine the nature of the trailer of a commit
> message (referred to as the "footer" in sequencer.c). However, the
> requirement that a footer end in a newline character was inadvertently
> removed. Restore that requirement.
>
> While writing this commit, I noticed that if the "ignore_footer"
> parameter in "has_conforming_footer" is greater than the distance
> between the trailer start and sb->len, "has_conforming_footer" will
> return an unexpected result. This does not occur in practice, because
> "ignore_footer" is either zero or the return value of an invocation to
> "ignore_non_trailer", which only skips empty lines and comment lines.
> This commit contains a comment explaining this in the function's
> documentation.
>
> Reported-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>
> Thanks for the bug report. Here's a fix - I've verified this with the
> way to reproduce provided in the original e-mail, and it seems to work
> now.
>
> The commit message of the referenced commit
> (7b309aef0463340d3ad5449d1f605d14e10a4225) does not end in a newline,
> which is probably why different behavior was observed with this commit
> (as compared to others).

Thanks for the fix. :)
Do we want to test for this use case in the future?

> @@ -151,6 +151,12 @@ static const char *get_todo_path(const struct replay_opts *opts)
>   * Returns 1 for conforming footer
>   * Returns 2 when sob exists within conforming footer
>   * Returns 3 when sob exists within conforming footer as last entry
> + *
> + * A footer that does not end in a newline is considered non-conforming.
> + *
> + * ignore_footer, if not zero, should be the return value of an invocation to
> + * ignore_non_trailer. See the documentation of that function for more
> + * information.
>   */

Makes sense. Maybe s/ignore_non_trailer/ignore_non_trailer()/ which makes
it easier to recognize it as a function? I'd also drop the last
sentence as it is
implied in the previous sentence (sort of).

Thanks,
Stefan
