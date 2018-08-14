Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835E51F428
	for <e@80x24.org>; Tue, 14 Aug 2018 18:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeHNV2W (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:28:22 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:43934 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbeHNV2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:28:22 -0400
Received: by mail-yw1-f49.google.com with SMTP id l189-v6so16950786ywb.10
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gRZqn55+GjhAVgRy6aVjb9n4qd7V3XKjwzyYpeLdlXg=;
        b=exvtqkt250KEdpGJoCUxWBZXjgxXRr0iDhRjwCQkXflSwi3z00leWpML8tTIJyd0Ba
         h6hgcN+omZV3XqJn3OI8mcsO+GeGNkHDKVMSMruAIgoqYDOGR8QQ1HwNzliTm/Sh2BNR
         yJNTicrEiDWSMawRKRixnYbxogf6bWec69DBR4zix2C+BkDoIZBVRnj47+0e+3/k3tiy
         jmv88jXrWX4W9MfDUdnSwAVWSWxaURwmldxdneuBUtcE2CRysiIl2Csd6bm4Xmc5JnIJ
         cR0eUAfQNq9u3eNagKfhR6teDm2sXdBFT32fho03Ui9wiSrDQAT4YJmlRjL50tPW86aN
         BE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gRZqn55+GjhAVgRy6aVjb9n4qd7V3XKjwzyYpeLdlXg=;
        b=MAKBWuOD47m1FXx2eu8eWlmlj7FYqbRNqvSmDQ4a7o0NtoGvP/dAQwIwB51T9RhUTc
         rHRfkORLZp+HSUWdTkkXD5Ej/tTIT2l+m60M3/0NHtTKXn32b6YjbdgCNWYuDlTt63Bz
         6q8yAg1sQvzdHvuckIkS4EkzxkLQqNcvt4sp8i0lZqB6qpI2mdGs0+vG/YmUO4hB7KSj
         Led1J8OjlERt2QUlflmMrSz/1pjbTsuTezY6GqScOctPlhYDEApn6Oc6DmT9GoWOFV3g
         sW40TG74h48iWprd5G8y0QQMkWaDq/Y78ImJsMbjbAVseBFeF9QU0/rIAmJSX06w8ax7
         q+WA==
X-Gm-Message-State: AOUpUlEYsYjoVWHnjEST904QoYGEN+WSTkuAvL1yxVe4Vb379HYQHZbB
        fsUgLGWhV3s4jT4R38uKhMxxEHIdSNKRMyxvXBENlg==
X-Google-Smtp-Source: AA+uWPxh+2qLmCd/2PcgFYpSWu00yrmlQ7nbmlhxK3d6Iqwa/B7/Zk3lS+oQEDfPY+Ue3yD4WxbITISIxkoPatOR5cw=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr13286575ywd.421.1534271992390;
 Tue, 14 Aug 2018 11:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180325182803.30036-1-avarab@gmail.com> <20180814181534.21234-1-avarab@gmail.com>
In-Reply-To: <20180814181534.21234-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 11:39:41 -0700
Message-ID: <CAGZ79kZa+VQLfSme2q9UHZEmGYb=7uGgQoNP-BHctq31Js-TGg@mail.gmail.com>
Subject: Re: [PATCH v2] send-email: add an option to impose delay sent E-Mails
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Add a --send-delay option with a corresponding sendemail.smtpSendDelay
> configuration variable. When set to e.g. 2, this causes send-email to
> sleep 2 seconds before sending the next E-Mail. We'll only sleep
> between sends, not before the first send, or after the last.
>
> This option has two uses. Firstly, to be able to Ctrl+C a long send
> with "all" if you have a change of heart. Secondly, as a hack in some
> mail setups to, with a sufficiently high delay, force the receiving
> client to sort the E-Mails correctly.
>
> Some popular E-Mail clients completely ignore the "Date" header, which
> format-patch is careful to set such that the patches will be displayed
> in order, and instead sort by the time the E-mail was received.
>
> Google's GMail is a good example of such a client. It ostensibly sorts
> by some approximation of received time (although not by any "Received"
> header). It's more usual than not to see patches showing out of order
> in GMail. To take a few examples of orders seen on patches on the Git
> mailing list:
>
>     1 -> 3 -> 4 -> 2 -> 8 -> 7 (completion by Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy)
>     2 -> 0 -> 1 -> 3 (pack search by Derrick Stolee)
>     3 -> 2 -> 1 (fast-import by Jameson Miller)
>     2 -> 3 -> 1 -> 5 -> 4 -> 6 (diff-highlight by Jeff King)
>
> The reason to add the new "X-Mailer-Send-Delay" header is to make it
> easy to tell what the imposed delay was, if any. This allows for
> gathering some data on how the transfer of E-Mails with & without this
> option behaves. This may not be workable without really long delays,
> see [1] and [2].
>
> The reason for why the getopt format is "send-delay=3Ds" instead of
> "send-delay=3Dd" is because we're doing manual validation of the value
> we get passed, which getopt would corrupt in cases of e.g. float
> values before we could show a sensible error message.
>
> 1. https://public-inbox.org/git/20180325210132.GE74743@genre.crustytoothp=
aste.net/
> 2. https://public-inbox.org/git/xmqqpo3rehe4.fsf@gitster-ct.c.googlers.co=
m/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> I submitted this back in March hoping it would solve mail ordering
> problems, but the other motive I had for this is that I'm paranoid
> that I'm sending out bad E-Mails, and tend to "y" to each one because
> "a" is too fast.'

Heh. GMail seems to have added an Undo button in their UI, which
would be the same feature as this one. (Hit Ctrl+C in time to "undo"
the sending command)

I have been bitten quite a few times by using "a" as I had old
series still laying around, such that it would send a new series and parts
of the old series (or when you changed subjects and resend another
iteration of a series, you may end up with two "patch 1"s).
So I learned to be careful before pressing "a" on sending.

Maybe the underlying issue is that you really only want to send a series
and not "all" as send-email asks for.
So maybe that dialog could learn a [s]eries switch, which would
check either filenames to count up, or if the base that is recorded
(base-commit for first and prerequisite-patch-id for followups)
is consistent.

    Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll|[s]eries):

Another note:
I personally never use no/quit, but Ctrl+C for both cases.

This is also different than the feature of 5453b83bdf9 (send-email
--batch-size to work around some SMTP server limit, 2017-05-21)
which introduced sendemail.smtpReloginDelay, which would offer the
same functionality when the batch-size is set to 1. (Although this would
keep you connected to the server as well as add the X-Mailer-Send-Delay
header, which is nothing from the official email RFC, but your own inventio=
n?)

Having sorted mails in GMail would be nice!

Thanks,
Stefan
