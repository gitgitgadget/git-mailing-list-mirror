Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97FD91F609
	for <e@80x24.org>; Wed, 28 Nov 2018 13:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeK2A2w (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 19:28:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35844 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeK2A2w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 19:28:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so26293776wrr.3
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=diV+wj8I3ssSFeCGiUTUG4CpNf8d3rBXrU3xKgh8AG8=;
        b=l505uw/nwKZkH7xFygfcuKJVxyLuL34S8NsvvodXQndvepm9XjzO5WOg8PIkt8eTWQ
         dxbLcplOUSfD1vmkO2L4GsprvO9tptQetJ1CGtdXKUP+rgn78jslGXTqjzhzs5GlOHob
         Y0pBHNMpzm0PSmZeMWaJxC97ei5RLPTj/7u23fd+8Ldkzt9vPt6ojzNVrk40+umQW1hp
         2MFI0++76KZVluLWhePxdH9wkQmv1ABb4b9RQNwqna04/8VpUJkbmEbcR1VK0cENSC1+
         O4z/iBqZpvUp8QGWbvSc1ZPyzPEFP69xQwjeEetiV5tGnVh8JRLQCIsL8tKmbTPJ1pEW
         Bsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diV+wj8I3ssSFeCGiUTUG4CpNf8d3rBXrU3xKgh8AG8=;
        b=HiaT8kKfAjD7xXyRXBoFkQsOA7DXdixpfluAOJR2E4vwSj7/cUsgHS14J6AigigYSh
         lvmZd85XsY7Oj6KaNsOaeNX1pLLGoKiu1atWmTeU/6cItop8IWSBiISPyhUy7EfiJBRP
         ktDSNhxGB+Nxxid/a0fAgxc+AnelNdOSndd4xJhU4g0v9NJ5UH0/caFEoQ64oXYvtcsi
         poRi4VIdNONgf4bvTTQ548e/OJ0kyMe4yQ6xzFgp6iBHV5Ve+n9gtXt4el9kTKBF3KWS
         272kUDSntvOBM8r/T7afTLOCGwXR4KjjVtN4tRZN90yNz7MxqKGKZWjuyiOTSH+3jmjk
         7APA==
X-Gm-Message-State: AA+aEWaT3Gu/K7moYGh08LNIntsFsm4frqBe3NZc7z+rfOdnHQkQbD/E
        qsuFyyRkdRNyLVgQiALnl6Q=
X-Google-Smtp-Source: AFSGD/V5bcFV/zg9KXKOLyOCMkbn58J2rfKNBl9CNmz1jHCgrnmjmgzDCia4J82cXXtGwryVGKDgaA==
X-Received: by 2002:adf:b649:: with SMTP id i9mr32363012wre.70.1543411631581;
        Wed, 28 Nov 2018 05:27:11 -0800 (PST)
Received: from szeder.dev (x4db2728b.dyn.telefonica.de. [77.178.114.139])
        by smtp.gmail.com with ESMTPSA id x12sm8451704wrt.20.2018.11.28.05.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:27:10 -0800 (PST)
Date:   Wed, 28 Nov 2018 14:27:08 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>, max@max630.net,
        git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181128132708.GE30222@szeder.dev>
References: <20181119101535.16538-1-carenas@gmail.com>
 <20181119184018.GA5348@jessie.local>
 <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
 <20181120091107.GA30542@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181120091107.GA30542@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 04:11:08AM -0500, Jeff King wrote:
> On Mon, Nov 19, 2018 at 11:36:08AM -0800, Carlo Arenas wrote:
> 
> > tests 3-8 seem to fail because perl is hardcoded to /urs/bin/perl in
> > t5562/invoke-with-content-length.pl, while I seem to be getting some
> > sporadic errors in 9 with the following output :
> > 
> > ++ env CONTENT_TYPE=application/x-git-receive-pack-request
> > QUERY_STRING=/repo.git/git-receive-pack
> > 'PATH_TRANSLATED=/home/carenas/src/git/t/trash
> > directory.t5562-http-backend-content-length/.git/git-receive-pack'
> > GIT_HTTP_EXPORT_ALL=TRUE REQUEST_METHOD=POST
> > /home/carenas/src/git/t/t5562/invoke-with-content-length.pl push_body
> > git http-backend
> > ++ verify_http_result '200 OK'
> > ++ grep fatal: act.err
> > Binary file act.err matches
> > ++ return 1
> > error: last command exited with $?=1
> > not ok 9 - push plain
> > 
> > and the following output in act.err (with a 200 in act)
> > 
> > fatal: the remote end hung up unexpectedly
> 
> This bit me today, too, and I can reproduce it by running under my
> stress-testing script.

I saw this a few times on Travis CI as well.

> Curiously, the act.err file also has 54 NUL bytes before the "fatal:"
> message.

I think those NUL bytes come from the file system.

The contents of 'act.err' from the previous test ('fetch gzipped
empty') is usually:

  fatal: request ended in the middle of the gzip stream
  fatal: the remote end hung up unexpectedly

Notice that the length of the first line is 54 bytes (including the
trailing newline).  So I suspect that the following is happening:

  - http-backend in the previous test writes the first line,
  - that test finishes and this one starts,
  - this test truncates 'act.err',
  - and then the still-running http-backend from the previous test
    finally writes the second line.

So at this point 'act.err' is empty, but the offset of the fd of the
redirection still open from the previous test is at 54, so the file
system fills those bytes with NULs.


> I tried adding an "strace" to see who was producing that
> output, but I can't seem to get it to fail when running under strace
> (presumably because the timing is quite different, and this likely some
> kind of pipe race).
> 
> -Peff
