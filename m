Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054731F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeAZSYR (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:24:17 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34506 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbeAZSYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:24:16 -0500
Received: by mail-pg0-f65.google.com with SMTP id r19so767078pgn.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 10:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dIKdfu/FYXplY1MlfiG3lCInp3PKhfUpzVr5AmslJc0=;
        b=pylwNnpoU4AcIeRBBo9wQFMVzuk8MvkaAZV/RNkigk3uuDqn2ia21ohlVUIfcYb46J
         2gHqrJS43whrb4e4T+7TzQpxSzRI7+PNowco7RaTnwoxOwuO0h5nYVLvFC4SOeeTWKJ4
         T15jeuoFFiUAONSHlPbVSp4rZZxrwANca1HuKv/Jniz9HPRigTl/w5+7MSNkF0ZkXpbr
         HPXpOdcf1ngITS5eGy3u6dQvjVevJmlVeckimMewdIK5WN9w+c2MyY+uNgq/KzYjtggg
         wT10T8zUmmcGgngb11NpwcCo1f03s5/KGoNTibPc8Yg++ahJ8NYCZLSrFhu17nVGTGOK
         OrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dIKdfu/FYXplY1MlfiG3lCInp3PKhfUpzVr5AmslJc0=;
        b=KrF+9sr4sJASm03t7wBHjTlD0PwGU83AYYG+djLrH/4C7Ui5qMTfR9yVSOnuNTR7b1
         0OEdVH/JgfeAU15FqjZVyvfSZSrgRWkaXM20suip8Isz2/M44ZODAxGVfD3mzqkZdX/J
         kWQVuuLJtJZt9JrE7bHp2pnvbrbtURFFFa/nAD7HEVdDelcCuYgKwxu5Ut4uPwQcRPHX
         tNieiex5HbNw/FaPF3pdwIMX9I5xiN05flvXgatMkBCuJfVQigUlUlwBPZH85LkFBCqd
         9XdwqY2+KEf59TrNAM7rYxwNd2sdedgRGQnPzdkoLszAbKCJ72EGqtO1BuEq5ay0dbdv
         BYwg==
X-Gm-Message-State: AKwxyteMBMywfZxg9yVeuWBaLM/6ROvOAAqKJfFnXsgfs2oTRQaYshAU
        IDUdIv6fd8ZdgdD38ULCSeo=
X-Google-Smtp-Source: AH8x224he78+5siLWg3GNCWifYlOZx+YYhfCpt41gICbjI5f38T26WAK4RzqLZ0+ZvJqAr+oZ3nrnw==
X-Received: by 10.98.166.22 with SMTP id t22mr19629570pfe.80.1516991055746;
        Fri, 26 Jan 2018 10:24:15 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id i9sm25042633pfi.154.2018.01.26.10.24.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 10:24:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/10] t: forbid piping into 'test_i18ngrep'
References: <20180126123708.21722-1-szeder.dev@gmail.com>
        <20180126123708.21722-9-szeder.dev@gmail.com>
Date:   Fri, 26 Jan 2018 10:24:14 -0800
In-Reply-To: <20180126123708.21722-9-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 26 Jan 2018 13:37:06 +0100")
Message-ID: <xmqq1sic8omp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> See two of the previous patches for the only such cases we had in our
> test suite.  However, reliably preventing this antipattern is arguably
> more important than supporting these cases, which can be worked around
> by only minor inconveniences.

I am not sure if that inconveniences will be minor.  Is this too
contrived an example, for example?

  check () {
        pattern=$1 file=$2 script=./runme

        test_i18ngrep "$pattern" "$file" &&
        write_script "$script" &&
        test_expect_success "check $pattern" '
                "$script"
        '
  }

  check foo file <<-EOF
  ... test script comes here ...
  EOF


>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/test-lib-functions.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 92ed02937..e381d50d0 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -719,6 +719,10 @@ test_i18ncmp () {
>  # under GETTEXT_POISON this pretends that the command produced expected
>  # results.
>  test_i18ngrep () {
> +	( read line ) &&
> +	error "bug in the test script: data on test_i18ngrep's stdin;" \
> +	      "perhaps a git command's output is piped into it?"
> +
>  	if test -n "$GETTEXT_POISON"
>  	then
>  	    : # pretend success
