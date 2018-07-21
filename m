Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7761F597
	for <e@80x24.org>; Sat, 21 Jul 2018 00:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbeGUBVn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 21:21:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45958 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbeGUBVn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 21:21:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so8100885pgq.12
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 17:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zBdrQkyNHdO7tdj0IHp11s723XR20fazXbAsB23b4Lo=;
        b=UwFmCQDPFkETXv8EeueCUPHTd5w86Rk1o3G0LpKwXShVRQOp6ffi8I/Ry8AtIXbsEq
         fH6uoB0bexSzWTWDjC4ZpIOn7Lc5QZWOW21I3Ngt888QSe5pRqKPJSAuGQMK6Bbr/Eme
         13jxw3mKVqGYa7UXmAK1bwK0nSst7tp8hNXBk4cQtc6rfJ5sje8YArKclVPFeifLm+OP
         bPETjeA8+pNDWXqC8syFcfuJNB5C3n1r1KLFirrhMbfGtdYuFN9tpbCqK/vGMz18JYcL
         AHd7oAijzXRodpBhD3lNkol3ERX+8FQEDGDX8KxfQMqF0DgHF0BzcMs52Y/3AufLtN4i
         QXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zBdrQkyNHdO7tdj0IHp11s723XR20fazXbAsB23b4Lo=;
        b=A/ZMkVvHTFJCah8wDi7Axzrr+TghhlY9lHcVHfwlEmDRx0jOCke1hFkhN2sUEEqaYj
         dtv/QFXbIO8r6x7CqkDsmeiRt4oPUssOe14oRZwEVNKOPSAdYSJdRQmLjwfcRH4Eo+bK
         nuNjL7HBMMbApl22CB/IxsyM70mcY92oonAC37/NngU9mWKK9+XTIuvRgEeE0qEZroML
         3WaPkg7LflwARqJ3pKhMIHfxh55n1oXVFbvLtvvS4xRcA+pG8SQ06ayy5326CjLyoz5d
         FqGQKGsQwhXzmjBrfJNQiWooLiBV+UAIOEiBQaXimWzq49LQQPBSm7TBgKAx+Q953i/M
         CErQ==
X-Gm-Message-State: AOUpUlENlHHc/g9XCgVv12XP3qR2TUaCPHNAtnrj/Bq4w+ivcGeRy8od
        7g7ztFPYGrfPgUXGBhYkkvA=
X-Google-Smtp-Source: AAOMgpcMMJISPmrk9fdfaBVtrY3ERZxw/WtUn3DPtfrJeTy6uYmiED3xybF9zgeZ2QUY6k1fZNGRBQ==
X-Received: by 2002:a63:6e08:: with SMTP id j8-v6mr3892367pgc.428.1532133064492;
        Fri, 20 Jul 2018 17:31:04 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r71-v6sm4516810pfg.43.2018.07.20.17.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 17:31:03 -0700 (PDT)
Date:   Fri, 20 Jul 2018 17:31:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Langley <agl@google.com>,
        The Keccak Team <keccak@noekeon.org>
Subject: Re: Hash algorithm analysis
Message-ID: <20180721003102.GB83654@aiede.svl.corp.google.com>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180720215220.GB18502@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

> I know this discussion has sort of petered out, but I'd like to see if
> we can revive it.  I'm writing index v3 and having a decision would help
> me write tests for it.

Nice!  That's awesome.

> To summarize the discussion that's been had in addition to the above,
> Ævar has also stated a preference for SHA-256 and I would prefer BLAKE2b
> over SHA-256 over SHA3-256, although any of them would be fine.
>
> Are there other contributors who have a strong opinion?  Are there
> things I can do to help us coalesce around an option?

My advice would be to go with BLAKE2b.  If anyone objects, we can deal
with their objection at that point (and I volunteer to help with
cleaning up any mess in rewriting test cases that this advice causes).

Full disclosure: my preference order (speaking for myself and no one
else) is

 K12 > BLAKE2bp-256 > SHA-256x16 > BLAKE2b > SHA-256 > SHA-512/256 > SHA3-256

so I'm not just asking you to go with my favorite. ;-)

Jonathan
