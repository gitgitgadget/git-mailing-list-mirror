Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D5E1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 23:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbeFAXPr (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 19:15:47 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:51379 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeFAXPq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 19:15:46 -0400
Received: by mail-wm0-f44.google.com with SMTP id r15-v6so5633305wmc.1
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dj9ocsRfjbFe0n9uneR5oNcnUaIvW7kQxYIWqz1oaRg=;
        b=TfypDA6O407lovzjTulWnaJzjL2pWUxvdpLzDVsYhAX+IUi7g9E713OUYrIw0bFGO5
         X/l8YdpMIm2BtXhqwsm4No7wfrdub778zHDILRsoE1y2YpoNXVU6P6WW+aMd0m1ZOrwl
         TM8HDYujR9WeJnov9m3pUfsrS9HqfQ5L3NK1xK3aQPz/057HWvlsXpoJ5V2ZZCD4bN0o
         FrZUQaKmq6jehrBirOWlG5W5JG7Su5y9neXZlneLW+T4qNEU9A8Oyj+BCEe4d7l3wgUD
         BLD3OH5plfalnlpETdOdxc0mEGaS9Qn/FsJcsyg8BD5jdYn0GeYQWUXkd/E24DHdVTPW
         1lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dj9ocsRfjbFe0n9uneR5oNcnUaIvW7kQxYIWqz1oaRg=;
        b=qHgefEYeWjyVohO9g3O+b5rniG64+HsVppD27aFlqRHdvhinaieLNRcFRh93Do2AD9
         x1zYPRPIdB8rO+v2/JEB2oqAt9E77DO5WNaca3Ri2sQlUxFtSctwmHwxmOZcm/QKx01k
         UxL4QdoSWT9cnTVgXzsNaCqd/uw+Fd7TKPelfI2RJg5jfbs7MUEE0JzZ8ejp1L9CZMYk
         VFBMV6f9EiRMtPHYRyB9M0EeqYarUIO6ZZuYDjonU8jlcrl2zHmldMPccz6ZmZoSZNvH
         s3WwfVtHeVUwrGk2ScFCBtW8H7UaymKMEr1CNhDOYu2Eeae7mKXuFbRC9dJYiPYLavCZ
         J8ug==
X-Gm-Message-State: APt69E0GwEPnD5Ut1diFB69QrhtZE26I2zuOraWJ6TTi8khd15pEM+2f
        IDHksVRUHNA/L0hlCCRnsHc=
X-Google-Smtp-Source: ADUXVKJ/l3Ruclrw5GWCnrMjXyVZhqh3PzBFVhzQzAUaqTS1fUU82gZimPg4mYFDh81y+f43Bgcfpg==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73-v6mr191533wme.141.1527894945036;
        Fri, 01 Jun 2018 16:15:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o12-v6sm58168827wrf.30.2018.06.01.16.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 16:15:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/generation-numbers (was Re: What's cooking in git.git (Jun 2018, #01; Fri, 1))
References: <xmqqa7sf7yzs.fsf@gitster-ct.c.googlers.com>
        <4a7c6695-52cf-46a1-5a21-bf2e03a85f6b@gmail.com>
Date:   Sat, 02 Jun 2018 08:15:43 +0900
In-Reply-To: <4a7c6695-52cf-46a1-5a21-bf2e03a85f6b@gmail.com> (Derrick
        Stolee's message of "Fri, 1 Jun 2018 07:39:45 -0400")
Message-ID: <xmqqy3fy6qu8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
>>   A recently added "commit-graph" datafile has learned to store
>>   pre-computed generation numbers to speed up the decisions to stop
>>   history traversal.
>>
>>   Will cook in 'next'.
>
> On Wednesday, these were marked as "Will merge to 'master'" What changed?

Nothing has changed.  "Will merge to 'master'" means "This is now in
'next', and unless there is some blocking breakage found, this topic
will be merged to 'master' eventually".  It does not even say if
that eventuality is before or after the release the current cycle is
working towards.

When it comes near pre-release feature freeze, things in 'next' need
to be sifted into various bins, and their labels are updated.  The
ones that are too big to be comfortably merged to the upcoming
release after -rc0 has passed (i.e. biggies are better merged early
to the 'master' in the cycle to give it full cycle of larger
exposure) will be kept in 'next' so that it can go first after the
final, the ones that are low risk but with higher importance will be
merged to 'master' before the release, the ones that are trivial,
distracting and lower value (i.e.  the ones that force i18n teams
extra work) may be held in 'next', and the ones that deserve a
chance to freshly restart are marked to be kicked back to 'pu'.
Etc. etc.

