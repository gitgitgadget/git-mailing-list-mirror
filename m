Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86542095B
	for <e@80x24.org>; Sat, 18 Mar 2017 23:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbdCRXPP (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 19:15:15 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34541 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdCRXPI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 19:15:08 -0400
Received: by mail-wr0-f171.google.com with SMTP id l37so71834419wrc.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i8FAtrbu59RGazf0BmurOs57s+kr+5MwPoLNqVvbDw8=;
        b=EzFd7WvoTpA9i0ByH2aEe+w940j8SIUaiK3V5xMcfAxJtgoEWoyq3mNWVCEa++OOUl
         6X6EAtG8Bmi0HebhwPE0wXa0mi9yrHo7Ezqi4wL94sIAKuG/7LypW0OtFyVg6kzlpsKP
         OG+L9GLLtLJpJunQtaBLyCovZjKrQysF26OmrR8Pcn0nGric1eXnkAr/n7Xq7wMSz9oU
         oKv2GbYYlVVA60Z2g86g/RJl46J5dkU0lyweco1AM7HAarEWcSvlJ4pM/Cepn3hSU659
         1AJIY2Co36HpqmpBCkUk9W/cmlQsrljVst7NVTIvCz98ZnYdijSu19kj+9OUL1gcvBX7
         a6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i8FAtrbu59RGazf0BmurOs57s+kr+5MwPoLNqVvbDw8=;
        b=foELO4fQeDgfrTRd449+DfFnX7TwPnNav1oH4D/h/y2jgYDNpjsbBNwtJlTs1erEja
         lxFdeq7+AoxTSTYeXhrp3rw+Cs9m2zzSpEu7RF+DR8AHq2V+Ecbzby0I6at+BG8Ba1Sa
         r38kmQdpGw6C9HE+9/VQvTZRC95a2D5eXJw9ncXWuGI8TqjF4nVu7DmVCiMKkA81CWV1
         5sgGq2zFtthr5F+W6i/mAFEKJPqYi5Qi4JJF+63tH9eY0iT+9nE8w4D4e+pmwzoY7nUd
         QvYLZIaROBTYOYb7eIlQurU9os/6x4b27qqVGkyS3ngQ+Zh0MyOBLrB9tGNEU74EVhLk
         FQPQ==
X-Gm-Message-State: AFeK/H3ylieaafrLCdwZFuwSmogoMMGXUdxiWPrOIrXQe/evlA80KZQAfJrp32V8PYe79g==
X-Received: by 10.223.160.143 with SMTP id m15mr20955575wrm.116.1489878864554;
        Sat, 18 Mar 2017 16:14:24 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id h65sm13441172wrh.32.2017.03.18.16.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Mar 2017 16:14:24 -0700 (PDT)
Message-ID: <1489878863.24742.3.camel@kaarsemaker.net>
Subject: Re: [PATCH] send-email: Net::SMTP::SSL is obsolete, use only when
 necessary
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Date:   Sun, 19 Mar 2017 00:14:23 +0100
In-Reply-To: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
References: <451E4A46-BA43-41A5-9E68-DE0D89BE676A@csh.rit.edu>
         <20170318222311.9993-1-dennis@kaarsemaker.net>
         <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-03-18 at 23:47 +0100, Ævar Arnfjörð Bjarmason wrote:

> On Sat, Mar 18, 2017 at 11:23 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
>
> > +               require Net::SMTP;
> > +               my $use_net_smtp_ssl = $Net::SMTP::VERSION lt "1.28";
> > +               $smtp_domain ||= maildomain();
> > +
> 
> While Net::SMTP is unlikely to change its versioning scheme, let's use
> comparisons via the version module here in case they do change it to
> something silly, and this ends up introducing a bug.

ok.

> > [...]
> > +                                       if ($smtp->code != 220) {
> > +                                               die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);
> 
> Here a new message you're adding gets __(), makes sense.

Didn't add it, it just moved from a bit further below :)

> > +                               else {
> > +                                       $smtp->starttls(ssl_verify_params())
> > +                                               or die "STARTTLS failed! ".IO::Socket::SSL::errstr();
> > +                               }
> 
> I see you just copied that from above but I wonder if it makes sense
> to just mark both occurrences with __() too while we're at it.

ok.

D.
