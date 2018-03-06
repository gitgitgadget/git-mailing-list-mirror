Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43D41F404
	for <e@80x24.org>; Tue,  6 Mar 2018 20:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeCFUlN (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 15:41:13 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36037 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFUlM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 15:41:12 -0500
Received: by mail-wr0-f195.google.com with SMTP id v111so22306593wrb.3
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 12:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3mmRP+PEulVAtKOsOnK3SydAF8EatJKuHQetAh0x3tY=;
        b=XfBBwTqe+U7da/fhLL8VNTXOBG6gXlJ+GE+9WfFKNrXL5hhK9sIdUbOjf9HWYN8s5X
         6eTuDXhfYHFKT5klmF9uwRDcadO30n9XF52jCTxpIhhhssPF4aIpHxow1na9lB5G+E8e
         hd7tcVe9SHMzy6U/zmFoITOtepToaN1R9Eb9lxGo0MqEzI7teMWsu68Vmrqzx7cC03oF
         IRJ5SqM0G9W8/1ZZqMsuFSgQNBocxvKx6jTdLF4Gxh4/i7hl7CVu6qMptIHRPZLCgnI1
         CuKtvjCnpSLEKTRGa4/PlqhL6WLf2zRcSMhjkX4DSg8GL3vIVvMbBUQr1nmtFXB3gcWD
         sDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3mmRP+PEulVAtKOsOnK3SydAF8EatJKuHQetAh0x3tY=;
        b=Lvwsr38bjWJ2EDyDvR+85NM1VU16s5hCas9uShqvlQuCjkPIQMDc48HZiH9z19vJAs
         pd47oXPfyxHF0tfoAi7SE87pdvFlePjiW5ZuKXaU0AvgQXExqqT0okpzDWju8PES6xRi
         fgIpYf/kQz6vLE1Bv2pmK9DW45KUV36OnhVOOv6wzwXuGQ67Lrz0JfYORGtN2bJ3DQuY
         dtMZ4XmDhHz4nIb8rjUNqI0CWlSFxHQb6PGS4yiv4PnF/DnCffKrqjP0zQRM5ifd01HS
         1j0TWO76mDLCuKeSYfiRtsY8WBNi7dJdBWmsd6JxBGSX4GIKyeQyh17euWbhzXCib+Ps
         gbNg==
X-Gm-Message-State: APf1xPDP/dNM0dFlu5xG+bvPvPoqZdMgxPy++NwVxk3oK+734MhrQanq
        ii40gmbvgp3g7q2BhOhVPcg=
X-Google-Smtp-Source: AG47ELv1HGu2IogAhPf7xAi0RVENXt5u4nUbVf5OnXXmAnSXr/vACQv+nJtrhX5CduTUid63jD86lg==
X-Received: by 10.223.170.78 with SMTP id q14mr16422954wrd.271.1520368870853;
        Tue, 06 Mar 2018 12:41:10 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id k2sm18743353wrc.30.2018.03.06.12.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 12:41:09 -0800 (PST)
Subject: Re: [PATCH v2 2/3] add -p: allow line selection to be inverted
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
 <20180306101750.18794-3-phillip.wood@talktalk.net>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <4ce95d01-5cda-44f6-0504-f06ffe217032@gmail.com>
Date:   Tue, 6 Mar 2018 21:41:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306101750.18794-3-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2018 11:17, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> If the list of lines to be selected begins with '^' select all the
> lines except the ones listed.

s/to be selected begins with '^' select all/to be staged begins with '^' stage all/

> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-add.txt  |  3 ++-
>  git-add--interactive.perl  | 17 ++++++++++++++++-
>  t/t3701-add-interactive.sh |  2 +-
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index ad33fda9a2..0e2c11e97b 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -341,7 +341,8 @@ If you press "l" then the hunk will be reprinted with each insertion
>  or deletion labelled with a number and you will be prompted to enter
>  which lines you wish to select. Individual line numbers should be
>  separated by a space or comma, to specify a range of lines use a dash
> -between them.
> +between them. To invert the selection prefix it with "\^" so "^3-5,8"
> +will select everything except lines 3, 4, 5 and 8.

Hmm, here, first "selection" seems to make sense as it is (I guess),
but might still be better to later say 
s/will select everything/will stage everything/ ...?

That said, might be "to invert the selection" could rather be "to unstage," 
instead? Not sure, though.

>  +
>  After deciding the fate for all hunks, if there is any hunk
>  that was chosen, the index is updated with the selected hunks.
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index a273b41e95..6fa3d0a87c 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1085,9 +1085,21 @@ sub check_hunk_label {
>  sub parse_hunk_selection {
>  	local $_;
>  	my ($hunk, $line) = @_;
> -	my $max_label = $hunk->{MAX_LABEL};
> +	my ($max_label, $invert) = ($hunk->{MAX_LABEL}, undef);
>  	my @selected = (0) x ($max_label + 1);
>  	my @fields = split(/[,\s]+/, $line);
> +	if ($fields[0] =~ /^\^(.*)/) {
> +		$invert = 1;
> +		if ($1 ne '') {
> +			$fields[0] = $1;
> +		} else {
> +			shift @fields;
> +			unless (@fields) {
> +				error_msg __("no lines to invert\n");
> +				return undef;
> +			}
> +		}
> +	}
>  	for (@fields) {
>  		if (/^([0-9]*)-([0-9]*)$/) {
>  			if ($1 eq '' and $2 eq '') {
> @@ -1110,6 +1122,9 @@ sub parse_hunk_selection {
>  			return undef;
>  		}
>  	}
> +	if ($invert) {
> +		@selected = map { !$_ } @selected;
> +	}
>  	return \@selected;
>  }
>  
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 65c8c3354b..89c0e73f2b 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -410,7 +410,7 @@ test_expect_success 'setup expected diff' '
>  '
>  
>  test_expect_success 'can reset individual lines of patch' '
> -	printf "%s\n" l 2 |
> +	printf "%s\n" l "^1 3" |
>  	EDITOR=: git reset -p 2>error &&
>  	test_must_be_empty error &&
>  	git diff --cached HEAD >actual &&
> 
