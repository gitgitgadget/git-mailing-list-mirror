Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91891201B0
	for <e@80x24.org>; Sun, 26 Feb 2017 03:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbdBZDMw (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 22:12:52 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34426 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdBZDMv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 22:12:51 -0500
Received: by mail-oi0-f41.google.com with SMTP id 65so26139526oig.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 19:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DB9H7klWgQXU7eCOonkkHW6LmXFdpIRM9CGX3xHZrbc=;
        b=jBQncQgYFaWezMC1FTXHh5bH5iSdR20f2V9nXKtvY6eamsoZ33OT9knpFeNmIKbd3k
         /0qLdBsixQGb6sb4WGTX5EC7PxwieMPsZQ5lxmT2RXwykgMuWGwMIkfAotmIKuMyVm8x
         Z6wBavHQqnigSJ+0KVZSV2dGNeFQQTmd4bJuwi8DOAYx78H/qDnA6UUealuCB6xNhYy6
         MetLvHEMwnJHBK/WtZQLO1uTiOCUCGVfVSJZ+NMy3l4wWtVmOCgYXcrBxNb+CNi+N6Jd
         Kx0PDrjtqW992vyuIQwLjTnuuSDI1HJ8W3v9OfFYmzZkbcGf/3qPU+bYsi67NAyrgCki
         nkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DB9H7klWgQXU7eCOonkkHW6LmXFdpIRM9CGX3xHZrbc=;
        b=EwJsPimyLsl7PW/nuvdTSOn+3sF/VE9eURrfp908j8LnoSDXbqtQlR9jYnumm2PXgx
         sNz7qXuOBUQ9PqgoD0sqTbCpEl5trWxLw1KShE42e4zLbaKr6II8OxoRmjvu/0W2zwa3
         yw1T72Sw4+bBcNw7fGrdNANRrGA7dBlWO2XAFWrx0Ikl8/oyOV2mYNU8qIFLfKG7K7Kv
         HN0av6G/w1VKfvEOzQnfpW8NvTnqpcY1XBbL2R/+/W+7Y05fyaKg4ejZcZ+BJ/+Nivdr
         c82Fd98V70vnTuOxeUtdJpGGFeIh9dZFfTFyScB+cCpub0kzCfhsH8p4ofVjmRLnMWcq
         I27Q==
X-Gm-Message-State: AMke39lLHcOq2M3bP3eCPJ0nXSP+WSHISf1RPUqvaa9Wfxh+GGzuXRPfHvF1JXSFLllE/N3nAZBtbmYoHC12/w==
X-Received: by 10.202.80.212 with SMTP id e203mr5625896oib.146.1488078169190;
 Sat, 25 Feb 2017 19:02:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 25 Feb 2017 19:02:18 -0800 (PST)
In-Reply-To: <29A09E4EDB1F4F4D9E77E67A7A8A33FF@PhilipOakley>
References: <20170223122346.12222-1-pclouds@gmail.com> <20170224131425.32409-1-pclouds@gmail.com>
 <20170224131425.32409-2-pclouds@gmail.com> <29A09E4EDB1F4F4D9E77E67A7A8A33FF@PhilipOakley>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 26 Feb 2017 10:02:18 +0700
Message-ID: <CACsJy8Bq-P8Aw+f0omndCmQU54n_p7ZwDVDK9APuH_3vXDac2g@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] config: add conditional include
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 5:08 AM, Philip Oakley <philipoakley@iee.org> wrote:
>> +Conditional includes
>> +~~~~~~~~~~~~~~~~~~~~
>> +
>> +You can include one config file from another conditionally by setting
>
>
> On first reading I thought this implied you can only have one `includeIf`
> within the config file.
> I think it is meant to mean that each `includeIf`could include one other
> file, and that users can have multiple `includeIf` lines.

Yes. Not sure how to put it better though (I basically copied the
first paragraph from the unconditional include section above, which
shares the same confusion). Perhaps just write "the variable can be
specified multiple times"? Or "multiple variables include multiple
times, the last variable does not override the previous ones"?
-- 
Duy
