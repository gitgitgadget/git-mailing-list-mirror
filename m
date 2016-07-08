Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FE9206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 22:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401AbcGHW3M (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 18:29:12 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35900 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319AbcGHW3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:29:10 -0400
Received: by mail-it0-f42.google.com with SMTP id f6so14306419ith.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 15:29:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hDh4jzQwwr04LZR5n+v+d6RM6fCg9mW3OGSJq/y3cJ0=;
        b=bbnihaeH431LK4egJZ/iO99ewNB5ihk5auNTK8apg+33ROslI8nty8lI4SSIdMTG6M
         pniexQqjgBj+0YIiccltp4PNETZdVeQBXhOZ8nwVw4fO3mvlwkrchdOIjlSwTh729ltM
         s8W780odofBJHW+QWzc/FTPmeCkRGv7u7fvUyG4v90Ki/Ip5OQwVLnabeFUlo/g7tdQW
         Vxs3J0iSpcTqiD0LMkU3gVvZdLFd9bB8t+/YuhR3cexd4muW0jkv9XbZSJp5AHI46MKT
         jPTO58ZraMY3pXvjet3YPZsmK5lTVPHtqgPWpAhrKTSEI6VabpKXtFlhMCW++4JQ5ycM
         9Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hDh4jzQwwr04LZR5n+v+d6RM6fCg9mW3OGSJq/y3cJ0=;
        b=fb/qhUkoabQjg2PJw8LTOTJnfDee6ZLh1otc2a4ymxyfwyk72TW85H4DZdlHuvcbeF
         4/JlUlfaYIwJVNCJygn8kj+PfVh3A3+zqgRrtOiAELlAaBaEmCiU2KL6GdwluYkclIt+
         +HjMn0mmcfaTlc+ol3GdQkrQjursXSVT/X4mNDtiW53q7+Ui1bvhgrx0m9nzWHHoWraP
         WfMrVoLJNHtmsA/AdX1lmhSwve4wX3a+5FP637fw4MNIBcp2L5YXeLBohqOgQHo5t/J2
         NWHJFmcFIZzyZ8TYYFXc3qBQcgQhLknk8w/4vg81j5yxmtA57sblqTzAYSwiJBWfjhbP
         hh5A==
X-Gm-Message-State: ALyK8tJskK39Ch1n0YP95tZApP/qeadYopsuqrF5Ya8defbD9FWmTLCJ2xeKxha5oo4AHXFOIinWYu2APZWjHvQr
X-Received: by 10.36.95.146 with SMTP id r140mr5574815itb.49.1468016949855;
 Fri, 08 Jul 2016 15:29:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 8 Jul 2016 15:29:09 -0700 (PDT)
In-Reply-To: <20160708222127.GA10756@sigill.intra.peff.net>
References: <20160707011218.3690-1-sbeller@google.com> <20160707011218.3690-3-sbeller@google.com>
 <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com> <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
 <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com> <20160708175821.GA29326@google.com>
 <xmqqshvkkm86.fsf@gitster.mtv.corp.google.com> <CAGZ79ka8eHOx28Ja+S6DOGEOrV_ijUvi_NnjprhuzQ+3O9BAoQ@mail.gmail.com>
 <20160708214637.GB9820@sigill.intra.peff.net> <CAGZ79kZOdcJwd0ePMquhfJTv=xZGP_+w4BRV=GyTy3ejb79yrQ@mail.gmail.com>
 <20160708222127.GA10756@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 8 Jul 2016 15:29:09 -0700
Message-ID: <CAGZ79kbu1ec-8LiFrvnXqFqsjFnEofhjZnxcENa1aA1K56m9Fg@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 8, 2016 at 3:21 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jul 08, 2016 at 03:17:13PM -0700, Stefan Beller wrote:
>
>> >If people are seeing these in
>> > routine use, then the limits are set too low, and this should happen
>> > roughly as often as a BUG assertion, and IMHO should be treated roughly
>> > the same: don't bother with translation, and don't worry about
>> > optimizing wasted bandwidth for this case. It won't happen enough to
>> > matter.
>>
>> Well the wasted band width is part of the server protection, no?
>
> Not if you stop receiving as soon as you hit the limits. Then of course
> they can send up to the limit each time, but that is not a DoS. That is
> things working as advertised.
>
>> This would favor the idea Jonathan came up with:
>>
>>     server: I advertise push options
>>     client: ok I want to use push options
>>     client: I'll send you 1000 push options with upper bound of 1000M
>>     server: It's a bit too much, eh?
>>     * server quits
>>
>> So this case only occurs for the (malicious?) corner case, where I
>> do not bother a translation.
>
> In the malicious case, the client says "I'll send you 10 push option
> with an upper bound of 1024K", and then sends gigabytes anyway. Either
> way the server has to react to what is sent, not what is promised.

Well that is what the initial patch did via:

+       for (i = 0; i < max_options; i++) {
+               char *line;
+               int len;
+
+               line = packet_read_line(0, &len);
+
+               if (!line)
+                       break;
+
+               if (len > max_size)
+                       die("protocol error: server configuration allows push "
+                           "options of size up to %d bytes", max_size);
+
+               len = strcspn(line, "\n");
+               line[len] = '\0';
+
+               string_list_append(ret, line);
+       }
+       if (i == max_options)
+               die("protocol error: server configuration only allows up "
+                   "to %d push options", max_options);

I assume the die is an effective way to "stop receiving".

Thinking further about what you said, I think the initial selections of
max_size and max_options is sufficient and we only see those bounds in
the malicious case.

This discussion rather makes me wonder if we want to stick to the initial design
as it was easy and not overcomplicating things as we assume the abort case
doesn't occur often.


>
> -Peff
