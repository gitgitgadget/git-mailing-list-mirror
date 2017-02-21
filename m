Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B13A201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 19:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbdBUTQP (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 14:16:15 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:35149 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754684AbdBUTQA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 14:16:00 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so122777162ith.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 11:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mdXb9uR8K053JDTr9PegKruN0b7cLooMz/Sqqt6PdH4=;
        b=FNuglQ1H2vt6mdOMCQFWt0IsCua0+q8/+PAP+l3pL0rO+AzHemWHdSmSkI+0etV67P
         Zc2T9LSLvYp7ojcleBB6FrwbEwVGsX0UrNGax669sboR12zAfgaLvQXx7SPIwLV7XvVV
         VlJcDVg7Z1JkcCKtp2m5v+CL+LyRTsSS7gEko9bL2LDu8tW0s+1AnXMuRtnBcgNZNeQr
         W3gmLNdR5jtB5v0/DbxgrSWPSwmaCHfwn9p/JiEQI7Th5zI1w74wbG+1DmX1AWuZS7tQ
         xtqNKbVZDUZMVT4miIuhnzDZ4YrA7i4MiRT0wkV3LLZyOkJMC7SSYLFHJUTTYfwsQdcf
         QEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mdXb9uR8K053JDTr9PegKruN0b7cLooMz/Sqqt6PdH4=;
        b=hPlNsmTr8dawbnN36MJe1IJg7ggiviDabDKclYJuzpCBW31dVXcHbAeUsudtieCT1C
         IIkPQT1iQg+PqjT0BCnQl1x3UGaI5J54SDm1AX9C3+Qy5IyY7CAPcWByacIOHYpRZFH9
         X2IgQxOLg69T4aM6337cX3JIH+AVZ6Je2a8J/qUcCDLmqTPMSldTTssPnGFxmClF4Yg0
         fKatXZPFEJ/ZqSyVsuRpyiWVlpVee5XOtfuk8OGK3gUoD+qRJ/mfWkC4zXX/UeQ7IJWA
         7J0BteAup68WOlOubSrNFqWUumO4LO+zcTm64sXFXczKZCZ8vFUTD3CS14YkOgAdWjpy
         exoQ==
X-Gm-Message-State: AMke39nQ22lhJCNsvMLyI4bHKul+WF2TwogsFlIcE9+ADAlhRwCHsGBQw5QZU/JqcSOTVeRHuyhcDSXSmJoWhEae
X-Received: by 10.36.225.13 with SMTP id n13mr11262686ith.114.1487704553329;
 Tue, 21 Feb 2017 11:15:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 21 Feb 2017 11:15:52 -0800 (PST)
In-Reply-To: <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
References: <20170215111704.78320-1-larsxschneider@gmail.com>
 <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com> <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
 <xmqqy3x712if.fsf@gitster.mtv.corp.google.com> <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
 <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com> <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
 <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net> <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
 <xmqqino5jia8.fsf@gitster.mtv.corp.google.com> <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Feb 2017 11:15:52 -0800
Message-ID: <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
Subject: Re: [PATCH] config: reject invalid VAR in 'git -c VAR=VAL command'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The parsing of one-shot assignments of configuration variables that
> come from the command line historically was quite loose and allowed
> anything to pass.
>
> The configuration variable names that come from files are validated
> in git_config_parse_source(), which uses get_base_var() that grabs
> the <section> (and subsection) while making sure that <section>
> consists of iskeychar() letters, the function itself that makes sure
> that the first letter in <variable> is isalpha(), and get_value()
> that grabs the remainder of the <variable> name while making sure
> that it consists of iskeychar() letters.
>
> Perform an equivalent check in canonicalize_config_variable_name()
> to catch invalid configuration variable names that come from the
> command line.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>     Junio C Hamano <gitster@pobox.com> writes:
>
>     > One thing I noticed is that "git config --get X" will correctly
>     > diagnose that a dot-less X is not a valid variable name, but we do
>     > not seem to diagnose "git -c X=V <cmd>" as invalid.
>     >
>     > Perhaps we should, but it is not the focus of this topic.
>
>     And here is a follow-up on that tangent.

Combining this thought with another email[1] that flew by,
do we also need to have this treatment for "git clone -c"
[1] http://public-inbox.org/git/EC270E42-9431-446C-96F9-E1A0C3E45333@gmail.com/

>
> +for VAR in a .a a. a.0b a."b c". a."b c".0d
> +do
> +       test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
> +               test_must_fail git -c $VAR=VAL config -l
> +       '
> +done
> +
>  test_expect_success 'git -c is not confused by empty environment' '
>         GIT_CONFIG_PARAMETERS="" git -c x.one=1 config --list

Do we also want to test obscure cases of expected success?
e.g. I suspect we never use a."b c".d in the test suite elsewhere but it
would be a valid key to be handed to git?
