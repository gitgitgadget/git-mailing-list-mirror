Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6088206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 22:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756307AbcGHW74 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 18:59:56 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38888 "EHLO
	mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbcGHW7z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:59:55 -0400
Received: by mail-it0-f50.google.com with SMTP id h190so21092567ith.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 15:59:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9G8p/M6Xr3Ccgwbhzo2Sz+DG+QlNz4x1Jkqsci9qe04=;
        b=BruVN1ZmPYdcYgLtkw9/qoWH6XxiWXCb14YMxutBu/w2M5ZLZ4FP8mzY2t4u8UoyY5
         thYzlI1cFCkfFdZRrm3AWkyLIJHAJbhZam0zUIP5z2eKAtOLz8O5a+pcE8YfjvIzIMab
         FSYat4Dy/Qu0SxuENOrTUJU8JtCsznOBQBEO8wa2KbwT/DdQX6aoqNSNk+z3GBn5ECze
         ZRrfR+mnV5rUbyB9/ueW+Y1UwdajVavvqPOT83DLQxkO7fdEbM755TN3mJsZx0mjjAJ0
         3Cx547SjLCriZL9RrhNHysCZq29q4MvPAFotZd8h7qTyUH6cgzKmminp22E38BL84I6P
         88CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9G8p/M6Xr3Ccgwbhzo2Sz+DG+QlNz4x1Jkqsci9qe04=;
        b=PxQ7/+4fcWdqnL2ntFz884YNARrLpe5lrSAdC23seFGRmhPKlQEjsH6TPlXIJgI9L2
         apsXdMYjolrvOe2w52iw9htqOB+RGb2r/ht5JTrfn82GPseUf2ZCd0F01RFAczHnynKy
         3D1nD0V7TkhFrM+RohkD9TAvrr+1eGxKVsKyuD3FVF4E6d7F9rXK9nIxlLlmOU5FwUC4
         JnM1lGXZP0+qdztDQ0sYnJXwve/dl2wMkIkBInIe2HlPmhPP3yH/u7vCU2t5zVqcC+Kn
         bM4QqzVE+yqXdL5VJFD6uXUgAVEVj1bJZcw2RE7hX6xWA8n69sPbamjZP8FvGJmeDcNe
         SZng==
X-Gm-Message-State: ALyK8tIWNnhx2hGxQeJI3rr7hQ1oLqZXU7qjfKzWKd+oQOXX7EygZ47nc1iWivUCmfLRnZOAsNbkqdU5yPmPwx+q
X-Received: by 10.36.158.197 with SMTP id p188mr831053itd.97.1468018794409;
 Fri, 08 Jul 2016 15:59:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 8 Jul 2016 15:59:53 -0700 (PDT)
In-Reply-To: <xmqq60shp3w9.fsf@gitster.mtv.corp.google.com>
References: <20160707011218.3690-1-sbeller@google.com> <20160707011218.3690-4-sbeller@google.com>
 <xmqq60shp3w9.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 8 Jul 2016 15:59:53 -0700
Message-ID: <CAGZ79kbkbb=qYUYmKnuKwJCBtidymXua3eAZGANpXDHT56pqGQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] push: accept push options
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 7, 2016 at 1:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +-L::
>> +--push-option::
>> +     Transmit the given string to the server, which passes them to
>> +     the pre-receive as well as the post-receive hook. Only C strings
>> +     containing no new lines are allowed.
>
> This is to affect what happens at the remote end, so I would have
> understood "-R".  I also would have understood "-P" as a short-hand
> for "--push-option".  What is the justification of "-L"?

It was made up. The actual code took -o for option. Changed that.

>
> What does "C strings" mean?  Did you mean to say "A sequence of
> bytes excluding NUL is passed verbatim"?



>
> I do not think I saw anything in the code I reviewed so far that
> requires "no LF" limitation.

It is enforced server side, but an additional
client side enforcement may be better indeed.

The rationale for no enforcement on the client side is an easier way
forward if we allow it on the server as the client would "just work"
and it's up to the server to complain.

That makes me wonder if we want to document that, i.e.:

-o::
--push-option::
    Transmit the given argument to the server, which passes them to
    the pre-receive as well as the post-receive hook. As it is up to the
    server to react on these push options, it may reject push options
    that contain new line or NUL characters. .


>
> ... Ahh, OK, you want to make sure that push-options are
> one-per-line in the push certificate.  While I do not think it is
> absolutely necessary, starting with a possibly tighter than
> necessary limitation is much better than starting loose and having
> to tighten it later.

This is not what I had in mind, but rather the pain of dealing with multi line
environment variables.

>>                       transport_get(remote, NULL);
>> -
>> +             if (flags & TRANSPORT_PUSH_OPTIONS)
>> +                     transport->push_options = push_options;
>
> The result would be easier to read without the removal of a blank
> that separates decl/defn and stmt here.

ok

>> +             OPT_STRING_LIST('o', "push-option", &push_options, N_("server-specific"), N_("option to transmit")),
>
> Here it seems to expect "-o".  If we really want a short option,
> "-o" would probably be OK, as I do not think "git push" wants to
> have "send the output to this file" option.
>

Ok, will update the documentation.


>
> by adding this between the two lines in the pre-context of this
> hunk, i.e.
>
>         if (push_cert_nonce[0])
>                 strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
>         if (args->push_options)
>                 for_each_string_list_item(item, args->push_options)
>                         strbuf_addf(&cert, "push-option %s\n", item->string);
>         strbuf_addstr(&cert, "\n");
>

makes sense.
