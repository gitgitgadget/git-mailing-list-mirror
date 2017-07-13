Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA642027C
	for <e@80x24.org>; Thu, 13 Jul 2017 21:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdGMVUQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 17:20:16 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35476 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdGMVUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 17:20:16 -0400
Received: by mail-pg0-f41.google.com with SMTP id j186so35358124pge.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=38hxzISxeeaSwc1emRE2ADdMtV3UZa9IelxVu40YsSI=;
        b=UmDWcc/jrAvtg4LGXpmCG/0HtxekQDvcWxf2xbTnT1HLTFmgGmEaTrVNt2A9Lb7Bx9
         xi5Cp+Ocrc4B6b560tU5gQ6y7oSq/8K9/xh8FbGRl2lxltfTmczX3UI5OMDc+EJ8Exrf
         oyXDNz8uNZS1TjRpPDH/lapf1+Xe5wg/mOAbZMSUJS9u2Nh3/USzTadkiRAFxRMyBeia
         wyHq1xcM0p9zvdbTWhwBeSUhpeldxfZ/Nz8QKVWw8qa7Ba98HfL3KBh2RkyPUW6nMSgO
         uMxBRx0aIhSoaq+OaWLf9fljuFGa6BkU7v3B9cXOIv0KL/bgCyeYTS0DlQUq0sgez1IE
         axjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=38hxzISxeeaSwc1emRE2ADdMtV3UZa9IelxVu40YsSI=;
        b=OBK9nJ0CIIC3bJ2eoAIWnbhVnOrNyDPP+ITpAIOMN5/JhuSJbSddH+Kd6UzFvuiEcl
         XJVVsVyz36Tvf9I/eQcjzmxnTugWAHJzx/bL2s4NWz2zRaApnCciYC73tDmkMyX1PYa3
         WzOVxhj6Ip7bj4y0HXeT0n5EOmsA9IKsG+jcyy+7CU6z6TmEhHkCBu0EwYndbd5CD6jv
         cxqhKOaAkIxaYbkmuBmcj68UcL/bxSXYQK57/Qk1FnGshMpKUjulsoz1UtJn2MFM6Tuf
         FYRlgws1JnD14wFKOgdfN8Vxvhr94v6ZGC+FqVImL4+hc9Q3BO7+lZfcwZ6043YzujuH
         p5RA==
X-Gm-Message-State: AIVw112+AmYDxFQ3GrqivReSIB/1rlvjFC7WGLw7WUBAXDeK11lvrqp9
        3YvpU3cBFUTXUsoZ+tg=
X-Received: by 10.99.148.26 with SMTP id m26mr1884660pge.222.1499980815137;
        Thu, 13 Jul 2017 14:20:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id c19sm13319904pfj.15.2017.07.13.14.20.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 14:20:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nikolay Shustov <nikolay.shustov@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "groups of files" in Git?
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
        <CAGZ79kZaf7=uwCPJoPoDiAO9QS21bchaKZvDzWJi=ewPZw9PXQ@mail.gmail.com>
        <xmqqiniwxkmj.fsf@gitster.mtv.corp.google.com>
        <CAEcERAxJRnB55Ardhs7LDW8M8EG-y+YE-He8hiiQv3wDqtVD3g@mail.gmail.com>
Date:   Thu, 13 Jul 2017 14:20:13 -0700
In-Reply-To: <CAEcERAxJRnB55Ardhs7LDW8M8EG-y+YE-He8hiiQv3wDqtVD3g@mail.gmail.com>
        (Nikolay Shustov's message of "Thu, 13 Jul 2017 15:47:36 -0400")
Message-ID: <xmqqzic8t4oi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikolay Shustov <nikolay.shustov@gmail.com> writes:

> I am not really try to ignite the holy war between Perforce and Git
> (and why would one???), but if you are interested in the answer on how
> you'd do your scenario in Perforce, it would be: "use shelved
> changelists".

Oh, that was not my intention, either.  My interest was to see if
there is a good solution that we could steal from other world.

> In Perforce, you could "shelve" the changelist, similar to "stash" in
> Git, but the difference is that the Perforce shelved changes are
> accessible across clients. I.e. the other developer can "unshelve"
> these pending changes to its sandbox (to the same or the different
> branch) so that sandbox would get the pending changes as well. That
> would be like the developer made these changes himself. Whatever
> automated/manual process is involved, it is typical to run "a trial
> build/tests" on shelved changelist (i.e. uncommitted yet files) to
> verify the quality of changes.
> Git achieves the same through the ease of manipulation with branches
> and I like the way it does it much more.

Thanks.  Shelving and letting others unshelve is like keeping the
changes in separate branches and privately share them among
developers, so they sound pretty much equivalent features to me.

> My question was about how to robustly handle "multiple pending
> commits" which in Perforce are represented by concept of pending
> changelists.

And in Git, they are represented by concept of commits that are not
yet pushed out to the public repository to become the final history
carved in stone.
