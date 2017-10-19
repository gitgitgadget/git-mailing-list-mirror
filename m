Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2144202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 22:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbdJSWGE (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 18:06:04 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44260 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbdJSWGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 18:06:03 -0400
Received: by mail-qt0-f194.google.com with SMTP id 8so16358843qtv.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F5aj5pSVN72ymngJSsjYhzt9fB0tZ7cHSBWjv13MFS4=;
        b=Ab+0fHhVKsKl1RXSHL/S+HaFTmldSPug64HZj5pIJtpxp0lgORqMNCXrtZ5Q1DDtyu
         iR/uhLQQTNQtCvpvcvH6d4cVmbD96P9ZirUQC0F3qsae+SxCuEZBtHQvehALLrNwwnxk
         9MStwMC47wgwhGj5XYydT7yrdQvCk4rR0b1f4obBgFbkJx6SBGdvkWCVruqXY8SwtVHf
         bC0kYbdt693pU85cqbm9gzHWKZearZ4SNntWfnnpTqGBlJiWUJYB5wsyxnK84lOr/9TN
         stz6tU3FU5LgvwYQSYICJrLDZ5De+wJs22mg+ZVj7nRZJjolxzTE6cT7f4GHLo0rWis2
         nDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F5aj5pSVN72ymngJSsjYhzt9fB0tZ7cHSBWjv13MFS4=;
        b=C7ycwW1x8KOSHgxN9X13sZ0bhQnLDWGillvJvV90m7nzf/LgH24nabgJcIe9dLV1mX
         78uS8DTg8kFdR5PUN+Cmm2gzU42DoJZEwY5/oADfAGJzLIkktQsXAxT4DWZ1FsICeUWS
         MCQZukLYkE6y+Z78RBEFqFPUm+d2O9QGH3GQi23DVMJgauzMN7Y+Gcpw4p03dX/X0M9b
         j4ctlQv2iN6JvvFTQRH5jtDzW1oxpE8pTctJzfurDsehsI94SehoGYV07nIyzRaHBQlx
         QjwNMAy4ebMuMiovD07lUJYIIQ306irIaa5O7lagwXAIy8n6JNt0xWOM0NGIZKPSjhop
         R74A==
X-Gm-Message-State: AMCzsaWTK87Ab6NFZK062d6l4sJ+4SeKFvrkf0yZ7C+5qFvHY6xXSs/N
        +vudx+eEdC+yZOWwH5R1tNl7hTKoXZCJkQi2LA44NfXw
X-Google-Smtp-Source: ABhQp+TcSuyP62KjnmOFqiGgJlw4hk/407xCMUqlMXdtDVqotH0QA8hULGAzAmq1BJUt9SD0rwssbDgq+G13hxZoYvo=
X-Received: by 10.237.53.137 with SMTP id c9mr4658893qte.125.1508450762770;
 Thu, 19 Oct 2017 15:06:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 15:06:02 -0700 (PDT)
In-Reply-To: <20171019123030.17338-7-chriscool@tuxfamily.org>
References: <20171019123030.17338-1-chriscool@tuxfamily.org> <20171019123030.17338-7-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 15:06:02 -0700
Message-ID: <CAGZ79kYTLrLJ22cn+yYbV8sTK-NAaeF4EcnnBj29Tt5Q7URi1g@mail.gmail.com>
Subject: Re: [PATCH 6/6] Add Git/Packet.pm from parts of t0021/rot13-filter.pl
To:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 5:30 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> And while at it let's simplify t0021/rot13-filter.pl by
> using Git/Packet.pm.
>
> This will make it possible to reuse packet related
> functions in other test scripts.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  perl/Git/Packet.pm      | 118 ++++++++++++++++++++++++++++++++++++++++++++++++
>  t/t0021/rot13-filter.pl |  94 ++------------------------------------
>  2 files changed, 121 insertions(+), 91 deletions(-)
>  create mode 100644 perl/Git/Packet.pm
>
> diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
> new file mode 100644
> index 0000000000..b1e67477a0
> --- /dev/null
> +++ b/perl/Git/Packet.pm
> @@ -0,0 +1,118 @@
> +package Git::Packet;
> +use 5.008;

+Avar, who knows more about perl versioning.

As we move it from our tests to the official part of the code
we'd want to keep aligned to the rest of the perl parts
of the code base?

This whole series looks good to me as a perl bystander.

Thanks,
Stefan
