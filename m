Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB182021E
	for <e@80x24.org>; Tue, 15 Nov 2016 22:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935318AbcKOWjP (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 17:39:15 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36314 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933544AbcKOWjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 17:39:13 -0500
Received: by mail-qk0-f176.google.com with SMTP id n21so154229321qka.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 14:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ztDBA2I2H9xxvbERkxmpmmhGUdk8OCN/kkZ2mrhamEQ=;
        b=Feit9W/xcIZ7fHcDfnax2yp+s5SvoJmJPvpcrU8OGpMm9yo38YrwGhT/+1DzYgkyyB
         hYuXrY9QyYCnO5vf2tz7Zo2mdAZ5R5nf1C54lesp4wrvLJEIhFFvhXUTLAIeJ7AT2uIC
         i1sov3rFq8jcAcldeRw/WCRYEFStcNJfoG0oVTBwRxS40IZkT9eOHiN6GbPMDgHSFOoM
         aGYGs4W4wwZY13yHUmYgn5a36pzaautMPWvJ1R+l57ytmolYQTn0sGSR+vEg6iKTV2Gx
         8T/j4RYOLLK10T53/uIj9QGSlwRnAN/0W548KIAo/U311KkBp6aStNgZEhKYJgFuaqax
         HYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ztDBA2I2H9xxvbERkxmpmmhGUdk8OCN/kkZ2mrhamEQ=;
        b=IbJLSbhDe/BvKd5Z6zu2Q4S7gyAdqgRy/5ec9KNysR1fXxivxCLxYO0aGhL3yzukOA
         2ovBw0njuJmE5qJQ6RxtLyfu9q1BpPnovp1zqyyPg+eG3LRGf0fBU0ykg4/GM1irEam/
         0EQ2cIbnPy3RmiRiIuORR+SpJEkX6Aqpmbm3LBCF2l+AUd481f5xXqidEeST28Yl+8Ge
         XL/qksN4o8ehity2gayxacma1HVnSurFBbe/Ee9xQuj5WR+Q++L5ZqEDYcJSDOsnfbUr
         XePatR8iyNwy11jswR3e76FwkAivK1fA5stXvU0c6sitryc+HcDBzfuG1bQ4Cicf+5j4
         071Q==
X-Gm-Message-State: ABUngveXLY34BB5/kQKcJ+/tuMIOkHZ980ybjWvRZr8yAcuesopc1Xmk04MSPp/3PgMKlDhh/jSKO+Q2yEMFrrj/
X-Received: by 10.55.67.81 with SMTP id q78mr22574137qka.53.1479249551296;
 Tue, 15 Nov 2016 14:39:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 15 Nov 2016 14:39:10 -0800 (PST)
In-Reply-To: <1d87628994df89751afdcc7e180ebcdc29dde722.1479221071.git.hvoigt@hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net> <1d87628994df89751afdcc7e180ebcdc29dde722.1479221071.git.hvoigt@hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Nov 2016 14:39:10 -0800
Message-ID: <CAGZ79kYyyjP7W7gWq6WomVSkhRtMbZZMKYQPFszko4_f9oprgg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] submodule_needs_pushing() NEEDSWORK when we can
 not answer this question
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 6:56 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  submodule.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/submodule.c b/submodule.c
> index e1196fd..29efee9 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -531,6 +531,14 @@ static int submodule_has_commits(const char *path, struct sha1_array *commits)
>  static int submodule_needs_pushing(const char *path, struct sha1_array *commits)
>  {
>         if (!submodule_has_commits(path, commits))
> +               /* NEEDSWORK: The correct answer here is "We do not

style nit:
/*
 * Usually we prefer comments with both the first and last line of the
comment "empty".
 */
/* or just a one liner */

AFAICT these are the only two modes that we prefer in Git.
For a discussion of all the other style, enjoy Linus' guidance. ;)
http://lkml.iu.edu/hypermail/linux/kernel/1607.1/00627.html


> "We do not know" ...

... because there is no way to check for us as we don't have the
submodule commits.

    " We do consider it safe as no one in their sane mind would
    have changed the submodule pointers without having the
    submodule around. If a user did however change the submodules
    without having the submodule commits around, this indicates an
    expert who knows what they were doing."




>   We currently
> +                * proceed pushing here as if the submodules commits are
> +                * available on a remote. Since we can not check the
> +                * remote availability for this submodule we should
> +                * consider changing this behavior to: Stop here and
> +                * tell the user how to skip this check if wanted.
> +                */
>                 return 0;

Thanks for adding the NEEDSWORK, I just wrote the above lines
to clarify my thought process, not as a suggestion for change.

Overall the series looks good to me; the nits are minor IMHO.

Thanks,
Stefan
