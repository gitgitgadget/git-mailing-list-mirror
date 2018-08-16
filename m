Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07FD1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 08:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389958AbeHPLTI (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 07:19:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40438 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389696AbeHPLTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 07:19:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so3336749wrs.7
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kIteQY25Qzht02V8zRHqvgfv9WjhExGaCdGj793cMUw=;
        b=gD54Ddcr/lRNV59CrQ8hdi6nBb94nGMkXwn3QFQ6INYVIVeSGNQGYgfW/auAEEn52A
         kUjNqOByamN+aeYvPqzm5srQ9RzLA9g3Sd5VJy7T0mxjKoAHc4E3ffUEZ/O39aDkTYas
         kxH+hJZZJ7NvpvH4vghT1I2sL0rH+8xte/BeqjM/f9Rk3g+1IMqGqfRLPAuI3BcdYBfC
         qQeJmmF1evQecpax95joUCrLf0BApgzqro3y6AUvojEnFnjJV6nGAtkMGni6Pzt65elb
         tLmXSofJr2J/AKK7439yU41gvlnDPwK8GYt6NJLftKbTnhX3IixUNuoAEXBX4A42Bqbf
         EfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=kIteQY25Qzht02V8zRHqvgfv9WjhExGaCdGj793cMUw=;
        b=gD8avk9kqIQqhEqds2fKO03Doqb4eZBDtU4j2py03lrvP+1M2aEYeT2kGq5i1+caAO
         49f6bWgFWJVjOOXeOM0h7457WEmQgi2Cv/WGjiJrUpVGbu4bbrTHPUQKXBrfBcvPkr58
         mGsypr83RszcBtOeEfQqPKTjjwSd/3Hb8bI/xZqijcIiFr2c9ZcLAZpBVpdQQfurZ/QH
         QwJbmFtAUL7bKNK4wY41/mJgZ2kDuZPnSzRxPQaXdlVrlx4e8phUR1UpcyifYaV+pOav
         pH98uW4llSuEOGjfWhaUPWlXz+1nR9XYGtbu4ssANPA41k6Gw8Y+0ygcuRVvLNn79EL5
         5BtA==
X-Gm-Message-State: AOUpUlGUzmR/Vvo3HqX+wWtB55Oock6A1dSVVX7NZzY5wlLMPl6Xcuzh
        8rDpCR+0zrjh/bcOtD8+ENVVQDK7RBs=
X-Google-Smtp-Source: AA+uWPzjRF0jPdRYZaVoshHY43PYctZYKawWrK4+kf29dgqMHj0OApoAaLjzUavw8WC+1JLld8hU0w==
X-Received: by 2002:adf:9c93:: with SMTP id d19-v6mr18054858wre.11.1534407736778;
        Thu, 16 Aug 2018 01:22:16 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id d12-v6sm23384741wru.36.2018.08.16.01.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 01:22:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, bug-less@gnu.org
Subject: Re: "less -F" is broken
References: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
        <87k1orqpxj.fsf@evledraar.gmail.com>
        <CA+55aFxjUsvhHwQGthGiLr537BGHkd-LECXVv8KzBTMMCo1bKQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CA+55aFxjUsvhHwQGthGiLr537BGHkd-LECXVv8KzBTMMCo1bKQ@mail.gmail.com>
Date:   Thu, 16 Aug 2018 10:22:11 +0200
Message-ID: <87in4araa4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 15 2018, Linus Torvalds wrote:

> On Wed, Aug 15, 2018 at 2:29 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Downloading & trying versions of it locally reveals that it's as of
>> version 520, not 530. The last version before 520 is 487. Presumably
>> it's covered by this item in the changelog:
>>
>>     Don't output terminal init sequence if using -F and file fits on one
>>     screen[1]
>
> Side note: that's sad, because we already use X in the default exactly
> for that reason.

And as another note for those following along (and myself until a short
while ago, I didn't remember how this worked).

We set those default options at compile-time here:
https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/Makefile#L1761-L1763

I.e. set LESS=FRX and then when we setup the pager we use that unless we
can find LESS (and LV) set in the env already:
https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pager.c#L71-L96

> So apparently "less" was broken for us to fix something that we
> already had long solved. The code basically tried to do "automatic X
> when F is set".
>
> And all that line_count stuff (which is what breaks) is pointless when
> -X is already given.
>
> That does give a possible fix: just stop doing the line_count thing if
> no_init is set.
>
> So "-F" would continue to be broken, but "-FX" would work.
>
> Something like the attached patch, perhaps?

This works for me under -FX.

>             Linus
>  main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/main.c b/main.c
> index 179bd78..961a9db 100644
> --- a/main.c
> +++ b/main.c
> @@ -59,6 +59,7 @@ extern int	missing_cap;
>  extern int	know_dumb;
>  extern int	pr_type;
>  extern int	quit_if_one_screen;
> +extern int	no_init;
>
>
>  /*
> @@ -274,7 +275,7 @@ main(argc, argv)
>  	{
>  		if (edit_stdin())  /* Edit standard input */
>  			quit(QUIT_ERROR);
> -		if (quit_if_one_screen)
> +		if (quit_if_one_screen && !no_init)
>  			line_count = get_line_count();
>  	} else
>  	{
