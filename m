Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B391FD99
	for <e@80x24.org>; Thu, 25 Aug 2016 09:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754693AbcHYJV5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 05:21:57 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35813 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753995AbcHYJV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 05:21:56 -0400
Received: by mail-it0-f52.google.com with SMTP id x131so260229947ite.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LR31LB40n6Gpu7Jef3R6FtoAkUGSqVjlq6tHDl+2L3Y=;
        b=A5qSXvg0e92aeIFG9EQa5s3p7sFLjaRqo3KNlBKaC9RtdV2RosCsFK8OvIaNlp/2gd
         sr2IW3GMsRd0r6fE1IMUJXOVCSny/5TKqajDYX8T+bZTRmtwKRYPtdvznq5AAD0pcNdt
         0+99Q4gyEPnQZ4FNzGP00JRFyAj9r+VSon0fxWuihTcoOQagIpDLJOZZ12V6M2dE0tNa
         xmN5uVKUX0lrWCvBinj7eN0OUjPUMLwbYqXq23jGbI6cBH1b2j5Y6nKgRRaXGz832lXd
         aw1UoP5LCgtKCsiYTftHxgrs3w2szBbDMOvXYtaiK55usPqqUmuemL1xIXI6CPf4BHTU
         jHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LR31LB40n6Gpu7Jef3R6FtoAkUGSqVjlq6tHDl+2L3Y=;
        b=HeFAIvYGtHp7yUqm8tFHmfXkGogdb5zDC5cNiCZJCWMqo913DGt3qtcLKUab13b2b1
         K1J8SKOE2uI3XXoO7lopovnYq6zpoExhSqf9SAALsp+Qyufz6ht2LoQFEX0o+numZoD5
         8iZ/91GH+6faCtmqJXOI4RqxcWrmuBZn5/7kB83/HYkXbEvbS4ZRsDNZyfF4xbZa6pob
         jPbeyCyM49D+eGMvFpX5shkxnm8F6FGLauuZi1sT+hzJzrVFdEnEkHXqlrJUUQTdxsDF
         bWKTbZiwDbwI9h0Cmz42jZlbJwe6ZmYn6JjgTX+HthD6aLoF1svEwrBRYIpLiESfj7Dq
         LnQQ==
X-Gm-Message-State: AEkoousy9U/QhAz6fRT2mOu4l8IVaqHT1Ut+0rzzMOKpktEihB6r/kJRynnLQyU8T+o1SxXfsMjqmToUfrFC1w==
X-Received: by 10.107.159.147 with SMTP id i141mr8966244ioe.29.1472116915766;
 Thu, 25 Aug 2016 02:21:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Thu, 25 Aug 2016 02:21:25 -0700 (PDT)
In-Reply-To: <xmqq7fb6rupa.fsf@gitster.mtv.corp.google.com>
References: <20160822123502.3521-1-pclouds@gmail.com> <xmqq7fb6rupa.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 25 Aug 2016 16:21:25 +0700
Message-ID: <CACsJy8AnDoh-CZp8oa21YHcM3sxoTJZiK7fP+ecNyqd0-DBZAA@mail.gmail.com>
Subject: Re: [PATCH] checkout: swap the order of ambiguity check for :/ syntax
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 11:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> It's not wonderful, but it's in line with how git-checkout stops caring
>> about ambiguity after the first argument can be resolved as a ref
>> (there's even a test for it, t2010.6).
>
> But that is justifiable because checkout can only ever take one
> revision.  What follows, if there are any, must be paths, and more
> importantly, it would be perfectly reasonable if some of them were
> missing in the working tree ("ow, I accidentally removed that file,
> I need to resurrect it from the index").  Does the same justification
> apply to this change?

I think there is a misunderstanding. My "after" is in "after the first
argument can be resolved, check if it exists in worktree too, if so
it's ambiguous and bail". This is usually how we detect ambiguation.
But git-checkout does not do the "check if it exists..." clause.
--=20
Duy
