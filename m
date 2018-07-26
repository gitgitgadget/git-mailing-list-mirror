Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 264E81F597
	for <e@80x24.org>; Thu, 26 Jul 2018 09:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeGZKZd (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 06:25:33 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:34727 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeGZKZd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 06:25:33 -0400
Received: by mail-ed1-f52.google.com with SMTP id h1-v6so925095eds.1
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xUysKTcQIqB+GSM0p/lBlp0Ttx9vsi41h31gw9ioPoI=;
        b=BwcX/ITs6GYt502aO1A+IdG9wNC1t+3/SjTjp5fd58oap5TFd7PCI7u9B2w7LZIjFd
         QXAiCNvbuVdSQVUZkqxbyRaxwaJRYIW1xN3IdRSADxa470d01hHvVfldJ00lg7PSuFqA
         Cn01sNPkUgZBMxfjigG9Bb/xxe/e3vceYcHQ44TfTaSwynGpeY/IpGyVm4Nj5oLPqzgC
         NN1J6UOVCzlZlw5kF3JBMgUP926LChFCxsWS2w6dG2s+SM66xCgtq6jaxY/j28eVJL2Q
         1jSn60l2TDXmkHN3uDu3E///ZX4wjFf8V7eS90Ia64KU+7Uc7G/Avr6ylbKunGjT8bau
         o23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUysKTcQIqB+GSM0p/lBlp0Ttx9vsi41h31gw9ioPoI=;
        b=tZtIIiyPyV5lEHPv0RHuGtcKfyMn4nn3QlPLyehD8jQf8+yg4orzcO5pW+bpTucocX
         NvIhR9pjqOl2O3x4D+srYg+4OFP4y/OvmWMkegHHmIYA6aA+BeMvOPCKr71RlGe0JBaK
         p2Cft0/+mWuL6k7XFu6ERYGiaxlOkZtVOqM67yrEvtAD701lHXUCQsCkTW5d12zYRSCO
         JUesaGvwMQKK4Qikm1iVlGsbROmeBj5P94QNoYjXvJtruNMZ/e7OgNdyICNci4BWPx8q
         CL0ecx7UR6WIXQmjL6pcSw2YtT6/I7LHDuiH5m4PvIqB0vMx95XCYj0KpZSgW5ieDZGQ
         y9ag==
X-Gm-Message-State: AOUpUlGuWruNnXcM36r9wWt/cBiyzVDjLOrihCWr5ZUoWrusMLXjeCWg
        003ykQrGgkDQRPNVchVAEKQ=
X-Google-Smtp-Source: AAOMgpfBy7NhEAjVnnY/x7plSy6JPqzrxZFK45fdOFyxwOevVsCr70FKJVjf44aDpptM+dTCiaHxnw==
X-Received: by 2002:aa7:c3d2:: with SMTP id l18-v6mr1743464edr.205.1532596178127;
        Thu, 26 Jul 2018 02:09:38 -0700 (PDT)
Received: from localhost.localdomain (x4db0efa4.dyn.telefonica.de. [77.176.239.164])
        by smtp.gmail.com with ESMTPSA id x51-v6sm482919edd.67.2018.07.26.02.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 02:09:37 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@jeffhostetler.com
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 03/25] structured-logging: add structured logging framework
Date:   Thu, 26 Jul 2018 11:09:21 +0200
Message-Id: <20180726090921.32232-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180713165621.52017-4-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com> <20180713165621.52017-4-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> +void slog_set_command_name(const char *command_name)
> +{
> +	/*
> +	 * Capture the command name even if logging is not enabled
> +	 * because we don't know if the config has been loaded yet by
> +	 * the cmd_<command>() and/or it may be too early to force a
> +	 * lazy load.
> +	 */
> +	if (my__command_name)
> +		free(my__command_name);
> +	my__command_name = xstrdup(command_name);
> +}
> +
> +void slog_set_sub_command_name(const char *sub_command_name)
> +{
> +	/*
> +	 * Capture the sub-command name even if logging is not enabled
> +	 * because we don't know if the config has been loaded yet by
> +	 * the cmd_<command>() and/or it may be too early to force a
> +	 * lazy load.
> +	 */
> +	if (my__sub_command_name)
> +		free(my__sub_command_name);

Please drop the condition in these two functions; free() handles NULL
arguments just fine.


(Sidenote: what's the deal with these 'my__' prefixes anyway?)

