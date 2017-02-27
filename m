Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D3320254
	for <e@80x24.org>; Mon, 27 Feb 2017 10:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdB0Kcw (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 05:32:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35252 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdB0Kcu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 05:32:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so12679332wmu.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 02:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fFcJbmdXppwPHolA3JuUVklisTnZjd6MKzKNcLQ0P1A=;
        b=tPtKaxd0UIdDysoUV0p7CMwjwyiwblY23zKNw1TWCXy2bhzOattBHg/oBkJQrhpyuo
         Da3ba8fkLJaxqD+pJH+bhGm31JgohiAPPozGQnJIeDEWxNXYF12wPIW/dBAMGjt+5O46
         6LOwwtq56huH0VLZ1RJmATdhMA7XOsXRvySlXvuBpyJbQmStqOsZs2f3hUawPM0A7M1o
         k6olU1eSc+wmRWQSknArI6qOVtcizzhQaod88yDU12qUPJK992sWyP0YefJPUiOm++HK
         5DX1T71aRH4uvaljrApl/JAl4a8rYc926BT6jkcdJ67TKu/0OoAhqCb6p2aRerwShaSM
         3eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fFcJbmdXppwPHolA3JuUVklisTnZjd6MKzKNcLQ0P1A=;
        b=MWYREQ85WBpQlA0XC8PYP032APBCkzmHCmLWjenP66SYgog18JWkuM09NqF6Aa3Jrj
         Ta5ze+Riqjhk4kNcAqKTGgrnT6aA2FVZAuG2WPuzPwEJqZxlxtvkbYKFz7Paemouws2n
         CwplAN4F4mbLB8beXFVoy5WnqjFiMmNNGgBbhlITtIbtRCR4l5x0tx8wShXDtAsxR6wu
         xe3LdD2mPE6jEZEE/8zLzjS53SsCuoCdlaDRoCSzBGgHaqk3M6Z75vcH0gwYtUZk8WwE
         SHmD3PSv2pngrjJo20oD4YNji1o2PKlGcHqMt1am9QrNl10XQSniEH+hzmWGoP9oVlU1
         VsZA==
X-Gm-Message-State: AMke39nTqk/kqrybJcQM/oDil/NwPAxQvICgzndmKzDvxNAVx0tGvB0esgVBPcwoqCCZyQ==
X-Received: by 10.28.13.20 with SMTP id 20mr12621810wmn.24.1488191569089;
        Mon, 27 Feb 2017 02:32:49 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id z198sm13701363wmz.24.2017.02.27.02.32.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 02:32:48 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170227095825.jhdspwy6oa6mvvvm@sigill.intra.peff.net>
Date:   Mon, 27 Feb 2017 11:32:47 +0100
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Wong <e@80x24.org>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        ttaylorr@github.com
Content-Transfer-Encoding: 7bit
Message-Id: <E4A6D866-D046-4CF3-8050-666FD6C98F7B@gmail.com>
References: <20170226184816.30010-1-larsxschneider@gmail.com> <20170227095825.jhdspwy6oa6mvvvm@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Feb 2017, at 10:58, Jeff King <peff@peff.net> wrote:
> 
> On Sun, Feb 26, 2017 at 07:48:16PM +0100, Lars Schneider wrote:
> 
>> +If the request cannot be fulfilled within a reasonable amount of time
>> +then the filter can respond with a "delayed" status and a flush packet.
>> +Git will perform the same request at a later point in time, again. The
>> +filter can delay a response multiple times for a single request.
>> +------------------------
>> +packet:          git< status=delayed
>> +packet:          git< 0000
>> +------------------------
>> +
> 
> So Git just asks for the same content again? I see two issues with that:
> 
>  1. Does git have to feed the blob content again? That can be expensive
>     to access or to keep around in memory.
> 
>  2. What happens when the item isn't ready on the second request? I can
>     think of a few options:
> 
>       a. The filter immediately says "nope, still delayed". But then
>          Git ends up busy-looping with "is this one ready yet?"
> 
>       b. The filter blocks until the item is ready. But then if other
> 	  items _are_ ready, Git cannot work on processing them. We lose
> 	  parallelism.
> 
>       c. You could do a hybrid: block until _some_ item is ready, and
>          then issue "delayed" responses for everything that isn't
> 	  ready. Then if you assume that Git is looping over and over
> 	  through the set of objects, it will either block or pick up
> 	  _something_ on each loop.
> 
> 	  But it makes a quadratic number of requests in the worst case.
> 	  E.g., imagine you have N items and the last one is available
> 	  first, then the second-to-last, and so on. You'll ask N times,
> 	  then N-1, then N-2, and so on.

I completely agree - I need to change that. However, the goal of the v2
iteration was to get the "convert" interface in an acceptable state.
That's what I intended to say in the patch comment section:

    "Please ignore all changes behind async_convert_to_working_tree() and 
     async_filter_finish() for now as I plan to change the implementation 
     as soon as the interface is in an acceptable state."

> 
> I think it would be much more efficient to do something like:
> 
>  [Git issues a request and gives it an opaque index id]
>  git> command=smudge
>  git> pathname=foo
>  git> index=0
>  git> 0000
>  git> CONTENT
>  git> 0000
> 
>  [The data isn't ready yet, so the filter tells us so...]
>  git< status=delayed
>  git< 0000
> 
>  [Git may make other requests, that are either served or delayed]
>  git> command=smudge
>  git> pathname=foo
>  git> index=1
>  git> 0000
>  git< status=success
>  git< 0000
>  git< CONTENT
>  git< 0000
> 
>  [Now Git has processed all of the items, and each one either has its
>   final status, or has been marked as delayed. So we ask for a delayed
>   item]
>  git> command=wait
>  git> 0000
> 
>  [Some time may pass if nothing is ready. But eventually we get...]
>  git< status=success
>  git< index=0
>  git< 0000
>  git< CONTENT
>  git< 0000
> 
> From Git's side, the loop is something like:
> 
>  while (delayed_items > 0) {
> 	/* issue a wait, and get back the status/index pair */
> 	status = send_wait(&index);
> 	delayed_items--;
> 
> 	/*
> 	 * use "index" to find the right item in our list of files;
> 	 * the format can be opaque to the filter, so we could index
> 	 * it however we like. But probably numeric indices in an array
> 	 * are the simplest.
> 	 */
> 	assert(index > 0 && index < nr_items);
> 	item[index].status = status;
> 	if (status == SUCCESS)
> 		read_content(&item[index]);
>  }
> 
> and the filter side just attaches the "index" string to whatever its
> internal queue structure is, and feeds it back verbatim when processing
> that item finishes.

That could work! I had something like that in mind:

I teach Git a new command "list_completed" or similar. The filter
blocks this call until at least one item is ready for Git. 
Then the filter responds with a list of paths that identify the
"ready items". Then Git asks for these ready items just with the
path and not with any content. Could that work? Wouldn't the path
be "unique" to identify a blob per filter run?

Thanks,
Lars
