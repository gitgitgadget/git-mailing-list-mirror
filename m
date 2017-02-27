Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F68C1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdB0WUx (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:20:53 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34378 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbdB0WT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:19:27 -0500
Received: by mail-lf0-f68.google.com with SMTP id a198so4494026lfb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=b5C4L/BQjSQQPeHQvenZthIuXoa6ijhuNjNtWRWgfj4=;
        b=kyUSOFvrpsmXGjSt5pGL7HgbHtalOHQItMBbJWKa8StHmb03G8DuuTWgnD1H9Xwx6j
         yIrganujClsG2mHpjkwiZBi2KVrjXbeLoDpLlSbe3YJVpeN0435fmmF+ZriX1fL+vUnJ
         vET8UiaBOMp9iUqkeGr91ozsrcbmkDVNLTezJC/W6EwFzbJ7wcr6M36QC+h3MY/4GrxB
         YnvEKgqsWR8tUfOqvc3lmK3V7GbLFJJV4T4Ho1/vKSJmPSJUYIHFjq38vFDLWK40ktNV
         Ri58PsNLBspy4nXdaFvTaWoLHzTaG2q68jOqxQdUE05FmlOH8bhAuJ2eB6kqcE88rSAu
         6p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=b5C4L/BQjSQQPeHQvenZthIuXoa6ijhuNjNtWRWgfj4=;
        b=SMKNFH4wfXADyBLRUc76UXUUqQnTamcrBCphkF00FTfp9ttYlPQi+eCsvp2PthlDPI
         MEJfIB9p4JT4sTh52ePQoVaAnyum40/S6ICsOcmMnXu5njv4FCgby9c5N9fXgZJG9EyY
         bfZgnljuNKGJJwRqSLgGgiVm8lksoRqcvdFxMIRUrtZhXvr698829oB1Ge9OPNsD/cCf
         y0ximflSabTYdhkgCgvZTtSfyclc4w+JWsgYmSgP/DRuQ97TEbcOVHBFc0LeT8qlTtg4
         DeJQ8ufQT6U+T1/FEEWoBJjK95eWHUd445S3SdxCyXXGr7Q2Ttrw02Ywu6HJ88gH5+zG
         eU7w==
X-Gm-Message-State: AMke39kqvalba6GvXSFRDpl2UGeadRT/ylKysfml4VT7Jo+I7WxhcB90VXXYhWFnkFXo6w==
X-Received: by 10.46.9.76 with SMTP id 73mr5365870ljj.128.1488233485093;
        Mon, 27 Feb 2017 14:11:25 -0800 (PST)
Received: from [192.168.1.26] (deg240.neoplus.adsl.tpnet.pl. [83.23.110.240])
        by smtp.googlemail.com with ESMTPSA id f137sm4177379lff.21.2017.02.27.14.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2017 14:11:24 -0800 (PST)
Subject: Re: [PATCH v2] convert: add "status=delayed" to filter process
 protocol
To:     Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
References: <20170226184816.30010-1-larsxschneider@gmail.com>
 <20170227095825.jhdspwy6oa6mvvvm@sigill.intra.peff.net>
 <E4A6D866-D046-4CF3-8050-666FD6C98F7B@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Eric Wong <e@80x24.org>, Taylor Blau <ttaylorr@github.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <7fbf63df-c61f-3d4b-99a8-eea52049709d@gmail.com>
Date:   Mon, 27 Feb 2017 23:11:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <E4A6D866-D046-4CF3-8050-666FD6C98F7B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 27.02.2017 o 11:32, Lars Schneider pisze:
> 
>> On 27 Feb 2017, at 10:58, Jeff King <peff@peff.net> wrote:
>>
>> On Sun, Feb 26, 2017 at 07:48:16PM +0100, Lars Schneider wrote:
>>
>>> +If the request cannot be fulfilled within a reasonable amount of time
>>> +then the filter can respond with a "delayed" status and a flush packet.
>>> +Git will perform the same request at a later point in time, again. The
>>> +filter can delay a response multiple times for a single request.
>>> +------------------------
>>> +packet:          git< status=delayed
>>> +packet:          git< 0000
>>> +------------------------

Is it something that happens instead of filter process sending the contents
of file, or is it something that happens after sending some part of the
contents (maybe empty) instead of empty list to keep "status=success"
unchanged or instead of "status=error" if there was a problem processing
file?

>>> +
>>
>> So Git just asks for the same content again? I see two issues with that:
>>
>>  1. Does git have to feed the blob content again? That can be expensive
>>     to access or to keep around in memory.
>>
>>  2. What happens when the item isn't ready on the second request? I can
>>     think of a few options:
>>
>>       a. The filter immediately says "nope, still delayed". But then
>>          Git ends up busy-looping with "is this one ready yet?"
>>
>>       b. The filter blocks until the item is ready. But then if other
>> 	  items _are_ ready, Git cannot work on processing them. We lose
>> 	  parallelism.
>>
>>       c. You could do a hybrid: block until _some_ item is ready, and
>>          then issue "delayed" responses for everything that isn't
>> 	  ready. Then if you assume that Git is looping over and over
>> 	  through the set of objects, it will either block or pick up
>> 	  _something_ on each loop.
>>
>> 	  But it makes a quadratic number of requests in the worst case.
>> 	  E.g., imagine you have N items and the last one is available
>> 	  first, then the second-to-last, and so on. You'll ask N times,
>> 	  then N-1, then N-2, and so on.

The current solution is a 'busy loop' one that I wrote about[1][2],
see below.

> 
> I completely agree - I need to change that. However, the goal of the v2
> iteration was to get the "convert" interface in an acceptable state.
> That's what I intended to say in the patch comment section:
> 
>     "Please ignore all changes behind async_convert_to_working_tree() and 
>      async_filter_finish() for now as I plan to change the implementation 
>      as soon as the interface is in an acceptable state."

I think that it is more important to start with a good abstraction,
and the proposal for protocol, rather than getting bogged down in
implementation details that may change as the idea for protocol
extension changes.

>>
>> I think it would be much more efficient to do something like:
>>
>>  [Git issues a request and gives it an opaque index id]
>>  git> command=smudge
>>  git> pathname=foo
>>  git> index=0
>>  git> 0000
>>  git> CONTENT
>>  git> 0000
>>
>>  [The data isn't ready yet, so the filter tells us so...]
>>  git< status=delayed
>>  git< 0000

So is it only as replacement for "status=success" + contents or
"status=abort", that is upfront before sending any part of the file?

Or, as one can assume from the point of the paragraph with the
"status=delayed", it is about replacing null list for success or
"status=error" after sending some part (maybe empty) of a file,
that is:

    [filter driver says that it can process contents]
    git< status=success
    git< 0000
    git< PARTIAL_SMUDGED_CONTENT (maybe empty)
    [there was some delay, for example one of shards is slow]
    git< 0000
    git< status=delayed
    git< 0000

>>
>>  [Git may make other requests, that are either served or delayed]
>>  git> command=smudge
>>  git> pathname=foo
>>  git> index=1
>>  git> 0000
>>  git< status=success
>>  git< 0000
>>  git< CONTENT
>>  git< 0000
>>
>>  [Now Git has processed all of the items, and each one either has its
>>   final status, or has been marked as delayed. So we ask for a delayed
>>   item]
>>  git> command=wait
>>  git> 0000

In my proposal[2] I have called this "command=continue"... but at this
point it is bikeshedding.  I think "command=wait" (or "await" ;-))
might be better.

>>
>>  [Some time may pass if nothing is ready. But eventually we get...]
>>  git< status=success

Or

    git< status=resumed

If it would not be undue burden on the filter driver process, we might
require for it to say where to continue at (in bytes), e.g.

    git< from=16426

That should, of course, go below index/pathname line.

>>  git< index=0

Or a filter driver could have used pathname as an index, that is

    git< pathname=path/testfile.dat

>>  git< 0000
>>  git< CONTENT
>>  git< 0000
>>
>> From Git's side, the loop is something like:
>>
>>  while (delayed_items > 0) {
>> 	/* issue a wait, and get back the status/index pair */
>> 	status = send_wait(&index);
>> 	delayed_items--;

This looks like my 'event loop' proposal[1][2], see below.

>>
>> 	/*
>> 	 * use "index" to find the right item in our list of files;
>> 	 * the format can be opaque to the filter, so we could index
>> 	 * it however we like. But probably numeric indices in an array
>> 	 * are the simplest.
>> 	 */
>> 	assert(index > 0 && index < nr_items);
>> 	item[index].status = status;
>> 	if (status == SUCCESS)
>> 		read_content(&item[index]);
>>  }
>>
>> and the filter side just attaches the "index" string to whatever its
>> internal queue structure is, and feeds it back verbatim when processing
>> that item finishes.

I have wrote about this for v1 version of this patch series:

[1]: https://public-inbox.org/git/ec8078ef-8ff2-d26f-ef73-5ef612737eee@gmail.com/
[2]: https://public-inbox.org/git/17fa31a5-8689-2766-952b-704f433a5b3a@gmail.com/

> 
> That could work! I had something like that in mind:
> 
> I teach Git a new command "list_completed" or similar. The filter
> blocks this call until at least one item is ready for Git. 
> Then the filter responds with a list of paths that identify the
> "ready items". Then Git asks for these ready items just with the
> path and not with any content. Could that work? Wouldn't the path
> be "unique" to identify a blob per filter run?

Why in the "drain" phase it is still Git that needs to ask filter for
contents, one file after another?  Wouldn't it be easier and simpler
for filter to finish sending contents, and send signal that it has
finished continue'ing?

To summarize my earlier emails, current proposal looks for me as if
it were a "busy loop" solution, that is[2]:

          while there are delayed paths:
                  for each delayed path:
                          request path from filter [a]
                          fetch the thing (supporting "delayed") [b]
                          if path done
                                  do the caller's thing to use buf
                                  remove it from delayed paths list


Footnotes:
----------
a) We don't send the Git-side contents of blob again, isn't it?
   So we need some protocol extension / new understanding anyway.
   for example that we don't send contents if we request path again.
b) If path is not ready at all, filter protocol would send status=delayed
   with empty contents.  This means that we would immediately go to the
   next path, if there is one.

There are some cases where busy loop is preferable, but I don't think
it is the case here.


The "event loop" solution, which is I think what Peff proposed, would
be something like this (from the protocol point of view, rather than
from the Git code point of view)[1]:

        while there are delayed paths:
                get path that is ready from filter
                fetch the thing to buf (supporting "delayed")
                if path done
                        do the caller's thing to use buf 
                        (e.g. finish checkout path, eof convert, etc.)

We can either trust filter process to tell us when it finished sending
delayed paths, or keep list of paths that are being delayed in Git.


Also, one thing that we need to be solved, assuming that the proposed
extension allows to send partial data from filter to be delayed and
continued later, is that Git needs to keep this partial response in buf;
this is because of precedence of gitattributes applying:

  Interaction between checkin/checkout attributes
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  In the check-in codepath, the worktree file is first converted with
  `filter` driver (if specified and corresponding driver defined), then
  the result is processed with `ident` (if specified), and then finally
  with `text` (again, if specified and applicable).

  In the check-out codepath, the blob content is first converted with
  `text`, and then `ident` and fed to `filter`.

Or maybe I misunderstood something; I am a bit confused by check-in
vs check-out there...


Note that with support of "command=wait" / "command=continue" Git
could interrupt sending contents, and drain unfinished files, if
it needs it... then continue sending rest of files.  Well, if the
protocol extension is interpreted to allow for this.

Best regards,
-- 
Jakub Narębski

