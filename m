Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592101F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeBTTDu (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:03:50 -0500
Received: from mail-yb0-f194.google.com ([209.85.213.194]:47047 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeBTTDt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:03:49 -0500
Received: by mail-yb0-f194.google.com with SMTP id z7-v6so4311594ybz.13
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4WfBNh9onznIl+Kzq9q9yE0PZ7p4RFOv/KSUh8nCpoI=;
        b=L6zAWJh0SQHSRCGAD3nUuPbosn3C0fMYKuEFRwnBsKiKEo3y59dPh+8ir30s7pmsGI
         LThCU4Vc5rAZJFM2oZA04xURvQ3A97avu7/YwiBou0wflvYdksscSa6H/MfswJ4CmDna
         QOc6IyosGIe10L67szfRQU0KIpzDASiGzULHT9dcXjUxRJwtaSTk8dTphrItq0i0sc1G
         RHC+nW1xCh+GGe6FsNIC6KU0cgBm81vwt8Ap6Qlzc8n7z2HRBLzLRf5LtF9MGDgj6IEV
         tNdwWfHgQfnznhx/H/WCOQAtFp1tuP3IwLH7w9dNcA8O9pCM5E7Egpd1mfl6uEgnm4en
         /3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4WfBNh9onznIl+Kzq9q9yE0PZ7p4RFOv/KSUh8nCpoI=;
        b=SlBen0SDBsWBH3dTFijX5U8EXFBwCEWbRIUaKH34HNcQBp8QQ1Q5w8dt/DREDToyCm
         qQf/Gt5Zb5pvYvDJutWjxzAmoVm+YsM1r3vcjSZoQwvNWCRTymZX9llJ4q/zZ2mwfBiz
         CePGN+jKYVEaeu6mSc1VeFsugAOi7RtL6ppsgmZD1TNHdB8ex8JuZ7XzakK0sMfqBR0V
         j1TWz6ufPrwxDZwhPajgIvxUGsDenAu58mGxlWqv7mtzdb4Oo7h1nmzhHvYeYHDHvcoG
         Zx+VP0sZsKb/doQJyXcRF9HnDQ8GhrDcBukJN0fahYHeBLdM/TjHjj7+9ydGF8RGV+Az
         woiA==
X-Gm-Message-State: APf1xPDlZCLTAVnnW4TChiLcwjsFb9oqSi/3dmb+ebRBAcv71+JA4Oog
        oL1qcRraU167dAgu6gmk0zADaEoU52ppfQoaaAlmUQ==
X-Google-Smtp-Source: AH8x225XdnpLx6n4/czi1vlQt/N6JJI+hvrOlH6kUyQcYC3DzGNWykxoE2yXjLZXG7FFVRPFqF7xPAtpENMlDhQha90=
X-Received: by 2002:a25:b087:: with SMTP id f7-v6mr579537ybj.247.1519153428676;
 Tue, 20 Feb 2018 11:03:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 20 Feb 2018 11:03:48
 -0800 (PST)
In-Reply-To: <20180220190009.GA201604@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com> <20180216174626.24677-1-sbeller@google.com>
 <20180216223404.GD216564@aiede.svl.corp.google.com> <CAGZ79kafB8JZ0hz4ZbjSpkA2j2AOWjFjoxcQ3e9KcovLp1tzxw@mail.gmail.com>
 <20180220190009.GA201604@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Feb 2018 11:03:48 -0800
Message-ID: <CAGZ79kZaDieXu+O6zA1W1pciMqa5_enjNXr9MOuzn=3oDSoU-w@mail.gmail.com>
Subject: Re: [PATCHv2 00/16] Moving global state into the repository object
 (part 1)
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 11:00 AM, Brandon Williams <bmwill@google.com> wrote:
> On 02/20, Stefan Beller wrote:
>> On Fri, Feb 16, 2018 at 2:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> > Hi,
>> >
>> > Stefan Beller wrote:
>> >
>> >> v2:
>> >> * duplicated the 'ignore_env' bit into the object store as well
>> >> * the #define trick no longer works as we do not have a "the_objectstore" global,
>> >>   which means there is just one patch per function that is converted.
>> >>   As this follows the same structure of the previous series, I am still confident
>> >>   there is no hidden dependencies to globals outside the object store in these
>> >>   converted functions.
>> >> * rebased on top of current master, resolving the merge conflicts.
>> >>   I think I used the list.h APIs right, but please double check.
>> >
>> > For what it's worth, I think I prefer v1.  I put some comments on why
>> > on patch 0 of v1 and would be interested in your thoughts on them
>> > (e.g. as a reply to that).  I also think that even if we want to
>> > switch to a style that passes around object_store separately from
>> > repository, it is easier to do the migration in two steps: first get
>> > rid of hidden dependencies on the_repository, then do the (simpler)
>> > automatic migration from
>> >
>> >  f(the_repository)
>> >
>> > to
>> >
>> >  f(the_repository->object_store)
>> >
>> > *afterwards*.
>> >
>> > Thoughts?
>>
>> I would prefer to not spend more time on these conversions.
>> If Duy and you would come to a conclusion to either pick this
>> or the previous version I would be happy.
>>
>> I do not see the benefit in splitting up the series even further and
>> do this multistep f(repo) -> f(object store), as the cost in potential
>> merge conflicts is too high. Note that brian just sent another object
>> id conversion series, also touching sha1_file.c, which I am sure will
>> produce merge conflicts for Junio.
>>
>> For the next part 2 and onwards I'd be happy to take either this
>> strategy or Duys strategy as requested.
>
> I think Jonathan is trying to point out that converting to f(repo) maybe
> easier than converting to f(repo->object_store) upfront

I agree.

> which would make
> it easier to write the patches (which most of them are already written)

true, but for this series we also have the conversion to f(object_store)
written already.

> and to review because you can use the #define trick to make some sort of
> guarantees.

That is true, so it would be a tradeoff between reviewers and maintainers time?

> After we have successfully completed the migration to f(repo), then we
> can revisit the subsystems which want to have a clearer abstraction
> layer and make the jump to f(repo->object_store).

I would think we can take this series as-is and then move on with making
f(repo) abstractions, eventually moving to f(specialized-subsystem) as those
patches are not written yet (neither direct conversions, nor the repo trick;
the patches I already have need adaption which takes enough time on its own.)


>
> --
> Brandon Williams
