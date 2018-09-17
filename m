Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF251F404
	for <e@80x24.org>; Mon, 17 Sep 2018 20:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeIRCQ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 22:16:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52356 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRCQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 22:16:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id y139-v6so105126wmc.2
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Y3L7Bc9sA6ymG/9pZR56sw9NQZ3BEz00eWv/+sUl3DY=;
        b=mKq+QX65TYkEe7mkr4kAkjnZvIE5AKrFUcd/uo5D+vWzc1gK17v1qDjcoXcp4Dan03
         v58L628x+QfDziHsTlRLGD5Vr5+F+KYfc0tfD93phCrzC0NDQD+eOtBUZvhbujAUMsRg
         P5HkG64oUjGqdOdz5VQnt0pEK42Vk0IwN831Bf3Rt0pSAt1dd6rQpd4i7jfQF0Oi1UtV
         hsRlb0HZbPFFPQbg+ezAhoGG6M5Y9wUiN2XtQI8idv4O6CmITTGYmWlBs74CnS5JXfap
         AJL55xroz1GbcHk24KcNhuzZ4Qgbg6zotlxWn55+8A7oCiHxc+dyoCtuZoDU6e30EV0O
         z0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Y3L7Bc9sA6ymG/9pZR56sw9NQZ3BEz00eWv/+sUl3DY=;
        b=q12b5ms2OP+toFL9UcKMqDcU7TeU6Ti5gcRuKZw0fPX+ytrMvOkO9nZUU37r9p4Njd
         GTim4e3ppaP8PVQapo63eeEsAuziLAxDMvpqZV/spCVHxiJycrtG/pqj1sDL29X8j57v
         /auo0HVl5lA+BACdiBE0Tmb8cV/uIzbsRhP4cKTE/JEbLlLybXVgZ5W4Y27qL1b3hVqx
         xr31qa2iZEV2Scv2jMDoJ031ichyQfIfNgE46v11t/FTjmGSy2qaiD0TfCyVclRY85jA
         eaMYoQ+vw4HKj/JXDVEobJmY+TcDOhvdMlywX88P6NCggj6d5D1fTSf9s6Fsmh7dc2j4
         8OwA==
X-Gm-Message-State: APzg51CJwxPEHfVnkpDXDRgMOTM1/4Lr+NU9x2kA7yRYbSpt9BatKIJp
        yFid07inGqmD00zS2ZFvtec=
X-Google-Smtp-Source: ANB0Vda7Bx04AHmxxDYQXgqI/SFLMRKH9DKxe8qABDbs2DmH/jenJU1u+HLnX0qJAGWloLxhjGw2vg==
X-Received: by 2002:a1c:8153:: with SMTP id c80-v6mr11792553wmd.123.1537217278303;
        Mon, 17 Sep 2018 13:47:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q16-v6sm10872867wrn.41.2018.09.17.13.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:47:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] midx.c: mark a file-local symbol as static
References: <63d480c7-0312-3b1d-59bc-7b9996facea0@ramsayjones.plus.com>
        <d4b88c9e-9d02-f361-922e-f85caf3994e1@gmail.com>
Date:   Mon, 17 Sep 2018 13:47:57 -0700
In-Reply-To: <d4b88c9e-9d02-f361-922e-f85caf3994e1@gmail.com> (Derrick
        Stolee's message of "Mon, 17 Sep 2018 16:11:59 -0400")
Message-ID: <xmqqlg7z6ebm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Thanks for catching this, Ramsay. Sorry for the mistake.
>
> ds/multi-pack-verify is currently queued for 'next', so I wasn't
> planning on sending another version.

Marked for 'next' does not mean we cannot touch it.  It merely means
"so far no issue that requires a reroll has been raised afaik", and
the whole point of marking it is to give people a chance to stop it
before getting merged to 'next' with known issues.

As the problematic commit is not in 'next', let's squash the fix in.

Thanks, both.

