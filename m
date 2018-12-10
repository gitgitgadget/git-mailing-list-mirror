Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935E320A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 21:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeLJV6P (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 16:58:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37609 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJV6O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 16:58:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so5610187pge.4
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 13:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3fpcgHoaTHi9DNCH+kxx30f4BZT8iqgOG9hwVVie7Sg=;
        b=qeOqiszY2A23yvNnSsAYHWx+fNHYPLUf1X1Gbshh0/IsRi/9OFsgwLBbwkHZ9/Qf5+
         xMEmbbmPOkBvdurLiqo6T3m/Mwj4iGTQahrIK/GpfjCmYm3wVDlyj4dI9Mrg2qYq6/it
         QVi5SOEX+oAL1aVvTFQQtTumztRnt/CIXToHhdJrV7G5NKochmH7YQ9Se8uRTnJZTCDf
         /xHVOhMUUfggwWnVPTRL+iKuQEkZ73ZQqUzehwMSjH8NylSv414tOJMNSUIAmtvb16jT
         gVp1Dd4+0WsTtYyErKp6O6HapicAK6TTbrCV+LikBWb0IOTBOdChG0tSCEFHcMet5AIm
         OauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3fpcgHoaTHi9DNCH+kxx30f4BZT8iqgOG9hwVVie7Sg=;
        b=JddlHpZWcRv8DJRJfbgzKt7M/PIf/ijcwFTbABNWYGrWQ9D/RDirInfXT/EWZ156lC
         4y9DEyQMj61Ixn4sNlbX/Ye/ONhkrR4YMyWXdq4QLTxy5ovjpnpwvx3vKHLTteN2tk3U
         t076CnXgkrTcFWeBNfrtCkaV135JQnf1CJC2i/fKAI9cC6+4hn9GDgh0wQZA1gL0+nzx
         lcQOF+4UvxgmiCn97EfzufMntPMvvlyfNZPYUsfDXH7XL5uzmmmNQ4cdXGcaLN1DUNhV
         t8/NmsjwrUDz4zEsFWlmu1aCKvacTgBAFOH+Bsc5Q0rK5qH4bUCW66TB63P0U7mj1qdi
         QVqA==
X-Gm-Message-State: AA+aEWa4BMlg+/3sDcR3FnG6EcDFt5VlL3V7TPflT+tllJ48tfLSEiYW
        piczaa6Uibf/+B3gUqhBLuVUiKFJnJl+Yg==
X-Google-Smtp-Source: AFSGD/UarqngBbVdCfmTxjvSqhbhBhAX+xjYvTtyd7lsXWdvVSNJfa7WnY7+vrzdV9UBd9jPxg9oAA==
X-Received: by 2002:a63:165e:: with SMTP id 30mr12388813pgw.103.1544479092564;
        Mon, 10 Dec 2018 13:58:12 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id 4sm27692583pfq.10.2018.12.10.13.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 13:58:11 -0800 (PST)
Date:   Mon, 10 Dec 2018 13:58:07 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH v3 2/3] commit-graph: fix buffer read-overflow
Message-ID: <20181210215807.GD37614@google.com>
Mail-Followup-To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com, peff@peff.net
References: <cover.1544127439.git.steadmon@google.com>
 <cover.1544221121.git.steadmon@google.com>
 <675d58ecea2f315bd05d2a21f6a473e9de1105a0.1544221121.git.steadmon@google.com>
 <xmqqsgz74acm.fsf@gitster-ct.c.googlers.com>
 <20181210042843.GQ30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181210042843.GQ30222@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.12.10 05:28, SZEDER Gábor wrote:
> On Sun, Dec 09, 2018 at 01:01:29PM +0900, Junio C Hamano wrote:
> > Josh Steadmon <steadmon@google.com> writes:
> > 
> > > diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> > > index 5fe21db99f..5b6b44b78e 100755
> > > --- a/t/t5318-commit-graph.sh
> > > +++ b/t/t5318-commit-graph.sh
> > > @@ -366,24 +366,30 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
> > >  GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
> > >  GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
> > >  
> > > -# usage: corrupt_graph_and_verify <position> <data> <string>
> > > +# usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
> > >  # Manipulates the commit-graph file at the position
> > > -# by inserting the data, then runs 'git commit-graph verify'
> > > +# by inserting the data, optionally zeroing the file
> > > +# starting at <zero_pos>, then runs 'git commit-graph verify'
> > >  # and places the output in the file 'err'. Test 'err' for
> > >  # the given string.
> > >  corrupt_graph_and_verify() {
> > >  	pos=$1
> > >  	data="${2:-\0}"
> > >  	grepstr=$3
> > > +	orig_size=$(stat --format=%s $objdir/info/commit-graph)
> > 
> > "stat(1)" is not so portable, so you'll get complaints from minority
> > platform users later.  So is "truncate(1)".
> 
> I complain: this patch breaks on macOS (on Travis CI), but in a
> curious way.  First, 'stat' in the above line errors out with:
> 
>   +++stat --format=%s .git/objects/info/commit-graph
>   stat: illegal option -- -
>   usage: stat [-FlLnqrsx] [-f format] [-t timefmt] [file ...]
> 
> Alas, this doesn't immediately fail the test, because it's not part of
> the &&-chain.
> 
> > > +	zero_pos=${4:-${orig_size}}
> 
> No && here, either.
> 
> > >  	cd "$TRASH_DIRECTORY/full" &&
> > >  	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> > >  	cp $objdir/info/commit-graph commit-graph-backup &&
> > >  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
> > > +	truncate --size=$zero_pos $objdir/info/commit-graph &&
> 
>   ++truncate --size= .git/objects/info/commit-graph
>   t5318-commit-graph.sh: line 385: truncate: command not found
> 
> Note that even if 'truncate' were available, it would most likely
> complain about the empty '--size=' argument resulting from the 'stat'
> error above.
> 
> Alas, this doesn't fail the test, either, because ...
> 
> > > +	truncate --size=$orig_size $objdir/info/commit-graph &&
> > >  	test_must_fail git commit-graph verify 2>test_err &&
> > >  	grep -v "^+" test_err >err
> 
> ... here the &&-chain was broken already before this patch.  However,
> since this above command was not executed due to the missing
> 'truncate', it didn't have a chance to create the 'err' file, ...
> 
> > >  	test_i18ngrep "$grepstr" err
> 
> ... so 'test_i18ngrep' can't find the file, which triggers its linting
> error, finally aborting the whole test script.
> 
> > >  }
> > >  
> > > +
> 
> Stray newline.
> 
> > >  test_expect_success 'detect bad signature' '
> > >  	corrupt_graph_and_verify 0 "\0" \
> > >  		"graph signature"
> > > @@ -484,6 +490,11 @@ test_expect_success 'detect invalid checksum hash' '
> > >  		"incorrect checksum"
> > >  '
> > >  
> > > +test_expect_success 'detect incorrect chunk count' '
> > > +	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\xff" \
> > 
> > Implementations of printf(1) may not grok "\xff" as a valid
> > representation of "\377".  The shell built-in of dash(1) for example
> > would not work with this.
> > 
> > > +		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
> > > +'
> > > +
> > >  test_expect_success 'git fsck (checks commit-graph)' '
> > >  	cd "$TRASH_DIRECTORY/full" &&
> > >  	git fsck &&

Thanks for the catch. All these will be fixed in V4.
