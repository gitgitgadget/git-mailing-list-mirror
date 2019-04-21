Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA2B20248
	for <e@80x24.org>; Sun, 21 Apr 2019 05:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfDUFN6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 01:13:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40318 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDUFN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 01:13:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so11826329wre.7
        for <git@vger.kernel.org>; Sat, 20 Apr 2019 22:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7ahk9NIcL529F0oaoHIO9bdzufaffJaCD4+9zfOyH2A=;
        b=OKAPVra90IOc0Gs7D5cnMCbcY8/Wslb7q+rMU0BMhE86oTVvrm45fZhNeJ4/eYVlbJ
         TZx5EJ94prY9+g5giTNA9JUxUV02k4Y3SKWUCmT9W3NyRd4HsqkavmQBc90ayGhiDqeJ
         LTmQcsihaaToWn+2WlmuWpQ4q+l2fnnxkio9VsPLnLbdL5j7BCdUZvgAJsY4xOOwfvez
         2q6qnYx94KHtcNmyR7boaXPG5T1GK/cvJwhJ0T/Uv9M1JDx447HZ4by4kd604zaEZlIg
         +wHPlwzDMiX68ufMFx8Lu1A5G40I3oJKcDBax8bAUSvyizFePD7FyQ+LiHDeIG5OEWkA
         jEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7ahk9NIcL529F0oaoHIO9bdzufaffJaCD4+9zfOyH2A=;
        b=s/qIq07m1y2lB2oyYHsol+87GPqcJZkhN/sKetdHmYcCWIHd5AU+cz5+ht5A7CM5RD
         A+iFGUjOJtb4pt0Jv2HETK7CaV3noqzFEx8LylUPsDGfFw2Jwgd6tQs4rjSDXSDAqISr
         TKtJUq9BE8sH7rlol9pNhNbtliijqnbl38SgXKlzBSVQp3dA6zl1C/OgU6jEQwzHyWYL
         iHB4Bx0Gxpl7jVFaMj3YxyHsdBLmCBv+Y9e/y9UwicEfEo7KIw8GSwlfWeYLKFbPzjnR
         wwofNCuwHeWtY7uQaCGC0bA2XscGCeDFzZdSKWm99D8KHN9TwpflnroOMCd7AKaiOU3T
         o5Ng==
X-Gm-Message-State: APjAAAVaxxVhWoLMosm6+b9j2uUfNUcDCCQ/fO5eonUdbUJHRRX0Zev0
        Z9Nsfdwu+Ce2aXXGdrBvHlU=
X-Google-Smtp-Source: APXvYqy/mWCWFFbZ+TmBx23ZRTHAwj4+8wFOn6j9sHTM6WqwxlYaRfsNClwyQV2i7BwHV0lmFEjOMQ==
X-Received: by 2002:adf:e711:: with SMTP id c17mr8180532wrm.316.1555823636537;
        Sat, 20 Apr 2019 22:13:56 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id n1sm6802202wmc.19.2019.04.20.22.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 22:13:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Jerdonek <chris.jerdonek@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: doc bug: update-ref --create-reflog also works with --stdin
References: <CAOTb1wc=qBmD4k4DH1bMckrYzc3ZzB=bBYDk7QUQWxKdtsXCHQ@mail.gmail.com>
Date:   Sun, 21 Apr 2019 14:13:55 +0900
In-Reply-To: <CAOTb1wc=qBmD4k4DH1bMckrYzc3ZzB=bBYDk7QUQWxKdtsXCHQ@mail.gmail.com>
        (Chris Jerdonek's message of "Fri, 19 Apr 2019 18:01:12 -0700")
Message-ID: <xmqqlg04c54c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Jerdonek <chris.jerdonek@gmail.com> writes:

> The update-ref documentation says that --create-reflog can only be
> passed when providing a new ref to create and doesn't say it can also
> be used with --stdin:

True.  It instead should say that it only makes sense when creating
a new ref; it does not matter where the names of new refs come from.
