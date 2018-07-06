Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B7B1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeGFVcg (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:32:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38973 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753946AbeGFVcd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:32:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so5375077wre.6
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sw6cWpdCfFs6U75U8WHo23YAUp+Jv+nesfl6PhOmwDs=;
        b=Gxn1BsVhQAC6LH0yP6DFf0gdS4JiXw/xu9yI9dr2MdG2VjJJjW5m+EJQjqqKGcrwUx
         DpK0jZAi/XkZwfmIWf4lNXb58Ezc8dknh4lKkXPiCboS4+VuczD7QTTrreeL5DVXueV+
         W4uVNXN/awmk9lPuGyHaMb+Nthlrw9GDjbT+JaIPb1bq0Pt4qn9jiyf3IHgC3AOPy1lE
         iXj5W7EgxLllPU6EsjIF9qg5xL+ZWDMg4R4VC1ANQ/RItCqwpNzS99sVVsWXc/V+h+KR
         P85FBJ4//DUidNhEbwBD7Qsqzt1Zq4Arvti6qD1BxW+toaiHAgRq0rhRz9dOFj3jJCXc
         c9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Sw6cWpdCfFs6U75U8WHo23YAUp+Jv+nesfl6PhOmwDs=;
        b=HBJ/pnOJDOszSvIzQoMAOjhtIVEIXcM3kqK0NCaJ6YsQkoptze3z6DwsGxjtK5JbwV
         PRszZfdUwFp+E/Yw03DmS7wFKylzb4oNVYZQTwYNy57T/gg09LNe90ApHjcwDsXCrhMo
         0IWqMU2zCZ4FFq54VPZacA8ZBiN67S5OnwCo3PYWRfS/WQLp+RUCgOKWA+N5AL0ry3Jb
         O/hmywv9xMXzCbPwf8Cp+n+9LLi+/nTPIN/3qvjgbqDUrYFRAmTwLNenSI5q4Jn94kjD
         N4NvSX2vHoO4qmFJFANp5KQD7gnj33IOBYFNOt5AyeELSWwtopmr+UrcmklSkq3+mNFL
         2qmA==
X-Gm-Message-State: APt69E2SIqvazZxA9+ODdkox6sdSAz/KndtZhx5yakkw47MTGytwY11h
        cIrb+nIVdmPKi8lbJ74oIKE=
X-Google-Smtp-Source: AAOMgpfQiDQB0ShOjax2i+VcnZTnTqHrBRUG+lP5VrNa0Hm/boWIFgXhm29U82JEJFW5vRZeV0kZLg==
X-Received: by 2002:adf:ac66:: with SMTP id v93-v6mr8266158wrc.7.1530912751569;
        Fri, 06 Jul 2018 14:32:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s17-v6sm6853669wmc.34.2018.07.06.14.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:32:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joshua Nelson <jyn514@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] ls-tree: make <tree-ish> optional
References: <20180703035802.24060-1-jyn514@gmail.com>
        <CABPp-BFu+m-7Fyf4kj8hUO33vhAxKuAu5JnyL5Tzc7c6Kq+Hjg@mail.gmail.com>
        <xmqqbmbonff3.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGJjJGhOEBiJJ5J5rnMXfLndKgwU-4_JVqumBB81DUHpQ@mail.gmail.com>
        <xmqqh8lcmh7u.fsf@gitster-ct.c.googlers.com>
        <6d7eca9f-bf3f-5724-42ed-bd579a4d604f@gmail.com>
Date:   Fri, 06 Jul 2018 14:32:30 -0700
In-Reply-To: <6d7eca9f-bf3f-5724-42ed-bd579a4d604f@gmail.com> (Joshua Nelson's
        message of "Fri, 6 Jul 2018 17:26:33 -0400")
Message-ID: <xmqqo9fkhwy9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joshua Nelson <jyn514@gmail.com> writes:

> On 07/06/2018 01:01 PM, Junio C Hamano wrote:
>> Elijah Newren <newren@gmail.com> writes:
>> 
>>>> I'd prefer *not* to have such a DWIM in a command like ls-tree, aka
>>>> plumbing commands, where predictability is worth 1000 times more
>>>> than ease of typing.
>>>
>>> Fair enough.  However, what if no <tree-ish> or <path> are specified,
>>> though -- would you be okay with the HEAD being assumed instead of
>>> erroring out in that case?
>> 
>> If we wrote ls-tree to do so 12 years ago, then I wouldn't have
>> opposed.  Changing the behaviour now?  Not so sure if it is worth
>> having to worry about updating the code, docs and making sure we
>> spot all the possible typoes.
>> 
>
> I have to say, as a first time contributor, reading this is extremely
> discouraging. I'm not being told the patch can be improved, or that I've
> made some error that should be corrected. I'm being told that the entire
> idea of the patch is unwanted, that it doesn't have a place in a mature
> project like git, that only bug fixes and security issues should be
> accepted.

... on plumbing commands like ls-tree, where keeping the interface
stable is much more important than making it easier to "type".

Rules for porcelain commands are entirely different.
