Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28722C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 11:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033D16109E
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 11:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhHRLtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 07:49:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:42757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229876AbhHRLtg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 07:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629287340;
        bh=IqAMYpM2zAtZ0xY4csx+EuFjiRuOvQb8n7u9SW9cClk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZcN8BCeGqRDe0I27Hi9Re3PYYUk+rmdbRqdZayVF/uA9yCsbLBtyqBm4JIOhE0lpM
         jPcX87bz68S3wjrvJpoew52zE4TGTyjlV5tq3HBt1bULvq+LwtQ+8BFaLUBkZ5VU4X
         CrwWgPjAlW7PPnsHF42AHIrkjHbjrjskxkjGG0mg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1mKOfE3zgl-00F8AF; Wed, 18
 Aug 2021 13:49:00 +0200
Date:   Wed, 18 Aug 2021 13:48:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] column: fix parsing of the '--nl' option
In-Reply-To: <20210818092456.3045808-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108181347010.55@tvgsbejvaqbjf.bet>
References: <20210818092456.3045808-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-400978424-1629287340=:55"
X-Provags-ID: V03:K1:FTvwSDDZyHmanTRqbqSTzz9BHFsOolrXMtrgq1pm0gYFgFuhYCe
 0MGJxf5KXczyW810McyCX4yc9UDTuF4fZPL2IqCk9F6bqmiJqtbcmyljLpIDuTWm8SEDXhk
 Z3H5giIPPxyhjAze7Hq+afFkvz++wXccmOOah/jufTks4WR4RmdPeSWzD4x2y/21b8cYIUq
 +9vR5Tf27zEebH5uOwW1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1iJzySNYgw0=:1GUhZB+fCzRC4R19kZXZdA
 PyEQ0jGGuBD0Mx6Cn48C0ftSduGF+1fF/msRbRK8RAaYEwAj8KR9sY71+eGd82QPegKBr/GDU
 ODDgY0mfbBy2NJzvXGUwBtZpbwGFEpv+tZSVS/zdf4JaGtTpqbc2SP/JoNsML8ZsoJle7fmBm
 DxBcRtFIrTnYtogbtbbVCCTiEWWXwQqM66PgSlRj5bVVruxqnMqko4Ud3vF3nTgM4HSgfYiLM
 WKTuwTJTCMydkZCDYMDwYVG9Ea4VVZMWjPS+4jzxlWQ/NL7ZMoyaFAds5qXrLX8vs4H2Pri2q
 UfVCSBtStW4cjMzZoSHsxefFqmVJJ6MHp0Bwk8n8o+F5REAOc4MHMGz6gzWFDoYdzpMSFfz9G
 RwgCCvtUGOYitA5KiqHAQ+/frh8eP/1JGd6PUr+i99ZeqrN7yYwf7k4ywGOHW1f4AdBexOoiF
 WUf+Rh+2QcazPOVu6tQ5ZVR/E91kfKZ8pIY41SEGWI0F9XQ4rH/YfKkj8fEvWGQQDZR171K9i
 jr79MwV2ftjF1zCR69xAAeCUBQRw0SmY1IOhJ8pS6Use8zZE9eEjpGmGtT+dVvCdLewQNHUI1
 Q6CC72dOZjFFwNnzSOE6TXQqtVLgwYXG88r6buMOXrDUXsvBfqm3Y0LN0vBK7aznRIKW5RFei
 WWo7bZWWlvlDZfPdpvfs3jN6m9YsRixloX5R/6lYtBy9OG1umpNnkfi0zck+O90SoR98j/VUt
 Ka3Pizh0w67vBK8XaIbiuIphuKPVJo8aSyBlrZJzZBHVRe82N0S3vNacO4gmftqsTr5YfgpbE
 wq9Ey5JkQzD9CMwPElFPrfkF9NCZlBf9935tKIRqkJ+Xu/9WKn3l9NC9R5G29RXn3GpLaV/tQ
 Dy91NJJQ4THQ3QfiZlezGzfnzs8gRwJ7MD2EAORDwPA3BdK4Yk0BotEgNCGpzM9yK+KMC4xcz
 S+czUaI27SbqlImSjDjlrJMPuL3SUlNyeSZrnA6SCGAplri86DvWdwmfyiAfE4pPf7cU53mIH
 EkGZ3jtHznMGASz4rMzu0Yk2eqkS3tezc+nZiX/un/od7wAXD4FoqIWAu77BmAIIofs3opN9n
 R0DQv90gAQtq2gSUYTiMTc3rXewf6Rb34/kFEUZ3Nmks5jWfHfVBzUJ1Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-400978424-1629287340=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Wed, 18 Aug 2021, SZEDER G=C3=A1bor wrote:

> 'git column's '--nl' option can be used to specify a "string to be
> printed at the end of each line" (quoting the man page), but this
> option and its mandatory argument has been parsed as OPT_INTEGER since
> the introduction of the command in 7e29b8254f (Add column layout
> skeleton and git-column, 2012-04-21).  Consequently, any non-number
> argument is rejected by parse-options, and any number other than 0
> leads to segfault:
>
>   $ printf "%s\n" one two |git column --mode=3Dplain --nl=3Dfoo
>   error: option `nl' expects a numerical value
>   $ printf "%s\n" one two |git column --mode=3Dplain --nl=3D42
>   Segmentation fault (core dumped)
>   $ printf "%s\n" one two |git column --mode=3Dplain --nl=3D0
>   one
>   two
>
> Parse this option as OPT_STRING.

Whoa. Nice catch. I have just one suggestion about the patch, below.

> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Documentation/git-column.txt |  2 +-
>  builtin/column.c             |  2 +-
>  t/t9002-column.sh            | 18 ++++++++++++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
> index f58e9c43e6..6cea9ab463 100644
> --- a/Documentation/git-column.txt
> +++ b/Documentation/git-column.txt
> @@ -39,7 +39,7 @@ OPTIONS
>  --indent=3D<string>::
>  	String to be printed at the beginning of each line.
>
> ---nl=3D<N>::
> +--nl=3D<string>::
>  	String to be printed at the end of each line,
>  	including newline character.
>
> diff --git a/builtin/column.c b/builtin/column.c
> index 40d4b3bee2..158fdf53d9 100644
> --- a/builtin/column.c
> +++ b/builtin/column.c
> @@ -29,7 +29,7 @@ int cmd_column(int argc, const char **argv, const char=
 *prefix)
>  		OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
>  		OPT_INTEGER(0, "width", &copts.width, N_("maximum width")),
>  		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("padding spac=
e on left border")),
> -		OPT_INTEGER(0, "nl", &copts.nl, N_("padding space on right border")),
> +		OPT_STRING(0, "nl", &copts.nl, N_("string"), N_("padding space on rig=
ht border")),
>  		OPT_INTEGER(0, "padding", &copts.padding, N_("padding space between c=
olumns")),
>  		OPT_END()
>  	};
> diff --git a/t/t9002-column.sh b/t/t9002-column.sh
> index 89983527b6..6d3dbde3fe 100755
> --- a/t/t9002-column.sh
> +++ b/t/t9002-column.sh
> @@ -42,6 +42,24 @@ EOF
>  	test_cmp expected actual
>  '
>
> +test_expect_success '--nl' '
> +	cat >expected <<\EOF &&
> +oneZ
> +twoZ
> +threeZ
> +fourZ
> +fiveZ
> +sixZ
> +sevenZ
> +eightZ
> +nineZ
> +tenZ
> +elevenZ
> +EOF

Or maybe we can do this instead?

	sed "s/\$/Z" <lista >expected &&

Much shorter, and less error-prone (in case any `--run=3D[...]` option wou=
ld
change what is in `lista` in the future).

Ciao,
Dscho

> +	git column --nl=3D"Z$LF" --mode=3Dplain <lista >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success '80 columns' '
>  	cat >expected <<\EOF &&
>  one    two    three  four   five   six    seven  eight  nine   ten    e=
leven
> --
> 2.33.0.453.gc5e41af357
>
>

--8323328-400978424-1629287340=:55--
