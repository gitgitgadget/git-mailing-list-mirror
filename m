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
	by dcvr.yhbt.net (Postfix) with ESMTP id 47AC61F462
	for <e@80x24.org>; Sat, 25 May 2019 20:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfEYUqV (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 16:46:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43877 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfEYUqV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 16:46:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so16523249edb.10
        for <git@vger.kernel.org>; Sat, 25 May 2019 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ujSD9Uh9ggF0i5zOQ0vGGU23BAi2SdmDmiTfygQ1eKc=;
        b=MLuQ03jYtiOOf1aIJFlXyg6l0/ry8Zp69vn6mIVr+YNQICKMUUXlU2nqRen9f83nyY
         1vRF8m/itjI6mGRhBDMBDBOhU34OWCfYlCYiC7gFlnPcRLx8toAjF3qbQR/zrd8G8wuZ
         1pe6exI6IPhTNwkaQs8MVlCJ4ZTcbOJy9qXBbL1sB8OTTexn7hPtFtlQzKWRKVKaCpzv
         cnyx9jAJBPjMDkAu/REvLA7F63s3w63hNI0Jd0zHXH3d9EhPDN87JDwRk3dvb3XMvEu7
         IzJ/P/+CwyEp7Z8RYuzKNH5hwxuFEoNOyAR+1mzwI+kM0ooPTW7xH0O9YeAD/4e1GFKm
         +pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ujSD9Uh9ggF0i5zOQ0vGGU23BAi2SdmDmiTfygQ1eKc=;
        b=MiCuCaUvwEuoLewBvNKdwIofpxPCwozwWX+YbToyNGgZg39CRsWh/+w3cIeH4nMWFy
         ujJxJy5iv6Rlk/C5y5LeUwO35XKN5KVoTUbxylzwIix8U9qQk46PcRB0W66BfnYcqV4V
         vNadnzNourd4jXCUpj21LVnvyVTAnpRLut7JhK64qxeLCUQLrek6e+6pozoUnfREJ1dp
         H6ZJQB8AWwub3S15M5MQap8nScEtkS2M4lSv3O5k68jvTGwJ2G7k1gnsEm4DismKLHkh
         cfb9O8n9bLsIfwvqzslyXLiGpB9j/b8ZmjWGMOW4gukhVNJJlyuReCV6Qe8aSK0gi/le
         MmMg==
X-Gm-Message-State: APjAAAV4jRhI5PmtD1NY5ULX6ZzZENvadn0iqIkmZjRElK0t1HXkwtq5
        /e091bFdk5zc7LHLEKvZOEo7Khj/
X-Google-Smtp-Source: APXvYqzOYB0IYS1ay1JAIOc/FemXPXd+Ia/b5/SByBnB8fyo5+XVbU3FolakaJ5bUUIszZyqDWCi5Q==
X-Received: by 2002:a50:9705:: with SMTP id c5mr113692058edb.258.1558817179234;
        Sat, 25 May 2019 13:46:19 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id y20sm934730ejb.40.2019.05.25.13.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 13:46:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com> <20190524070644.GF25694@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190524070644.GF25694@sigill.intra.peff.net>
Date:   Sat, 25 May 2019 22:46:16 +0200
Message-ID: <878suufejr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, Jeff King wrote:

> On Fri, May 24, 2019 at 08:45:23AM +0200, Keegan Carruthers-Smith wrote:
>
>> git archive can generate a malformed tar archive. bsdtar reports the
>> error "tar: Ignoring malformed pax extended attribute" when reading
>> the archive. Go's "tar/archive" package also reports the error
>> "archive/tar: invalid tar header". However, BusyBox's tar does not
>> report the error (unsure if it just has less error logging).
>>
>> I can reproduce this when generating the tar on linux and mac. I
>> tested this with "git version 2.21.0" and a build of next I did today:
>> "git version 2.22.0.rc1.257.g3120a18244"
>>
>> Reproduction:
>>
>>   $ git clone https://github.com/SSW-SCIENTIFIC/NNDD.git
>>   $ cd NNDD
>>   $ git archive --format tar c21b98da2ca7f007230e696b2eda5da6589fe137
>> | tar tf - > /dev/null
>>   tar: Ignoring malformed pax extended attribute
>>   tar: Error exit delayed from previous errors.
>
> I can't reproduce on Linux, using GNU tar (1.30) nor with bsdtar 3.3.3
> (from Debian's bsdtar package). What does your "tar --version" say?
>
> Git does write a pax header with the commit id in it as a comment.
> Presumably that's what it's complaining about (but it is not malformed
> according to any tar I've tried). If you feed git-archive a tree rather
> than a commit, that is omitted. What does:
>
>   git archive --format tar c21b98da2^{tree} | tar tf - >/dev/null
>
> say? If it doesn't complain, then we know it's indeed the pax comment
> field.

Solaris tar also complains about this. I've seen that for ages, but
never thought to report it, I figured it was well-known.

When you "tar xf" an archive git-archive it complains:

    tar: pax_global_header: typeflag 'g' not recognized, converting to regular file

It will then extract the "pax_global_header" as if it were a file at the
root of the archive. That file will look like this:

    $ wc -c x/pax_global_header
      52 x/pax_global_header
    $ cat x/pax_global_header
    52 comment=$40_CHAR_SHA_1

Where $40_CHAR_SHA_1 is whatever commit this archive was produced from.
