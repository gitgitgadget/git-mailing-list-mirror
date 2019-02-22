Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5056A1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 10:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfBVKvA (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 05:51:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54489 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfBVKu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 05:50:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so1527096wmh.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 02:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yKMCW3tdl6mYs5IZ57Xmj1jBrhvM5yRu3Lk5M76VGQg=;
        b=S+ExCGxbouZc8oC8d2juFlcQzG+cfW7h+dBJub3q313dUAqftYiKPGmP4DGVhHSQ8E
         5VhVZwoUJQVXta+nUKbAPUyppjC58Om7nBfXm8/CbB2VBYubcSG0ePztZWEts/wcEcyf
         +R+fwqrIvLTi1NXwpvdgKF3oJ7+RkGYrQ9+9j5+bivt/LKPr3ydnMmL/PBpRQf3lvqOT
         BlBfToLCuImovIjxchMHx+5FmRDnml3KQA+sqkAzlmzm8V5auHFxTOEPLOGGZnlPpAy5
         7Ns9ajQbR9P1MZ1RLRR7fK7ibMANh7WK8H4pFVvO47TvGSoW2qJCHaWaTU2g3eJ/BxBl
         pWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yKMCW3tdl6mYs5IZ57Xmj1jBrhvM5yRu3Lk5M76VGQg=;
        b=G9oaWMj4pE8t5WsHuNlPr3rYWPqXvfGiyU+PhyEzEiJdrNScr5QCBp6WunkgaTdMNT
         Nzc/GzeIYWIxGmYZF9sRXIUTeJe3QKBY0s+p3RB03BXRWr0Y7SPosmgcbFa1JeEVYwdA
         myWpNlKYrWTw1QnMJCTbiCp7a4yo2blWOqby1eRWSFGHLW/X5JrRG96UA9FxTtZC8QgN
         3k3Z63qryCu4nblPH116asGJG/tvugoGCQbdTD2TEmoVI+wAXK7l5UKsxYSnQQbf3KvL
         1HY0JEe3W/wQvIVYYyX9eFttceKJXz8QmUxn70WNTDPUiSISZ4PW0WljGXivEULJ241Y
         PYYQ==
X-Gm-Message-State: AHQUAuYV3g/Z+wTUPlpVK2Ad3ye8zUtW313qM7fvKe5Q3Zv7FVGNUHEA
        ybbIL/d02dbeqn0JbtY8r+U=
X-Google-Smtp-Source: AHgI3IaXHPQQcEFhBqiuGqGAS6l9X2pymaQYbbDGeYOfb5x4iP5U4k7lv2+SDLHkt9IjgddZUnwh7g==
X-Received: by 2002:a1c:7eca:: with SMTP id z193mr2254097wmc.140.1550832657170;
        Fri, 22 Feb 2019 02:50:57 -0800 (PST)
Received: from szeder.dev (x4dbd721b.dyn.telefonica.de. [77.189.114.27])
        by smtp.gmail.com with ESMTPSA id b195sm2940119wmg.36.2019.02.22.02.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 02:50:56 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:50:53 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] commit-graph tests: fix cryptic unportable "dd"
 invocation
Message-ID: <20190222105053.GU1622@szeder.dev>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
 <20190221192849.6581-3-avarab@gmail.com>
 <20190221204310.GS1622@szeder.dev>
 <878sy86anh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878sy86anh.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 11:26:26PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> -	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
> >> +	perl -we 'truncate $ARGV[0], $ARGV[1] if -s $ARGV[0] > $ARGV[1]' \
> >> +		$objdir/info/commit-graph $zero_pos &&
> >
> > This will make Dscho unhappy :)
> 
> Sorry Dscho :)
> 
> Although this is a one-off in one test, as opposed to a new "perl -e" in
> test-lib-functions.sh
> 
> > Is there a problem with:
> >
> >   dd if=/dev/null of="$objdir/info/commit-graph" bs=1 seek="$zero_pos"
> >
> > ?
> >
> > To my understanding of the specs it's well-defined what it should do,
> > even when $zero_pos is larget than the file size,  it's shorter,
> > simpler, and doesn't introduce yet another Perl dependency.
> 
> I tried that as a one-off and it indeed works as a "truncate" on NetBSD
> & GNU.
> 
> My reading of POSIX "dd" and "lseek" docs is that we'd need some similar
> guard if we're going to be paranoid about a $zero_pos value past the end
> of the file. It doesn't look like that's portable, my assumption from
> reading the docs is that the seek=* will devolve without a stat() check
> on some "dd" implementations to an "lseek".

Could you point to the part of the specs where your assumption comes
from?  The specs are quite clear on what should happen:

  If the size of the seek plus the size of the input file is less than
  the previous size of the output file, the output file shall be
  shortened by the copy. If the input file is empty and either the
  size of the seek is greater than the previous size of the output
  file or the output file did not previously exist, the size of the
  output file shall be set to the file offset after the seek.

IOW no such guard is necessary.

I checked the man pages of FreeBSD's, NetBSD's, OpenBSD's and Solaris'
'dd', and they are clearly following the specs in this respect.  I
tried NetBSD 6.0's and 8.0's 'dd', and both behave as advertised.

And using 'dd' doesn't add a condition after statement...

> I'm not going to submit a re-roll of this because it works, and I'd
> still trust Perl's truncate(...) portability over dd.
>
> But more importantly because it takes me *ages* to fully re-test
> anything on the slow BSD VMs I have access to, and I already tore town
> my one-off hacking env there after testing these patches...
> 
> >>  	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
> >>  	test_must_fail git commit-graph verify 2>test_err &&
> >>  	grep -v "^+" test_err >err &&
> >> --
> >> 2.21.0.rc0.258.g878e2cd30e
> >>
