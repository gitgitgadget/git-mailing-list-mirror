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
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A6C211B5
	for <e@80x24.org>; Wed,  6 Feb 2019 17:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfBFRji (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:39:38 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52119 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729715AbfBFRji (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:39:38 -0500
Received: by mail-wm1-f44.google.com with SMTP id b11so3392717wmj.1
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nH/ezpfvAycANU/2tAthoQ739e4docVakPk1n5pHTc4=;
        b=K/efxtyauDF5dH6de+lO5DwK6H/3irVtWkeQMGx/5x63fAd7VIZQcyzmxOjVa73XTp
         p9E3VGn5HfdRZ9GI6kdRsOZcwHqZ+1+9WIeZiS645F8TuSuxiPPhoAd27zDLqwX81HkN
         w+Wb/GGvmqXk1yRlLjiRyl331Zws7BjMPnZwaA1b1zjYan7vfaUj9Vv7gmjwMApysDuG
         TCYwZwdhNylVfDfCgutbdMFHHOaaaczuDSu/QKPE4J1nDFn4gkTjPJhisfJ6Fulv9Xy+
         2YSTb5EZAYSPNP+jqX2DCbp9ZaFH1fNzvhP9CQAkR1004nblZ6v0NKHNR5h6Afb6NYrT
         4/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nH/ezpfvAycANU/2tAthoQ739e4docVakPk1n5pHTc4=;
        b=Elf/rvUbywMpM4sSpYp4UA6NpEndB42NFH2LlaMsmdn2xYfQ5CymERb/n5QTuWN4SW
         +wVrxNqnUvQVztM//ZTOo+7sxwRtnmt4fJcvoW/eXS2SPnT+qyxmzJ8gYvtGw2DRCZ9W
         iAMuXn3D242r1vaU4pKQISruf8ss/4YTZ/zo9m3Z1qbmr2jiox3XaR2ZPNQyF8BajSV3
         GMQUERHAAe3sQi4VZM2InXrzN6UexY1OoumTI2QHYz0xt9sFZbRLNUWeJ2YLQ/Er/F/V
         Iw9j/jsU1Z+ymfDYVs/ktztSLwLVe9gFN60OslTqdW0HmrNk0bHExXOujjZitZ+Tk62z
         heeg==
X-Gm-Message-State: AHQUAuZW++crHG3vzsib8Pl/6ZtlXDMDYCBTHF+nryfa14YiiusW2CLi
        hoc0IpX4oFp9xug2FM63uH8=
X-Google-Smtp-Source: AHgI3Iblzsjr/D3m/80Fkxbi/3V1GBbZzdRdTSvnLIr0G5OA6W5UQRwts0uX52ytoQI+Eh5lzL/mKA==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr4049819wmi.60.1549474774942;
        Wed, 06 Feb 2019 09:39:34 -0800 (PST)
Received: from szeder.dev (x4dbda645.dyn.telefonica.de. [77.189.166.69])
        by smtp.gmail.com with ESMTPSA id h135sm25200709wmd.21.2019.02.06.09.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:39:34 -0800 (PST)
Date:   Wed, 6 Feb 2019 18:39:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: t0025 flakey?
Message-ID: <20190206173932.GM10587@szeder.dev>
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet>
 <20190206104243.GJ10587@szeder.dev>
 <nycvar.QRO.7.76.6.1902061450280.41@tvgsbejvaqbjf.bet>
 <20190206171517.s5lskawpdodc74ui@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190206171517.s5lskawpdodc74ui@tb-raspi4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 05:15:17PM +0000, Torsten Bögershausen wrote:
> On Wed, Feb 06, 2019 at 02:52:53PM +0100, Johannes Schindelin wrote:
> > Hi Gábor,
> >
> > On Wed, 6 Feb 2019, SZEDER Gábor wrote:
> >
> > > On Wed, Feb 06, 2019 at 11:25:38AM +0100, Johannes Schindelin wrote:
> > >
> > > > at first I thought that those intermittent test failures were limited
> > > > to Windows, but they are not: I can see it now in a build on 32-bit
> > > > Linux.
> > > > Full logs here:
> > > >
> > > > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=1032&_a=summary&view=ms.vss-test-web.build-test-results-tab
> > > >
> > > > Excerpt from the failing test case:
> > > >
> > > > -- snip --
> > > > not ok 2 - renormalize CRLF in repo
> > > >  expecting success:
> > > > 	echo "*.txt text=auto" >.gitattributes &&
> > > > 	git add --renormalize "*.txt" &&
> > > > 	cat >expect <<-\EOF &&
> > > > 	i/lf w/crlf attr/text=auto CRLF.txt
> > > > 	i/lf w/lf attr/text=auto LF.txt
> > > > 	i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
> > > > 	EOF
> > > > 	git ls-files --eol |
> > > > 	sed -e "s/	/ /g" -e "s/  */ /g" |
> > > > 	sort >actual &&
> > > > 	test_cmp expect actual
> > > >
> > > > + echo *.txt text=auto
> > > > + git add --renormalize *.txt
> > > > + cat
> > > > + sort
> > > > + sed -e s/	/ /g -e s/  */ /g
> > > > + git ls-files --eol
> > > > + test_cmp expect actual
> > > > + diff -u expect actual
> > > > --- expect	2019-02-06 09:39:42.080733629 +0000
> > > > +++ actual	2019-02-06 09:39:42.088733629 +0000
> > > > @@ -1,3 +1,3 @@
> > > > -i/lf w/crlf attr/text=auto CRLF.txt
> > > > +i/crlf w/crlf attr/text=auto CRLF.txt
> > > >  i/lf w/lf attr/text=auto LF.txt
> > > > -i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
> > > > +i/mixed w/mixed attr/text=auto CRLF_mix_LF.txt
> > > > error: last command exited with $?=1
> > > > -- snap --
> > > >
> > > > Any ideas?
> > >
> > > I reported this and Peff looked into it on the way to Git Merge, but
> > > not working solution yet.
> > >
> > > https://public-inbox.org/git/20190129225121.GD1895@sigill.intra.peff.net/T/#u
> >
> > Thank you!
> > Dscho
> 
> I shortly looked into the pointers here -
> Is t0025 flaky after the fix from Peff:
> 
> [PATCH] add: use separate ADD_CACHE_RENORMALIZE flag
> 
> Or has it always been shaky ?
> Does anybody know ?

I sort-of bisected it, and it pointed to Peff's fix.

Running 't0025 --stress' in the merge of 'sg/stress-test' and
'jk/add-ignore-errors-bit-assignment-fix' results in a failure within
seconds or <20 repetitions.  In the merge with
'jk/add-ignore-errors-bit-assignment-fix^' it runs successfully for
thousands of repetitions.


