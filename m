Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F94202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 23:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbdKTXE6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 18:04:58 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:39048 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbdKTXE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 18:04:57 -0500
Received: by mail-qk0-f174.google.com with SMTP id w125so9613814qkb.6
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 15:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=v6hDIbI5abdTZ3Fcn3S8wMn0OkUrx5y4s8xmAz8vTBM=;
        b=IvKBPxHR+S/gQucFsIpkZQ9miENHh/p/i34w6jbasBUCQgEw30EEmRmZBYcp93Y/5L
         zupdI01CZ/U3tMsxgcQwN5unhzb47Gfyx4kfC9ULxeinOIdS0r8bLTFyuKiOmcMBFjWs
         KNT2SeOVjzZtS9YfU7YWQKMsg7psT/ClztDzKzN0P2JISkxpeBcMKJtHnEwIh8sH765/
         winNwXuT0OxZyiU1FK9ogxZxkDWN0MMSm1OTSuWpFzA50kgF6axUGxCG+IoI2/pb5rBO
         Jrxf1bsNTErD/2pkEjK6SrZESAy7dwzj9e8r+ERP2tL5dQLmbl83Ylc7/mCcu/8wRXSv
         4evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=v6hDIbI5abdTZ3Fcn3S8wMn0OkUrx5y4s8xmAz8vTBM=;
        b=ney69ioOcuVIgq8IIPqy1cVaV8RFKT+D/o5c0eognmxaxLA1vzzSKpuiYBmOA/ObS/
         y/lw8kBvhQknkS0IwF2NwGZAee5bt0rpBiQ7ms6pKJViImJClOZnrApYnUN5GEdDCcmN
         lAqWbr7ir+Iu4g4sLDXLqa/vISDqCfibUrIL+41R018+elv2sUe8UiCvrQocf7w63CvF
         VCDi7CFqsXbRRHOI27+kLbdoq1XF1398RBvEMtSbQTbTMc5xofU49lgq+0Y4i3EtH9mL
         Av7mOTatvTP8y+pw8urPxe4kO/DVY7LVFTJifoh1kNJ0wPLmT1SkUDFf0pg58fWCyP32
         5wlg==
X-Gm-Message-State: AJaThX5An1x4NLG9DEoKgbKz2X94c0q+60yNl95jOHDorW0CEp34HB0d
        F8HA9wJK+f7BCJNaMMrSuJzNEv7o+3Rym7Y6JQMVog==
X-Google-Smtp-Source: AGs4zMYOrG2OE5uajkElnFEObpivrc953R+9IVg5UN31C6XvX+uv2qQpgqUwVuNd7O0yH5GsK3AK5SFBM+QvKI2ZIR4=
X-Received: by 10.55.141.3 with SMTP id p3mr23583080qkd.210.1511219096291;
 Mon, 20 Nov 2017 15:04:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Mon, 20 Nov 2017 15:04:55 -0800 (PST)
In-Reply-To: <20171120114101.16508-1-alex.bennee@linaro.org>
References: <20171120114101.16508-1-alex.bennee@linaro.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Nov 2017 18:04:55 -0500
X-Google-Sender-Auth: tMNWABD6QA7qRuKj8XXRs31kGGE
Message-ID: <CAPig+cTkPUVgEaDK+yo9+JdE1Mmx0kEOV5EfCQYeswd8vkxJNw@mail.gmail.com>
Subject: Re: [PATCH] git-send-email: fix --cc-cmd get_maintainer.pl regression
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 6:41 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> Since the removal of Mail::Address from git-send-email certain address
> patterns returned by common get_maintainer.pl scripts now fail to get
> correctly parsed by the built-in Git::parse_mailboxes. Specifically
> the patterns with embedded parenthesis fail. For example from the
> Linux kernel MAINTAINERS:
> [...snip...]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
> diff --git a/perl/Git.pm b/perl/Git.pm
> @@ -936,6 +936,9 @@ sub parse_mailboxes {
>                         $end_of_addr_seen =3D 0;
>                 } elsif ($token =3D~ /^\(/) {
>                         push @comment, $token;
> +               } elsif ($token =3D~ /^\)/) {
> +                       my $nested_comment =3D pop @comment;
> +                       push @comment, "$nested_comment$token";

See [1] for commentary on this fix being too fragile and working only
for this very specific case.

[1]: https://public-inbox.org/git/CAPig+cTXq6jSN9f2_xyj=3DJfv_cg2kUFUtA5uVk=
ZDrRRSi2x7vg@mail.gmail.com/

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> @@ -172,6 +172,22 @@ test_expect_success $PREREQ 'cc trailer with various=
 syntax' '
> +test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
> +        write_script expected-cc-script.sh <<-EOF &&
> +echo "One Person <one@example.com> (supporter:THIS (FOO/bar))"
> +echo "Two Person <two@example.com> (maintainer:THIS THING)"
> +echo "Third List <three@example.com> (moderated list:THIS THING (FOO/bar=
))"
> +echo "<four@example.com> (moderated list:FOR THING)"
> +echo "five@example.com (open list:FOR THING (FOO/bar))"
> +echo "six@example.com (open list)"
> +EOF

Since you've used -EOF, you can indent this entire block (with tabs)
to the level of the write_script() to make it easier to read.

Also, it's recommended to use -\EOF to suppress interpolation within
the here-doc; it's not needed in this case, but doing so states
intent.

> +       clean_fake_sendmail &&
> +       git send-email -1 --to=3Drecipient@example.com \
> +               --cc-cmd=3D./expected-cc-script.sh \
> +               --smtp-server=3D"$(pwd)/fake.sendmail" &&
> +       test_cmp expected-cc commandline1
> +'
