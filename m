Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEAD61FAE8
	for <e@80x24.org>; Fri, 16 Mar 2018 21:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeCPVCu (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:02:50 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39724 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeCPVCt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:02:49 -0400
Received: by mail-wr0-f195.google.com with SMTP id c24so1067592wrc.6
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2R9RBG72jV9Jik8i6A09JNPBbhnnR45uJUHWeKadx2E=;
        b=lRrya5cplI2GPHVX4mHa1OG/e9TjwB6C3O+je3r7/xTkHvsXGuF8ynvuNHpZ1KyUnF
         sqZqW5mX/5GkEnWILKwiKAZ8J70HXnrdhwm7y9CiyUTSZ9mlx7lL93nn7QNIs3Kx/uyg
         b61xWz5ZMM+WXqgnkRsnqqBJkhvmBq1uzraSZK3rbhf6PxWtEMWDZLQUO1384a2L/Iyf
         wLrBYSyr9EXEYE2morxyKG+8RBH/VVpaUE7/U3PtTWwoKhzmH4UatmXofz0tj5wAMlmt
         4hzsSa7CkExeaCo/CfZsOPQTAbZrjSi7oL1UOmDP118rlanpIzdyfkxO0JgLypHRWW5/
         1sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2R9RBG72jV9Jik8i6A09JNPBbhnnR45uJUHWeKadx2E=;
        b=hbYIMgu/SE6Pd/lASq6C8DGnvix7z3YLRSN4O4s9O7T57MCvqIJC5OwO4HOyb/Hen3
         OxJlBAIjWDNEikV8n0LH89zd0EzJ4fRm8EHrxTH6m4hXwIeEhkAP5O290xT+IvyEpKqv
         2E3ozgQIgupSZegToka42mfPJjIxSSVvswlFpt5gzR6ihtAECFTLcUB0zHsLHOWT1xcF
         pwDCv62OqEyhBXWu3Xnk1j9+3xI7nfzUy8J3ir1t61/Ha6SZgIfTB1sXkJlwsSJDEY9D
         2igmpv7bf5JuqsnjXKVfY6VpmRttty8IL6a03bpqXXSi4IXmsQ7Q4q31i7RbS1D6HcvD
         FkHg==
X-Gm-Message-State: AElRT7F4NACeEdMUg/Dqu9x47gqMEKGfa06xOkvuDimivQUUkNInZ4hu
        /5mLrl99qt1RQy2x0DQVgwc=
X-Google-Smtp-Source: AG47ELsj7i1EBJkfkubf2kpWVInLyDtNyhzpa8hyYNKxprO0mIWQ0D2atNWu1LYd29PkcQRR8nrySw==
X-Received: by 10.223.138.172 with SMTP id y41mr2738661wry.98.1521234167630;
        Fri, 16 Mar 2018 14:02:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e18sm8225759wmc.21.2018.03.16.14.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:02:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 11/11] pack-objects.h: reorder members to shrink struct object_entry
References: <20180308114232.10508-1-pclouds@gmail.com>
        <20180316183200.31014-1-pclouds@gmail.com>
        <20180316183200.31014-12-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 14:02:46 -0700
In-Reply-To: <20180316183200.31014-12-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 16 Mar 2018 19:32:00 +0100")
Message-ID: <xmqq370z20p5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Previous patches leave lots of holes and padding in this struct. This
> patch reorders the members and shrinks the struct down to 80 bytes
> (from 136 bytes, before any field shrinking is done) with 16 bits to
> spare (and a couple more in in_pack_header_size when we really run out
> of bits).

Nice.

I am wondering if we need some conditional code for 32-bit platform.
For example, you have uint32_t field and do things like this:

        static inline int oe_size_less_than(const struct object_entry *e,
                                            unsigned long limit)
        {
                if (e->size_valid)
                        return e->size_ < limit;
                if (limit > maximum_unsigned_value_of_type(uint32_t))
                        return 1;
                return oe_size(e) < limit;
        }

Do we and compilers do the right thing when your ulong is uint32_t?
