Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CB21F744
	for <e@80x24.org>; Wed, 20 Jul 2016 18:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbcGTSLE (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 14:11:04 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35720 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbcGTSLB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 14:11:01 -0400
Received: by mail-yw0-f194.google.com with SMTP id c13so3921082ywh.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 11:11:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iOmo1X3u6fDvAS5fn0ogtIf6xDSyPrKnO6RLAVZEdkY=;
        b=I1fVQeT+uil07ShHuyvm0r6f5uN7hY4eXRks5KrvQh6iMcO92qjEo1DvdZVO+AGev0
         ljrVz6EKP7vEXoak65kd432Zln+a/lG4kKcVJfwWvMlUSDvRWqh8Mr7a/YlxH8OAHrSS
         LHyDxpq2JCJeROXNQI0zMxsxJCqtKzie+uj0FDq7JcAyiudRFjww/fl2/Vlh9/EZrZGx
         XJSop/CBNWwvjeBy5KoHn8ZtriaAiFmmd1Kr77vwAJ286VR5beGv+rPqGgctZYeU+XPy
         +b7m3zDM59QLxZeHNedopuNrZzrpdIzzEQMq9KBXagNY8Q/MLeQVjw7xn9molJxLyz29
         vdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iOmo1X3u6fDvAS5fn0ogtIf6xDSyPrKnO6RLAVZEdkY=;
        b=NbrKRKOSpcqFWBFbpJx5Wr1Q6BUCityD56VAek8lSKhfHMpvsNdN5PZaArUzm5/ppa
         qlE+rHOrOSNG5lMpZPmResOuLiO2cal7epxEtnZ+/ay0XR5CgiuLldnXQL709eWVO8S+
         uvuAPzIgbKLgE2ZnVA4uZpPKgtDAkXbgEirNMA602WbaAfbN85EBk0FJ7P1jXo9CsG56
         m11S1/qnhWFgzF5Y+PQCPcSPAi0eqKRd7D58JTpN6mbX/lF0iuAeHlZmhCk2EwL9YDJP
         +s2uOwiRrHyLeC2ObwxOqXS2aAbwDYHHL8aky7I7dAJ1aFaoKJcEb7NyGfkv7q3ZTP6y
         4wLg==
X-Gm-Message-State: ALyK8tJy/hCNiB+mZTHGTaCdl3/qlNx5TRo4D2ziq74ghpPbNDedH1tjfrHC0wtdocumIAsTcpm3WhfZx5pEtQ==
X-Received: by 10.13.206.65 with SMTP id q62mr6640293ywd.317.1469038259559;
 Wed, 20 Jul 2016 11:10:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 20 Jul 2016 11:10:40 -0700 (PDT)
In-Reply-To: <20160720180702.GA13404@starla>
References: <20160720025630.GA71874@plume> <alpine.DEB.2.20.1607201322350.14111@virtualbox>
 <20160720180702.GA13404@starla>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 20 Jul 2016 11:10:40 -0700
X-Google-Sender-Auth: jDjHPrApC1qB70Q_K3wcpxu527Q
Message-ID: <CAPc5daXuZZuhaTW-hb6FOo6p+gzvrd-rx-FDvo4VzCOH+HpSJg@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: set PERL_PATH for FreeBSD 5.0+
To:	Eric Wong <e@80x24.org>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 11:07 AM, Eric Wong <e@80x24.org> wrote:
> Also, my use of a numeric comparison may be more future-proof
> in case FreeBSD decides to have /usr/bin/perl again.
>
> I also wonder why we don't use `which` to search for somewhat
> standard path components, instead.  Something like:

Because historically output from "which" was not meant to be
machine parseable (some implementation said 'perl is /usr/bin/perl')
