Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B4720248
	for <e@80x24.org>; Mon, 15 Apr 2019 09:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfDOJnw (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 05:43:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37886 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOJnw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 05:43:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so21060630wrm.4
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=34yvmotYSD4m61FH9hIOIaTXhtXwEivgwWpE6ILO8z0=;
        b=WnHDgZn3j2KA/R0f48KfHlcHeNr4cqy5Ojbn6gTXHY/MeDVgtORF3LWDhgfsmOFtad
         uxvWrNM5AEGmlHlKheKrPWXLZZASy9k/VukwmxjpvNPoVKw5uqaBc6Z+YchG0AWRrpgY
         xteI3EFAKxwuxbq9PvgQCb2wvutc07uCfhEcVycBxAXHzRCYEIbqPlw5Is+O8DHw+o+s
         ujKJdJPXYd0DcP9RK9rl+TunFf9taY+COy7lGj00hktmJg7zk8fIdJ0QBbVkTRs3sHy9
         LCyAfKbYcemUtLcUHN4urd7B3t4k1Xa8e2zRSnoHFX/JVhaQgjtpu3JEFFm3vzKP2xmm
         wvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=34yvmotYSD4m61FH9hIOIaTXhtXwEivgwWpE6ILO8z0=;
        b=ncGxiibWw2Tz+vSBIdNtAy6B/eUqtFPiNp/pZPDa7Ew+ETCGsb0gIKJScaR3zHltHN
         tziS8FUhckoWhhG99RCH3XgeDmA0R64JBYlqOOSW3EX6WFnjPZPAqk0nGyYpiS5blYO6
         Eg/vifOch45d5A9bwtcjGQnItikzlDqSjJ1Qvu/v0Jll2l4wFshXMrTpS+4i4q/40fbb
         Jao2K3ySZpIbKT1NEuil+R56VhjqGF2Y86bahpIRlvOdYNeeMt5WXm39L/CY6JRUFZqu
         iAMuzOr/WRPBb2sJj6t6YbRKTAN2Dwjn2IbYeYEbomcuBme0xo9yEdfZYtTMNtHzQBot
         FAqw==
X-Gm-Message-State: APjAAAW+7bIIc3rRxTWmo3yvzAiCFsLE8XBchEHcBHJKoaKPyNTaKrww
        Bz1+JfvltXf7xi3UbBfoLiRQoatL2oo=
X-Google-Smtp-Source: APXvYqxdfBxYdlg0OS4i8y8eXRGNfUUXpEIWo+SKQfqkC8fynCFO+zuP8HeWzvLqyqNPzGIDlPUFkA==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr48493603wrs.278.1555321430977;
        Mon, 15 Apr 2019 02:43:50 -0700 (PDT)
Received: from szeder.dev (x4db554a2.dyn.telefonica.de. [77.181.84.162])
        by smtp.gmail.com with ESMTPSA id t74sm25588059wmt.3.2019.04.15.02.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 02:43:50 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:43:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Re* [PATCH v4 1/2] transport: die if server options are
 unsupported
Message-ID: <20190415094347.GE15936@szeder.dev>
References: <20190405204413.93900-1-jonathantanmy@google.com>
 <cover.1555098572.git.jonathantanmy@google.com>
 <598b2de0162e240521f04d40d41eb11843be7198.1555098572.git.jonathantanmy@google.com>
 <20190412201228.GA15936@szeder.dev>
 <xmqqlg0bvppc.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlg0bvppc.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 01:48:31PM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > ... therefore these should be 'test_i18ngrep'.  This applies to the
> > other tests in this patch series as well.
> > ...
> 
> Hmph.  That would mean the following is needed, but I suspect that
> 6cdccfce ("i18n: make GETTEXT_POISON a runtime option", 2018-11-08)
> is somewhat broken (see the bottom for a suggested fix).

Oh, wow, indeed.

I still notice these [1], because I prefer to run the GETTEXT_POISION
CI jobs in my half-baked "scrambled" mode [2], but haven't yet got
around to deal with the conflicts between those patches and
'ab/dynamic-gettext-poison', so my script prepping in-flight topics
for my CI builds still starts with reverting
'ab/dynamic-gettext-poison', restoring that missing 'export'.


[1] https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/519163854#L2724

[2] https://public-inbox.org/git/20181022202241.18629-1-szeder.dev@gmail.com/

> -- >8 --
> Subject: [PATCH] gettext tests: export the restored GIT_TEST_GETTEXT_POISON
> 
> 6cdccfce ("i18n: make GETTEXT_POISON a runtime option", 2018-11-08)
> made the gettext-poison test a runtime option (which was a good
> move) and adjusted the test framework so that Git commands we run as
> part of the framework, as opposed to the ones that are part of the
> test proper, are not affected by the setting.  The original value
> for the GIT_TEST_GETTEXT_POISON environment variable is saved away
> in another variable and gets unset, and then later the saved value
> is restored to the environment variable.
> 
> But the code forgot to export the variable again, which is necessary
> to restore the "export" bit that was lost when the variable was unset.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/test-lib.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 8665b0a9b6..078efda9da 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1394,6 +1394,7 @@ test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
>  if test -n "$GIT_TEST_GETTEXT_POISON_ORIG"
>  then
>  	GIT_TEST_GETTEXT_POISON=$GIT_TEST_GETTEXT_POISON_ORIG
> +	export GIT_TEST_GETTEXT_POISON
>  	unset GIT_TEST_GETTEXT_POISON_ORIG
>  fi

Makes sense.

