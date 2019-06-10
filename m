Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5528D1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 18:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbfFJS5M (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 14:57:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40618 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbfFJS5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 14:57:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so10273971wre.7
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X03Gu0dr6Izol/xZO0OgnsMo/Ky5z2AJ4YaZTkHCLhY=;
        b=LumDGbSOpaN9uErgsJ+pa/tFVEAPJlvcJzJGXj6a1W/mYRj5NdTz33lYZ25IuTbI2M
         2Bdp9FHsy6vwYsUt0ANJLFw0F5KjqFNbAYYO2EJ1xvrk4kazXsuZY+0sOjniLSDw7daj
         w9LCc+db/9dwJIHxpxFzXCJNEz0HoXMfZLhVftsVY6XOpOF4se1WRV1nuVOdrr16DNcQ
         lV/Ky6Zyl9WtOM2R7gNaj2VrCJChpersBoe4oi98EaqzqXwzAfwHptFv4gUkmWmOQ+Oe
         R2/0Mg1yKfCO2TOv70FhZYyf8i+Q6trz/NaAwDDZbsSK5NUZw4LDCf8dnNgSGlBOG8iu
         T8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X03Gu0dr6Izol/xZO0OgnsMo/Ky5z2AJ4YaZTkHCLhY=;
        b=aVMGf/8uyNb9vXoUcfWbwJffiMqteq59I5nc+57UdKDiAQEtVte3aIH6PGIOsSeaJJ
         4xZ+wzsSzcQyS07fQd1qUbliUV06MW5lvZkVYWIlyuw9sX2lzh+6fpxJQrotbEchGWRa
         ly2GpIui8xbFUHO4zldWyyueKVZsDnPf6R+OZZQOf5LnYLgydWmVGx0CXOKOgCQJ8A58
         PgSSM25OozfS/fN/cSSSC6f3t9FwY38klr7VJOO8Ka7zr2GFXE2HXlrAuTPqsVTGDroN
         gPEo3HHayS02+oSWbOVzuKSWXlIxKDmvHQo8EeNp8u9lZqmOIMYscdMb3a4ObTG6/XFW
         Wtkg==
X-Gm-Message-State: APjAAAVqfe+rS6XgaN9hqJvP3o3TW5DXT43TZ+/JSoCQdRU9hZ4tFf1F
        mxNkWb958fZnImPAgNCdPMQ=
X-Google-Smtp-Source: APXvYqzCC8iRF+0AmDDMlBx0nx/NtUYic1UsqvQ4d1izGM/QJWPzy9nlSeuOaBPzYrHOuOkMnZG9DA==
X-Received: by 2002:a5d:6ccc:: with SMTP id c12mr22278933wrc.57.1560193031065;
        Mon, 10 Jun 2019 11:57:11 -0700 (PDT)
Received: from szeder.dev (x4d0c1d42.dyn.telefonica.de. [77.12.29.66])
        by smtp.gmail.com with ESMTPSA id l190sm268913wml.16.2019.06.10.11.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 11:57:10 -0700 (PDT)
Date:   Mon, 10 Jun 2019 20:57:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] t7610-mergetool: do not place pipelines headed by
 `yes` in subshells
Message-ID: <20190610185708.GC4012@szeder.dev>
References: <cover.1560152205.git.j6t@kdbg.org>
 <75c812bd4838f6f35b6f42b97ae396ebb28d8b95.1560152205.git.j6t@kdbg.org>
 <20190610095942.GA19035@szeder.dev>
 <nycvar.QRO.7.76.6.1906102026030.789@QRFXGBC-DHN364S.ybpnyqbznva>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1906102026030.789@QRFXGBC-DHN364S.ybpnyqbznva>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 08:29:56PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 10 Jun 2019, SZEDER Gábor wrote:
> 
> > > diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> > > index 5b61c10a9c..b67440882b 100755
> > > --- a/t/t7610-mergetool.sh
> > > +++ b/t/t7610-mergetool.sh
> > > @@ -131,13 +131,13 @@ test_expect_success 'custom mergetool' '
> > >  	git checkout -b test$test_count branch1 &&
> > >  	git submodule update -N &&
> > >  	test_must_fail git merge master &&
> > > -	( yes "" | git mergetool both ) &&
> > > -	( yes "" | git mergetool file1 file1 ) &&
> > > -	( yes "" | git mergetool file2 "spaced name" ) &&
> > > -	( yes "" | git mergetool subdir/file3 ) &&
> > > -	( yes "d" | git mergetool file11 ) &&
> > > -	( yes "d" | git mergetool file12 ) &&
> > > -	( yes "l" | git mergetool submod ) &&
> > > +	yes "" | git mergetool both &&
> > > +	yes "" | git mergetool file1 file1 &&
> > > +	yes "" | git mergetool file2 "spaced name" &&
> > > +	yes "" | git mergetool subdir/file3 &&
> > > +	yes "d" | git mergetool file11 &&
> > > +	yes "d" | git mergetool file12 &&
> > > +	yes "l" | git mergetool submod &&
> > >  	test "$(cat file1)" = "master updated" &&
> > >  	test "$(cat file2)" = "master new" &&
> > >  	test "$(cat subdir/file3)" = "master new sub" &&
> >
> > Another possibility for eliminating a few more subshells might be to
> > turn these
> >
> >   test "$(cat file1)" = "that"'
> >
> > checks into
> >
> >   echo that >expect &&
> >   test_cmp expect file1
> >
> > because 'test_cmp' on Windows first compares the two files in shell
> > and runs 'diff' only when there is a difference to report.
> 
> When you remember that spawning processes is much more expensive on
> Windows, still, than I/O, you will realize that this adds even more
> expense. Instead of a spawn & read, you are suggesting essentially a
> write, spawn, read & read, and that is only the best case.

No, instead of a spawn (the subshell of the command substitution), spawn
('cat'), read, I suggest a write, read, read (no subshell or external
process in 'mingw_test_cmp's main code path).

> In the worst case, it would be a write, spawn, read & read, spawn, read &
> read.

It would be a write, read, read, only one spawn (diff), read read, but
I assume that the tests succeed, so I ignore this worst case.


> (Even if the first spawn is an MSYS2 spawn on Windows, which is more
> expensive than the MINGW spawn for the `git diff`, if that is a `git diff`
> rather than `diff`, didn't check...)
> 
> So I am rather negative about this suggestion ;-)
> 
> Ciao,
> Dscho

