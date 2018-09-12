Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6151F404
	for <e@80x24.org>; Wed, 12 Sep 2018 22:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeIMEGT (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 00:06:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37950 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeIMEGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 00:06:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so3673693wrc.5
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7i3Zw1tU/Twdlf+S9VjfCxdAjvlj5jfTvj782BxWlwg=;
        b=TqYjxD4OVG//CGrwpGpYpNDLosi4Qydcn3Q/u70M3+j6VgQyzE8L+/3jRmQWNe6apD
         zOP74v/es+zVP+x+I1Ax/QBsMEn58skq40aLwb5ZMRo8pT2ApJQh+8+IIJuv5ArcJTgt
         wDx7lzk10CrdeI1GPDaJurCAxf69EmYxokThNC7yhGFCI46JGfdlzqkeTi6Rv9VpddCF
         O/CKcskHSOZpvvTM8ZFCgK0G7ABbs8irLLkQ+OWASLHT7tTyLTHjhy6ijNyLRvTrz/FT
         O4zLyxl7DXCKv95kfLsrXseTUVCTO7rfykHyq3dlVVB7Tx9dgwFpxFT8jy1KDYxuEXTR
         qgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7i3Zw1tU/Twdlf+S9VjfCxdAjvlj5jfTvj782BxWlwg=;
        b=odDyAiqVsYUkTr3mFz7a9aGkykrmr24S7b0RA0bHLJhBaIvBgKscMT7txEzRJAkWuu
         x+EF3qSGtdstlBZS4a6PvH9L1Xj7pXpEMOsdZS0mJBW4QhzKZEHLrmmCU4ETqneffFqC
         ssH++g8oNvPuabvwquirvYBvFLspXTlJHXiyMBlyCFNVhWhcyzF5upqzfAO4h0vDTmYG
         TeNuIAfdULX36cBtbq2QPCU/WP4vQT5oa7RI4SwjA2rxgN5utU8BKUCt5BCBEtEFt3hc
         qSAM/TunywoySetB2xpWWi3yxLF8nqa/ohflMF53Wc0S42aBJviBFeUTat/bE3lQ4cB4
         lTUg==
X-Gm-Message-State: APzg51B9Z1wbTrygO91T6lIyHhMfQreYivWiMk6OdRI0UbyZBuXcem4X
        l0yfnERx8xXVFqEFzkptmGwqT8eDZZk=
X-Google-Smtp-Source: ANB0Vdb7l6i0oC7F403dmQeLIY8UDyJvmPv84U49hJ3ac/jn39S11gMG/+zYcEWC3pmNA6IEnXlb5A==
X-Received: by 2002:a5d:4cc8:: with SMTP id c8-v6mr3363609wrt.210.1536793177546;
        Wed, 12 Sep 2018 15:59:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q16-v6sm1346379wrw.2.2018.09.12.15.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 15:59:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Johannes Sixt'" <j6t@kdbg.org>, <git@vger.kernel.org>
Subject: Re: [Question] Signature calculation ignoring parts of binary files
References: <003901d44acd$12c2bb90$384832b0$@nexbridge.com>
        <4102803b-d5de-5812-4cef-569c9869fed1@kdbg.org>
        <004e01d44ada$b4a11ad0$1de35070$@nexbridge.com>
        <000001d44ae6$c2a20ac0$47e62040$@nexbridge.com>
Date:   Wed, 12 Sep 2018 15:59:36 -0700
In-Reply-To: <000001d44ae6$c2a20ac0$47e62040$@nexbridge.com> (Randall
        S. Becker's message of "Wed, 12 Sep 2018 18:20:00 -0400")
Message-ID: <xmqq1s9yjp9j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> author is important to our process. My objective is to keep the original file
>> 100% exact as supplied and then ignore any changes to the metadata that I
>> don't care about (like Creator) if the remainder of the file is the same.

That will *not* work.  If person A gave you a version of original,
which hashes to X after you strip the cruft you do not care about,
you would register that original with person A's fingerprint on
under the name of X.  What happens when person B gives you another
version, which is not byte-for-byte identical to the one you got
earlier from person A, but does hash to the same X after you strip
the cruft?  If you are going to store it in Git, and if by SHA-1 you
are calling what we perceive as "object name" in Git land, you must
store that one with person B's fingerprint on it also under the name
of X.  Now which version will you get from Git when you ask it to
give you the object that hashes to X?  
