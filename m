Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A86B8209F1
	for <e@80x24.org>; Sun,  9 Apr 2017 18:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbdDISR7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 14:17:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36090 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbdDISR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 14:17:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id q125so6179119wmd.3
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wYJ32gtwT7IvmwfV3wHJ68YRSPLLn0tyJ/iSMzI5cZI=;
        b=fRvDsbxwIZkJ0Og7//dQWY6Iw52cLuOxLXn9TM90pc80hgQENTg25Lv2WzPvCMhOH/
         iimAlQuPAm/6tDrw3JeIcOEOdNu/TCndKKv2L+AOCGqarWuh9vjTmidwWCZUkpThiHzP
         O95i7Y9gq9nqTtwkz6kPztshVVOXnIPLOIBCQQMldis48e0ihvl5bt5Xg4I4LBnF0BCs
         YksqCze+77EX50z5FLBKuL6NmA7IrKwG8d3FX8ZJkacDGTPKXb7bgRJMwkpnmOts8SgQ
         nS3gCDcYkftXsicolPNGYMAiJVcuwHCSQMdbEhLS23XVXrbFsrmUq4dh41mVDT3LH0+I
         MfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wYJ32gtwT7IvmwfV3wHJ68YRSPLLn0tyJ/iSMzI5cZI=;
        b=YRYhSx3LQypKh7CBaikbLoNcJotDioytHoVI15bpVVv1eEjPetlzrWWc74iKJ6Gdfy
         Y0igAfexgNQd+Fv3aS///tAmO1iwvHV/wrLgqWUlYRqPnua+qVBpEdTlhC3deVJF/r3p
         Lta9CL7+wK7iIR7+bBtyiT6/IQ8sG/R8jJOQWZ0GzlkIQYKyy8jwWz+0KboHU/iQoh8W
         UQ841x+kgDvWrnyKkJoVd7orVapD/f1tRJxEy1hwp63XDYFkdJ9A0NHaDiB6+3l+Un9s
         gdGv8iCJMD3zKRgi1v7gKgxQdy43s8jfiF9S64nHdpQaU0tLd9LkND2GECdKbjB4DSMm
         imog==
X-Gm-Message-State: AN3rC/6Z15igcmqP5PWVCNU5m7rbfqfhqFyQH9xwVl3+fGbq4WSpQBxjTYLA11P5VNIPIQ==
X-Received: by 10.28.11.130 with SMTP id 124mr7169419wml.3.1491761876811;
        Sun, 09 Apr 2017 11:17:56 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5F77.dip0.t-ipconnect.de. [93.219.95.119])
        by smtp.gmail.com with ESMTPSA id 134sm7162125wmj.6.2017.04.09.11.17.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Apr 2017 11:17:55 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170227105330.gv5qk6dszrv56kmg@sigill.intra.peff.net>
Date:   Sun, 9 Apr 2017 20:17:54 +0200
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Wong <e@80x24.org>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Content-Transfer-Encoding: 7bit
Message-Id: <011147E3-3D2F-4260-9296-A60557A8FE3A@gmail.com>
References: <20170226184816.30010-1-larsxschneider@gmail.com> <20170227095825.jhdspwy6oa6mvvvm@sigill.intra.peff.net> <E4A6D866-D046-4CF3-8050-666FD6C98F7B@gmail.com> <20170227105330.gv5qk6dszrv56kmg@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Feb 2017, at 11:53, Jeff King <peff@peff.net> wrote:
> 
> On Mon, Feb 27, 2017 at 11:32:47AM +0100, Lars Schneider wrote:
> 
>> ...
> 
>>> From Git's side, the loop is something like:
>>> 
>>> while (delayed_items > 0) {
>>> 	/* issue a wait, and get back the status/index pair */
>>> 	status = send_wait(&index);
>>> 	delayed_items--;
>>> 
>>> 	/*
>>> 	 * use "index" to find the right item in our list of files;
>>> 	 * the format can be opaque to the filter, so we could index
>>> 	 * it however we like. But probably numeric indices in an array
>>> 	 * are the simplest.
>>> 	 */
>>> 	assert(index > 0 && index < nr_items);
>>> 	item[index].status = status;
>>> 	if (status == SUCCESS)
>>> 		read_content(&item[index]);
>>> }
>>> 
>>> and the filter side just attaches the "index" string to whatever its
>>> internal queue structure is, and feeds it back verbatim when processing
>>> that item finishes.
>> 
>> That could work! I had something like that in mind:
>> 
>> I teach Git a new command "list_completed" or similar. The filter
>> blocks this call until at least one item is ready for Git. 
>> Then the filter responds with a list of paths that identify the
>> "ready items". Then Git asks for these ready items just with the
>> path and not with any content. Could that work? Wouldn't the path
>> be "unique" to identify a blob per filter run?
> 
> I think that could work, though I think there are few minor downsides
> compared to what I wrote above:
> 
>  - if you respond with "these items are ready", and then make Git ask
>    for each again, it's an extra round-trip for each set of ready
>    items. You could just say "an item is ready; here it is" in a single
>    response. For a local pipe the latency is probably negligible,
>    though.

It is true that the extra round-trip is not strictly necessary but I think
it simplifies the protocol/the code as I can reuse the convert machinery 
as is.


>  - using paths as the index would probably work, but it means Git has
>    to use the path to find the "struct checkout_entry" again. Which
>    might mean a hashmap (though if you have them all in a sorted list,
>    I guess you could also do a binary search).

Agreed. I changed my implementation to use an index following your
suggestion.

>  - Using an explicit index communicates to the filter not only what the
>    index is, but also that Git is prepared to accept a delayed response
>    for the item. For backwards compatibility, the filter would probably
>    advertise "I have the 'delayed' capability", and then Git could
>    choose to use it or not on a per-item basis. Realistically it would
>    not change from item to item, but rather operation to operation. So
>    that means we can easily convert the call-sites in Git to the async
>    approach incrementally. As each one is converted, it turns on the
>    flag that causes the filter code to send the "index" tag.

Agreed. I change the implementation accordingly and I will send out the
patches shortly.

Thanks,
Lars
