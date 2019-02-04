Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AB71F453
	for <e@80x24.org>; Mon,  4 Feb 2019 21:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfBDVgM (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 16:36:12 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43019 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBDVgL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 16:36:11 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so1223114eds.10
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 13:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WnaIEUN543ZY5i7V4bgsGHJPe8dglXaRaLt48p9H1fM=;
        b=bFXxIhhP7dhDmZ0C8+wht3GkCZQ0CUxSn70RuLFCfLrfgdlxnJlUHmmWQ3GG7fHJzn
         F2dRm+Mb9Odhm/TwVIDsdpuBkTS4+7U5rIfV1CXvC3o6B6ZAoyq9HTSLXG4ycI2PHZq5
         E/Y7c/NMuLHeHBDf+7p+NlQmK6iQKpzCF3e5L/xy9YpZBfDSKWk/hVCjTOKJK5NdEUIS
         PFMGhXHMg73DnYuWAz/ew1sPlQgGulQDufw8tov1I13m9oEAdrORmK9V0uKJNE8qWlWO
         OPl9Kmnlqw7obiZOps7xt1z1TubW/ExrS0uzaJ9DNt6auS7Nsmxgnmc6vGci/HPaBZlr
         gIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WnaIEUN543ZY5i7V4bgsGHJPe8dglXaRaLt48p9H1fM=;
        b=EyMToGGuycgC4v6Lphgf9bkDB9TbCa1B0QjfoxXdyRVFSa1lQv/ZAww5FP7MQLVCbB
         a6BRBEesrA2t1xzGG0lbe32aaDSHltoyEB08AM/GI1TncUbkngPLH+2uHIWKsuL6XUWt
         NUttuRL+8ERtIi98NloY9pZFcr5j0vTzV7PmQGAbRfjvqg+DjT09Tr5OtirJZ5iW2iSE
         7RmjSCS4T0wK+QZntySk+xVYufwsymzNzW0hAYe0ao3XEEc8DjazrEOJE2l2mdkZIDJ5
         08FpXqfqrVblif53yWVRwJ2IUC+f2YmfkhGqBvzEz38eJ6v+UmydCwNTQrL16uH4aGbE
         ZDTw==
X-Gm-Message-State: AHQUAuYeV+SrPtH5s0sFp1pxsfnxAS9qPS99LGatgFGPH9BlEx0nJSr6
        xmPXwG+PvToVBH62d6Zl3MaiQiSVZcc=
X-Google-Smtp-Source: AHgI3IaQyMjgJRC4krC+2shWNBk2wPQ1DtmdfDHvvf+nlC9Myo1zaVTK8iomzE92z4DBnFgfxesGsQ==
X-Received: by 2002:a50:94b6:: with SMTP id s51mr1177341eda.22.1549316170090;
        Mon, 04 Feb 2019 13:36:10 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b46sm4588978edc.57.2019.02.04.13.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 13:36:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] core.abbrev doc: document and test the abbreviation length
References: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net> <20190204161217.20047-1-avarab@gmail.com> <xmqq36p3uxq2.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqq36p3uxq2.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 04 Feb 2019 22:36:08 +0100
Message-ID: <87tvhjkzhz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 04 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> @@ -773,6 +773,14 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
>>  					return 1;
>>  				continue;
>>  			}
>> +			if (opt_with_value(arg, "--abbrev-len", &arg)) {
>> +				unsigned long v;
>> +				if (!git_parse_ulong(arg, &v))
>> +					return 1;
>> +				int len =3D abbrev_length_for_object_count(v);
>> +				printf("%d\n", len);
>> +				continue;
>> +			}
>
> Instead of exposing this pretty-much "test-only" feature as a new
> option to t/helper/test-tool, I think it is OK, if not even better,
> to have it in rev-parse proper like this patch does.

While I mainly added this code so I could prove the docs correct with a
test for both myself & others, I think having this exposed is probably
useful.

I've seen more than once some feature of a web frontend for git where
there's both access to aggregate statistics (number of commits or
objects), and SHA-1 shortening going on, but the latter is just done via
substr().

Right now we have nothing directly exposed to answer "what length would
git pick", you can of course e.g. "log --abbrev" a single commit, but if
that commit happens to be more ambiguous than most you'll get the right
answer.


> I however have a mildly strong suspition that people would expect
> "rev-parse --abbrev-len=3D<num>" to be a synonym of "--short=3D<num>"
>
> As this is pretty-much a test-only option, perhaps going longer but
> more descriptive would make sense?
>
> 	git rev-parse --compute-abbrev-length-for <object-count>
>
> may be an overkill, but something along those lines.

Yeah I think that's better. This is so rare that it's better to be
verbose.

> Oh by the way, the code has decl-after-stmt, and perhaps len needs
> to be of type "const int" ;-)

Thanks. Will fix.
