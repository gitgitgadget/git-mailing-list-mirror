Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997171F404
	for <e@80x24.org>; Mon, 16 Apr 2018 23:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeDPXNj (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 19:13:39 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35456 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbeDPXNh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 19:13:37 -0400
Received: by mail-wr0-f174.google.com with SMTP id w3so13772601wrg.2
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J+Y0Cgj+UkBH3VAH5i7VOllbDIk3yXfnpf921b+29eo=;
        b=Yys+nCNh0uZFpw5T4QDr/oeQf/EKiqh9pe9GlDaTJa9ByXXVGjNUMPwJ37pNx15reS
         6936woIMaI6leci8Ee51pQty4tYV9Sg35Pane7lCPuDFhyjaCE6JygO1Kj35QB2V4Imo
         49fhgVQ43qWVzD/M43/1HTBG4tZg+OgnmQzsLMGMrHp/28gbVkOzA3gxmllXD560i/ZU
         RP+/emVYEUz3pGX9y1plPsbRsWoNdC7mpTBMGKaXncxIpNIP6ISz81naKfHhmv0/OEO6
         kl95tOzkMgzyuPYxYr1REVoty5vj1tUxLghOhwMvK+VvwkitxZyD4rlfi2TdhtNrDpKt
         SApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J+Y0Cgj+UkBH3VAH5i7VOllbDIk3yXfnpf921b+29eo=;
        b=kAmpoyYgx9FfYtBgixK5o0mcB3hSl5/0UCUXD0yIIFGmzhaHAuOolUhuXVTQ+16cyJ
         852otx8XomFfYEHsrCXRd2pt/WzMzjoA4liEXb4maP81WHoRy1fWrWke3DhfbHxKt036
         mLT6GOOI0FQvjPWBlVNP77EOhDkFBpf5+aNeYcxT9nc2DWIh3etclISQe/hFAjt/btf3
         mh6f4ICNC3EPjXRLLwGWHE5+jnxWVi7Ehu9iEKl+31laetrt4dNJBv+Vjbnl4SNAsA7X
         xgBZQGg2n5h1YroEJk4Xt8WSihWFrzK8PNk5r8XQyKKFFnxDvJsNWK/CS+gGPQsy1ZyX
         LdNw==
X-Gm-Message-State: ALQs6tBYcr3F+6jHIn35d0d7AyRen74BhgTmGI70rFUaaoVciCLUggdI
        //ERUS+qfk0hXJDVMjzPZozc0CXk
X-Google-Smtp-Source: AIpwx48wHP0XWyEjIDE7ibrp+MGN34fXlx5O0WIkO4YZNNlBfivD4CPCjfSWRagMJ4RoYGDSKtsMSA==
X-Received: by 10.223.200.145 with SMTP id k17mr12217839wrh.6.1523920416381;
        Mon, 16 Apr 2018 16:13:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q127sm19144796wmd.3.2018.04.16.16.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 16:13:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: man page for "git remote set-url" seems confusing/contradictory
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
        <87y3hn5drx.fsf@linux-m68k.org>
        <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain>
        <CA+P7+xrDsPXA6Bq77gYwWtc16Dz4drg+CHA80=vBNB9-NhxHVg@mail.gmail.com>
Date:   Tue, 17 Apr 2018 08:13:35 +0900
In-Reply-To: <CA+P7+xrDsPXA6Bq77gYwWtc16Dz4drg+CHA80=vBNB9-NhxHVg@mail.gmail.com>
        (Jacob Keller's message of "Mon, 16 Apr 2018 11:20:03 -0700")
Message-ID: <xmqqefjewxr4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Things won't work so well if you set the push url and fetch url to
> different repositories. Git assumes that refs updated by "push" will
> also be reflected via "fetch".
>
> I don't know offhand what will break, but likely something will. For
> one, when you fetch again it will rewind your remotes after the push.

Exactly.  I still haven't fully embraced it myself, but for a long
time, "git push" pretends as if it fetched from that remote and
updates the corresponding remote tracking branches (if you have
any), so you'll be inviting inconsistent behaviour if you set your
fetch and push URLs pointing at two logically separate places.

This is a tangent, but there probably should be a boolean that
disables this feature in "git push" per destination repository,
i.e. "when pushing into this repository, pretend that we immediately
fetched from the refs we just pushed to and update the remote
tracking branches we have for them: yes/no".  It is not entirely
implausible to envision an overly smart remote repository that turns
a non-fast-forward push into an automatic rebase when it is safe to
do so, instead of failing such a push, and you'd disable the "assume
what we pushed would appear there" when talking to such a remote.

