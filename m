Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B911A20756
	for <e@80x24.org>; Thu, 12 Jan 2017 07:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750755AbdALHNZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 02:13:25 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:36595 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdALHNY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 02:13:24 -0500
Received: by mail-it0-f47.google.com with SMTP id c7so5919272itd.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 23:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rdNjoMKyU7GMzGwrTbw8lktxUiENi+ML1GyGh10uuWs=;
        b=NcE6NIrf3JbcDNeuHCI4yZpYeebALWC/BQ5IwO7MV998ake6spso6bl5tDiYNoq3px
         0X6eTK567/kfPyX+I7MgwbFXZ4t3+xR9OuopweSYdJTJzl5DxLic87+1d4YoCRVHBTbO
         Xi1iN511Q5Fm3Q6PqQeR2AEL/i0n9gkT/BAKwKcbP4IAh28A8v0fx4rF/Coa3LCaxqMn
         C/gVNsltWagGudehYsnKtMRLGOmPsgBcB5wS6PPokiLyRkUXj7dbWumias1heXKjq0fb
         Q3x6KO0CctJsqNHBQrqvAlk5eHcCkLqHCRcH2Ev0ALPXTU7gGRozfmC0r0pWsfTCK1Bt
         hlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rdNjoMKyU7GMzGwrTbw8lktxUiENi+ML1GyGh10uuWs=;
        b=WKbx1ct/OyWYiVwb9M/mkNYczbGNOSMr5sOTmjwaKrb9buWzBcytb51OJ6GnJ28e2O
         dVgq/bYRvZoz4bEmzU6a+uBFPiht3QKZoCcP7YedJpNhMUM3PElIhlyF3KyT7+f8k9P/
         s74h4bF/IqpH9zJ/qPPh4EGJN8IuZmgFs9mgtI2QlTnrztWOLArFk5v3bCG0QNDY/tI/
         6xMUQl823onfXOroCaU4VGG4KeqwBK3yT2aHXFBevpc+//+lfE3bG7YP12gmtA6aE1zH
         +Md9ovZUboOEIe9o4BwhJhrfzLLybYvi/JJTVYoCe87zlSSFtRtZv3WZag4ckKtJ31KJ
         pn7w==
X-Gm-Message-State: AIkVDXIcBj+pNkwst9YJ0i6TUjKzvnuIoYb8QTXO8mcZM3vz2/vO+j8p4LEtuu90dhD/Tz1VI5WIifr4XDRKoQ==
X-Received: by 10.36.147.6 with SMTP id y6mr12274873itd.98.1484205203903; Wed,
 11 Jan 2017 23:13:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.50.131.84 with HTTP; Wed, 11 Jan 2017 23:13:03 -0800 (PST)
In-Reply-To: <xmqqa8awn6i6.fsf@gitster.mtv.corp.google.com>
References: <20170112055140.29877-1-pat.pannuto@gmail.com> <xmqqa8awn6i6.fsf@gitster.mtv.corp.google.com>
From:   Pat Pannuto <pat.pannuto@gmail.com>
Date:   Thu, 12 Jan 2017 02:13:03 -0500
Message-ID: <CAAnLKaHrGkAkF+kZtrawDSkuhVkvvUZONp6PQj6=3AGoAwFxyw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use env for all perl invocations
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[plain text re-send, sorry]

Interesting, I'm guessing this came from when git was installed (
https://github.com/Homebrew/homebrew-core/blob/master/Formula/git.rb#L50
), when the perl path was likely still /usr/bin/perl

It feels weird to me that the perl path is fixed at
compile/install-time as opposed to run-time discovery -- this means
users can't change their perl install without breaking git?

On Thu, Jan 12, 2017 at 1:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pat Pannuto <pat.pannuto@gmail.com> writes:
>
>> I spent a little while debugging why git-format-patch refused to believe
>> that SSL support was installed (Can't locate Net/SMTP/SSL.pm in @INC...)
>> Turns out that it was installed for my system's preferred /usr/local/bin/perl,
>> but not for git-format-patch's hard-coded /usr/bin/perl; changing the shebang
>> allowed git format-patch to work as expected.
>
> Isn't that an indication that you are not building correctly?
> Perhaps
>
>     $ git grep 'Define PERL_' Makefile
>     $ make PERL_PATH=/usr/local/bin/perl
>
> would help?
