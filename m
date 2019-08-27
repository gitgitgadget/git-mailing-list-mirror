Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE7D1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 18:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfH0Soh (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 14:44:37 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:35859 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbfH0Sog (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 14:44:36 -0400
Received: by mail-qt1-f177.google.com with SMTP id z4so79704qtc.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hIXlNs9hDcgdTj+f8Gx5VSr2OSaXL94fsaJaS0rT+SI=;
        b=QAc8u0Lzao3Z8QK1ie3fxlX7IiK8j+qnZuuU4ncoi6jx+tY2fiUstXG4P5CwZ8iIOV
         LkTjzEONV+jHjktPrjWw3jk/4c4+d5XxdYd8UuK3fY3GTRyCS4lD7VqtbGOBSybwgASA
         hZdvrmuGKrYW7vUYrZoSh4lGFpkEd+7flN+BWPIsET/DA5OAP2XDGyWtlx/iuPvHaHP7
         DcNXB85LM6YE2kZ97WR/2iyVVZYYjGRI65ndF+JS6GzuNldzb7v2fAMspHNFzK5KuN3E
         rwiGyH3qMnjNFRNqL3A1tiID2pp323Fs41VIRxfmU6oCDLdasoaEaEM2qlYvjWtIFENl
         7wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hIXlNs9hDcgdTj+f8Gx5VSr2OSaXL94fsaJaS0rT+SI=;
        b=BoNkgTFCZAfbXBPujHmhxHzqfhzz7LM74XDmvpTndkbh6nUWjy1tGg6XdwsXqds9I2
         cixLCncSHS7UzQpqNZnBBm8WKepHW+IN7Q6u8/d9RS9F2LgqPQWNyp6jVMY3zawl5pay
         axuzXqyIRGpyKxOCI0RQ8LEFnagWiQxawKg/OU+P+7ILbNOARUoi1PlqXAVcSs0L3rp9
         13RKL2j/asTNQR8SeSmevHl2F0OVuO6ogAKiGH1rV3HDaJBZS41C8DTqsrW7LW+j0RFN
         0AhUP8r2P5/GqCjO3w/ItUKlYhWLM6nF56wcJWSzYtrIMrdjSCNTcarpWMrhiSI2Byfj
         zDQA==
X-Gm-Message-State: APjAAAVMY584LgiSBe34WOTDDO8Z9zF75cJA+NAHOlH7qCVx4upbxx2k
        nnB1ZQnpLjoEmV0HomBm6SESpB01N0Oghw==
X-Google-Smtp-Source: APXvYqy8P2wlPlf8zc/ZhWNxCO4Ok4qtx69zwXqs/DWzpyFPfoIb/vy04GezzNwoStKVHlKz5UcBEw==
X-Received: by 2002:a0c:ec84:: with SMTP id u4mr21314114qvo.205.1566931475736;
        Tue, 27 Aug 2019 11:44:35 -0700 (PDT)
Received: from localhost ([2605:9480:205:fffe:a56f:bf18:42be:60d4])
        by smtp.gmail.com with ESMTPSA id o33sm9535847qtd.72.2019.08.27.11.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 11:44:34 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 27 Aug 2019 14:44:34 -0400
To:     "Saravanan Shanmugham (sarvi)" <sarvi@cisco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git commit" of single file takes 5 minutes, mounted
 fileystem/diskimage with 50G GIT repo + 900G of builds articles
Message-ID: <20190827184434.GA63526@syl.lan>
References: <7A1C0468-E07D-4D10-8891-01AC1FA1CC1B@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7A1C0468-E07D-4D10-8891-01AC1FA1CC1B@cisco.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Saravanan,

On Mon, Aug 26, 2019 at 08:43:34PM +0000, Saravanan Shanmugham (sarvi) wrote:
>
> Based on a previous thread “First Git status takes 40+ minutes, when mounting fileystem/diskimage with 50G GIT repo + 900G of builds articles”
>
> The context is that
>   1. git wokspace was clone(50G)
>   2. some 30 platorms build(900G)
>   3. This tree was then copied into a new diskimage/filesystem + git update-index --refresh" was done to update the index to the new filesystem, then frozen.
>   4. New workspaces created by cloning this frozen diskimage(< 30 seconds)
>   5. This diskimage was mounted on a new machine
>   6. A file was modified and "git add/commit" was done
>
> I have done “git update-index –refresh”, in the mounted filesystem, as above
> This has improved “git status/diff” timing from 40+ minutes to 1.5 minutes for the first time and <5 seconds for subsequent calls.
>
> But "git commit -m "dummy commit" of a 1 line change in 1 file takes about 5-6 minutes, everytime in this workspace.
> Tracing shows a whole bunch. The entire 5-6 minutes worth of the following sort of trace logs.
> 3:13:50.320930 trace git-lfs: filepathfilter: rejecting "x/y/z.o.command" via []
> 13:13:50.320940 trace git-lfs: filepathfilter: accepting " x/y/z.o.command "
> 13:13:50.320862 trace git-lfs: filepathfilter: rejecting "a/b/c/d.o.command" via []
> 13:13:50.320972 trace git-lfs: filepathfilter: accepting " a/b/c/d..o.command"
>
> Does anyone have any insights on what could be causing this?

These are messages from the Git LFS tool, and this list does not provide
support for Git LFS, since it is a separate project not affiliated with
Git.

I would recommend that you create an issue on Git LFS's tracker at:

  https://github.com/git-lfs/git-lfs/issues/new

and mention that you are seeing lots of 'filepathfilter' logs. My
speculation is that this could be a slowdown in the 'filepathfilter'
code paths, or an entire-tree scan where 'filepathfilter' is invoked
every so often. I'd mention both of those as possibilities (or send a
link to this email on public-inbox), and see if anything comes up.

> On the other hand, if I had
>
> Thanks,
> Sarvi
> Occam’s Razor Rules

Thanks,
Taylor
