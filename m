Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3157120A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 02:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeLMCRY (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 21:17:24 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35954 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLMCRY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 21:17:24 -0500
Received: by mail-wm1-f51.google.com with SMTP id a18so773792wmj.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 18:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IRRhq1B1JnJfyPCnuhnjO1zgxDsSN9xMvDZXgL50VHM=;
        b=Da5/JUuHrlpm/lI1iIm+nnTPIyqUxOMspzk6k9NkHNWULWkjpEwkc6JgCjH1RA74JL
         ra1DmOWO+ALUeUsVJbUQjgFcipll2HEtG1Cw+8/+8xNvPjKBjdj4+0i8LIZrJI6aJcV1
         jvzt5TSnXvJyA/n88BqbEJ5k2MDLPaFmC6i/8hWqHS1OD0JtKXNsfgFn1c/NV2dndFlK
         PsSajkCuNP/jhWijYJnInmDqFZDVKQTTfBZ//R18HZpBwn+3KvazVR4kc0SzJUlE9iuB
         RcFyQx8Zfsq2Kdz55Hz7OLYjL44+upsejDNmZ+IxaDs445wYpwO+fCVYCQI9ys+q8b/+
         z2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IRRhq1B1JnJfyPCnuhnjO1zgxDsSN9xMvDZXgL50VHM=;
        b=RipytxVdf3mtPzu+f+wS2B/gCRyWpTywDdUZiqlMS8ygCL+CNJqXU2UxuWzyc3LeZS
         dLnpnspnvX3hmmj245y8aQYsVJL3XsvyNdACmj5x5Qqo+Ir3IXcw+z799/UVqjmdNMqd
         fJ9SOZLAJ088SUZmdPp8qgWYiyLsnvDiQNFLTMo0AG2vN+XGOEDafS/OYmSo18otljXo
         l0qlNUUXsBZyOmVPg/NRcdyu/CYTb/mh8U8rWcHkq74IXK4v1uke56JQbFN3ELzMTKvV
         mqhUfMu1o61aB6vh6BgC003yWyAMsjdsUlZqYPVu9/yJLmT27YxFf+ydi0OCIFTKBE7K
         zqHg==
X-Gm-Message-State: AA+aEWYwAvBZAyLh4hmn6Ilg74goyvFORaApbBjrRKmKwmXdDXUKnfJF
        LjY7DTtYWB2gibd+5kfdk9spZYQQ8Yw=
X-Google-Smtp-Source: AFSGD/Xv4me3L+8yrmDZCf7OzJ36DlwOypQZyo4yyql0gD9OxBJ3TACqZIWzOwT1K8l+YNBStpROGQ==
X-Received: by 2002:a1c:8f95:: with SMTP id r143mr8077376wmd.65.1544667442309;
        Wed, 12 Dec 2018 18:17:22 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a18sm1211859wrp.13.2018.12.12.18.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 18:17:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lukas Fleischer <lfleischer@lfos.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] A global mailmap service
References: <154454625546.29948.6229097078125430492@typhoon>
Date:   Thu, 13 Dec 2018 11:17:21 +0900
In-Reply-To: <154454625546.29948.6229097078125430492@typhoon> (Lukas
        Fleischer's message of "Tue, 11 Dec 2018 17:37:35 +0100")
Message-ID: <xmqq1s6mi30u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lukas Fleischer <lfleischer@lfos.de> writes:

> The basic idea of the service I imagine is simple:
>
> 1. You register a primary email address and specify a password. You
>    receive a verification email to confirm that the address is yours.

I would do so with my current, reachable address, I'd presume.

> 2. At any time, you can add additional email addresses and link them to
>    your primary email address, using your previously specified password.
>    You can also update your primary email address. Any new addresses
>    obtain verification emails such that you cannot steal somebody else's
>    identity.

With this, I won't be able to add my ancient identities that appear
in our history.  I would imagine that one of the common reasons
people use different identities in a project is that people changed
e-mail providers or jobs.

