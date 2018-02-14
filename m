Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B32D1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 17:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161180AbeBNRXp (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 12:23:45 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44503 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161065AbeBNRXo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 12:23:44 -0500
Received: by mail-wr0-f196.google.com with SMTP id v65so714169wrc.11
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 09:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PsG8OpVJyoK28l8tcPMYuLP6b7dV0bsTCwe8i5Fol6M=;
        b=pP6g+lP6fMTLDLsKze9LMEx/ZXBtEVgeddD3PBjnYfc0b1HfYRVco2lRSn78+dq+WT
         JgDN+t8TjYdz33VZ69DQeqa1CTWgUh+q56rK4T3wQ+npjubaVoEa9mgg29fYsaevXn7i
         GkcoBp6VVvBPeyiBaZHdhZBZjMnrOHvght7zGLfng5EJw+AtRWDZbW+iSUxf7XsZCr3h
         uaCInZQ48TwhLvT7bpDQUfimxJyG3k2qvvC//FXeoXUiP3sY/yP+TF/5jmvF8jqwlfID
         R32xETfIE+fUj3KBjEOmzBL7dW4aEiTku+kgJEcgsyJCmzAY43WHybxylFA0VaMyFkFm
         MTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PsG8OpVJyoK28l8tcPMYuLP6b7dV0bsTCwe8i5Fol6M=;
        b=YmijqeWF6AWwfW6VL27UBIXcD6EB53NDo1K+Npvsu+E86wW7VDIHj3hqwEaKmVa/B4
         bT9vwnelHOLu8oCWXrj5cmPxQSQ9O3CZNK8HXBhpc1VWbaLwL1qnG8MWA69ZfOlk3CAB
         jheTCpdVYBGsCFGLEMyGnWpPh/5KKs7oUScwvCuI1opxWILrce6MqGMyoBJmfbE5gLG4
         Mu6mjmKxofd6lLlYSi2uujUkmyz2jz17Konb4c5AD8aazi8MOnBWOHjg0Eb/IK6NGLeo
         brrom0E2mg7WLEnAZKF7m3QItLaN8o5HnMJUqnbXU7YJBRcTSJp2OzIalOXmthvTIPiQ
         CS8Q==
X-Gm-Message-State: APf1xPAeFnIcU4McWWWD0BjG3vrTF7FBLk6GHER9qIDYFR/Gnah6naoQ
        GhF8wxdwXzgPFpQ6sCI0KzlLz5BmeH4=
X-Google-Smtp-Source: AH8x224yfZO3Oc0wY5+Wns2Ljn8Hu4zbWoaOm+DdAQzdP+XtBjR72ugI6/1kzrnT3zEHr1c/b2jtzw==
X-Received: by 10.223.198.200 with SMTP id c8mr5454421wrh.79.1518629022445;
        Wed, 14 Feb 2018 09:23:42 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i6sm13903810wrc.46.2018.02.14.09.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 09:23:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2018, #02; Tue, 13)
References: <xmqq8tbwpcdv.fsf@gitster-ct.c.googlers.com>
        <8f014e98-8360-785c-fc5d-0664466057fb@gmail.com>
Date:   Wed, 14 Feb 2018 09:23:40 -0800
In-Reply-To: <8f014e98-8360-785c-fc5d-0664466057fb@gmail.com> (Derrick
        Stolee's message of "Wed, 14 Feb 2018 09:10:46 -0500")
Message-ID: <xmqqy3jvo57n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> There have been a few "What's cooking" emails since I submitted v1 of
> "Serialized Git Commit Graph" and it has not appeared with a tracking
> branch. Is this a mistake, or is it something about the state of the
> review?

The latter.

Once I pick up a topic and have it in 'pu', I'd be committing to
carrying it and keeping it up-to-date, while dealing with possible
conflicts with other topics.  As I do not have infinite bandwidth, I
try not to chase targets that are still moving too rapidly, which in
turn means that a hot topic everybody is excited by its goal will
take more rerolls than other topics before hitting 'pu', because it
gets more good suggestions and it takes time for its patches to stop
morphing a lot.

The discussion in the last and current rounds gave me an impression
that some stuff (e.g. "graph-head") are still likely to change quite
a lot during the review-response cycle.  Is everybody happy with the
latest set of patches or are there issues raised already in the
review that are better addressed before we start making it interact
with other topics in flight?

Thanks for pinging.


