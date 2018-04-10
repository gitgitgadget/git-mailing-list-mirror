Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9FA1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 16:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeDJQB6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 12:01:58 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:39961 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeDJQB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 12:01:58 -0400
Received: by mail-ot0-f178.google.com with SMTP id j8-v6so13340880ota.7
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 09:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pyhRo20m0j5MmcVF87tJYp8OcZJP3DmnB1R9r+3M7YA=;
        b=IKaOWFTQh8j21XcGMy1HDbiPq0dhcbec8qtmyx5VouIcdxd6Si23QpOEDXTKIDagjS
         CltevIts22D14MOXIhxeie7V0PzcMREMI3DnrZHjgfq8hYONWHLIFM7GJg0FEyHhoGFo
         djxciXfXQJq7QWpb8KrmbkVjXLwnJFFPO+X+gFDFKEp+JnaP0VnUgWnzIDdXQWqZ4oTt
         S9U8om74krHWj0WemcqHjTY23BozZDhri1FD86VzWYnbzHcydVQgcXJBmB3ZdJK4sHnm
         N9pK8C1WHra7MxkMVGanzW9k/nhu2Y5lWfbdpBUfc0ANgTufHMtJlTQrzAKWu+FiLa4U
         w0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pyhRo20m0j5MmcVF87tJYp8OcZJP3DmnB1R9r+3M7YA=;
        b=qbxYaXw9fLxY/77AqTO7a3OskNytZ0AdsMjZHOLBfCaO6qmFDPHX7xx5Z1ps5KdvOv
         FnvOF1MqBBG2b0RsnhZOG3aJE17avdbB01fJ9nQyKFGQFtRZdv913an2EdkqK7NYaOEN
         AttbsSsHXefSUZPmouzVtsA2yL3e+5KyLC0Pa6pVb+lw0t1X0ubhTf1gFDg2+0fE27kv
         M0rEShyBD6SYVBWVQHlm8dJVx/nMdsFLyVRPKF7epqpCtWU+9IKAgf/KjrYxzBW8oz8w
         YdOEABQ+9lYHvt5VDVY5cGJLm6qGyhPSN+RJ+RbRmSgENhPOqmgBlH3RYZe7euvqX/FA
         1fLQ==
X-Gm-Message-State: ALQs6tAV5a5XRCEvjCdeYShuG+8ap+XgM5w8hm7aCHeKTPbivjBFhEF2
        rOLLI/PGgDWZWyIcbhxkuhIZHBHznfm+dq7gSjf6Iw==
X-Google-Smtp-Source: AIpwx4/hLmj4x6SZF2EBvE1v/PmJDh1ZsNBu3U801mequ/Vruz8TlMgx8LkUVlH3crZ/BhOHgzzS0T08LInH6nZWv0w=
X-Received: by 2002:a9d:2d03:: with SMTP id v3-v6mr656760ota.334.1523376117107;
 Tue, 10 Apr 2018 09:01:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.56.25 with HTTP; Tue, 10 Apr 2018 09:01:36 -0700 (PDT)
In-Reply-To: <xmqqr2nn2ylz.fsf@gitster-ct.c.googlers.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com> <20180409204129.43537-9-mastahyeti@gmail.com>
 <xmqqr2nn2ylz.fsf@gitster-ct.c.googlers.com>
From:   Ben Toews <mastahyeti@gmail.com>
Date:   Tue, 10 Apr 2018 10:01:36 -0600
Message-ID: <CAE=pOyHey_8kJ0JsA3ROhpE9qn+HivVQgwd+Wdonw8L6D+9MUg@mail.gmail.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 3:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ben Toews <mastahyeti@gmail.com> writes:
>
>> From: Ben Toews <btoews@github.com>
>>
>> Currently you can only sign commits and tags using "gpg".
>> ...
>> have asked before on the list about using OpenBSD signify).
>> ---
>
> Missing sign-off.
>
>> -gpg.program::
>> -     Use this custom program instead of "`gpg`" found on `$PATH` when
>> -     making or verifying a PGP signature. The program must support the
>> -     same command-line interface as GPG, namely, to verify a detached
>> -     signature, "`gpg --verify $file - <$signature`" is run, and the
>> -     program is expected to signal a good signature by exiting with
>> -     code 0, and to generate an ASCII-armored detached signature, the
>> -     standard input of "`gpg -bsau $key`" is fed with the contents to be
>> +signingtool.<name>.program::
>> +     The name of the program on `$PATH` to execute when making or
>> +     verifying a signature.
>
> I think you do not want "on `$PATH`", as you should be able to
> specify a full path /opt/some/where/not/on/my/path/pgp and have it
> work just fine.  The mention of "found on `$PATH`" in the original
> is talking about the behaviour _WITHOUT_ the configuration, i.e. by
> default we just invoke "gpg" and expect that it is found in the
> usual measure, i.e. being on user's $PATH.  What you are describing
> in this updated explanation is what happens _WITH_ the configuration.
>
>> +     This program will be used for making
>> +     signatures if `<name>` is configured as `signingtool.default`.
>> +     This program will be used for verifying signatures whose PEM
>> +     block type matches `signingtool.<name>.pemtype` (see below). The
>> +     program must support the same command-line interface as GPG.
>> +     To verify a detached signature,
>> +     "`gpg --verify $file - <$signature`" is run, and the program is
>> +     expected to signal a good signature by exiting with code 0.
>> +     To generate an ASCII-armored detached signature, the standard
>> +     input of "`gpg -bsau $key`" is fed with the contents to be
>>       signed, and the program is expected to send the result to its
>> -     standard output.
>> +     standard output. By default, `signingtool.gpg.program` is set to
>> +     `gpg`.
>
> I do not think the description is wrong per-se, but reading it made
> me realize that with this "custom" program, you still require that
> the "custom" program MUST accept the command line options as if it
> were an implementation of GPG.  Most likely you'd write a thin
> wrapper to call your custom program with whatever options that are
> appropriate when asked to --verify or -bsau (aka "sign")?  If that
> is the case, I have to wonder if such a wrappper program can also
> trivially reformat the --- BEGIN WHATEVER --- block and behave as if
> it were an implementation of GPG.  That makes the primary point of
> this long series somewhat moot, as we won't need that pemtype thing
> at all, no?
>

Just because a signature is PEM encoded and claims to be a "PGP
SIGNATURE", doesn't mean it can be understood or verified by a PGP
implementation. Without different tools specifying different PEM types
we would have no way of knowing which tool to route the signature to
for verification.

>> +signingtool.<name>.pemtype::
>> +     The PEM block type associated with the signing tool named
>> +     `<name>`. For example, the block type of a GPG signature
>> +     starting with `-----BEGIN PGP SIGNATURE-----` is `PGP
>> +     SIGNATURE`. When verifying a signature with this PEM block type
>> +     the program specified in `signingtool.<name>.program` will be
>> +     used. By default `signingtool.gpg.pemtype` contains `PGP
>> +     SIGNATURE` and `PGP MESSAGE`.
>
> As Eric noted elsewhere, I suspect that it is cleaner and more
> useful if this were *NOT* "pemtype" but were "boundary", i.e.
> letting "-----BEGIN PGP SIGNATURE-----\n" string be specified.
>
>> +signingtool.default::
>> +     The `<name>` of the signing tool to use when creating
>> +     signatures (e.g., setting it to "foo" will use use the program
>> +     specified by `signingtool.foo.program`). Defaults to `gpg`.
>
> Will there be a command line option to say "I may usually be using
> whatever I configured with signingtool.default, but for this single
> invocation only, let me use something else"?  Without such a command
> line option that overrides such a default, I do not quite get the
> point of adding this configuration variable.
>
> Thanks.



-- 
-Ben Toews
