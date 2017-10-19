Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B82202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 19:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbdJSTqK (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 15:46:10 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:57065 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbdJSTqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 15:46:09 -0400
Received: by mail-qt0-f177.google.com with SMTP id z28so15889141qtz.13
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=suV6OvXEsbwK5lGJV85tpnYXaJOdwdAdjgF9Kh+vatU=;
        b=C29yONrpqYBjlU5/0A4IyV7aeKKyPVjSfnsd9z4rDqADghFSP+NuPQg5KO99ppozzS
         m/tpVT+vocwQ73+bkkhaC2KaSvSfaQle+4L9WskVQ6L/KXmluTLdV5yFNMI4nKG8MkHs
         VvWttYioQ10BgKk4R/crX6R+5hEcZJ2emlB/EddMC/giBcHrCZOjLrP8nJTBvtBnOkWl
         MSdi0zdtOMDob2JEm/VB6QGvrm0hdngssoOb40QaL29qyGXJ/6FOsHkCAtKTVHdDNmzW
         TRn6sUYQvZWb9l/5tcYmv/f2ggQb0NNiAiksmpIG8O7Sj0FTyBsjFzBOhFUQ37ijwJmC
         4srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=suV6OvXEsbwK5lGJV85tpnYXaJOdwdAdjgF9Kh+vatU=;
        b=iIEjB0dwYdZeI887e9SuaZXNSdRPv0VPeoBCS8LFH6H/hBKldcFzp8bZqZNRZ5+Xcp
         ZLYPh+IeXX2DSOKEHpRnwKbbvYrLrzj+3eU07UzZsKs2P3vauzGh2hH/uGjEn9s2nFPc
         tdT7aA3yOcIBQxHulO3t3nrAPyCOzCzYVKAildayOKfkcqD2o/y4AYMrOt6P+OnzOEjK
         lpkiwCJFT4XspqyJUfKwSwO1pI/shATsSl7fa0S6szQRF5O0vhd8ItGpEFAWcsAGpK7g
         41tB/Qc59ExB7D9bVYlSrf4el6xI3mQV3Tdb1LBJhSRdFlSI3DOzjAkVEPZRP+LYLUll
         VaUQ==
X-Gm-Message-State: AMCzsaUcVEmGEbXABFzQjRgBTQ0jMYHr2K80qOGjhGmtPiTe9qXbpe2n
        aJWt3bN318FjwR+vT2Ie+thv7i/JLDy7SKxKalOTFw==
X-Google-Smtp-Source: ABhQp+QZNPY78dAw8DJ1vkf3l64+Q81lz3WMLxcg3/W923d+vG8if4gdbI/zOI1S45GmSKpUXxW2EfjKXwUTLB4TruM=
X-Received: by 10.237.37.132 with SMTP id x4mr3530937qtc.224.1508442368827;
 Thu, 19 Oct 2017 12:46:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 12:46:08 -0700 (PDT)
In-Reply-To: <20171019174715.6577-1-marius.paliga@gmail.com>
References: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com> <20171019174715.6577-1-marius.paliga@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 12:46:08 -0700
Message-ID: <CAGZ79kaSU+w0=zb61=5pEzhtd4U5Hzae4C2bUgpchNHAL_mzMA@mail.gmail.com>
Subject: Re: [PATCH] builtin/push.c: add push.pushOption config
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, thais.dinizbraz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 10:47 AM, Marius Paliga <marius.paliga@gmail.com> wrote:
> Push options need to be given explicitly, via the command line as "git
> push --push-option <option>".  Add the config option push.pushOption,
> which is a multi-valued option, containing push options that are sent
> by default.
>
> When push options are set in the lower-priority configulation file
> (e.g. /etc/gitconfig, or $HOME/.gitconfig), they can be unset later in
> the more specific repository config by the empty string.
>
> Add tests and update documentation as well.

Thanks for keeping working on this feature!


> @@ -161,6 +161,9 @@ already exists on the remote side.
>         Transmit the given string to the server, which passes them to
>         the pre-receive as well as the post-receive hook. The given string
>         must not contain a NUL or LF character.
> +       When no `--push-option <option>` is given from the command
> +       line, the values of configuration variable `push.pushOption`
> +       are used instead.

We'd also want to document how push.pushOption works in
Documentation/config.txt (that contains all the configs)

So in the config, we have to explicitly give an empty option to
clear the previous options, but on the command line we do not need
that, but instead we'd have to repeat any push options that we desire
that were configured?

Example:

  /etc/gitconfig
  push.pushoption = a
  push.pushoption = b

  ~/.gitconfig
  push.pushoption = c

  repo/.git/config
  push.pushoption =
  push.pushoption = b

will result in only b as a and c are
cleared.

If I were to run
  git -c push.pushOption=d push ... (in repo)
it would be b and d, but
  git push --push-option=d
would be d only?

As a user I might have expected it to be the same,
expecting
  git push --push-option='' --push-option=d
to suppress b.


> @@ -584,12 +599,13 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>                 set_refspecs(argv + 1, argc - 1, repo);
>         }
>
> -       for_each_string_list_item(item, &push_options)
> +       for_each_string_list_item(item, push_options)

We have to do the same for _cmdline here, too?

The tests look good!

Thanks,
Stefan
