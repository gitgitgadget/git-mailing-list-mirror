Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D86C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 08:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiEWIFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 04:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiEWIFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 04:05:14 -0400
Received: from pb-sasl-trial21.pobox.com (pb-sasl-trial21.pobox.com [173.228.157.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C1C13DCF
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:05:13 -0700 (PDT)
Received: from pb-sasl-trial21.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 8A9D727309;
        Mon, 23 May 2022 04:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ZnawnYw+vVGpu4SZkI4vdi8gIj0=; b=lxph7vPPbz/4lMjt3mSu
        96MlLtjQ6AX5q/BkUIEpK5I40b+3YrCjd1vQ5REUHaGsinzoFJsO0gXZQngc3RId
        Cj2b/8EM7aqul0jGeVAOICXaIiy4FzF8CgaEsvH+jfhpNN+lU1rJl8qkIQ1Faz/R
        dMKXUYS3eV+JhF6K+w8LYBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=PYGXbv8H3DCQhDsH+GSCU8zN1cRF0Z0lrSGFWos7dToL6M
        jYqnMTF3FpPvDRKgPD4wnQeqO//Vz+ZTouLint7t+qvXcdbM+/MK7Uu7+znjPEq/
        VkhAjpZleNYV4kuteeEgRRFXeHT96zuVdkU1mVc5bqquAl4r+WqtI6aX0f6VI=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial21.pobox.com (Postfix) with ESMTP id 7121527306;
        Mon, 23 May 2022 04:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DE141AE84F;
        Mon, 23 May 2022 04:05:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH v3 1/9] Makefile: sort "po/git.pot" by file location
References: <20220519081548.3380-1-worldhello.net@gmail.com>
        <20220523012531.4505-2-worldhello.net@gmail.com>
Date:   Mon, 23 May 2022 01:05:05 -0700
Message-ID: <xmqqk0acu11q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F1357EE-DA6F-11EC-BE0F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> We will feed xgettext with more C souce files and in different order in

"source"

> subsequent commit. To generate a stable "po/git.pot" regardless of the
> number and order of input source files, we add a new option
> "--sort-by-file" to xgettext program.

Probably: ... we pass the option "--sort-by-file"

> With this update, the newly generated "po/git.pot" will has the same

"will have"

> entries while in a different order.
>
> With the help of a custom diff driver as shown below,
>
>     git config --global diff.gettext-fmt.textconv \
>         "msgcat --no-location --sort-by-file"
>
> and appending a new entry "*.po diff=gettext-fmt" to git attributes,
> we can see that there are no substantial changes in "po/git.pot".
>
> We won't checkin the newly generated "po/git.pot", because we will
> remove it from tree in a later commit.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This has no input from me (yet), so technically it is a bit
premature to add my sign-off here.  It wouldn't make a difference to
the end result, though ;-)

> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index f8bccfab5e..83e968e2a4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2706,6 +2706,7 @@ XGETTEXT_FLAGS = \
>  	--force-po \
>  	--add-comments=TRANSLATORS: \
>  	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
> +	--sort-by-file \
>  	--from-code=UTF-8
>  XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
>  	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
