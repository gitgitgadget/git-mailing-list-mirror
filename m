Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 692341F404
	for <e@80x24.org>; Thu,  8 Feb 2018 21:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeBHV1e (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 16:27:34 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51245 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeBHV1d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 16:27:33 -0500
Received: by mail-wm0-f67.google.com with SMTP id r71so12040014wmd.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 13:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WP50uZ+U4P4DIEbPo3VhmVrKffvM1+epaT5xImcx8jY=;
        b=afEepHXggjl+lamWIPV3r5gVuqivypS4SuHg3btyYSAm23jFCBMW0W9+lW3LLc19HC
         7NKloIdUk/WmA+Bf7nn5DwdnYH0UkSNFdPKgmwH7DUuQLHf64LJXXOtaHQFCrEYvdFs5
         z+6cLZlQ/Qkso5VNCGpJDS1gVgbAcCWrWfOqkxfLSIiS9pj0GIydnxfQY3BKhYJH1MWk
         gbjebHS8+rGswS/AEvoyZHRJPLAwaC2nBziOoRSBxA6l4ARlmeNAVG6j0Cynpv0tMigz
         Xsy8j8KM41YxGriM6W3NTFaXw9TQ27GIEykfJRSVqIlPT5I2L6TvcNpje+v7DjyDYYRu
         RrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WP50uZ+U4P4DIEbPo3VhmVrKffvM1+epaT5xImcx8jY=;
        b=FI9nawgOuy0ypKDoWriNaPKZMcNriR1DhJc7QViiz/g+LMxUK4jfnBPVioCEfmNTKe
         URW/J0isPTyVQtzep2IFXWezp4a89ZSTTjbuK2qTI4/oFo1kZ+IMZ28Edm1Il4YjNDZu
         EL7M04DUb2TFSbzC+XghseFwer2MIw+UJwzEQvw2pmTmKdWIqooX2Qrxsg2KMRuNSVuU
         uKswWy2axjjdTqvsrFGtk7THbbS0r9Ey4qL1JzlxSIL1Wl+rA0KQdYbvDJ4QA9kDjAiw
         /grHkHSY1MrbNVKgFRhzkfCge2e5N3XYXpQmIB8ywdw91Y1fKTL213lv2zCkvcRjWNyv
         dUmA==
X-Gm-Message-State: APf1xPAMpMSHTxqm9CsHBZYUhy7GIgtt4qve/5TgZLEpWtnDKGa1R2sg
        1y0e9occiU/HYR46SkhU6z4=
X-Google-Smtp-Source: AH8x225h5NhXuOcLBV5WpYV6zWxttRkaxBM5W0elGxNoAlcmssi3rW3c96D84AKPvXrYE4TO8gWEFw==
X-Received: by 10.28.142.10 with SMTP id q10mr316842wmd.3.1518125251836;
        Thu, 08 Feb 2018 13:27:31 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j77sm905200wmf.37.2018.02.08.13.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 13:27:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 03/14] commit-graph: create git-commit-graph builtin
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-4-git-send-email-dstolee@microsoft.com>
Date:   Thu, 08 Feb 2018 13:27:30 -0800
In-Reply-To: <1518122258-157281-4-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Thu, 8 Feb 2018 15:37:27 -0500")
Message-ID: <xmqqzi4jp3y5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Teach git the 'commit-graph' builtin that will be used for writing and
> reading packed graph files. The current implementation is mostly
> empty, except for a '--pack-dir' option.

Why do we want to use "pack" dir, when this is specifically designed
not tied to packfile?  .git/objects/pack/ certainly is a possibility
in the sense that anywhere inside .git/objects/ would make sense,
but using the "pack" dir smells like signalling a wrong message to
users.

