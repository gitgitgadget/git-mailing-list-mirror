Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BDFC54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 17:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D94D206DD
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 17:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IMvV5NH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgDZRFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:05:11 -0400
Received: from mout.web.de ([212.227.15.14]:38597 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgDZRFL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 13:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587920708;
        bh=Y0crcdbGgCTDBucYjgjdvvHzuW1R5b/yL4/x1/WxZNw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IMvV5NH7mogl+4RqNpa7eXFvvXR9Nx81qCcqwmHJPa7xACzSn5PZLlVuWAsVDPEZ9
         td2lkHIRss0wcVr8K5ElToDXqL+ejnMevsRRSUlO4UeFpyeEjzwRaTPK30EfR85kr4
         GPU9wZGt9G2rQHYRgrjcMp7PfaTGF8LkGwJCIkV4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlWVj-1isaLj2piZ-00bHsz; Sun, 26
 Apr 2020 19:05:08 +0200
Date:   Sun, 26 Apr 2020 19:05:08 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] macos: do let the build find the gettext
 headers/libraries/msgfmt
Message-ID: <20200426170508.6uaexvcmorj2ntv3@tb-raspi4>
References: <pull.616.git.1587628367528.gitgitgadget@gmail.com>
 <pull.616.v2.git.1587819266388.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <pull.616.v2.git.1587819266388.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:GPf7yVgfBgR3PRA0WdVTyO7LkeD3l83A+HT8rokv1Jbi9NnhwOb
 pdLg8kC+hKzyLr2mnFfQzByEw8LPJsV3xgurD8UL4NdxbcJo1r3/2/KTBim8cED+P5+Jlzx
 TfOsw4wNFUBD3mVzYlgTb3nmLKQjaAQHu49j11SZ71u29BGXJMDEDgNbNJjDoCKAXgpmB8k
 wtuklkl75JnXLckanbxyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K9sx49RwTQM=:K4izR/HhRXxtEAE81+JGQJ
 w+nYQuHIVftgkFGqaIVGqLVCLXB3VhJPFBtfAZmRk0TrMSoyikfEbp573nJc+AlGn7NIfkju0
 jhr7tsgCqvInFGrQr0A3j65AZW1AQMdqk61Oy+lz4B5gHLZU3dC2kBp4o4pSS65/0uOtjQpk3
 Qi2kRf/BVx69jd6FnDe0NIFjhbi82cjmUZXYcgNO6aDMljHC370wPIlP2iCx7ojsdgECiz2Yk
 XSKqYwUAncDsa8Om3fcN/luu0axdGY1BwSW19nduYbOVJtLiOTh7kGsoARohj6bd2Q27ie1dY
 mLbhBlpFxhOx90hrII+U89H121f9tChFMoHhaRxrY7umHQHH2vXHF6xUMoXo8k6mMYsmz26iV
 Yrb0Tfaewjw0DzjJugxRDNldsfCtpgqMemZKoe2nZu8YW5I5ix/mYg0jGmQnfi+7QvHenFt03
 l2zY9quz4nH8R8MlScoMs5p5aHX+e3zPwSy1zqugbxBWVwiKwj+h0FoUiqsHJPcgI4GlVrPPK
 utcpG0Y9o52U2cHQbsuF5nQw+38fCwItmRXGA7G/1NKsNK+BcWtVnqv9QsxWhD10uZr80igOy
 EUYdN6WJA7ui53ptCYH36xFoZduSKrMx7qt+2t61fvhK7fy5B7bEpLuy0pzR3yhbTMFqJDrlN
 SPIyflGyjcK7YX4w1HtPu2fG/jj+idekIUllEncOYxNPUNMCq/0mv1+d/DDZQSnry6YdYpnuq
 Qf8JsO8199SRl06olDKF8DGebz06IZ3NFhjicfMnIHEqL65DEue7K+l9+0gsZgo9EnGSxCTOs
 BCIDTHmVTsffx2lvUKR/1yKOVJTqeyOQof/wsBw8PILYsniHGIDWiHPcyb+UNjqJDqx4C361y
 YNP0qH930q8LPOIWDFHCFXHkTtJC40jibDN+o5f4o79GZ94oRlJXN/SDhWIcHoQ+QNSSeqDBh
 /ZPYmwBAkcPyP0x01YY4HGdDl1Bc5kOA6feIrGI+LBhAWHKLIVnMzteZDmB71HKUoHv/L7qld
 9pHWiKmvqKoQb5UGTRuc0G9HZxu5tzZvsr329rTte0CACED7mldLQ5aNDdVWg3OvL5gouam6k
 tG3nEbKkovA+EItW1uDrJCVrvFaQtPUePggOfoHSPQWgSTHe1qNlrmcOGZvGN66jwm/xyGq71
 Msr+Uuo+Y8CVQoYl5fZUfhIQz5FRWHBBRkGupmqkIAf4GUJec6tZwR73vJeRG92jdkMzCyeiN
 Z0G2zs6PUX2UY+lDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 25, 2020 at 12:54:26PM +0000, Johannes Schindelin via GitGitGa=
dget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Apparently a recent Homebrew update now installs `gettext` into a
> subdirectory under /usr/local/, requiring the CFLAGS/LDFLAGS to list
> explicit directories _even_ when asking to force-link the `gettext`
> package.
>
> Likewise, the `msgfmt` tool is no longer in the `PATH`.
>
> While it is unclear which change is responsible for this breakage (that
> most notably only occurs on CI build agents that updated very recently),
> https://github.com/Homebrew/homebrew-core/pull/53489 should fix it.
>
> Nevertheless, let's work around this issue, as there are still quite a
> few build agents out there that need some help in this regard: we
> explicitly do not call `brew update` in our CI/PR builds anymore.
>
> Helped-by: Carlo Marcelo Arenas Bel=F3n <carenas@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

It seems as if things are happening fast in the brew-business.
After debugging (on a local box) and travis-ing (remote) I may have a sugg=
estion
for a better commit-message - I can probably send that out as a patch late=
r today.
What do you think ?

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
MacOs/brew: Let the build find gettext headers/libraries/msgfmt

Apparently a recent Homebrew update now installs `gettext` into the
subdirectory /usr/local/opt/gettext/[lib/include].

Sometimes the ci job succeeds:
 brew link --force gettext
 Linking /usr/local/Cellar/gettext/0.20.1... 179 symlinks created

And sometimes installing the package "gettext" with force-link fails:
 brew link --force gettext
 Warning: Refusing to link macOS provided/shadowed software: gettext
 If you need to have gettext first in your PATH run:
  echo 'export PATH=3D"/usr/local/opt/gettext/bin:$PATH"' >> ~/.bash_profi=
le

(And the is not the final word either, since MacOs itself says:
 The default interactive shell is now zsh.)

Anyway, The latter requires CFLAGS to include /usr/local/opt/gettext/inclu=
de
and LDFLAGS to include /usr/local/opt/gettext/lib.

Likewise, the `msgfmt` tool is no longer in the `PATH`.

While it is unclear which change is responsible for this breakage (that
most notably only occurs on CI build agents that updated very recently),
https://github.com/Homebrew/homebrew-core/pull/53489 has fixed it.

Nevertheless, let's work around this issue, as there are still quite a
few build agents out there that need some help in this regard: we
explicitly do not call `brew update` in our CI/PR builds anymore.

Helped-by: Carlo Marcelo Arenas Bel=F3n <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
