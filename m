Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A3D1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 00:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBHA65 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 19:58:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43485 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfBHA65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 19:58:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id r2so1791683wrv.10
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 16:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nm4I1+bQFiVWhI/CF0Ry2E+5FkNo+WzW2VzmL5Qx910=;
        b=UC06hyVw3jRjo+Ag7ZElm5hE3Roso/We/RpKkJIUwzgvGu4POmC3sE1ltTkpDeu5p1
         KpYBO5zno0oZg3wt1idfYbqfMkUKevgPQ5RZMh60Bhwvw64Ey6muwxvItxMyWJ75sgo6
         ZHkrNJq1jOsKrSiRUvhcWGx+CAqR/JcjeYHwCM0GXxLh83BhxxHDXwT+VjzTIfI1U3Ox
         VldB3S+Yck5ae6l3wwYXcZvqKyH0hfp3+cFDWT10BnsEpO132YjkmvT+rU4HRAOVZvQ+
         CmR9/U0bOm123mX0EY0bzjGWhK/BhaxMJwObEnqNIrtOJ4jBpo3sV1Mp/aG0c8B8uNHa
         0AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nm4I1+bQFiVWhI/CF0Ry2E+5FkNo+WzW2VzmL5Qx910=;
        b=XbfsnsX5448/tQJzLdthoMO6+LVuLS6NaCnYIlEb8R5lAD62mbsJL9AloCAmz/7ISW
         6v2xrowLYDy2pE70UkZb0s2xtwjBo3+Az0uC6RpjSDHSHv8kTYiGWCQ8EpoblQrltwYn
         q5nytr9jOR8Qc2yg1KmulY7Flec8M63F38VkJAhmqgvhOL1P0TyPJgIhIhOYPv/cNhiS
         cCW49bjhHllcAhrg0V/JjXsKe0DSHVEDJ4I94wOvYZ0HX9sifMLhalC1aA6d5ptl3AWf
         1wu8IUPZExk4XsbFxb/E1+yZv17qk3lg2AorwzvnOnHahcQm7JvWF6RbYnt5LkbxQ3vR
         Ynjg==
X-Gm-Message-State: AHQUAuYDdbgJapPt2CsH67zeA1GvTUvKC/blNYV4dXcFb1Vz/0ZU6RjE
        xMbEm0Lnf3OqazVokDEhGB0=
X-Google-Smtp-Source: AHgI3IZiHHQmA8Agn9j01lo96sH7CDWxuBw+ST0ojAHaMnMGeAMrrkxE6pxdVak5Do36/vZEISr58Q==
X-Received: by 2002:adf:8366:: with SMTP id 93mr4852802wrd.20.1549587536003;
        Thu, 07 Feb 2019 16:58:56 -0800 (PST)
Received: from szeder.dev (x4db57a12.dyn.telefonica.de. [77.181.122.18])
        by smtp.gmail.com with ESMTPSA id a8sm1659395wme.23.2019.02.07.16.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 16:58:55 -0800 (PST)
Date:   Fri, 8 Feb 2019 01:58:52 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
Message-ID: <20190208005852.GT10587@szeder.dev>
References: <20190203230152.GA25608@sigill.intra.peff.net>
 <20190204205037.32143-1-martin.agren@gmail.com>
 <20190204233444.GC2366@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
 <20190206184903.GC10231@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902071518340.41@tvgsbejvaqbjf.bet>
 <20190207204502.GA28893@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190207204502.GA28893@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 03:45:02PM -0500, Jeff King wrote:
> Fair enough. As an alternative, do you know offhand if there's an easy
> machine-readable way to get the CI results? If I could poll it with curl
> and generate my own notifications, that would be fine for me.

Well, what do you mean by "CI results"?  Getting whether a build
succeeded, failed, still running, etc.?  Sure.  Getting which
particular test script (semantic patch, documentation...) caused the
build failure?  Nope. [1]

Travis CI has a REST API (note that you have to sign in with GitHub
account to view its docs, and then need an access token to use the
API):

  https://developer.travis-ci.org/gettingstarted

They also offer a command line client for this API:

  https://github.com/travis-ci/travis.rb

Depending on what you want that in itself might already be enough for
you.  It wasn't for me, as I have a very particular idea about how I
prefer to view my CI results, but neither the website nor the CLI
client offer such a compact _and_ detailed view like this:

  ccccccccc 2175  pu
  ccccccccc 2174  sg/ci-parallel-build
  ccccccccc 2173  js/fuzz-commit-graph-update
  ccccccccc 2172  js/mingw-host-cpu
  PsscsPscc 2171  dl/submodule-set-branch
  PPXsPPPPP 2170  kl/pretty-doc-markup-fix
  PPPPPPPPP 2169  en/combined-all-paths

('c' - created, 's' - started, 'P' - passed, 'X' - failed)

Nothing that can't be achived with good screenful of Python/Ruby/etc
scripting... including colors matching the website's color scheme! :)


[1] Although since we include the trash directory of the failed test
    script in the logs, surrounded by clear marker lines containing
    the failed test script's name, it wouldn't be too hard to get it
    programmatically, either.

