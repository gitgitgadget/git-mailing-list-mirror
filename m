Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1F41F453
	for <e@80x24.org>; Thu, 18 Oct 2018 01:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJRJyQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 05:54:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45460 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeJRJyP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 05:54:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id f17-v6so3552wrs.12
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 18:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=M0VqPAcr/Tv70B7Cqsm4mBraNaKU8Vora6wH5BbhRao=;
        b=dRq0obH92aGsHyEwjWW/n1GHhDNNok2o+IPEPwW/yD/j14BEG8EfWxawO36vbCPfUV
         k0zz+F+sZbSeFm7PT9zEjNMMyg4x6r/K4AUt6IMsLJ14sXKEPeLNJU4zD5sZAKVwuMjW
         IVdapc9aw964xNJUr66jRdBDyPqPRf96GHHjxxpxXq/kEHcJXtQ076e1CyF7GCvAzYJt
         OnaRs0eiUm0mz4qTtZqP6thyqCMHHAUGnYS0fdZo9m7m7HGiWUnIPtzVN62NEKzC//aM
         AN2fSH9IjL+nL7lNnsebwxelsPY3Pu6MzCUSj9QIIBc7B9Hykhe6prFJi1de1tGMUZAr
         CYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=M0VqPAcr/Tv70B7Cqsm4mBraNaKU8Vora6wH5BbhRao=;
        b=B1HLJ2eXHx2g8NJCN3rE6HV65jnlpg7dNYPEEqesoN8ifIn0SNx2GJoTTUgKLS8lpy
         LfDqNvizuZT1uEJMMgIdwD7R8UrvSXNtk4v7+L/lmH64ougj+3VJDWWf+5iZVM2utYux
         6VcJC6vCwxa/O7KwNdDG5BzINkGeWLFnFcxjtew4UIo9A7qFCnAasflbcDoAWL6tNXgH
         O3WJbuoJZ6GX3Oxj7cMqKnwlZzP8J3JdiwRs//c9vuIQMwoKplGaoIghbNKpkgxsLpjI
         YNR5uo/AfBbUTKj5UjAGqxlnFQL1N+JO1KJFLis+z6W6HBxT5wW4hlIN4EuMFlocEdEL
         8X5A==
X-Gm-Message-State: ABuFfohCkhvVZrv0utzLXylJyu9lkxZ7UxoLypp9je+vgenAdhpb7bI/
        xgnd2Q6WZMZ865SqHRLkmQE=
X-Google-Smtp-Source: ACcGV61z+ZOjdnvitfjjjIvOvLd77k9KbDEHyek4F3waLJAVRFXVvjbciHjKY3ZZIIAfdAxYsn9WtA==
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr26347376wra.95.1539827742287;
        Wed, 17 Oct 2018 18:55:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a205-v6sm3546500wmh.19.2018.10.17.18.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 18:55:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, per.lundberg@hibox.tv,
        Git Mailing List <git@vger.kernel.org>, git@matthieu-moy.fr,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth \(IKS\)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: Ignored files being silently overwritten when switching branches
References: <7d6858c8-aa84-aa05-6c69-22dbbff7dfaa@hibox.tv>
        <7v4oepaup7.fsf@alter.siamese.dyndns.org>
        <vpqd3t9656k.fsf@bauges.imag.fr>
        <20181016064049.GB25933@sigill.intra.peff.net>
        <871s8qdzph.fsf@evledraar.gmail.com>
        <CACsJy8BzjrvCMzhLKmktywfpa-8_OSvmQ8A_uRv2jfMa8_MbLA@mail.gmail.com>
Date:   Thu, 18 Oct 2018 10:55:40 +0900
In-Reply-To: <CACsJy8BzjrvCMzhLKmktywfpa-8_OSvmQ8A_uRv2jfMa8_MbLA@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 16 Oct 2018 17:05:55 +0200")
Message-ID: <xmqqwoqgvx0j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Just fyi I also have some wip changes that add the forth "precious"
> class in addition to tracked, untracked and ignored [1]. If someone
> has time it could be another option to pick up.

It is much more sensible than gaining the ability to express
precious by trading away the ability to express expendable, I would
think.

