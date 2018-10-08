Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118BE1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 23:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbeJIGXk (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 02:23:40 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:34233 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIGXk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 02:23:40 -0400
Received: by mail-wr1-f48.google.com with SMTP id z4-v6so22500350wrb.1
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 16:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZJpwTuUaj/Wu8cOChcpqb8HoliGWOdWb24kw93RX+9s=;
        b=fAsDFZ/i7zB2zeNuerq4Y0p6OEy/7IFF9V0bs7jBI92Ol0HJEuqTskfpL3iaQYtt8l
         fwqnP+Ym/7Oe9W11ims3aEzm3dCYV/eRJcqwkapeBNF+z8+Ac0KAnkkEu50jm4QSpxyi
         W9n1Uc/QK6CIQ3t4y2UL8hTKZ49ctniuA+Zz/nIZ/+nYloOWGZGLhviVV/UEBRJaFjsk
         vQgVRkdO9c2zC5nIl5RSE9VWMPekSjzqL3tn2srrqCl9CqvHiP/iKYI7lksRAk0T1lS8
         NhtxueuWzYxAvKrC6GVWYNTSYwPNJxAo1WoSwCeiy+VY33s/Xv28lS/41rgt/Xc1Qa4Q
         uc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZJpwTuUaj/Wu8cOChcpqb8HoliGWOdWb24kw93RX+9s=;
        b=kZR89adntrnUbjPa6b1XPgKJOiKV4UB2fReTVr/TOSfhjMHm895kU1uTMzqM5GVisy
         hmcJA81rWM/GblrHXjlY80IC/JySIfoKmiIYp/eXC1uVaY1MSG7LQn5TlLmAPQ/Az+El
         YWZbX9GnDdsWkOcfOqx2B4WEQd/W45w7eA9vYy68j4cPoDep84HBPXQmg1ioWawfVLLP
         4eu+KmfsGDObNWDAt0HInMU5Bj6C7f+QPWv8Pi7sbCkIA9Nz9d6a82yM4dh+RNDzZvfl
         85+YJMtQDWVszZGCqXrcIJEvoqdJCbJ/unAPlGKN5PmYGyxF4hwTU7q6fixLd1Mn9HNW
         YNSQ==
X-Gm-Message-State: ABuFfohOF/X9DmMxTRWXFjX7vzstikaMdi+3jdrlVbkJwxD4E1yyK5M+
        RJ4BGvviA0mFCTIdZEPLiOE=
X-Google-Smtp-Source: ACcGV63ZesF6JchglglA1JAjGKS/XQ//8jrjhuFpSneNK/2L0ERv3jyG/v2Krwf3oOPVFPcTrDCFNg==
X-Received: by 2002:a5d:618f:: with SMTP id j15-v6mr19459651wru.198.1539040174574;
        Mon, 08 Oct 2018 16:09:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 18-v6sm22673376wmw.26.2018.10.08.16.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 16:09:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git log -S or -G
References: <alpine.DEB.2.21.1810061712260.2402@hadrien>
        <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com>
        <xmqqd0smvay0.fsf@gitster-ct.c.googlers.com>
        <alpine.DEB.2.21.1810070719200.2347@hadrien>
Date:   Tue, 09 Oct 2018 08:09:32 +0900
In-Reply-To: <alpine.DEB.2.21.1810070719200.2347@hadrien> (Julia Lawall's
        message of "Sun, 7 Oct 2018 07:21:26 +0200 (CEST)")
Message-ID: <xmqq8t38t4r7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julia Lawall <julia.lawall@lip6.fr> writes:

>> Doing the same for -S is much harder at the machinery level, as it
>> performs its thing without internally running "diff" twice, but just
>> counts the number of occurrences of 'foo'---that is sufficient for
>> its intended use, and more efficient.
>
> There is still the question of whether the number of occurrences of foo
> decreases or increases.

Hmph, taking the changes that makes the number of hits decrease
would catch a subset of "changes that removes 'foo' only---I am not
interested in the ones that adds 'foo'".  It will avoid getting
confused by a change that moves an existing 'foo' to another place
in the same file (as the number of hits does not change), but at the
same time, it will miss a change that genuinely removes an existing
'foo' and happens to add a 'foo' at a different place in the same
file that is unrelated to the original 'foo'.  Depending on the
definition of "I am only interested in removed ones", that may or
may not be acceptable.



