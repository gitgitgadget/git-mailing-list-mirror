Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04611C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 08:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiEWIFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 04:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiEWIFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 04:05:14 -0400
Received: from pb-sasl-trial3.pobox.com (pb-sasl-trial3.pobox.com [64.147.108.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA76F13F70
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:05:13 -0700 (PDT)
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 2632C254BA;
        Mon, 23 May 2022 04:05:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=wUZIYlzGV4KuaBSDwYQmxlR3NjU=; b=YEl0YK2HqKd2j79geYIO
        b3lHv5WRGiw030FAzsAl4PCRukgguEKt9mlragNql5qBMsKd+Syoxtys8GJMJeB2
        7Ci4R6nshQmbogorppQ0Rlw3CMHsSiXQO7g6dV7nr05tJMk1uWIfZtY4iTX1VY9o
        1QuPACjU7QcLMzR4pSZt9U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=xbRI24KEWnI8t5lrTBg/ttLuxWEWR0bgvPiHLoXUBCO//B
        HkyDmsqhYOhogsGhC9t2WRXgg1dVHoaNyxaOb3ebgZzg5r/Zh9OB7H+LXPP0OCrt
        DQEOvI/64t2eMFTCroALeowUJZ8ihXvRyzOz3uovEyhzGrnmR/XVaM3w81WIA=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 07566254B7;
        Mon, 23 May 2022 04:05:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 451951189FF;
        Mon, 23 May 2022 04:05:10 -0400 (EDT)
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
Subject: Re: [PATCH v3 2/9] Makefile: generate "po/git.pot" from stable
 LOCALIZED_C
References: <20220519081548.3380-1-worldhello.net@gmail.com>
        <20220523012531.4505-3-worldhello.net@gmail.com>
Date:   Mon, 23 May 2022 01:05:09 -0700
Message-ID: <xmqqee0ku11m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10FFF850-DA6F-11EC-9A36-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When running "make pot" on different platform, we may get a different

"on a"

> message template file "po/git.pot". This is because the "LOCALIZED_C"
> variable may have different C source files on different platforms or
> different compiler conditions.
>
> We can make a stable "LOCALIZED_C" variable by applying patch snippets
> as follows:
>
>      ifdef NO_LIBGEN_H
>          COMPAT_CFLAGS += -DNO_LIBGEN_H
>          COMPAT_OBJS += compat/basename.o
>     +else
>     +    LOCALIZED_C += compat/basename.c
>      endif

While that is true, going into such a detail of an approach that you
rejected does not sound like a good use of readers' time.  Instead,
perhaps mention why ...

> But it is much simpler to use variables "$(FOUND_C_SOURCES)" and
> "$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C".

... FOUND_C_SOURCES approach works better by reminding the readers
what it is.  I'd probably discard everything after "This is
because..." up to point and replace it with something like:

    "$(LOCALIZED_C)" is supposed to list all the sources that we
    extract the strings to be translated from.  Instead of using
    "$(C_OBJ)", which only lists the source files used in the
    current build, to compute it, use "$(FOUND_C_SOURCES)", which
    lists all source files we keep track of (or ship in a tarball
    extract).

if I were writing this.

> We also add
> "$(SCALAR_SOURCES)" files, which are part of C_OBJ but not included in
> "$(FOUND_C_SOURCES)" because they are in the "contrib/" directory.

Good.

> With this update, the newly generated "po/git.pot" will have 30 new
> entries coming from the following C source files:
>
>  * compat/fsmonitor/fsm-listen-win32.c
>  * compat/mingw.c
>  * compat/regex/regcomp.c
>  * compat/simple-ipc/ipc-win32.c

Good.

> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 83e968e2a4..46914dcd80 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2714,7 +2714,8 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
>  	--keyword=gettextln --keyword=eval_gettextln
>  XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
>  	--keyword=__ --keyword=N__ --keyword="__n:1,2"
> -LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
> +LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
> +	      $(GENERATED_H)
>  LOCALIZED_SH = $(SCRIPT_SH)
>  LOCALIZED_SH += git-sh-setup.sh
>  LOCALIZED_PERL = $(SCRIPT_PERL)
