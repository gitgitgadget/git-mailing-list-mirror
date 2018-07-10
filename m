Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8784F1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934472AbeGJQbt (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:31:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43788 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934447AbeGJQbs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:31:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so15297706wrv.10
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JsJNMbj85wDMtU2HJn3gPk6FlmOEVdzlM0483DIsUH0=;
        b=fm3Q0GDOOPdwYAXloE3l20ZjkKKVVWL3sOWvRBhaQi6clWM9eCBLKxGsxmxf1rPBsq
         zgd5ELTukkN8tcXgDOcGNmHnU0HK+KJm+1ocMbN5a4Fzd4n/xvLbKRQd7mQmatCKsMua
         qZ6Eb95jX0As7CzcgbqR+qOXW3N0RSACGojT2RnCNWyzEs1SxrQx5OThQdX6rw8tieZF
         hnxoqvYYBNvsoNCv/3YHmj5ftQmbUTV725MH99I8Xs7NUVWzHMnyMgiviEe3n7JLzn5m
         9f1VW/6MjK5sdS7bNpjjA7w2o/UdiLNKIdg5NYRP30UE9dZroVXg2KVm2OYXkDzmUvlV
         6jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JsJNMbj85wDMtU2HJn3gPk6FlmOEVdzlM0483DIsUH0=;
        b=Qbtzv58IFaDtUKD+UKl0BQjm1bmNOmTz4p6nwDHH+iRolxRVdfpqG4ZJuCtn/6B7EL
         hA6Q5GSnpct32znQH4k+8izAU6kdMeEFjSi8ESnIjNEwgtWYvc+zElO60+1v5uO9+4sv
         bwzVhkbUIWU1xgjUoRNQbRn7J0Avib/OVQ0H/ME4jU2XHa1vU5aCxT06bGrU3qhA1XFu
         HVV2ei+wQq0cbLx+CjpNRCYuxOdBJB8dtUDJR2aJZy4Vo6yBbazjB0ar4obQurMypNp3
         NMH4Q8mQp33aRnpJwmLDsKRLtOb2/jqzD6yUAD+KV8LRFcOHgClhVaFFwHgZ18GA7Uxq
         zygg==
X-Gm-Message-State: APt69E3YyD8YYYDMlxSs9qZlafxSiQlpzy3sZOJwru352d8+3wmz8ipI
        A4MRNcmjKxhQC0c8WdXgX3E=
X-Google-Smtp-Source: AAOMgpda/TPUse9rfbS6STAC9steVmO1PgYtyHMW7Bfv/Oyv9PzjzAU1h5XBwBtnXCjXClHynVb52A==
X-Received: by 2002:adf:9c91:: with SMTP id d17-v6mr17671881wre.11.1531240307588;
        Tue, 10 Jul 2018 09:31:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 185-v6sm9440784wmh.22.2018.07.10.09.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 09:31:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, Johannes.Schindelin@gmx.de,
        jehan@orb.com, whee@smaertness.net, me@ttaylorr.com
Subject: Re: [PATCH v1 2/2] convert: add alias support for 'working-tree-encoding' attributes
References: <20180708183036.29459-1-larsxschneider@gmail.com>
        <20180708183036.29459-3-larsxschneider@gmail.com>
Date:   Tue, 10 Jul 2018 09:31:46 -0700
In-Reply-To: <20180708183036.29459-3-larsxschneider@gmail.com>
        (larsxschneider's message of "Sun, 8 Jul 2018 20:30:36 +0200")
Message-ID: <xmqq601n9hn1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> In 107642fe26 ("convert: add 'working-tree-encoding' attribute",
> 2018-04-15) we added an attribute which defines the working tree
> encoding of a file.
>
> Some platforms might spell the name of a certain encoding differently or
> some users might want to use different encodings on different platforms.
> Add the Git config "encoding.<iconv-name>.insteadOf = <alias-name>" to
> support these use-cases with a user specific mapping. If the alias
> matches an existing encoding name, then the alias will take precedence.
> The alias is case insensitive.
>
> Example:
>
> 	(in .gitattributes)
> 	*.c	working-tree-encoding=foo
>
> 	(in config)
> 	[encoding "UTF-16"]
> 		insteadOf = foo
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

Hmph, when I was reading the discussion between you and Peff, I
didn't expect it end up with a change too specific to this single
attribute.  I was instead imagining that a change would come closer
to where we call iconv (perhaps we muck with in/out_encoding
parameters to iconv_open()), so that places other than the
working-tree-encoding (e.g. commit log message encoding) would start
honoring the same configuration variable in a consistent way.
