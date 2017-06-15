Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 635FE20401
	for <e@80x24.org>; Thu, 15 Jun 2017 19:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbdFOTPX (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 15:15:23 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33662 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdFOTPW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 15:15:22 -0400
Received: by mail-pg0-f47.google.com with SMTP id f185so10604252pgc.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=03RAYmRDImxw0rNqmFc7B2F3s8JjDAveiySJNrDxTas=;
        b=H2+0P859O+xxAzsfXZzYhIBlY+5xna0GcYkolBrOtWWIzHYB8j1mfPr9K2+Rge9QUr
         gVCIlX2+Nk7KtncN/MiDYoe0c4sE7x5w/m4vXvmgcptMpW2Sx2tir3UVmQh/NNf5PHQm
         frBm1sqpumGIp7jaXhNe37Bsl3qF9Rm4uJek6ysiIxis2vhw7YooW+MNhRzUOZa5JWCI
         e+bQviGkEX/448McCVrOjBTTTvYuR/6dqw7jZgLIrcOt3+aSPl/2/xGiMP0Le308r04Q
         IwphRqPZFFN8zUWtW8My6+b9L7xEseG9skzMBFRCMzjD80aRUtRiyLbJxJsRiyG3OFRL
         vrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=03RAYmRDImxw0rNqmFc7B2F3s8JjDAveiySJNrDxTas=;
        b=OFsgb5Yj2thrb72zUGYPigzBqGwHgwYNkChECZrSfpaMiDcKoOlqDlV2YNvQrlesEa
         zajD3n/pjMxzgp89UH7ytNQZNitWfptOqDdhsSVyxGNXf5I2pgjt4Rf6aipnjLiCJKqE
         ngT0R2xJkCmekBq6qHzJCspDkSckejEFys3r8FdDOOoYAQTUOjHp2HUnwI/XFt2ZaB1I
         bPcUm8bDBYppbpSoHsmO9T/Q5aE3SzvN9JxxuC566HYzWPSZwNrY6Z1hXj+nLol42P/T
         tpMRPpfCCkdOH3ddbwfaPjb5LgAwuxUj9e+vI3JF+J9g05CHavpq8kQClTX3dKJod/io
         vOQQ==
X-Gm-Message-State: AKS2vOzS67E+gJUemwypWF5nd/NH9WMGH+IVD5MAaTm8dC/I8omhtCti
        S1mhhDme5yCTk5Bsm44=
X-Received: by 10.98.15.134 with SMTP id 6mr6913098pfp.32.1497554121309;
        Thu, 15 Jun 2017 12:15:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id y68sm112493pfy.12.2017.06.15.12.15.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 12:15:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Scott Baker <scott@perturb.org>
Subject: Re: [PATCH] diff-highlight: split code into module
References: <20170615163055.b63hcivjogafkerq@sigill.intra.peff.net>
Date:   Thu, 15 Jun 2017 12:15:19 -0700
In-Reply-To: <20170615163055.b63hcivjogafkerq@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 15 Jun 2017 12:30:55 -0400")
Message-ID: <xmqqpoe512rc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The diff-so-fancy project is also written in perl, and most
> of its users pipe diffs through both diff-highlight and
> diff-so-fancy. It would be nice if this could be done in a
> single script. So let's pull most of diff-highlight's code
> into its own module which can be used by diff-so-fancy.
>
> In addition, we'll abstract a few basic items like reading
> from stdio so that a script using the module can do more
> processing before or after diff-highlight handles the lines.
> See the README update for more details.
>
> One small downside is that the diff-highlight script must
> now be built using the Makefile. There are ways around this,
> but it quickly gets into perl arcana. Let's go with the
> simple solution. As a bonus, our Makefile now respects the
> PERL_PATH variable if it is set.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Scott and I discussed this off-list, and this was the least-gross
> solution I came up with.  The plan would be for diff-so-fancy to pull in
> this copy of diff-highlight from git.git and have a wrapper script
> similar to the diff-highlight.perl found here.
>
>  contrib/diff-highlight/.gitignore                  |  2 ++
>  .../{diff-highlight => DiffHighlight.pm}           | 40 +++++++++++++---------
>  contrib/diff-highlight/Makefile                    | 21 ++++++++++--
>  contrib/diff-highlight/README                      | 30 ++++++++++++++++
>  contrib/diff-highlight/diff-highlight.perl         |  8 +++++
>  5 files changed, 82 insertions(+), 19 deletions(-)
>  create mode 100644 contrib/diff-highlight/.gitignore
>  rename contrib/diff-highlight/{diff-highlight => DiffHighlight.pm} (91%)
>  mode change 100755 => 100644
>  create mode 100644 contrib/diff-highlight/diff-highlight.perl

Do you want +x bit for the last one?  I could throw that bit in
while queuing if you want.

Thanks.
