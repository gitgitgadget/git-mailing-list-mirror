Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408671F462
	for <e@80x24.org>; Wed, 20 Feb 2019 16:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfBTQuy (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 11:50:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38797 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfBTQux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 11:50:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id v26so7101037wmh.3
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 08:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UCfSUSSd7hf6Kjc8e3ABbRoedir8/a3RPHBL8WjiNCY=;
        b=P+FgtuNRYRr4eBaU0b8vU2T+tYwevWetjfG/dPNoFHfqQ9kSf9eHO+PYr93NBZsB95
         d58z+rTc5JVFNb5Tif7r/c5w9m80p4zBw2jWgKsf3u+9LCd5vtHAHGnc8cpczv7pJZlo
         5tbtFfkq1+jxCe1zu+MKGuI4jnAjUYlBJb0bNm1EMryR3oIIGeUuyowt7MnYxSxGQQsH
         798aYhFWicc1AlcOyRxVVU/7N9OH2x9IVJukcQkv1Oy9OPwuALYzLS5amKpD/2Rt84xo
         UizYAB8dYsWxDHx5/xFOfhPKVzW53grMXQ7YvIjXCdnkfLNPQ9HyqMdPctm2xUSLBELL
         qpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UCfSUSSd7hf6Kjc8e3ABbRoedir8/a3RPHBL8WjiNCY=;
        b=ozhz8TGFe0mP4/0zKbvpq/ozhbEzBrgHzLkhT0FYN13G3xtr9IuB6HrEJGby94R21h
         wniY74dbov/jNT1bEB+7H7CZ+ZLVXNwdlxOOlAhiai143uBBLgcVQ0OIrX3V5C+8f44K
         mlEFzc0ejZMdzEfJY2SXlMhMvzA+xwFWba3aa3MFsCVA7Mt5P81jO2zGtVFpzBhfzjXA
         ht88H9sJPGJM9Spzxx+Yi6cfVuc7Oea2Vr8hcopDXgmmYKqdTNBy6ul5vOTiPYddmzXS
         4FFNpx9qWF3fACEJT8fkxWi64aNSJP8EOtc8Ksw4suk1ldPGAAv1PHQ2Soowc7h+QnZ8
         OjXQ==
X-Gm-Message-State: AHQUAubh5erPa+69HUQROU8t031Mbl8AqCGMTqd9eDUEwx8bkXSNsJBm
        JafskBlOs6ip7/iGtBIVY8c=
X-Google-Smtp-Source: AHgI3IYkDKTrFjTEaWwxNQbwWnGhwzo9q16s4q9asXXhzaVLWj5u36ygNJuAmkcYFf0DXJcaPZ9eSQ==
X-Received: by 2002:a1c:5fc5:: with SMTP id t188mr7125120wmb.86.1550681451500;
        Wed, 20 Feb 2019 08:50:51 -0800 (PST)
Received: from szeder.dev (x4db9774d.dyn.telefonica.de. [77.185.119.77])
        by smtp.gmail.com with ESMTPSA id d15sm43283011wrw.36.2019.02.20.08.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 08:50:50 -0800 (PST)
Date:   Wed, 20 Feb 2019 17:50:48 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH v6 2/3] commit-graph: fix buffer read-overflow
Message-ID: <20190220165048.GR1622@szeder.dev>
References: <cover.1544048946.git.steadmon@google.com>
 <cover.1547590928.git.steadmon@google.com>
 <d7b137650f9203148c1fb998a3dd4af7a2105e62.1547590928.git.steadmon@google.com>
 <87d0nm5x1d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0nm5x1d.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 03:55:58PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > @@ -376,11 +377,15 @@ corrupt_graph_and_verify() {
> >  	data="${2:-\0}"
> >  	grepstr=$3
> >  	cd "$TRASH_DIRECTORY/full" &&
> > +	orig_size=$(wc -c < $objdir/info/commit-graph) &&
> > +	zero_pos=${4:-${orig_size}} &&
> >  	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> >  	cp $objdir/info/commit-graph commit-graph-backup &&
> >  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
> > +	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
> > +	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
> 
> In the limited time I had to dig it starts failing at test 46, when
> count=0 is given. dd on NetBSD exits with 127 when given count=0 it
> seems.

So the first 'dd' is supposed to truncate the commit-graph file at
$zero_pos.  I don't think we need 'count=0' for that: in the absence
of the 'if=...' operand, 'dd' reads from standard input, which is
redirected from /dev/null in our test scripts, i.e. there is nothing
to read, and, consequently, there is nothing to write, either.

Though not strictly necessary, I would feel more comfortable if
'if=/dev/null' would be explicitly specified, and even more so with a
"# truncate at $zero_pos" comment above that command.

As to the second 'dd', I think we should not run it at all when count
would be zero, i.e. when $orig_size = $zero_pos, because in
combination with 'if=/dev/zero' it's asking for trouble.  According to
POSIX [1]:

  count=n
      Copy only n input blocks. If n is zero, it is unspecified
      whether no blocks or all blocks are copied.

Imagine a 'dd' that implements the second option: there are infinite
blocks in /dev/zero to copy!  OTOH, if an implementation chooses the
first option (e.g. the usual Linux 'dd' from coreutils), then both of
these 'dd' invocations will leave the commit-graph file as-is, so it
doesn't matter whether we run them or not.


[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/dd.html

