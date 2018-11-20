Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-13.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5141F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 23:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeKUKRy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 05:17:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42896 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUKRy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 05:17:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so3201303lja.9
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 15:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u+RO1euQAK3oHXvAy5oMKJKda3/z5Z5qOvAG7YpDZBM=;
        b=kXEE+LPGWSyEUK6Vof4x+lMxBK6vqT8xOFKf3EvOtjxVvhLDdj/UmwKLRPfpCD9ixB
         PJQUO6NNl+DIYEP9pb+zpuElh7DKn8qNJv6tcWrfGgK8jMgIQm2XRcAxpRZ324e4+rE0
         OCbfDAywVqwzlqq0TK8ejgsuN8+N+8PBRoMmgTyO+vSO/5dXP6AnnfcSLovSyAPFcyMB
         VRQ4ShSNIs0xZP4uVrDpU/yFm1sepTRcg97jQ/wdy8TtdNe2lOSDtOBl30mkn+uXaphS
         wmyBg5o0cfwU/S12S7QOPz+tzDVfcWt7Ound8UFKdaEUC7BEfQePoH5lz3Ht9nZLka+i
         U/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u+RO1euQAK3oHXvAy5oMKJKda3/z5Z5qOvAG7YpDZBM=;
        b=d6DsONJibPJVsMfZ7en5KGZrJzOprQgJCj7t+uLmnc8+tiTK5/c8YbVCdZXEl9VsFw
         hyHCuXjlBw4kIs4aU6tvgO2rwqxxlwK9h3hXbj1/Gi0kErRS4GUPxe7dwTA2kK7C426F
         ZH1lM/FfY6PpeekxR20C0oXc5DnicBHKqUATpZGvcP5xwy7V9pohAwidU4UlW+gV/rqg
         z/Pr52lD5LML62ePsRv/+HzcJxry2RvfJn7MEKx7O7b7v/R+7RG/Z+HzO2Lnu5WM5EDX
         ZnSQ3TNzXR5TTpQYqVxyXBVxGdPEFG/jQP+xMcNLlFVkMGRYVKbAwrCdvmDLAmS5vhLK
         Kmhg==
X-Gm-Message-State: AA+aEWb4IpAJIHpGt9TKtbwl0pJDRQNqw5egwzBKoDi5Q+eCnLQXCpPo
        KYRkk6iuqEcdrmCdEwRcVsCmQyZNk3ifus+nWhdyg7iL+vA=
X-Google-Smtp-Source: AFSGD/UFwkoTa/9iC5xS6JRqgS45plB00szBZy/AqwQ3j3u/8Z11ZLyi9MWSPGKq+2IU7u1M/JUpjRxUoS9uIVhQA1Q=
X-Received: by 2002:a2e:5654:: with SMTP id k81-v6mr2371081ljb.48.1542757565758;
 Tue, 20 Nov 2018 15:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <87r2fm1hey.fsf@evledraar.gmail.com>
 <20181120011841.GB62243@google.com> <87r2fgyth8.fsf@evledraar.gmail.com>
 <CAPL8Zis6Jz3=Jb0JxuSyHczYQrrrqP3JGiov1ZuH2A_0x=dpVQ@mail.gmail.com> <20181120220626.GB149929@google.com>
In-Reply-To: <20181120220626.GB149929@google.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Tue, 20 Nov 2018 15:45:52 -0800
Message-ID: <CAPL8ZitZMSOLRZ3pQW_9qatdTPhZ69fG1A=zRk1QVLARAawiuQ@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> putting it in the commit message is a way to
> experiment with the workflow without changing the object format

As long as we're talking about a temporary state of affairs for users
that have opted in, and we're explicit about the fact that future
versions of git won't understand the change graphs that are produced
during that temporary state of affairs, I'm fine with using the commit
message. We can move it to the header prior to enabling the feature by
default.

- Stefan



On Tue, Nov 20, 2018 at 2:06 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Stefan Xenos wrote:
> > On Tue, Nov 20, 2018 at 1:43 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
>
> >> I think it sounds better to just make it, in the header:
> >>
> >>     x-evolve-pt content
> >>     x-evolve-pt obsolete
> >>     x-evolve-pt origin
> >>
> >> Where "pt =3D parent-type", we could of course spell that out too, but=
 in
> >> this case it's "x-evolve-pt" is the exact same number of bytes as
> >> "parent-type", so nobody can object that it takes more space:)
> >>
> >> We'd then carry some documentation where we say everything except "x-*=
-"
> >> is reserved, and that we'd like to know about new "*" there before it'=
s
> >> used, so it can be documented.
> [...]
> >                                                      that should
> > probably be the subject of a separate proposal (who owns the content
> > of a namespace, what is the process for adding a new namespace or a
> > new attribute within a namespace, what order should the header
> > attributes appear in, what problem is namespacing there to solve, when
> > do we use a namespaced attribute versus a "reserved" attribute, etc.).
>
> Agreed.  There are reasons that I prefer not to go in this direction,
> but regardless, it would be the subject of a separate thread if you want
> to pursue it.
>
> >> Putting it in the commit message just sounds like a hack around not
> >> having namespaced headers. If we'd like to keep this then tools would
> >> need to parse both (potentially unpacking a lot of the commit message
> >> object, it can be quite big in some cases...).
>
> On the contrary: putting it in the commit message is a way to
> experiment with the workflow without changing the object format at
> all.
>
> I don't think we should underestimate the value of that ability.
>
> I don't understand what you're referring to by parsing both.  Are you
> saying that if the experiment proves successful, we wouldn't be able
> to migrate completely to a new format?  That sounds worrying to me ---
> I want the ability to experiment and to act on what we learn from an
> experiment, including when it touches on formats.
>
> Thanks,
> Jonathan
