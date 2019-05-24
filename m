Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9051F462
	for <e@80x24.org>; Fri, 24 May 2019 10:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390419AbfEXKMO (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 06:12:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35698 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390230AbfEXKMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 06:12:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so2510060wmi.0
        for <git@vger.kernel.org>; Fri, 24 May 2019 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cNKZoXwZ0hkZiB77J7N5Y6KjG+/cNFsE3t0JruRXMZU=;
        b=P0N/PMVuV0DJkK24XKZ0U0UtLoIDRGs5VEzAGjURgkOn1P8m5Vn5I9pm0kikjGDkAF
         6X17PCQ+4lNKKRMQHXccs4UPR2B7lXpDz2Xk5gsZTDq5AqEU9ETnSCB33/JFIehE6j6T
         qHauVp+nnnCmkEYPMvNo9JO27DuE/PnfbZRZbfhquWKVfH7x4b2N5kEB7fCoiiA3kghF
         qw4oRkIujNLgHZ34lH8Q70E+Ek8662MVbzYPVM9g/zbsDQh8e6amV+xUtgGRNwy8Vq1U
         L1qEeTcWFiaFs01pDQcOC6cQ9zEn7hTx2/iqnjueJC5uU+aivpEHy5x8bLBKc3+eUz3V
         cH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cNKZoXwZ0hkZiB77J7N5Y6KjG+/cNFsE3t0JruRXMZU=;
        b=oyJYU+lZ2l5dvngrA1DwFRqT/av14MZ6s8xq8bUV5z0xqYJw1EPUYj2XWv+NuRbd5J
         QEf4DBidFNNPc8uAjkErtkA6ZKDlu9QIaHYrERzSH4M4puUbFG8Fye65lYlxvTohPgpX
         CcGs7h6Yb0ORPkgOFdnN7fFydndhrobYAlf/0EZG+qFrcWEVe3cDCV4ckxsX6FOlFTWu
         /n8xbX/3l306hxiHv5kR1l3gZKneoURfQ9s0dd+HsIgshElvdgEZmhb6vobUDhpMnlm0
         0rzvFyIQQtZRqNUSk2q7KrRt0YI+PHPfPRAbtdBZljMkWAZ2vBw4Zvz3XyviY/y0kCKZ
         7r+w==
X-Gm-Message-State: APjAAAVB26zwenAC7LAfUnA/Iulg6L+UT6E250ypIgXpTeItquPJqMIt
        wG/N4hQIkH4LeqTRFbV64+A=
X-Google-Smtp-Source: APXvYqyZjy8yPW1y69yJTZ4SarxA4jLn2pj6YvdybbbteptWu7FE3+5rq4bJf618P0RAOgbp1k3eLQ==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr16204480wmc.28.1558692732013;
        Fri, 24 May 2019 03:12:12 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x64sm3382061wmg.17.2019.05.24.03.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 03:12:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        "Matthias Urlichs" <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] hash-object doc: elaborate on -w and --literally promises
References: <20190520215312.10363-1-avarab@gmail.com> <20190520215312.10363-3-avarab@gmail.com> <20190522050839.GB29933@sigill.intra.peff.net> <86woigp3ro.fsf@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <86woigp3ro.fsf@gmail.com>
Date:   Fri, 24 May 2019 12:12:10 +0200
Message-ID: <87lfywf9fp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, Jakub Narebski wrote:

> Jeff King <peff@peff.net> writes:
>> On Mon, May 20, 2019 at 11:53:11PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>>> Clarify the hash-object docs to explicitly note that the --literally
>>> option guarantees that a loose object will be written, but that a
>>> normal -w ("write") invocation doesn't.
>>
>> I had to double-check here: you mean that _when_ we are writing an
>> object, "--literally" would always write loose, right?
>>
>>> At first I thought talking about "loose object" in the docs was a
>>> mistake in 83115ac4a8 ("git-hash-object.txt: document --literally
>>> option", 2015-05-04), but as is clear from 5ba9a93b39 ("hash-object:
>>> add --literally option", 2014-09-11) this was intended all along.
>>
>> Hmm. After reading both of those, I do think it's mostly an
>> implementation detail. I would not be at all surprised to find that the
>> test suite relies on this (e.g., cleaning up with rm
>> .git/objects/ab/cd1234). But I suspect we also rely on that for the
>> non-literal case, too. ;)
>>
>> So I am on the fence. In some sense it doesn't hurt to document the
>> behavior, but I'm not sure I would want to lock us in to any particular
>> behavior, even for --literally. The intent of the option (as I recall)
>> really is just "let us write whatever trash we want as an object,
>> ignoring all quality checks".
>
> I thik that this implemetation detail of `--literally` is here to stay;
> how would you otherwise fix the issue if garbage object makes Git crash?
>
> However, I would prefer to have options state _intent_; if there is
> legitimate need for a tool that creates loose objects, it would be
> better to have separate `--loose` option to `git hash-object` (which
> would imply `-w`, otherwise it doesn't have sense).

I wonder if we can just remove this option and replace it with a
GIT_TEST_* env variable, or even a test-tool helper. I can't see why
anyone other than our own test suite wants this, and that's why it was
added. So why document it & expose it in a plumbing tool?

>>>  --literally::
>>> -	Allow `--stdin` to hash any garbage into a loose object which might n=
ot
>>> +	Allow for hashing arbitrary data which might not
>>>  	otherwise pass standard object parsing or git-fsck checks. Useful for
>>>  	stress-testing Git itself or reproducing characteristics of corrupt or
>>> -	bogus objects encountered in the wild.
>>> +	bogus objects encountered in the wild. When writing objects guarantees
>>> +	that the written object will be a loose object, for ease of debugging.
>>
>> I had to read this last sentence a few times to parse it. Maybe a comma
>> before guarantees would help? Or even:
>>
>>   When writing objects, this option guarantees that the written object
>>   will be a loose object, for ease of debugging.
>
> I agree that this reads better.
>
> Regards,
