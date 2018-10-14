Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C71C1F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 09:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeJNRkU (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 13:40:20 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41881 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeJNRkU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 13:40:20 -0400
Received: by mail-wr1-f44.google.com with SMTP id x12-v6so17834929wru.8
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jAMa/mnsd1WUJE4jG/IfI+92MtytaOeXgLxhWGoGsc4=;
        b=REyC74pOegkZCa/RGnUIa/k3TkBuvkM9MnmkMQ4S8s6fVuhpA/buJUoH7LRbCt9J0W
         c0zuPsZnKdgwblInrAEUTsshY2rXZyCyalf2fvHNCLfTxdK3eObFE5pqDIOYW7k3Kzo5
         p993FwEzbWWG43+OyYnhb/WiNA7pnhaOmntvBoXfwhI2X0ekE2aGkfyyHmvJCfXH8yO/
         diSHr+2u/lY+Hh+FJT4tK9cJhQ2gsfJauYX5niIZ0UQZzwl+9AGMdNjlNh3jIwBcH8vi
         5x4pdLbnMhbqWR2tpEeCjdxte9hxl+zCPnHZsYnOl3uSxoiZcG5q0EnIT9GmJSCpavVm
         e+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAMa/mnsd1WUJE4jG/IfI+92MtytaOeXgLxhWGoGsc4=;
        b=SRttGQwAD2qrGzL4yvd+aANjZSa1YNVPoHn5B7yDTNATq2s9m9CzNZ34FLTWItuk7z
         WixDDHcX18aVUUy6K3wDYvhO7R9acw4jOC9Q2hgrVLv7CumvZBib93+7uhECBmxv7FSf
         j4yFiTIioXi+FFQ/VHUUcv14E5d3Dvc2U9A0MW6XfeTG9T2IGhC8gmrvZUYFHTa9o9h1
         7NZzCvGP1cDDpk3uQ8ThYxZl/Vrw9I3YPCfaDRneiL9CbAfZo+vZmIEZ5dXX8V0Pc5+C
         2tpRD9AyjO7jrM73ehObLoRsn16F7ksALw+H7IoYZTApAE4e0v21oqHIVFcjSWpm4EH3
         97iA==
X-Gm-Message-State: ABuFfojZmKwyfI3wSQLETQq4MV5jb/GiY4XyKxXlTZFczt1qBfE9jdL8
        izYu2LZXe50ftxYW8+HtNMA=
X-Google-Smtp-Source: ACcGV62hXWS8rT1tYkJC4b6VlKtFRmtgprcj9FDhLxOZQRB8hOjnplwTP6AZBzF8dFLrcChSy0sE3A==
X-Received: by 2002:adf:f6c4:: with SMTP id y4-v6mr11646574wrp.79.1539511191066;
        Sun, 14 Oct 2018 02:59:51 -0700 (PDT)
Received: from localhost ([31.127.45.92])
        by smtp.gmail.com with ESMTPSA id e196-v6sm13078186wmf.43.2018.10.14.02.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 02:59:50 -0700 (PDT)
Date:   Sun, 14 Oct 2018 10:59:49 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Farhan Khan <khanzf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Does git load index file into memory?
Message-ID: <20181014095949.GB22611@hank.intra.tgummerer.com>
References: <CAFd4kYCTuLMZ6UDk49MASbZfhwjgUcmfeyd6jZS5QO9-LnzLCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd4kYCTuLMZ6UDk49MASbZfhwjgUcmfeyd6jZS5QO9-LnzLCw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12, Farhan Khan wrote:
> Hi all,
> 
> Does git load the entire index file into memory when it wants to
> edit/view it? I ask because I wonder if this can become a problem with
> the index file becomes arbitrarily large, like for the Linux kernel.

Yes, currently git always loads the entire index file for any
operation on it.  This is not particularly a problem for projects like
the linux kernel, as the index file for it is relatively small, ~6MB
at the moment.

It is more of a problem for larger repositories, such as the windows
repository, which has and index file of ~300-400MB, iirc, where
loading the index has a significant cost.  There's some patch series
in progress to improve the performance, e.g. Ben Pearts series to load
the index in parallel [*1*].

For writing the index to disk again, the split index feature can help
improve performance.  See also 'man git-update-index' and
"core.splitIndex" in 'man git-config'.

[*1*]: https://public-inbox.org/git/20181010155938.20996-1-peartben@gmail.com/

> Thanks,
> --
> Farhan Khan
> PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
