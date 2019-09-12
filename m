Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77F61F463
	for <e@80x24.org>; Thu, 12 Sep 2019 11:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfILLKA (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 07:10:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33755 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILLJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 07:09:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so28009426wrr.0
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pe9mJWxr4CYFKuxI9MCsz9AVET8oBJx7IVT0KQyuRUs=;
        b=tnwBVzydVL+ptYL+S+LpM+nG9+qySQB12YQ2YWreoOt4tdrp+ZeUp1Jzl3ylpUMyx1
         ZG8LpfACbdHwK+Iy2Jp8+uOPFZ1FJ17p24ZUZIG/wBQObr50e9TiYjSwBVVePEh9wId6
         rnjsnT6P5piQLuQREDdHvFtqkWn3QgJG+1viy4jf4AriLdQFR+flr1dBQD6wEAhjLw9c
         Lz6O4P+N66671WyXONcN+BhkZ2xS0CXoo2sCfLRW87/2XnSdyct29MhW5TdEnRRj4+Ow
         z7Nut9CKHHoIf+ctv33RCfE1AryJlZUj3yp2lKv94CqY6OMDkyw+RH1/Pq0YVIUwmfBX
         iA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pe9mJWxr4CYFKuxI9MCsz9AVET8oBJx7IVT0KQyuRUs=;
        b=C4yous/XMeWCKp8DY8DFPiW6YdEMGIqXJlJ6SJG/FRCrecnnr4uiGXhThMQ6Sh+8wg
         OQyKILNfMPgO9J2IdfrqaVktkETG0OSuKvM3mehRSjJFlx9ZZsTEKlgVvw4egW1JNfOX
         Z4Dk7j/0UJIlcup6JKAXYl+aeigLJrTacC7R8Xipa0Jc8f7Jf2Oab/ryCsK2WJqpmI9V
         forqg4Ko0vKAIZSalzCAlo+EJDKdQ1nfuZIGCYpX5Nrlnb2YG5DvyaOYCLiXV1J/XNpN
         zXFCaLD0IPx58BI1JCNVq2bLE7oYZorHKeAcnNhUHJ6M7nq1fXn/u9LS4WMEr2Whhz9o
         ZjZw==
X-Gm-Message-State: APjAAAW2DFVqla6gxA+ggIEaj5tPg6iS6ecXDgUqld3tDw9Q7GPA9vhV
        5VQ1BJWEM0T0hOSBhMiPSYEf7tj2
X-Google-Smtp-Source: APXvYqywNGQtB9sDtW6wFN34gIRGoB/sIGEHBpgnPaQRS6cjZhENZxIwJuNUWKUgo8bAxvmmzjvIkg==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr36115519wrp.281.1568286597732;
        Thu, 12 Sep 2019 04:09:57 -0700 (PDT)
Received: from szeder.dev (x4db4440a.dyn.telefonica.de. [77.180.68.10])
        by smtp.gmail.com with ESMTPSA id c10sm32885429wrf.58.2019.09.12.04.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 04:09:57 -0700 (PDT)
Date:   Thu, 12 Sep 2019 13:09:55 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: install P4 from package to fix build error
Message-ID: <20190912110955.GM32087@szeder.dev>
References: <20190906102711.6401-1-szeder.dev@gmail.com>
 <20190906105825.GD32087@szeder.dev>
 <nycvar.QRO.7.76.6.1909100049180.5377@tvgsbejvaqbjf.bet>
 <20190910122455.GH32087@szeder.dev>
 <nycvar.QRO.7.76.6.1909111710050.5377@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1909111710050.5377@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 05:12:31PM +0200, Johannes Schindelin wrote:
> On Tue, 10 Sep 2019, SZEDER Gábor wrote:
> 
> > On Tue, Sep 10, 2019 at 12:51:01AM +0200, Johannes Schindelin wrote:
> > > On Fri, 6 Sep 2019, SZEDER Gábor wrote:
> > >
> > > > On Fri, Sep 06, 2019 at 12:27:11PM +0200, SZEDER Gábor wrote:
> >
> > > > > Let's install P4 from the package repository, because this
> > > > > approach seems to be simpler and more future proof.
> > > > >
> > > > > Note that we used to install an old P4 version (2016.2) in the
> > > > > Linux build jobs, but with this change we'll install the most
> > > > > recent version available in the Perforce package repository
> > > > > (currently 2019.1).
> > > >
> > > > So I'm not quite sure whether we really want this patch.  It
> > > > depends on how important it is to test 'git-p4' with an old P4
> > > > version, but I don't really have an opinion on that.
> > >
> > > I'd rather have that patch. It seems to be a much better idea to use
> > > the package management system than to rely on one host, especially
> > > when said host already displayed hiccups.
> >
> > Well, I'm not so sure.  As far as I remember this was the first time
> > that this Perforce filehost was inaccessible and a simple "Restart
> > job" could not rectify the situation, because it was inaccessible for
> > about a day or more.
> 
> Right.
> 
> > OTOH, transient errors or timeouts from 'apt-get update' or 'install'
> > from the official Ubuntu package repositories are not uncommon (at
> > least on Travis CI), although in those cases it's usually enough to
> > just restart the errored job.
> 
> My impression precisely. I trust the Ubuntu package servers to have
> transient, _short-lived_ problems ;-)

Heh, that's true, but note that we won't install P4 from the Ubuntu
package servers, but from the Perforce package repository, so I doubt
we can expect any improvements in this regard.

OTOH, instead of issuing only two HTTP requests to download those two
binaries we'll issue a total of 9 requests (1 pubkey, 2 package lists,
6 packages) that could go wrong.

I'm undecided, and at the very least the proposed commit message
should be updated.

