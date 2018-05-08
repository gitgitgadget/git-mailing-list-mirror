Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BAF3200B9
	for <e@80x24.org>; Tue,  8 May 2018 04:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750724AbeEHEAT (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 00:00:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41998 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeEHEAS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 00:00:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id v5-v6so30747253wrf.9
        for <git@vger.kernel.org>; Mon, 07 May 2018 21:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1hrdwFJn3NPdiUW21cr1M2TP4pry7fuW4D2Ol423s/Y=;
        b=eQ4WBlbeiH9ucmepxdnQ4CeSP0kenq+Lp8sCxsdlBoEfoslRNKWrVkRzvWOiV+qjrv
         9jgfqJsvVK1DLFYcOQ4oaxmmmHA3NcCuutn1olBy6ycx2jagqNBR89izcZrblGIxEMht
         ouvuYbNHqII3hg8Fw0ugDh45/SSW4P/CSBUpDCJfetoBewmibdfWydbpsjF7RDQrfZAb
         t7WkXCDmupRBcXx00fJEfNrJcRHSJBR/J3JaoJZ9o5wpeiUiVvpnoTPUuVTAkg9xOBFG
         9Wips5t8lGVds3wQOL+Ubivpd8NRn8ykXSLdkpnrE6b/6MeJXBWEe4fVdu9F9pO0cBW+
         bSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1hrdwFJn3NPdiUW21cr1M2TP4pry7fuW4D2Ol423s/Y=;
        b=KReefjFamM28oyTlxzuFnlygbDYqv6PsFtp63HRsjLDZRj+iybdK+oRIOCLC8FfrjC
         eXCSBrCSz2WH1CEdTCcNyITl5ubgYOi8l2pw9bfHBxTAEBT1L/ZVTyf2yrCFmrIp2iBo
         7tduQqEUn8jfjw5l2yWAHM/5pG8UEuf98DA99hXgLN9DCDPHqksBuhUdFg8KeIgWsga6
         +VbErkpLFHB2mhTPQjL8XMBBk7sC4BMoFUHKUzoUsl1n1qh+Lc8tTgj8G4WIuxawSKr4
         oBA2tGSu2G/5aWsRFS/bx7Ldw7uVzvkggTKwxe9jEqz4b4FVP9FtU5Wc6C+s8udzYU6k
         vzEg==
X-Gm-Message-State: ALQs6tB5uTvkEy1lMU0TGbEiTD41HOgPC++UixTkNkkqGd5ftTU/8bjV
        9griCu64jUAlx1PZYvIgsnY=
X-Google-Smtp-Source: AB8JxZq0E4Ilob+9x+ok6W8Qx2z4xI5tbkN617/H/COYAVESiiXZBqtCEKV9dcmJA7uQxTZZEgIPKw==
X-Received: by 2002:adf:a00d:: with SMTP id k13-v6mr30944166wrk.39.1525752017068;
        Mon, 07 May 2018 21:00:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m134sm11854175wmg.4.2018.05.07.21.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 21:00:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v6 08/13] git: support --list-cmds=list-<category>
References: <20180429181844.21325-1-pclouds@gmail.com>
        <20180507175222.12114-1-pclouds@gmail.com>
        <20180507175222.12114-9-pclouds@gmail.com>
Date:   Tue, 08 May 2018 13:00:16 +0900
In-Reply-To: <20180507175222.12114-9-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 7 May 2018 19:52:17 +0200")
Message-ID: <xmqqefimn6en.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This allows us to select any group of commands by a category defined
> in command-list.txt. This is an internal/hidden option so we don't
> have to be picky about the category name or worried about exposing too
> much.
>
> This will be used later by git-completion.bash to retrieve certain
> command groups.
> ---

Missing sign-off.

>
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index 015eef2804..bfd8ef0671 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -45,6 +45,21 @@ define_categories() {
>  	test "$bit" -gt 32 && die "Urgh.. too many categories?"
>  }
>  
> +define_category_names() {

Style.

>  print_command_list() {

Ditto (but needs fixing in an earlier step).

> diff --git a/git.c b/git.c
> index 3c032d01fc..67f3e20ae9 100644
> --- a/git.c
> +++ b/git.c
> @@ -53,6 +53,13 @@ static int list_cmds(const char *spec)
>  			list_all_main_cmds(&list);
>  		else if (len == 6 && !strncmp(spec, "others", 6))
>  			list_all_other_cmds(&list);
> +		else if (len > 5 && !strncmp(spec, "list-", 5)) {

Earlier I asked to have a small helper to avoid the constant length that
has to go together with a constant string, e.g.

		has_prefix(spec, len, "others")

but this new one may make it a bit tricky.

	else if (has_prefix(spec, len, "others")
		...
	else if (has_prefix(spec, len, "list-") &&
		spec[strlen("list-")] != '\0' ) {
		...

does look a bit ugly.  Others may be able to help with better ideas.

Thansk.
