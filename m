Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A2420A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 03:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeLMDwS (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 22:52:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40666 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLMDwS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 22:52:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so495789wrt.7
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 19:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K7fMv3rvtvpyEfV1DhURTqFkAhQkMqwJSps3TQ6X6K0=;
        b=fdkG/gILMLo4qtKz5a3uf+iUUJJHbyz2H8JNe1tn17A3dF2jbWUYWouB3puP5+qFHl
         ae2wG1+CEIFJLivOhE/VrhFooWvyDEQrRJ9kk0L+byQsyZjvaAyBPWWehgw+EiwzL4U6
         OwmNmMg9Hfi711pYkSL268tk5qhYgmF1vuJfE6vfOiaZJ0HvI6UEoEbslDoklSZFwPgd
         zH4WIREFw1EZySs7JJdzVjmL8tVJqjPkr/qZvnDeGxho566Y553omh8p91Z/hJQO1n3H
         fwJL5RgeCG6WAVfhGP2Vb2TpwHHdXTUbcNSgZSNbK3SoIEc3FL+d5aoOgZUg0j7lcLwD
         PI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K7fMv3rvtvpyEfV1DhURTqFkAhQkMqwJSps3TQ6X6K0=;
        b=pLdU99ap96kiT7fwX3E295fchi7RNRJDEI0lPTTpoRj4pTS02RUPcLET+BhHxsyT6K
         I90DDG4nXQFtx/SgwzG9+c4GiMxzOED6WcV6ojx4dydDSv36NHi8Wee6mD3AbOCC7Oso
         M72PWLerMD6LiZCYIacyxvzcTOBh8tX9pLjv4iSbBZixBrxw/Mc3kzf8RJWiNRrJvtxO
         PY9NwLqquhkx+Xte5z5Yq3apa3+yQdJh/1L5XNPDhy2R71+Oy+BHIAacFHzLK3UBPaYZ
         P2FbKRZplNWmSN7ZSWCdmHrreiLM94jOXRKuvCt2BUtqDnMHkHeP/Y4OdC3z3jpE2t6R
         SFVg==
X-Gm-Message-State: AA+aEWZTui5MJv4ACY9zIVHP4zjHg3+MWfRQZRdQPfvDlQbIQ1hv/ac3
        qH50uyQknCCXEqGOQOt2CrA=
X-Google-Smtp-Source: AFSGD/XVXWC3KpsrnXre1oCuoYQGpPW34BN7PsrNknUZJljv3Pn1ZYniLU/n5YXNP/7VnbUxGdVbPw==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr19124154wrx.315.1544673136480;
        Wed, 12 Dec 2018 19:52:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l202sm1614886wma.33.2018.12.12.19.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 19:52:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Steven Penny <svnpenn@gmail.com>
Cc:     j6t@kdbg.org, git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] git clone <url> C:\cygwin\home\USER\repo' is working (again)
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
        <20181207170456.8994-1-tboegi@web.de>
        <CAAXzdLVTjCVDmBik-j9B_Z_2wgSj=_6baqmjmGEGBFOsjkyOsw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1812100938140.43@tvgsbejvaqbjf.bet>
        <CAAXzdLUKhCfvqdvsPryeMGJ2ttJxof4sUcyTx-xd5p2BaoryiQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.1812111429320.43@tvgsbejvaqbjf.bet>
        <CAAXzdLU7dJGOW689tDkYuRYko1zYHXMcj_2PaVa0qStYA7ELNw@mail.gmail.com>
        <be24f331-5c8f-954d-e6f5-d5b09ee4e5f3@kdbg.org>
        <CAAXzdLU0Desw=kt2A3qHx8v=8hvKcN9OdV9fnXEcYiO=ht-t9A@mail.gmail.com>
Date:   Thu, 13 Dec 2018 12:52:15 +0900
In-Reply-To: <CAAXzdLU0Desw=kt2A3qHx8v=8hvKcN9OdV9fnXEcYiO=ht-t9A@mail.gmail.com>
        (Steven Penny's message of "Wed, 12 Dec 2018 06:40:23 -0600")
Message-ID: <xmqqsgz2f5hs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steven Penny <svnpenn@gmail.com> writes:

> On Wed, Dec 12, 2018 at 1:29 AM Johannes Sixt wrote:
>> As long as C:\Windows\System32 on my Windows computer contains only
>> 64-Bit binaries, I consider the characters "3" and "2" next to each
>> other in this order just noise and without any form of information. The
>> important part of the name is "win".
>
> sorry friend, but thats a logical fallacy :(
>
> http://yourlogicalfallacyis.com/no-true-scotsman
>
> just because the name "System32" is still in use (wrongly, I might add) doesnt
> mean that "Win32" should still be in use.
>
> Each name is a separate argument. The "Win32" name has been changed by Microsoft
> and shouldnt be used by Git if possible. Its an easy change and I could send
> a pull request myself. However just because Microsoft hasnt changed "Sytem32"
> doesnt mean that they wont or shouldnt - as you said its just as misleading. We
> should fix ambiguities where we can, not embrace them.

FWIW, in the context of the Git development ecosystem, whatever
Dscho wants to do in compat/ that is limited to Windows is
"officially endorsed by Microsoft" enough.

Also I do not think J6t felt 32 in System32 or in win32 was
misleading.  At least I didn't read the above that way.  
