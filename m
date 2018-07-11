Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1826A1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 21:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbeGKVe4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 17:34:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53704 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388831AbeGKVe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 17:34:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so3688196wme.3
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pgGTOOGrtVQ7CdTM6IHX00gLE+q9X4UAeFJF9Rqgyag=;
        b=Z7yBWowQI4PmnrdFIjJ3ZCbedZhp0vNQjpKbKmDBXdVHmiDpRDyfGF476XEhNwYcd2
         yLr99aTj5RVcqZNkeaBfahN1iaWEYg9piCSsqLApV0c44al+57vUa2+XqAL0SXBypezt
         /ywiU1QCHKwVFm31XimuvJ9NdWvwN5ZgxVNw2ZBTyzsXPej4Tq+lI1yWBe4p9nZ2+d3M
         +4dCqw6zb3SJCdHsabd6YSM0kDsu3Xn+g6r51JeAjtJb9nfXhNWX7sYAT1aCLq3+iMKD
         oXB2acSEqImHIsLPn0oXBR7TkIkXFRh3aI3VNT+T74vCoIzZ7O3XBNHf6x+sP6P79se5
         HzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pgGTOOGrtVQ7CdTM6IHX00gLE+q9X4UAeFJF9Rqgyag=;
        b=m5vtZUrS0ZD5rjnp68ooySIODM1dxKVjoqWkmBl3XtQalOVbV0VpdJieRWoTmiyRB7
         a3J4M6A3r9Ee38FidR1CDQ52FJmyvC3DxkSSoKGwZvZKkVQ+aRcIBJqdZJZD6dH9SodK
         ZocCD1yz+wTn2GIM1//dAykINE9EdGc+gGgcKglekLfQDEo60sk0MBsYqX/qLRdn5xDG
         2tYzd1neJGdBfa8Vf6C3aI/uInkl/bRGWJgMk4MjBH9Q6NQxEeGaS9A87x97cSlMwI3e
         24RJ9dG273xAuOFDVxcnQ+p6ly8SF0NmcHgkVL77Rh+zEranXCbBHoEkNugzHa14ALPx
         EskQ==
X-Gm-Message-State: AOUpUlETF2x0IOPT5MnUlyk2/+5KUACZZL7fVmBj7ALtMOnr7CbFFvqK
        JX37mWfZosLpOHqT1m7HWK4=
X-Google-Smtp-Source: AAOMgpdwNlRHyQsjxqMJKy40mE1q7SU6e1R27AAtnKwzcTzv+aQsNSUs7VYV2wTM7AXV1KvjfyM89Q==
X-Received: by 2002:a1c:c289:: with SMTP id s131-v6mr122405wmf.65.1531344518669;
        Wed, 11 Jul 2018 14:28:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g75-v6sm4113685wmd.38.2018.07.11.14.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 14:28:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2018, #01; Wed, 11)
References: <xmqq7em138a5.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 11 Jul 2018 14:28:37 -0700
In-Reply-To: <xmqq7em138a5.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 11 Jul 2018 12:02:42 -0700")
Message-ID: <xmqqpnzt1myi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * jt/commit-graph-per-object-store (2018-07-09) 6 commits
> ...
>  Expecting a reroll, as it breaks 32-bit build.
>  cf. https://travis-ci.org/git/git/jobs/402422108

> * ot/ref-filter-object-info (2018-07-09) 4 commits
> ...
>  Expecting a reroll, as it breaks compilation with uninitialized var.
>  cf. https://travis-ci.org/git/git/jobs/402422102

> * ds/multi-pack-index (2018-07-09) 24 commits
> ...
>  Expecting a reroll to fix documentation build.
>  cf. https://travis-ci.org/git/git/jobs/402422110

I've added SQUASH??? patch at the tip of each of the above,
rebuilt 'pu' with them and pushed the result out.  It seems that
Travis is happier with the result.

Please do not forget to squash them in when/if rerolling.  If there
is no need to change anything else other than squashing them, you
can tell me to which commit in your series the fix needs to be
squashed in (that would save me time to figure it out, obviously).

