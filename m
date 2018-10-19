Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB9C1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 03:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeJSLXd (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 07:23:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36210 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeJSLXc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 07:23:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so35823968wrw.3
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 20:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7XlyrjaCeAHFRqyqobffK3Cj/MfU+p2vP2uvULGQjCI=;
        b=iUQFsyTK1gImdKukqkZXsiVzs8Nk2E2A689eRVXAfMDkq7DXyo3S2ty+Lm83XtM2+a
         /eJxtmYjczpxr6awui426Wib4HYTFnv2TBVc23JPbbeW8BUvYEcotsQ2Btr3p+1Latl+
         05Kc3GM0MmYifk6lhDL/jUoRV23exKA62sWFiM1Jirg2/TCShy7n6/eIieJJ6mg4pUFV
         8uU7f2uEdCLA2sfotlGN9Pt7VUCeZPv6uk5P6oz5Gc4cfJm5vZ6DmS7a/gxbChN92VKT
         LVB729aRVmeab88BTn3vO7samhdcDBwNKn7HXH5d6++rwriIaENM/t4IMEezEy9hLmbm
         Kxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7XlyrjaCeAHFRqyqobffK3Cj/MfU+p2vP2uvULGQjCI=;
        b=GFURMwxC8pr0sl//tPzeKCJsi91aF81u04CKnic9j6cdRj5ES7OeZHYJw3wKh6Gpkz
         mWZeQgBPkvAzWTROUsNB54yjN+6elnKW1Sy1NduvgTzkJWTHR4tAotXjVO1r1FLT1q9S
         m3Vw8hSvrB5i/hXsTIcLiYVhICE8oBtRAO/h0XBqszyg2PTJZ7ur/fihkb5wv0noq70e
         H56EfrTdelro5HGmRXkNhqOxUZ+JmJVI4tcVXAfC6e9OtvSA0uvI8iUfNDqsSdDpVb+s
         icyZSGFAmwtHjojUoMRqJ+HrQzu8uG0yd2s+Th+62UsZCjYOcB7rNBEyQdCqBtxSn2uY
         DHkw==
X-Gm-Message-State: ABuFfogQ+8NeD/D3+kNjvaLfvgyBTRbpf2vUphL0Nr7TqjaCgCDWy4a7
        2jrVe2+vudj8eS1zLYvsvhU=
X-Google-Smtp-Source: ACcGV62Go1kdBwpUeAbtvvHzRBAbUWVZXp+JmxjNTa0mGPTiV3vqh5buODyovDP6Azo2i6R+/g9tKw==
X-Received: by 2002:adf:81b5:: with SMTP id 50-v6mr29400460wra.10.1539919164641;
        Thu, 18 Oct 2018 20:19:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z4-v6sm17954495wrt.13.2018.10.18.20.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 20:19:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Clear flags before each v2 request
References: <20181016215850.47821-1-jonathantanmy@google.com>
        <cover.1539893192.git.jonathantanmy@google.com>
Date:   Fri, 19 Oct 2018 12:19:23 +0900
In-Reply-To: <cover.1539893192.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 18 Oct 2018 13:43:26 -0700")
Message-ID: <xmqq8t2u39ok.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Jonathan Tan (3):
>   upload-pack: make have_obj not global
>   upload-pack: make want_obj not global
>   upload-pack: clear flags before each v2 request

It took a bit of time why 2/3 did not apply cleanly but it turns out
this is based on a slightly older tip of 'master' (but still ahead
of 'maint'), that lacks 829a3215 ("commit-graph: close_commit_graph
before shallow walk", 2018-08-20).  Applying and merging it to make
it up-to-date with the tip of 'master' went smoothly once I figured
it out.

The first two clean-up patches are probably overdue and worth doing
regardless of the bugfix.  Nicely done.

The first two steps use static objects local to a transport method
to "preserve the existing behaviour", and because this codepath
happens to want a clean slate every time it gets called, the third
step manages to lose it, which is a nice progression.  But it makes
me wonder if it also hints that there may be a need to invent a
state object that is passed around from the transport layer across
requests, if we want to fulfill a request by calling multiple
transport methods in the future.  In any case, there is no immediate
need to address this comment ;-).

Will replace.  Thanks.

