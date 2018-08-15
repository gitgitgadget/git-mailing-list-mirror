Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B431F404
	for <e@80x24.org>; Wed, 15 Aug 2018 21:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeHPAX1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 20:23:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41921 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeHPAX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 20:23:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id s24-v6so1548959edr.8
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=7s5Zf9PepF0i0bbuxKOm+vAEgo1kP1lbUhmDO8q9DDo=;
        b=F4HBlFTQR3xXSCxV3M6iX82YK4kB2lftQLK97kcw05tg9YTHd8car/0DaOEGjn+wTO
         eMjGpH+x2qGiuKIrn8WqzFRqnsUHqkUWZEABm2jt9cbitw8cIxUpGKfDZUcL+Bh1Kb3J
         bJbcHe5V3PJThigobq1lM4ExR7Jgy/5n8YsFpbMPNQobyIKiYAtHoMspgLpMbkDJLKMn
         b/QH2zrn376MdQt37YxWKKG80H1Zp682Q4oy4qppvojCERtQj3ZuGmKTVthV/9his/o0
         9ZA4dUE8schEJKy4tFHtqBBdbquc+1EOwNGMKSiw3fbfj2SswxqZrsyykFehTX+VxOXC
         M80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=7s5Zf9PepF0i0bbuxKOm+vAEgo1kP1lbUhmDO8q9DDo=;
        b=UbqClqs+f26G4diX88DE2A2KixxRimX5DkuKfwpyBgZjwUr3BdO+T67Nng35n/7ibC
         GuH+iAthLqsHmp1g+kNsjQmxh9dIDKO8lrwrltZNO2lSkKkSATHNnF61CJLDHfPXS37M
         /aB40DQQCeKrkEvwNrrwAvkasn1JjHQa2ElxKjvr+DmaBeidZny/3jICOvy0xCGEDAzn
         wDdStiyBZcRv12b8NuqGljOYa1O5B1amU4yK2SLpi74sKIyqw2fy11oKGEOBtA5MSzyR
         JxGiEN6D7HlBHnomAz72jzjLVDid9vmCFNSV6MTRowV0wAiUOn1W2embM9I9viYEE7ff
         cY4w==
X-Gm-Message-State: AOUpUlEFbQYmISbwJeeHGn0JkG6l1+baKJ85BgyETU+Dhhw4Ma4SNRl3
        1PZTzRbGZXYY1asIG/N6ptG3HkmRUwI=
X-Google-Smtp-Source: AA+uWPwuqem5TTjqAApRWBGr1FdKx0PqaTlXE4OGg68fogRw2Ks8r3LBS6Gn59P9xrNsTYMD4skQVQ==
X-Received: by 2002:aa7:c1c5:: with SMTP id d5-v6mr33968688edp.270.1534368569972;
        Wed, 15 Aug 2018 14:29:29 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id j42-v6sm11996531eda.2.2018.08.15.14.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 14:29:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, bug-less@gnu.org
Subject: Re: "less -F" is broken
References: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
Date:   Wed, 15 Aug 2018 23:29:28 +0200
Message-ID: <87k1orqpxj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 15 2018, Linus Torvalds wrote:

> Sadly, as of less-530, the behavior of "less -F" is broken enough that
> I think git needs to potentially think about changing the defaults for
> the pager, or people should at least be aware of it.

Downloading & trying versions of it locally reveals that it's as of
version 520, not 530. The last version before 520 is 487. Presumably
it's covered by this item in the changelog:

    Don't output terminal init sequence if using -F and file fits on one
    screen[1]

> Older versions of less (at least up to less-487 - March 2017) do not
> have this bug.  There were apparently 520, 527 and 529 releases in
> 2017 too, but I couldn't find their sources to verify if they were
> already broken - but 530 (February 2018) has the problem.

FWIW they're not linked from
http://www.greenwoodsoftware.com/less/download.html but you can just URL
hack and see releases http://www.greenwoodsoftware.com/less/ and change
links like http://www.greenwoodsoftware.com/less/less-530.tar.gz to
http://www.greenwoodsoftware.com/less/less-520.tar.gz

> The breakage is easy to see without git:
>
>         (echo "hello"; sleep 5; echo "bye bye") | less -F
>
> which will result in no output at all for five seconds, and then you
> get both lines at once as "less" exits.

The relevant change in less is this, cutting out the non-relevant parts:

    diff --git a/less-487/forwback.c b/less-520/forwback.c
    index 83ae78e..680fa25 100644
    --- a/less-487/forwback.c
    +++ b/less-520/forwback.c
    [...]
    @@ -444,3 +444,21 @@ get_back_scroll()

     		return (sc_height - 2);
     	return (10000); /* infinity */
     }
    +
    +/*
    + * Return number of displayable lines in the file.
    + * Stop counting at screen height + 1.
    + */
    +	public int
    +get_line_count()
    +{
    +	int nlines;
    +	POSITION pos = ch_zero();
    +
    +	for (nlines = 0;  nlines <= sc_height;  nlines++)
    +	{
    +		pos = forw_line(pos);
    +		if (pos == NULL_POSITION) break;
    +	}
    +	return nlines;
    +}
    [...]
    diff --git a/less-487/main.c b/less-520/main.c
    index 960d120..6d54851 100644
    --- a/less-487/main.c
    +++ b/less-520/main.c
    [...]
    @@ -273,10 +275,19 @@ main(argc, argv)
     	{
     		if (edit_stdin())  /* Edit standard input */
     			quit(QUIT_ERROR);
    +		if (quit_if_one_screen)
    +			line_count = get_line_count();
     	} else
     	{
     		if (edit_first())  /* Edit first valid file in cmd line */
     			quit(QUIT_ERROR);
    +		if (quit_if_one_screen)
    +		{
    +			if (nifile() == 1)
    +				line_count = get_line_count();
    +			else /* If more than one file, -F can not be used */
    +				quit_if_one_screen = FALSE;
    +		}
     	}

     	init();
    diff --git a/less-487/screen.c b/less-520/screen.c
    index ad3fca1..2d51bbc 100644
    --- a/less-487/screen.c
    +++ b/less-520/screen.c
    [...]
    @@ -1538,7 +1555,9 @@ win32_deinit_term()
     init()
     {
     #if !MSDOS_COMPILER
    -	if (!no_init)
    +	if (quit_if_one_screen && line_count >= sc_height)
    +		quit_if_one_screen = FALSE;
    +	if (!no_init && !quit_if_one_screen)
     		tputs(sc_init, sc_height, putchr);
     	if (!no_keypad)
     		tputs(sc_s_keypad, sc_height, putchr);

If you undo that first changed part in main.c your test case prints
"hello" to the terminal immediately.

> It's not always obvious when using git, because when the terminal
> fills up, less also starts outputting, but the default options with -F
> are really horrible if you are looking for something uncommon, and
> "git log" doesn't respond at all.
>
> On the kernel tree, this is easy to see with something like
>
>    git log --oneline --grep="The most important one is the mpt3sas fix"
>
> which takes a bit over 7 seconds before it shows the commit I was looking for.
>
> In contrast, if you do
>
>    LESS=-RX git log --oneline --grep="The most important one is the mpt3sas fix"
>
> that (recent) commit is found and shown immediately. It still takes 7s
> for git to go through all history and decide "that was it", but at
> least you don't need to wait for the intermediate results.
>
> I've reported it as a bug in less, but I'm not sure what the reaction
> will be, the less releases seem to be very random.

Via bug-less@gnu.org? Is this report available online somewhere? Anyway,
CC-ing that address since my digging into this will be useful to them.

1. http://www.greenwoodsoftware.com/less/news.520.html
