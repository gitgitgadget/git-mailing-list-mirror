Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D5F20954
	for <e@80x24.org>; Fri,  1 Dec 2017 18:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbdLASYv (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 13:24:51 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:33600 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdLASYu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 13:24:50 -0500
Received: by mail-io0-f169.google.com with SMTP id t196so12224641iof.0
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 10:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EIXYBbuwxngSLjpmyVUAQxS81L5g9ukCMvWPPOOqAwQ=;
        b=jHLcKe8DjztAEGhR5Lp36S57pl9A58n0MNOGHKstCyhFk3e0z9intlIQ7eO+i9kblI
         810qRbm5H6KKtaT0ptA+9Hn/vgL7TCG1nmTCfXK6hYnNPTUKrvQXOjAIkG40Pix0HQSs
         aBhg8eZrbNTVyreEvDPMajOH9LgZwLhKqksotNGhEyIunYjaJT6ZZiRKjGO6sITfJldu
         ktM6fyHXjfI5jvBUhL5xCmzSz+tJmOqkFg474YJ+GBFiqEYKTz7obiiyJdUvJB5IiCDs
         h4Q3exrunj8qR15NHXldmEIuw4GCXFGtir3aQtDPc7Qjp6KydjFBEsLGVCXPqpeKbe0Z
         nueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EIXYBbuwxngSLjpmyVUAQxS81L5g9ukCMvWPPOOqAwQ=;
        b=JFbSeWGBGhKFRLfs6zXgJhvyLwAjtIBGVlPZmM4gm9hvut7GBDKN6LhjEfPXDBgBkB
         ygxReEiMWGOKSPsLLkolaVxOutO154UKutlvTCRnJPPeVSaEbzNArn0cuede85sViDcd
         vT1C9XlbEvt3Qn4ZoxvCoauYAb86O2b3WHZ+3QDgoHQ9gKEgusVBjC4G3ufdqU2PNB/H
         xgbYgybA8uQMvRYHIO+F3k2xWhM8K9c3qjKvpVAD21dgNhkF5P/KUbO2bRTXukrOZNRb
         UMY2i2SZ5AEp3c59FcZR0OoKXcWGplc4f1FlNMWvkzpwcPzVN8QJYYtMvyuN8CqfuRHO
         LUjA==
X-Gm-Message-State: AJaThX5aftiUprJ/zYThimOFpZuEj4SJiU0MWqivjZjHBmRhUGv93rKe
        yqXanuSbDhRbscL/TF2Z6DY=
X-Google-Smtp-Source: AGs4zMYLcb0I0MQFoqK0EijZg39FqKF8yY7Qv4ZmcBkoZW1awb10k2np58V71UMGVcnpiF7jbRpSNg==
X-Received: by 10.107.192.7 with SMTP id q7mr3239229iof.89.1512152689223;
        Fri, 01 Dec 2017 10:24:49 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v65sm823146itb.30.2017.12.01.10.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Dec 2017 10:24:48 -0800 (PST)
Date:   Fri, 1 Dec 2017 10:24:46 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Vitaly Arbuzov <vit@uber.com>, Git List <git@vger.kernel.org>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
Message-ID: <20171201182446.GB18220@aiede.mtv.corp.google.com>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley>
 <0e851e08-0dcc-da3b-b2c4-42afcdbf6ca4@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e851e08-0dcc-da3b-b2c4-42afcdbf6ca4@jeffhostetler.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler wrote:
> On 11/30/2017 6:43 PM, Philip Oakley wrote:

>> The 'companies' problem is that it tends to force a client-server, always-on
>> on-line mentality. I'm also wanting the original DVCS off-line capability to
>> still be available, with _user_ control, in a generic sense, of what they
>> have locally available (including files/directories they have not yet looked
>> at, but expect to have. IIUC Jeff's work is that on-line view, without the
>> off-line capability.
>>
>> I'd commented early in the series at [1,2,3].
>
> Yes, this does tend to lead towards an always-online mentality.
> However, there are 2 parts:
> [a] dynamic object fetching for missing objects, such as during a
>     random command like diff or blame or merge.  We need this
>     regardless of usage -- because we can't always predict (or
>     dry-run) every command the user might run in advance.
> [b] batch fetch mode, such as using partial-fetch to match your
>     sparse-checkout so that you always have the blobs of interest
>     to you.  And assuming you don't wander outside of this subset
>     of the tree, you should be able to work offline as usual.
> If you can work within the confines of [b], you wouldn't need to
> always be online.

Just to amplify this: for our internal use we care a lot about
disconnected usage working.  So it is not like we have forgotten about
this use case.

> We might also add a part [c] with explicit commands to back-fill or
> alter your incomplete view of the ODB

Agreed, this will be a nice thing to add.

[...]
>> At its core, my idea was to use the object store to hold markers for the
>> 'not yet fetched' objects (mainly trees and blobs). These would be in a
>> known fixed format, and have the same effect (conceptually) as the
>> sub-module markers - they _confirm_ the oid, yet say 'not here, try
>> elsewhere'.
>
> We do have something like this.  Jonathan can explain better than I, but
> basically, we denote possibly incomplete packfiles from partial clones
> and fetches as "promisor" and have special rules in the code to assert
> that a missing blob referenced from a "promisor" packfile is OK and can
> be fetched later if necessary from the "promising" remote.
>
> The main problem with markers or other lists of missing objects is
> that it has scale problems for large repos.

Any chance that we can get a design doc in Documentation/technical/
giving an overview of the design, with a brief "alternatives
considered" section describing this kind of thing?

E.g. some of the earlier descriptions like
 https://public-inbox.org/git/20170915134343.3814dc38@twelve2.svl.corp.google.com/
 https://public-inbox.org/git/cover.1506714999.git.jonathantanmy@google.com/
 https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
may help as a starting point.

Thanks,
Jonathan
