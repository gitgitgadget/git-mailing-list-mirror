Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EA51F42B
	for <e@80x24.org>; Sun, 24 Dec 2017 16:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbdLXQK7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 11:10:59 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:47018 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdLXQK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 11:10:58 -0500
Received: by mail-wm0-f45.google.com with SMTP id r78so29494453wme.5
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gScJMbMkwnCova1EB/o3AOIdkzhjk8XBMIP5NJkk2w8=;
        b=UvEYFRwIINZUi/n8YlX49YglNj8j7z5dW76AFsy7ShMpZAWWkCXM58MYCQLLwMHgei
         FcBBLRX19uWcpRJ0a9/4PzMyq+V4DHWXY5oUtiTga/N9dP6Uw8RsM1o/5BtMMQC16WvJ
         surF3ofXayqUy/0EsLIIB+1JTmjQHmtxm3GKnaVqv5ndRSjX3136fX8Cc2zcUbogzIAP
         allyYQDu+yHnz2G3f+PGft9ymIuuLjj3Fl0nEMwOj+hEbxPPlKenkdF9gd98sBeEr2HC
         Vb4Qq7FszGf/ex3FQ6BHuPuAlU2Nivqqyq1e3AV4X5krszQtR2Y83tS9vYPx3UxVZTne
         wWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=gScJMbMkwnCova1EB/o3AOIdkzhjk8XBMIP5NJkk2w8=;
        b=hLr3RfjpmMij6Na5q4IgdAw8jnY9lS2+s0HYe+I5TFSRUmDPUs7mwwDyGGSL41iDg1
         XGV5/pQjD1vhjI1nqlvrbbGl95kq4wTzge2Xdj5ic9pQVhts1a1zVZQfJUe16B1vyetn
         yeQC5Uq1XcqtuJOf0YCC+yu8CRg2OuyUreh1MIRwFF73/o+XLnahjr6GrUAPIZ49/PAQ
         73O1DoLE6k4yibFity3RF3sWnvihOLioWiRFDQ/611pTCFtXJrWQWur1Xo9Ara1PWDxD
         rEl+qUeMHc8O4Jqtg/1CVWrlVPcoablIV3WQdsp+rk+fEmXLEwBIfrKmQQH6sWBbgxFF
         /rgA==
X-Gm-Message-State: AKGB3mLbvM2ue+Cwzk/LxpIvTFpP74qc6Q6GNlpQRZwSHvPmNqL4in4h
        Ng4wRY0LFdIFXtTbihBE7jw=
X-Google-Smtp-Source: ACJfBovOCieSSoMRgkK8fPpUTAmgzdY3A9UK084EVTpueZVXBBW5EYifPkv4B7fOPDqK9OSYpkAYsA==
X-Received: by 10.80.174.230 with SMTP id f35mr23350658edd.25.1514131857323;
        Sun, 24 Dec 2017 08:10:57 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id g61sm21977050edd.48.2017.12.24.08.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Dec 2017 08:10:55 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>, Jakub Narebski <jnareb@gmail.com>,
        Petr Baudis <pasky@suse.cz>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from 5.8.0
References: <20171223174400.26668-1-avarab@gmail.com> <20171224143831.GD23648@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171224143831.GD23648@sigill.intra.peff.net>
Date:   Sun, 24 Dec 2017 17:10:53 +0100
Message-ID: <871sjkrtrm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 24 2017, Jeff King jotted:

> On Sat, Dec 23, 2017 at 05:44:00PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> This is similar to Jeff King's jk/drop-ancient-curl series in that
>> we're dropping perl releases that are rarely tested anymore, however
>> unlike those patches git still works on e.g. 5.8.8 (I couldn't build
>> anything older).
>
> Heh, I'm not sure if those are the best prior art to justify this, since
> I stopped posting them after getting complaints (though I'll admit I was
> considering re-posting them since AFAICT nobody has stepped up to fix
> the breakage after many months).

Less of a justification, more of a "this is going to be a similar sort
of dumpster fire" :)

> This may be more like the recent C99 weather-balloon patches, in that
> we're not using the new features yet, but want to see if anybody screams
> at this first change.
>
>> The reason to do this is to be able to use features released with perl
>> in the last decade, 5.10 was a major feature release including things
>> like new regex features, state variables, the defined-or operator
>> etc.[3]
>>
>> I expect this to be more controversial as since the 5.8 release stayed
>> along for longer in various distributions, e.g. it's the version
>> shipped with RHEL 5, replaced by 5.10 in RHEL 6 released in late 2010,
>> similarly the first Debian release to include 5.10 was 5.0 (Lenny)
>> released in early 2009. The release history for other distributions
>> can be seen on CPAN's "Perl Binaries" page[3].
>
> As far as this actual perl change goes, I don't have a strong opinion. I
> agree it would be nice to eventually move forward, and your reasoning
> about what constitutes "old" seems sane. But we also don't write much
> perl in this project these days, and I don't see a lack of modern perl
> features causing a lot of headaches.

Yes, unlike with the curl patches it's not a big PITA to maintain
compatibility with 5.8, it would just be easier to write new code &
maintain old code and not have to be on guard about not using features
one takes for grantend, and maintain compatibility with 5.8 versions of
core modules.
