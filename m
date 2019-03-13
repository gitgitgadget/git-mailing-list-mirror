Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F67C20248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCMXtd (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:49:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33608 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfCMXtc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:49:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id d12so3081054edp.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=EoGtRawB5wm6pOBikLnNBweMErqqbttX8Mg+4zUQtDw=;
        b=By4cOsT1gc9RPelKByZzwwUUnvy8DVEAlOoFmj/1Yjrbv83ICzBtVQCWi8sTxiqMeH
         tqbFLA/Dyf/f8gn5IXyc9ZFz6FG3+kWCFiypa4OfXxMf0LF0IF2VN91tafYkm4jt3nQ+
         uoZv4cotEsm8YJx1OnBn/tSzqrNKoLVpTvPBQjZziQHRAYENgWrX8z2UbmsaKQzFSKPq
         pcCQSccAAa74R3eFX1P8ZFugQe72XSsEhOjq0Kb7fNsH2rU7v21MRdaYX3d9kuyWQ1Mk
         S8OdJWF/kKjvvcd8Jwjtg126Ae+8ZVRb8TMyv0wpF5HfBGMayterOOSOdRX4AMX5bEVN
         j7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=EoGtRawB5wm6pOBikLnNBweMErqqbttX8Mg+4zUQtDw=;
        b=aw9cAj9vhwxFvLtc6I7zwYRtLa3D9bE4fdLLh3DulY0WNk7IBwI9ujI5KR43W31sNb
         RCx9mV6WZSjibvRIsBoS6YCVUAAj/SqdfwCClkrfAFkraOflzbxbPu9kN1sKXDYXBBnK
         cDdybZsPmf7UCGwNxvbPi5mbH0skAEEp2ITelVwYAJm3hezHeZDndP/a/XSTlExnr0iY
         4fO5xO8NBlC5HP0bVMr5wvFZqbdowjHOTIVLTlSWiANqR4uVXEOywL0CU+Rv6MIqS6QQ
         IbliRL5QLMqiX0ht4F70P/cgHHf3qGdmJ+l/v3GQ8kT2I1bf1fgDB4buke1QhBLdf4ob
         LTdQ==
X-Gm-Message-State: APjAAAWXlZ7ZVIbLGA5P9Vb7PqaTDCacaolxCIJcwn7HpNLBrkrekELH
        jaRQsY+NTvNiGncWPJtMCQA1Ni93
X-Google-Smtp-Source: APXvYqyJnFeP+mMhvGfTLZyGTpyhCRdL6y1Ekya/j5W/QPpnh+XQ8lTJzg4IfStOQNhRvTJHx7RbUg==
X-Received: by 2002:a17:906:95c3:: with SMTP id n3mr31487635ejy.59.1552520970655;
        Wed, 13 Mar 2019 16:49:30 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id m5sm752766ejk.8.2019.03.13.16.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 16:49:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 2/2] trace2: randomize/timestamp trace2 targets
References: <cover.1552519463.git.steadmon@google.com> <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <17ec237ba7498251a3ff64eec259d6f61c8f5ccc.1552519463.git.steadmon@google.com>
Date:   Thu, 14 Mar 2019 00:49:28 +0100
Message-ID: <87h8c6baif.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 14 2019, Josh Steadmon wrote:

> When the value of a trace2 environment variable contains instances of
> the string "%ISO8601%", expand them into the current UTC timestamp in
> ISO 8601 format.

Any reason not to just support feeding the path to strbuf_addftime(), to
e.g. support a daily/hourly log?

> When the value of a trace2 environment variable is an absolute path
> referring to an existing directory, write output to randomly-named
> files under the given directory. If the value is an absolute path
> referring to a non-existent file and ends with a dash, use the value as
> a prefix for randomly named files.
>
> The random filenames will consist of the value of the environment
> variable (after potential timestamp expansion), followed by a 6
> character random string such as would be produced by mkstemp(3).
>
> This makes it more convenient to collect traces for every git
> invocation by unconditionally setting the relevant trace2 envvar to a
> constant directory name.

Hrm, api-trace2.txt already specifies that the "sid" is going to be
unique, couldn't we just have some mode where we use that?

But then of course when we have nested processes will contain slashes,
so we'd either run into deep nesting or need to munge the slashes, in
which case we might bump against a file length limit (although I haven't
seen process trees deeper than 3-4).

Just to pry about the use-case since I'm doing similar collecting, why
are you finding this easier to process?

With the current O_APPEND semantics you're (unless I've missed
something) guaranteed to get a single process tree in nested order,
whereas with this they'll all end up in separate files and you'll need
to slurp them up, sort the whole thing and stitch it together yourself
without the benefit of stream-parsing it where you can cheat a bit
knowing that e.g. a "reflog expire" entry is always coming after the
corresponding "gc" that invoked it.
