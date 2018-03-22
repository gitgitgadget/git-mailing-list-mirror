Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDA51F404
	for <e@80x24.org>; Thu, 22 Mar 2018 17:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbeCVR43 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:56:29 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:50576 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCVR42 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:56:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id f19so17649549wmc.0
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=coB3xDzr9JnpASiVAI7JEvy3axksRgbETl4TWado+xc=;
        b=WLXXGDR+VOnTdu26Jb2J4EjoYIWjRnIgLRd4GsY8VRnq7g5NEnFD2gONq1hmcSd9dJ
         0kB1uCiKeOtXVva7cIxl0U+rk5IBMgOYsCse/G68FVqpbLaxZSu2GC4MBuU8UNkg5kwe
         85DMlZeUSvTqDrZyTiXyOgfZD0R318ytzJ9RgDnA4Zsse64fDHQ2LrRLNO862dxEkWoL
         cv5qif7o97jlN3zMZWMsDpomlvZztKBgU6QIEo5NiqZojI/HAqAoHr0xnRwuxw5sFPS5
         qoqcyaScodsbaoJC2kNfdQsHqdK0Cg7Cv+ie41b4gVMS0NggNi39fJuOufNnP9orHmdl
         9LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=coB3xDzr9JnpASiVAI7JEvy3axksRgbETl4TWado+xc=;
        b=ui7n5Qq0hE8gKWGxi+XOBFyy8ZSKxrhwEQqRCCUFQrW+sRoDUSR1gNr5sgK7RyGrYk
         5I2MsZuxV5W0AToP/us9oiDbAOUncL68jjI2z/8yL/pnJDwWdp/8AL1UmiDU83+igmyQ
         hUTLWNGcOPccK9tGExn4jdL5047v9O2YpkNzZH9GVqfVD8RPtrWp6LxudTLIHmdqn8BT
         QHkP4Ero6IDKN8XtA9HKkB1FLCpOgumRWMkvr9QbNEwrbSMGA2yvbaFCmkjXPXJbmUWQ
         PdAiPWPNQzoNSxb/+xM0LZ0nz3TCKMDuxfZd2/kMZ0Z7WkN8mJd3c/HrvR6lbXKDIKm4
         uhxQ==
X-Gm-Message-State: AElRT7EQYIue9w5b/O/hqcEA4IO35dR2qkGBnFv9ffbbD4isdBAaWFc8
        7qBzQ4n0ZxpkODAcxzaKtwA=
X-Google-Smtp-Source: AG47ELuBDFF7aPR0zHwBzrR0cIk4TNfGab0IBU3SoNmB1xuVZAsmlLb53mRBs2LIyBNtVoNx3m/WEA==
X-Received: by 10.28.35.205 with SMTP id j196mr6072195wmj.108.1521741386695;
        Thu, 22 Mar 2018 10:56:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m9sm7578922wrf.13.2018.03.22.10.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 10:56:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: add option completion for most builtin commands
References: <20180321193039.19779-1-pclouds@gmail.com>
        <xmqqd0zxno0j.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CWWSixQpXDh+q108j4xF8vpm5gsj2u3gJEgW=2bnXQHA@mail.gmail.com>
        <xmqqy3ikkpba.fsf@gitster-ct.c.googlers.com>
        <20180322173553.GA20984@duynguyen.home>
Date:   Thu, 22 Mar 2018 10:56:25 -0700
In-Reply-To: <20180322173553.GA20984@duynguyen.home> (Duy Nguyen's message of
        "Thu, 22 Mar 2018 18:35:54 +0100")
Message-ID: <xmqqtvt8kn92.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> +__git_main_with_parseopt_helper='
> +	blame cat-file check-attr check-ignore
> +	check-mailmap checkout-index column count-objects fast-export
> +	hash-object index-pack interpret-trailers merge-file mktree
> +	pack-objects pack-refs prune prune-packed read-tree repack
> +	send-pack show-ref stripspace symbolic-ref update-index
> +	update-ref verify-commit verify-tag write-tree
> +'
> +__git_complete_command() {
> +	local command="$1"
> +	local completion_func="_git_${command//-/_}"
> +	if declare -f $completion_func >/dev/null 2>/dev/null; then
> +		$completion_func
> +	elif echo $__git_main_with_parseopt_helper | git grep -w "$command" >/dev/null; then

"git grep"???

I imagined that you'd keep an associative shell array (we are not
constrained by POSIX here) that can be used like so

	elif test -n "${__git_main_with_parseopt_helper[$command]}"; then

Of course, a more traditional way to write it without spawning grep
or pipe is

	case " $__git_main_with_parseopt_helper " in
	*" $command "*)
		... Yes, $command is on the list ...
		;;
	*)
		... No, $command is not on the list ...
		;;
	esac
