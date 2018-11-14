Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B151F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 11:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeKNVEY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 16:04:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33231 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNVEY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 16:04:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id u9-v6so16791931wrr.0
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 03:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=azAm+rL6D+n8O3G+XRtwJeCUuuL7v9khaCR40RdCf94=;
        b=Z+oqFg5m0MDCg2PTMASSQ2bM372Y8ibOot/UIavHdOWi7gG01YvFvFZ3n/X7mhUqbz
         G7HPDCB4kOIzFMAQFCUW5n5f3GeOcDJNA+XwVFoHjLNJ+zXX+h4ZJKtfdtTX6hTYXaoM
         MywL5C47+XyJ81OYZ4gW1lAmphE9DV2IOGUGCx6c7iENfJa4ecwZTWZpp1xTx4WGXK9W
         6hVtRVjwN2bx8PX06IjxuZszzRwqfbO/5z2D5ijmzgUPQKZLaebvOcSZWLY6E7sfBxdg
         JdBP6muhxb9mXqYD6O44haGC5n+7+fr0BFzDFAIdqGMu96TFaJMREMSg/SBtszFRgPeR
         r9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=azAm+rL6D+n8O3G+XRtwJeCUuuL7v9khaCR40RdCf94=;
        b=DF9zvxnUg2n0kPv22mbYFdE6o5x8B+9IGAATObvVOhM8k8C0LDb8VgkgEUooZf/Y9c
         lZizshoxePaxwc6hdUVPP77akj53xl0Wy7LK11HKdxhgWAYHof0vTdqE7ReF9oel4dNu
         cXUAqyC1e8pSTTUYDAVaV2yHbXmus4GTblNN/teba8gsdll5lLkXHiCa6A5OU+eWH7R3
         LesAz3GVgdAzjgKakdDRAOQoDchRsxBy+7+VmxXuTjVPvrBP3yw7wzRpBQzolqUqYxP5
         B86q8naTl8cHvLx+YV89KZIqmPwl90gRBYSmW0Vq2qUacJmDo5mD11AjkAIEo+ZfpjaE
         kpjw==
X-Gm-Message-State: AGRZ1gKiMHd66ic9ejnh8eag0kfXLRtc3o4mF9CNskseby/sPPpTbcGx
        UymiZCGynwAD0V33FfPFHCo=
X-Google-Smtp-Source: AJdET5fbH6OQRQikvfp9p1hS91WWcqWWy8Mr/hiqCY307bdRFYgZHFrOR+smDLAYyoswKnPpMRNRzA==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr1390349wrp.61.1542193297150;
        Wed, 14 Nov 2018 03:01:37 -0800 (PST)
Received: from szeder.dev (x4db1d05b.dyn.telefonica.de. [77.177.208.91])
        by smtp.gmail.com with ESMTPSA id d18-v6sm7509721wre.25.2018.11.14.03.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 03:01:36 -0800 (PST)
Date:   Wed, 14 Nov 2018 12:01:34 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     steadmon@google.com, git@vger.kernel.org, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
Message-ID: <20181114110134.GI30222@szeder.dev>
References: <cover.1539305180.git.steadmon@google.com>
 <cover.1542059029.git.steadmon@google.com>
 <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
 <20181113182802.GG30222@szeder.dev>
 <xmqqwopgqsws.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwopgqsws.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 11:44:51AM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> +	if (tmp_allowed_versions[0] != config_version)
> >> +		for (int i = 1; i < nr_allowed_versions; i++)
> >
> > We don't do C99 yet, thus the declaration of a loop variable like this
> > is not allowed and triggers compiler errors.
> 
> I thought we did a weather-balloon to see if this bothers people who
> build on minority platforms but
> 
> 	git grep 'for (int'
> 
> is coming up empty.
> 
> We have been trying designated initializers with weather-balloon
> changes (both arrays and struct fields) and I somehow thought that
> we already were trying this out, but apparently that is not the
> case.

I thought so as well, and I run the exact same 'git grep' command
before replying to Josh :)

There was a discussion about such a weather-balloon patch [1] (which
happened to use an unsigned loop variable, so our grep wouldn't have
found it anyway), but it wasn't picked up because it required new
options in CFLAGS and there was no standard way to do so [2].

[1] https://public-inbox.org/git/20170719181956.15845-1-sbeller@google.com/
[2] https://public-inbox.org/git/20170724170813.scceigybl5d3fvdd@sigill.intra.peff.net/

