Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C981F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeDCShV (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:37:21 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:38805 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753180AbeDCShU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:37:20 -0400
Received: by mail-yb0-f174.google.com with SMTP id k1-v6so1073787yba.5
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y6QzAv3EVqOiZggTsq6sH+w6eHVEuMFHbTQpXR6a6Qo=;
        b=tN7xywuuUcWTuufxRpFHRMgx6N34UZ+VKwGfmAKIBJeUKTwP4DdF7tT+Olwra98MGt
         5cHX4LB12ai5fQgSq/6pxtVNZmY8HiC0Ba1sFGnfR9VgygG9FDLv6J9YA0RXSSfzAoJ5
         yDw3MEPBlFbXNhUs9PO+AMjOqDqD2gw0syq7Bh4KmaiQZfB7byDI4634EQ53CChZycA5
         ftGB6rJptiMOHBJL7R9yv/E+cCbmg8n4N2LpqWCg66V2uQyQQMsnlia3hB4oj/YmNbJR
         +7JIxUgBlurbOUMIWO9+fiKrjWe10kiNO17o4DUv6b5+H9/Ua0HrzpIvZxhGZR9lJ5X2
         lNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y6QzAv3EVqOiZggTsq6sH+w6eHVEuMFHbTQpXR6a6Qo=;
        b=acCzXaZieNzVhO4oMArlHWqZ3X2WtX3cVC8cWlurw9wV95u8CetiANoSCeLyMs22Ur
         WuY56TAq/x4jMu2wi/L6WYQkLFqtBniemPK97eM7y2NtI12gi2PD7opllP9AawkFPIGd
         xXTYjXGlujjtKLuxZYV2CyTRJRGaLdnnhYMVAka6YIKSvFqbr2Tu+4xZUPmbHL2NPQxL
         LamK0ywrEIqJNyLENo1YOpqRkjH0h2aXEVg/vgAwOuSs+R5ozeYoVS6LQIS+oFnnMxe2
         SwyV1tzcXI9yrt4IdycR4+PAEPQf4b2mcIZKvQhXIgYj9J4cD2ooH8APT/Z7Z+R8kAGw
         u4Zw==
X-Gm-Message-State: AElRT7FbcP6tlcUoqQUMDfnrymdROUZF7Io9AGo4/EdRajbaanYfrMJI
        3Brfl4MDI2pQbH573X3dMNCHrd86aNL2xRxWowOWaA==
X-Google-Smtp-Source: AIpwx484+V8VgEfhLr7m90KV9F9WcEvHQD5W5SLci3pYnAMjpwRhN6KpWk5/Cm0prvL6znWILh/EDsWwoz5huC018so=
X-Received: by 2002:a5b:143:: with SMTP id c3-v6mr5821450ybp.292.1522780639485;
 Tue, 03 Apr 2018 11:37:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 3 Apr 2018 11:37:18 -0700 (PDT)
In-Reply-To: <aa3340e8-dbd9-7cf7-1711-a6f675bf6b8c@gmail.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180403120057.173849-4-dstolee@microsoft.com> <CAGZ79kZ0XZRiKcJG-5Ckd=XjE-3GfGHkNuyu4590OyfGPve4Rg@mail.gmail.com>
 <aa3340e8-dbd9-7cf7-1711-a6f675bf6b8c@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Apr 2018 11:37:18 -0700
Message-ID: <CAGZ79kZTbDFBcw1MJeYyc_Ge1ZGZzRMVG7dhXEt9MjM9YAcTVA@mail.gmail.com>
Subject: Re: [PATCH 3/3] commit-graph: lazy-load trees
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> +/*
>>> + * For performance reasons, a commit loaded from the graph does not
>>> + * have a tree loaded until trying to consume it for the first time.
>>
>> That is the theme of this series/patch, but do we need to write it down
>> into the codebase? I'd be inclined to omit this part and only go with:
>>
>>    Load the root tree of a commit and return the tree.
>
>
> OK.

This was just a suggestion, others may want to chime in on the terseness.

>
>>
>>>   struct tree *get_commit_tree(const struct commit *commit)
>>>   {
>>> -       return commit->tree;
>>> +       if (commit->tree || !commit->object.parsed)
>>
>> I understand to return the tree from the commit
>> when we have the tree in the commit object (the first
>> part).
>>
>> But 'when we have not (yet) parsed the commit object',
>> we also just return its tree? Could you explain the
>> second part of the condition?
>> Is that for commits that are not part of the commit graph?
>> (But then why does it need to be negated?)
>
>
> Some callers check the value of 'commit->tree' without a guarantee that the
> commit was parsed. In this case, the way to preserve the existing behavior
> is to continue returning NULL. If I remove the "|| !commit->object.parsed"
> then the BUG("commit has NULL tree, but was not loaded from commit-graph")

Oh. That totally makes sense now. I should have more coffee (got up extra
early to see a dentist before going into work)

> is hit in these two tests:
>
> t6012-rev-list-simplify.sh
> t6110-rev-list-sparse.sh
>
> I prefer to keep the BUG() statement and instead use this if statement. If
> someone has more clarity on why this is a good existing behavior, then
> please chime in.
>

I would also keep the BUG statement; I am unsure if we'd want to
have a comment explaining the situation, or if it is obvious enough
and I was just not focused enough.

This totally makes sense now and I'd keep the code as is.

Thanks,
Stefan
