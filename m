Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83331F803
	for <e@80x24.org>; Mon,  7 Jan 2019 23:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfAGXYd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 18:24:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39653 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGXYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 18:24:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so1836134ljh.6
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 15:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAnqCYr7uDWVgi5keUeW9GPNVNIs/RYEADuNQhMpRyk=;
        b=O65z4qRBUUUh5yIBx1uqCufkBu8S3G90lIxdv7SiwF3pNHXUx6z7nKrXbneNmFqxvX
         2B65NJlCg/vgJ+Bi5LDMJVea60GO7qXj++3lXVna0cvquIMBqLGJyAtRe+rO2RdyHLpl
         3wgOKu9S+5+RWruwp9E/PLVWbJKGJVGooNpGHEhYw1Qx1J0nmOn8Hpx+Vhlms6LXjm9V
         Fxa5ADjfDqjJQub0UzXH1SnR3FuIUWWDxrpzKGTQLY0+bOy11dLQl8D77IqwUX31OxP8
         a2PV1PWJ/1c1fZkSNXlpWxU5McbUmYVvBhYc2w6t5izIwEB4URC0w7OPS9ETAu9NJQak
         0yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAnqCYr7uDWVgi5keUeW9GPNVNIs/RYEADuNQhMpRyk=;
        b=uPjo3jzi5zfCaMKP/wFdlJ1xLXcE4xUi/N34VVkTF6jGN/ypxZwXBvMNNldyrLkTNC
         E7gS6L4+sQamgN7AKbAYHwPkMbV0ssIivp0u4qYcj1q1dC07nIIo9tcUMZ4+Po47nsbD
         myFKH2cMbZvme65LaXGwsuAf8T5UJEK4HYme6zNLkMhr/VzPTsJGd7TbV282wHXR4n0X
         4kfVujwdzD10Q3Sq+ulk7ia19Glxu+gmot/w7G4/wBx2JXu6HzFL8MjCn9JCoder8Vf2
         xwZFjAm/folk/UhPVnStXn/nhTuiIOUEyKLIkpLzz5xRczURxOuLayeeQ3PfFmw+Lt3D
         I74w==
X-Gm-Message-State: AJcUukcqRh6MXhwHBxd6eo4FbYVxZ/3qoRIM8azy8KTiMcliTyRt49db
        VqbEspUEStNCx/v2Ah8qwMLwTxXXjyyD1SywwomCvg==
X-Google-Smtp-Source: ALg8bN41KhshIlQjtWi/zmMgcRQ7W96yMaP3qz0A4bfva2HNFtST1jdDshe0O9pFjvPCfhlzDmKAWsVvy0N1f45MCaU=
X-Received: by 2002:a2e:9ad0:: with SMTP id p16-v6mr24974753ljj.102.1546903471008;
 Mon, 07 Jan 2019 15:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20181228014720.206443-1-masayasuzuki@google.com>
 <20181229194447.157763-1-masayasuzuki@google.com> <20181229194447.157763-3-masayasuzuki@google.com>
 <20190104104907.GC26185@sigill.intra.peff.net>
In-Reply-To: <20190104104907.GC26185@sigill.intra.peff.net>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Mon, 7 Jan 2019 15:24:19 -0800
Message-ID: <CAJB1erVjLwnKqy5zSMTBNySSUrJXiiL8Xrpw9puh7o4CDaeA2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Unset CURLOPT_FAILONERROR
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 4, 2019 at 2:49 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Dec 29, 2018 at 11:44:47AM -0800, Masaya Suzuki wrote:
>
> > When GIT_CURL_VERBOSE is set, libcurl produces request/response headers
> > to stderr. However, if the response is an error response and
> > CURLOPT_FAILONERROR is set, libcurl stops parsing the response, and it
> > won't dump the headers. Showing HTTP response headers is useful for
> > debugging, especially for non-OK responses.
>
> Out of curiosity, does GIT_TRACE_CURL do any better? Or is it simply
> that curl closes the handle when it sees the bad response code, and
> nobody ever gets to see the rest of the data?

curl disregards the rest of the contents when it sees a bad response
code when CURLOPT_FAILONERROR is set
(https://github.com/curl/curl/blob/dea3f94298ac0859464768959488938c4e104545/lib/http.c#L3691).
So nobody gets the rest of the data.

>
> > This is substantially same as setting http_options.keep_error to all
> > requests. Hence, remove this option.
>
> The assumption here is that every code path using FAILONERROR is
> prepared to handle the failing http response codes itself (since we no
> longer set it at all in get_active_slot()). Is that so?

I was thinking that I covered the all code paths using FAILONERROR,
but it seems it's not the case. http-walker.c and http-push.c also
calls get_active_slot(). I'll narrow down the scope on removing
FAILONERROR.

>
> Anything that uses handle_curl_result() is OK. That means run_one_slot()
> is fine, which in turn covers run_slot() for RPCs, and http_request()
> for normal one-at-a-time requests. But what about the parallel multiple
> requests issued by the dumb-http walker code?

Right. I'll keep FAILONERROR in get_active_slot and remove it only for
the code paths that can handle HTTP errors.

>
> There I think we end up in step_active_slots(), which calls into
> finish_active_slot() for completed requests. I think that
> unconditionally fetches the http code without bothering to look at
> whether curl reported success or not.
>
> So I _think_ that's probably all of the users of the curl handles
> provided by get_active_slot(). Though given the tangled mess of our HTTP
> code, I won't be surprised if there's a corner case I missed in that
> analysis.
>
> -Peff
