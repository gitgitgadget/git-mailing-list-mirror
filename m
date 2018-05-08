Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C46C200B9
	for <e@80x24.org>; Tue,  8 May 2018 03:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754191AbeEHDrQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 23:47:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44905 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753886AbeEHDrP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 23:47:15 -0400
Received: by mail-wr0-f194.google.com with SMTP id y15-v6so19004762wrg.11
        for <git@vger.kernel.org>; Mon, 07 May 2018 20:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=y+0Apm2pBJVcIxB3yr8wffQLotD4mTc3d0AtIx+7U5U=;
        b=drmNxJDYr4Eppm3gmlFCvr3X04Lu7zWBb19Yz1ZWcl1Pq7kK38UrQVDAh438qm35cB
         m6qQVwUXxupiNz6E10K+/SP5Vos8sp8UhDfU7GuJEZfBmgiVSeoJ1mRLSPQAVn47Evga
         C8QQww6GvcVCUd1DNxBte2kbx3xfkI3q1RTvREi8sWXvZRYu5ASJg5gwsgKuLdByDj1P
         YMXfoGRQHWHeQ/lD77dkyMO9Kd2l0rLJc3CmKE46FxFVYyFqt46lKOAas+0GmKumU8OS
         +DMimN4gq/jTtfJZ6OuThDEIBG1T3epPKlBWrHB0Mri98+o1+Bl72UzRq4lLvh1JemOw
         jYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=y+0Apm2pBJVcIxB3yr8wffQLotD4mTc3d0AtIx+7U5U=;
        b=IdtRHV3W1GgI40g+JaLmGcOSuLrtAOkrMRjEb3XXw4qU0/gRzNIIFG8m9rXVukc9Bf
         xZ+3P8liZrUFsd8INcyBd2fhKayGbznLgB/cLjyBSD5OEU1SYelQNlE7GuusFJvSVgif
         e3UISNGL3EYeRNhQ91/0IhOygT1u+ivBxnniEXHJuSbyA9hOn0+d7YNx4RrnepdQlU2K
         GQgDtsLeMma3LbSFelMlLeTRmeSvvq07dJA5a444HcHlb4uJ/7Q139kqaKYtt/FVtIQM
         vXeQHIQg1XREwiGolyN7Jcmlwrvx1dTe7AlH/GP5exUjaCDKbVWyiVjrJs7H2Z+TKkjY
         pnGA==
X-Gm-Message-State: ALQs6tAROeNGBfgecqS6kDnvyPzD6Ne4C8RRKLQx6QhHH29rnulUO/g4
        gaxhiMR5pd2v0ObuqlkA2EFnciuJC3Q=
X-Google-Smtp-Source: AB8JxZp5BcJkThetYHk/PDPzPidA0Z4rHiaVwY7CbvsMObLXhVRscRzFJ/veD/ad41xeaOKTJ7HkLw==
X-Received: by 2002:adf:9789:: with SMTP id s9-v6mr33667861wrb.28.1525751234054;
        Mon, 07 May 2018 20:47:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x65-v6sm11982292wme.31.2018.05.07.20.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 20:47:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v6 02/13] generate-cmds.sh: export all commands to command-list.h
References: <20180429181844.21325-1-pclouds@gmail.com>
        <20180507175222.12114-1-pclouds@gmail.com>
        <20180507175222.12114-3-pclouds@gmail.com>
Date:   Tue, 08 May 2018 12:47:12 +0900
In-Reply-To: <20180507175222.12114-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 7 May 2018 19:52:11 +0200")
Message-ID: <xmqqmuxan70f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The current generate-cmds.sh generates just enough to print "git help"
> output. That is, it only extracts help text for common commands.
>
> The script is now updated to extract help text for all commands and
> keep command classification a new file, command-list.h. This will be
> useful later:
>
> - "git help -a" could print a short summary of all commands instead of
>   just the common ones.
>
> - "git" could produce a list of commands of one or more category. One
>   of its use is to reduce another command classification embedded in
>   git-completion.bash.
>
> The new file can be generated but is not used anywhere yet. The plan
> is we migrate away from common-cmds.h. Then we can kill off
> common-cmds.h build rules and generation code (and also delete
> duplicate content in command-list.h which we keep for now to not mess
> generate-cmds.sh up too much).
>
> PS. The new fixed column requirement on command-list.txt is
> technically not needed. But it helps simplify the code a bit at this
> stage. We could lift this restriction later if we want to.
> ---

Missing sign-off.

> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index 31b6d886cb..c9fd524760 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -1,5 +1,27 @@
>  #!/bin/sh
>  
> +die () {
> +	echo "$@" >&2
> +	exit 1
> +}
> +
> +command_list () {
> +	sed '1,/^### command list/d;/^#/d' "$1"
> +}
> +
> +get_categories() {

Here and define_categories() below lack SP before (), and all others
do.  Be consistent.

> +	tr ' ' '\n'|
> +	grep -v '^$' |
> +	sort |
> +	uniq
> +}
> +
> +category_list () {
> +	command_list "$1" |
> +	cut -c 40- |
> +	get_categories
> +}
> +
>  get_synopsis () {
>  	sed -n '
>  		/^NAME/,/'"$1"'/H
> @@ -10,14 +32,51 @@ get_synopsis () {
>  		}' "Documentation/$1.txt"
>  }
>  
> +define_categories() {
> +	echo
> +	echo "/* Command categories */"
> +...
>  };
> +"
> +if [ -z "$2" ]

if test -z "$2"

