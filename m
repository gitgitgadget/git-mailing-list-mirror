Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697601F403
	for <e@80x24.org>; Mon, 11 Jun 2018 20:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933204AbeFKUfx (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 16:35:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53257 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932983AbeFKUfw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 16:35:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so16817773wmc.3
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oLxBsZIZRKDCgQNcmDAEQS/69ESPQxGtqPp78P8A5sE=;
        b=KZpN6l3vegHzMkStgMYYUAAJZNEL86hcrCXQ0h30rI/pnu5B9sRivldA8YYcNGTflt
         Od3H53uwVVotfRuiwze+dPKwzzCeoTtdtpHEghRNDLGtbhipP69dY7k1WbquMH0vVzLy
         ia82Z2jCWTANpDPZaRuCgZQ1v/RDrLwJl/Ra4y/YU42UBpezNK7FjOd+crK3hbhqBxoD
         HKSDEpo/M1wheD7ySEFMJuogZO3bWhBcZtx2qK0k6IsIWTl2ncByREIrYHV7q0uuKEr5
         iUg9/VgCWdor07XyGhqXrVxhIYSBdgyYPf9ntBQADBV+qxBi0/DwFUqy3Fmn6CIXhQPn
         AJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oLxBsZIZRKDCgQNcmDAEQS/69ESPQxGtqPp78P8A5sE=;
        b=c1o8nQJsHJKX9wdosUnysNRHeb0ix/kS0tTZDtIP04fp3ovmu8BtD9zZ9IjvBGgF7y
         XA30VHLkjxtkzG0BpnH7VXeubv7v7qgpDs9MOvZqbWm9eW30BBmAzKtGAzbdVGk8oo54
         97JlaVd2NLLZEW306b9y0poGJj/4yCDimKbU9x6vO4rz9G8lD45qzUKeWAA3N56P+uGS
         fTrlth93U3M8837cejxppzowd6fT94fgrhiHuNSsfhbYLHGl7Xv2rJBebPdnWr6dH0d7
         +xvQUuN6dXLP9kgMfCWOmlNewB39lAD85SrSZf844xQPMmS81BQ4q7g+/xY/05jVDqHK
         Wy8g==
X-Gm-Message-State: APt69E00PMgZXvh7og6jpXU37/RZP74pms9M+Y1IU76MXLANn7tVCykA
        J0AggId85INxdEcWWaDcfLH7P67tKj0=
X-Google-Smtp-Source: ADUXVKIDhfX/hknxNzEuqWqKegMl9K3sZv4oh7huuIunaV1a9ypC8wqR1ydJ1SD2XZfRA5GAJoWwpw==
X-Received: by 2002:a1c:4189:: with SMTP id o131-v6mr256596wma.7.1528749350903;
        Mon, 11 Jun 2018 13:35:50 -0700 (PDT)
Received: from 606faba9ba17 (global-5-182.nat-2.net.cam.ac.uk. [131.111.5.182])
        by smtp.gmail.com with ESMTPSA id l10-v6sm50584686wrm.29.2018.06.11.13.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 13:35:49 -0700 (PDT)
Date:   Mon, 11 Jun 2018 20:35:41 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     Clemens Buchacher <drizzd@gmx.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] checkout files in-place
Message-ID: <20180611203541.GA6@606faba9ba17>
References: <20180610194444.GA1913@Sonnenschein.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610194444.GA1913@Sonnenschein.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 10, 2018 at 09:44:45PM +0200, Clemens Buchacher wrote:
> 
> It is safe to do this on Linux file systems, even if open file handles
> still exist, because unlink only removes the directory reference to the
> file. On Windows, however, a file cannot be deleted until all handles to
> it are closed. If a file cannot be deleted, its name cannot be reused.

I'm nervous about this proposed change, since it feels like it's
addressing an issue that only exists in QT Creator.

You've accurately described the default semantics in Win32.  A file
cannot be deleted until all handles to it are closed, unless it was
opened with `FILE_SHARE_DELETE` as their sharing mode.  This is not the
default sharing mode in either Win32 or .NET.

However, for your patch to have an effect, all processes with a handle
open must have specified `FILE_SHARE_WRITE`.  This is rather uncommon,
since it's also not included in the default Win32 or .NET sharing mode.
This is because it's uncommon that you would want other processes to
change the data underneath you in between ReadFile() calls.

So your patch will benefit people who have processes that have
`FILE_SHARE_WRITE` set but not `FILE_SHARE_DELETE` set, which I think is
generally an uncommon scenario to want to support.

Generally if you're willing to accept files changing underneath you,
then you probably want to allow them to be deleted, too.  So this feels
like something that's very specific to QT Creator.  Or are there other
IDEs or development tools that use these open semantics that I'm not
aware of?

Cheers-
-ed
