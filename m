Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5051F516
	for <e@80x24.org>; Wed, 27 Jun 2018 16:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965782AbeF0Qpq (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 12:45:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53169 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964969AbeF0Qpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 12:45:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id e69-v6so3671383wme.2
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JWoZWfstpR6MdR4g5KzlIN1mv+4OM8VfCmBP6EHMdqo=;
        b=EuL4Zdwm10MpBAycopdTj2JVI7Lt5QwTaonj3AfdNb2AJsb/fq0jAdOWJWgBKHDOOD
         frwPkNmNckvXjmDeF33mpXytyUfUHtjU4PZ8EHDosROEastcMYDhMToZDnrrXdN8zEX0
         4eFIc6LXcwy9pyvUjHiuyaLwHhUyQYcH+qJLbQAyTVPRJ4JTz+Clt/S406PiUoge0Uo1
         Y8W18U1yghx7KhSXvLvBOKm8pMEL+qhsl+TYryLK2e0lZaIR0JqoLMB99MzPPNqyHNwV
         U0+Dcm8o23zEPPn2ttQNM/eI6JxoRdNLhSguyDfLAoHnf28Y0gzYuifFUk9KRNVe+Ds0
         5MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JWoZWfstpR6MdR4g5KzlIN1mv+4OM8VfCmBP6EHMdqo=;
        b=XgSnTcPsiG1C21HFQPFINtrJ2QXSIXvpeOKagqQgxUTVbVgb6BH+qwws9bq8VVDnCA
         JS8r0KmkLx9GS81FyfMNVqW30AIpemGl4psaKFkKXGwVgt7ZfQP50cnUrBDe+pXSBxqT
         y2tcf/pQnG7wj8Df+C357g2GLOE85wYYhUv6+fd+fHsIIYw8K0FNz/sZ5dVSWfLFQhfY
         l1ZJuwiz2JqFksSOvlbkg6MukwO+UyVdrS4oobLankmWmorqZeRGSYde/P/oQ0BrMN1i
         HvKFUKyp97BVcGuKYsSuX/VkMqnxEqOPdrC95lV2hEOo8tMqLjXBHoPTqKm2dtSCsyBX
         jruw==
X-Gm-Message-State: APt69E3cG8QfjzK+wkyaJUihuy5qGlKsq/UiOTKjfvTq+4/r3KCQelQc
        XADxGc0udDHj5rtDhhbjPbA=
X-Google-Smtp-Source: AAOMgpcYq/Tvrr93eTrshDnelPewgzRQ2iDKrtfv/ZgmR6ChDtdbqykRwo5pZwKH/UJhWhoYxWwZ0A==
X-Received: by 2002:a1c:bfc8:: with SMTP id o69-v6mr5682380wmi.66.1530117942414;
        Wed, 27 Jun 2018 09:45:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 139-v6sm7389774wmu.47.2018.06.27.09.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 09:45:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated docs
References: <20180627045637.13818-1-tmz@pobox.com>
        <20180627141430.GA13904@sigill.intra.peff.net>
Date:   Wed, 27 Jun 2018 09:45:41 -0700
In-Reply-To: <20180627141430.GA13904@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 27 Jun 2018 10:14:30 -0400")
Message-ID: <xmqqlgb0goui.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Specifically, I'm thinking of:
>
>   1. The pre-built documentation that Junio builds for
>      quick-install-doc. This _could_ be customized during the "quick"
>      step, but it's probably not worth the effort. However, we'd want
>      some kind of generic fill-in then, and hopefully not
>      "/home/jch/etc" or something.

That is very likely to happen, actually X-<.
