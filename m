Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358501F453
	for <e@80x24.org>; Sat, 22 Sep 2018 12:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbeIVSwY (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 14:52:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34764 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeIVSwY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 14:52:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id e25so4343055edv.1
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9EAAUcItjAq5Ftll4lBBR9FCnin75VJ928BMP5VfEYE=;
        b=Fo8jFvtzoFhHbdgRYX0Jp2Hxwscn921T/wY4h6NnPR3ELNuNONcMzU8Bq2oOZciU4P
         BDV++TmOUhNSxsBoIZNnde1UU7WkmRdWSeF5uFDS/fY0AiNSp+97KdU8t6hnBpFsurBh
         3M6Ny8nrTnDlBbRaGnwRsvryXcT0iKBSx70kq/8WJ6oTaXXejJoQUAmDgfWHnJ5nY74i
         oaALfsNXsuyjKUaDGqSc+ZyZuidvdSplp4DvtAerF8XH0T5fuFYIOuVN0gZGuTAy7jaq
         0jph+jAIMrzZk1ykZnneo4E+vLV1Df0QGjAI0dOD/b/OHnzZ2Ff65/QaAkSTofXL3+KL
         /YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9EAAUcItjAq5Ftll4lBBR9FCnin75VJ928BMP5VfEYE=;
        b=iwnjWWKgjtoLNgL+7Lf7ClrTSyH08Nd5v5bPB3tkNhzX0VpJlOX5psfbtlhVRY4eG+
         ur6OapfqwigHiQcM27oSE607Y3+jinZ3q68/fTzX95lBes+YOytInwrkGjYcnX4aUpG+
         Z+4pmvublksyJAUfipynY2rRJwb0hi5tkJok2FUcWl67F4opnejaPxoDWEyGtpmMAm03
         58IX4BBIlMjOlPcSIL+E2ssSTEbVoYZlr4DgBRlsJm8CkvC26G2wbuBW3hbb5D2/6dOB
         blLO+Kza6RpEa0fwm68RwUfrY3aMd/Z9VOdNnMJoPgjo7svsIF/Aj5IzkykB1kFm86j8
         pl3A==
X-Gm-Message-State: ABuFfojLh/dIUsq7H2GlE1rA8/7wzJhQW3nce+bFSE6sdR9NnUkJnH45
        N198nNGsE33my4/E7r1O8yU=
X-Google-Smtp-Source: ACcGV63b+oeLC8JEuWQSp1DkdyNiLiQPapdcKXR4V1L/3pFkFxYY5tgaJQ736KT9nrB3KKSfD/HbBQ==
X-Received: by 2002:a50:b84f:: with SMTP id k15-v6mr532173ede.105.1537621132122;
        Sat, 22 Sep 2018 05:58:52 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id h8-v6sm3422152edi.68.2018.09.22.05.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Sep 2018 05:58:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
References: <20180921223558.65055-1-sbeller@google.com> <20180921223558.65055-2-sbeller@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180921223558.65055-2-sbeller@google.com>
Date:   Sat, 22 Sep 2018 14:58:50 +0200
Message-ID: <87h8ihk7sl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 21 2018, Stefan Beller wrote:

> +/*
> + * Apply want to each entry in array, retaining only the entries for
> + * which the function returns true.  Preserve the order of the entries
> + * that are retained.
> + */
> +void oid_array_filter(struct oid_array *array,
> +		      for_each_oid_fn want,
> +		      void *cbdata);
> +
>  #endif /* SHA1_ARRAY_H */

The code LGTM, but this comment should instead be an update to the API
docs, see my recent 5cc044e025 ("get_short_oid: sort ambiguous objects
by type, then SHA-1", 2018-05-10) for an addition of a new function to
this API where I added some new docs.
