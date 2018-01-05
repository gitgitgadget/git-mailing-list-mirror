Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C095E1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 18:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeAES7a (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 13:59:30 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37125 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeAES73 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 13:59:29 -0500
Received: by mail-qt0-f194.google.com with SMTP id f2so6856553qtj.4
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 10:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JSKqSfCJEOpiCmi8vm2i5QcnYp/WbGk+2ABs6s1HSeM=;
        b=CQiYVciM9Ylbk5RylUjBb1pvkfCtSFGoSlYkeeIkPTHjMgPXaDXY3XKhjo/2BSu+Ra
         /QYcggn7AnTdrpzBDZ0r4c+Pbu/abvvi2MA018n2x+VBI+jc32NMpmwvUGBG9i+OCxgE
         Bla3mXV++ZpGtk3TgUww/SKgCEIAgQaZeFvBuV3UKcNxnec8mRuW556oIRktH8c4ywg0
         /BxXT3ZdPSiiJT/tA1L43NTkvhYi0AhOzzmqQIJvFx1CU8ogNkfOuBHvGCupqJ0OnwqI
         1opkkNruN/oq466kkZ4Zj6vIA14vz/oQaETD9hF31EBOxaB2qVStI4rvU4xYxeVh7k+Y
         dDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JSKqSfCJEOpiCmi8vm2i5QcnYp/WbGk+2ABs6s1HSeM=;
        b=bpu/Bvbu1c+sta42dutLCx339+wDo/jrcTpff3lSIYAPlHI20A1yAsZiCe5vzezQaM
         H+/ZTLvelU9kiqpZ6qC7dhnG9Y/sJ7HE6ikd1Wg1BBFu27QyzJakezog99EXs0LUouhg
         akenVXDCj+GQ15/xAD80YuVs9W+oM9vNngGjtP7w0heFKslhkMop03AZyG0wetdo9jo3
         l3X9DqzJQgOUD2nFfS+3YKalMGxy926Uczb+CtogKMg2wtWzuVHIVaNETET+JPJ69nrZ
         8cIGqbnEJ0k0rYEAi5+vk1wwbMk/ExPSuMWX4vm4C63Hr784E076vNDJMpghMqtMojO+
         /MRQ==
X-Gm-Message-State: AKwxytf/aJEiEVcBfBGuIRYK+9DawDcPoUeEWL+BgHvggz6eRCPXz/e9
        dqxe+lN3tQ3il8LLzR56AO7Jf87KocA5UyTk2HA=
X-Google-Smtp-Source: ACJfBovDiSkTPZ2Q3/fWGGkXF58AkBqfkWD3lzUa9KpKGiSoKYR2TWpzizxETpYQ/7dFppE5nm5rIIcW5lbGtB1LMq0=
X-Received: by 10.237.38.71 with SMTP id z65mr5485339qtc.114.1515178768378;
 Fri, 05 Jan 2018 10:59:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Fri, 5 Jan 2018 10:59:27 -0800 (PST)
In-Reply-To: <1515177413-12526-3-git-send-email-git@matthieu-moy.fr>
References: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
 <1515177413-12526-1-git-send-email-git@matthieu-moy.fr> <1515177413-12526-3-git-send-email-git@matthieu-moy.fr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 Jan 2018 13:59:27 -0500
X-Google-Sender-Auth: sh5tdGclCnboHZgMknA-JbP51Io
Message-ID: <CAPig+cQURBQxw69RFyOGKxqyQihTh1c7djsFx3H2MJtWNXKryg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] send-email: add test for Linux's get_maintainer.pl
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Thomas Adam <thomas@xteddy.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 5, 2018 at 1:36 PM, Matthieu Moy <git@matthieu-moy.fr> wrote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> We had a regression that broke Linux's get_maintainer.pl. Using
> Mail::Address to parse email addresses fixed it, but let's protect
> against future regressions.
>
> Patch-edited-by: Matthieu Moy <git@matthieu-moy.fr>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
> ---
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> @@ -172,6 +172,26 @@ test_expect_success $PREREQ 'cc trailer with various=
 syntax' '
> +test_expect_success $PREREQ 'setup fake get_maintainer.pl script for cc =
trailer' "
> +       write_script expected-cc-script.sh <<-EOF &&
> +       echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
> +       echo 'Two Person <two@example.com> (maintainer:THIS THING)'
> +       echo 'Third List <three@example.com> (moderated list:THIS THING (=
FOO/bar))'
> +       echo '<four@example.com> (moderated list:FOR THING)'
> +       echo 'five@example.com (open list:FOR THING (FOO/bar))'
> +       echo 'six@example.com (open list)'
> +       EOF
> +       chmod +x expected-cc-script.sh
> +"
> +
> +test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
> +       clean_fake_sendmail &&
> +       git send-email -1 --to=3Drecipient@example.com \
> +               --cc-cmd=3D"./expected-cc-script.sh" \
> +               --smtp-server=3D"$(pwd)/fake.sendmail" &&

Aside from the unnecessary (thus noisy) quotes around the --cc-cmd
value, my one concern is that someone may come along and want to
"normalize" it to --cc-cmd=3D"$(pwd)/expected-cc-script.sh" for
consistency with the following --smtp-server line. This worry is
compounded by the commit message not explaining why these two lines
differ (one using "./" and one using "$(pwd)/"). So, at minimum, it
might be a good idea to explain why "./" is used for this one distinct
case, compared with all the others which use "$(pwd)/". An alternative
would be to insert a cleanup/modernization patch before this one which
changes all the "$(pwd)/" to "./", although you'd still want to
explain why that's being done (to wit: because --cc-cmd behavior with
spaces is not well defined). Or, perhaps this isn't an issue and my
worry is not justified (after all, the test will break if someone
changes the "./" to "$(pwd)/"). At any rate, such a concern probably
shouldn't hold up this patch.

> +       test_cmp expected-cc commandline1
> +'
> +
>  test_expect_success $PREREQ 'setup expect' "
>  cat >expected-show-all-headers <<\EOF
>  0001-Second.patch
