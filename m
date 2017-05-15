Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C22201A7
	for <e@80x24.org>; Mon, 15 May 2017 16:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759953AbdEOQeC (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 12:34:02 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36000 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757952AbdEOQd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 12:33:59 -0400
Received: by mail-pf0-f181.google.com with SMTP id m17so65680497pfg.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XVxZjG8zqL/gYE0lDBzsK7rVz0Uio2Q138gqqxrlMKs=;
        b=FF8Dk3Vf+r6uZYqiYRv+KK2yIeyECGiW1cQ/YlHOlL3SyIPNLfPMxHUJV1BskbFPza
         JHsy3dWuPbgBlMdt4np91K+SBMOfdH+w8qoQFnx3aPLAmwODUpFDRint8UsyHgWOW6mW
         nOpdIcYnmOqMB6FSSKk9pFkDu8if6/OfCAzmtSJIG9yVOeQ40MywY238jTm3E31moIe/
         zZ/gwf96YYZP0USpgo0EpKqCxtyIy3iltg3y+ubUVZw6cnMkj10VYAXGr8ioepQ+HbrQ
         CrDzttwvlUF/oz0rUNpMVf6GA0hyVtVz7mByhjfYz1g8Tb2wAXaVJkMp/DUxVVE6A6Ha
         wykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XVxZjG8zqL/gYE0lDBzsK7rVz0Uio2Q138gqqxrlMKs=;
        b=NBkTyZaFt9EnJGkHTjhiqXgWGokzuX0BpbW22D0LwNHyQ+tljPHyn1w425Fq8BmkV+
         HREm6Nn17jIz5zRkNLif7jFqa8JvWt87bdKF8cLsS2BeLhwH6jFE15W80T/URlkcFmg4
         HqS1qp+IMG1H15FbngDtEQGvM9IKe0Tgp4rjJbjbXqV+zmNpbAqx2caBujAoVHHVdoO+
         hganh9GtVLqvZ0o+rhEYMyOyONVrdwfbxg44DQDOJnA0CDImwhXxpX/fRBFjiLCjpYRz
         w0l7QEe3BMaBePoppLjAGEyc5UuMapfpNuDonuNhd/2OGwm+WH0ZACHhdvMXOTwg5m91
         SZ+A==
X-Gm-Message-State: AODbwcD6LIXQnzMLTzagU/6tDxkoN4pwMI4KYpJS7QqaPwWxyCHIdl53
        qlPnBjiILMoZKMp1D2PSifSa7SEqs+MzK2KsXw==
X-Received: by 10.98.104.4 with SMTP id d4mr7121864pfc.94.1494866037199; Mon,
 15 May 2017 09:33:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 15 May 2017 09:33:56 -0700 (PDT)
In-Reply-To: <xmqq37c6uw7n.fsf@gitster.mtv.corp.google.com>
References: <20170514040117.25865-1-sbeller@google.com> <xmqq37c6uw7n.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 15 May 2017 09:33:56 -0700
Message-ID: <CAGZ79kaJeeXvcwj-Jc+KckLLzBvtOShp=bXjqHNQ83NBtzpaqA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] Diff machine: highlight moved lines.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 5:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> For details on *why* see the commit message of the last commit.
>
> Luckily, we have a good test case to see how effective this approach
> is in the flight.  Running
>
>   $ git diff master...'pu^{/Merge branch .js/blame-lib}'^2
>
> with your new feature should tell us that bulk of blame.[ch] that
> are new files came from builtin/blame.c with some symbols renamed.

Oh! Yeah, that looks nice. Though looking through that[1] it seems not yet
optimal to me.

So we have 2 additional colors for moved code to differentiate between
adjacent moved blocks. However in this implementation we toggle between
these two colors even if we're not adjacent, such that the moved_alternative
color shows up quite frequently.

So if we have normal lines in between, we may want to reset to "default"
moved color.

[1] http://i.imgur.com/djAoTf8.png

Thanks for pointing out this series,
Stefan
