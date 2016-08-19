Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8DF1FD99
	for <e@80x24.org>; Fri, 19 Aug 2016 08:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755251AbcHSIRv convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 19 Aug 2016 04:17:51 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:40579 "EHLO
        zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753725AbcHSIRu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Aug 2016 04:17:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 11BA4268A;
        Fri, 19 Aug 2016 10:17:47 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
        by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0_MuObzsv-Qc; Fri, 19 Aug 2016 10:17:46 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
        by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E8A0B2670;
        Fri, 19 Aug 2016 10:17:46 +0200 (CEST)
Date:   Fri, 19 Aug 2016 10:39:11 +0200 (CEST)
From:   Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        me@jnm2.com, philipoakley@iee.org, john@keeping.me.uk
Message-ID: <1462477081.1237058.1471595951145.JavaMail.zimbra@ensimag.grenoble-inp.fr>
In-Reply-To: <20160818185719.4909-2-ralf.thielow@gmail.com>
References: <20160816162030.27754-1-ralf.thielow@gmail.com> <20160818185719.4909-1-ralf.thielow@gmail.com> <20160818185719.4909-2-ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] help: introduce option --command-only
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: help: introduce option --command-only
Thread-Index: DXX7WgtpiBhEdX64RCmAfY6NyLAwSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

Ralf Thielow <ralf.thielow@gmail.com> writes:
> [...]
> +test_expect_success "works for commands and guides by default" "
> +        git help status &&
> +        git help revisions
> +"
> +
> +test_expect_success "--command-only does not work for guides" "
> +        git help --command-only status &&
> +        cat <<-EOF >expected &&
> +                git: 'revisions' is not a git command. See 'git --help'.
> +        EOF
> +        (git help --command-only revisions 2>actual || true) &&

I think you want to use
  `test_must_fail git help --command-only revisions 2>actual`
here to make sure that the command does fail.

Thanks,
Rémi
