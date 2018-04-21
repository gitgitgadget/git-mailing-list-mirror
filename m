Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BDB91F404
	for <e@80x24.org>; Sat, 21 Apr 2018 06:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeDUGVN (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 02:21:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40377 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeDUGVM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 02:21:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id v60-v6so27942105wrc.7
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 23:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYiLCmh7Ab53vek4Xw91Jb2+r7Sc7eOlcbClpV+J+0k=;
        b=bstycpMN7c1TWrTfC6ze+pK81SKlBwGH1Plz/Vx+1BR16Bc7COn4HFQoe4kwp/z/02
         f4MO4Hu+WTaZSaYI09kW6x4YNZKzOdGxC6e+abREsnAQmPPzkfUYONI9hnNLqfERFGYD
         1uSud1VveQ/mp3E93LJApJVhgXDh/+6gArGdVKqctQqwBVWHPE//Lo20LGeu2VI4QQFS
         FRC/YCZn52RcZOs0oeKu90O+BWr9yM81qtc4+Chouf/Mmf8lXy9gc9F6V9Bk5eg2sD9d
         XtBmaNQ7SsFrpXMdcS6Bee6lkf2WGPnDNAoKv9G7DKYIRe5PIX0lIwNdxlLmncgdibuE
         wljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYiLCmh7Ab53vek4Xw91Jb2+r7Sc7eOlcbClpV+J+0k=;
        b=LIN8T1VYc9P9XhVwlQe3AWqO4ZhY+GRVutZcGBQmybMbazF5f9q8bWWwzmkMUJx7dN
         De8O3iYrOWELNeFd5dgUy/VYQZkWszI/biSrnbkQtngT4CO5oIQuULyQp7wuQU/92ry/
         1VhQy4e5012WhImAPnN+82sAu5oMfG3MEOvFPW/1aKxEDmQR7UHNRFVqVn3Gs3dgFPRH
         +Licnuuud6pOLdSpLaT7AdPMgETC7UiX8+UkJD4ppeAWGWrUlPZqiRtlpKPf816NAnHK
         kYdJp3prOhCikSg3k7IGyjsgFXo6Y3UG+OK7PCQiS9nyKrnuAZMzlx9JrJcXiiEgA5Jr
         +W4A==
X-Gm-Message-State: ALQs6tDqnA6jQrsMrqQFSeXAZLcyxZ2ii6BXjBDsd9kClz4qyBIgVQEZ
        omEBZyIuO9pe/FWLDNOhg54=
X-Google-Smtp-Source: AIpwx4/e9h3SpqZtcCUrVHDNai8+kmLXm1KzK/aLXcotPPx6dVxRENgvx1kXjTSf/K4lSIJXfBpjNw==
X-Received: by 2002:adf:860d:: with SMTP id 13-v6mr7781707wrv.12.1524291671818;
        Fri, 20 Apr 2018 23:21:11 -0700 (PDT)
Received: from localhost.localdomain (x4db03a65.dyn.telefonica.de. [77.176.58.101])
        by smtp.gmail.com with ESMTPSA id k28-v6sm13468377wrk.96.2018.04.20.23.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Apr 2018 23:21:11 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 06/11] Add a test for `git replace --convert-graft-file`
Date:   Sat, 21 Apr 2018 08:20:54 +0200
Message-Id: <20180421062054.4290-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.geecde6d7e
In-Reply-To: <de1d455d6e526cf264ce1291c1923b97271969c3.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de> <de1d455d6e526cf264ce1291c1923b97271969c3.1524262793.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The proof, as the saying goes, lies in the pudding. So here is a
> regression test that not only demonstrates what the option is supposed to
> accomplish, but also demonstrates that it does accomplish it.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t6050-replace.sh | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index c630aba657e..8a3ee7c3db9 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -444,4 +444,24 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
>  	git replace -d $HASH10
>  '
>  
> +test_expect_success '--convert-graft-file' '
> +	: add and convert graft file &&
> +	printf "%s\n%s %s\n\n# comment\n%s\n" \
> +		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
> +		>.git/info/grafts &&
> +	git replace --convert-graft-file &&
> +	test_path_is_missing .git/info/grafts &&
> +
> +	: verify that the history is now "grafted" &&
> +	git rev-list HEAD >out &&
> +	test_line_count = 4 out &&
> +
> +	: create invalid graft file and verify that it is not deleted &&
> +	test_when_finished "rm -f .git/info/grafts" &&
> +	echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
> +	test_must_fail git replace --convert-graft-file 2>err &&
> +	grep "$EMPTY_BLOB $EMPTY_TREE" err &&

This should be 'test_i18ngrep'.  Apparently this error message is
translated, and, consequently, the check fails in a GETTEXT_POISON
build.

> +	grep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
> +'
> +
>  test_done
> -- 
> 2.17.0.windows.1.15.gaa56ade3205
