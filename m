Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83AF61F42D
	for <e@80x24.org>; Wed, 30 May 2018 22:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932401AbeE3WTf (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 18:19:35 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:42119 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753617AbeE3WTe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 18:19:34 -0400
Received: by mail-yb0-f193.google.com with SMTP id d123-v6so6919423ybh.9
        for <git@vger.kernel.org>; Wed, 30 May 2018 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GCG1vJUaQEu+2iLRVq017BEFXsZY7y8FhTTz8045C2c=;
        b=jIcfTXVfJNJ+0LcWZr2VpfxVjmi/NrV4AIJuUNUE82KxF0F113ZenMAKHgUi8UptMs
         GUDBL8Y+AW9Wo1qvya4zzkoZ4KQM8Mpa6EI4ZtEimnyphod1Ee40sjyCr077d6Cdct/N
         bQgRazTVQ+dI31Kb3ButDDDfs0cWr1UTqKOQsXPsrA5GRqU5w3rwi8SXTWT/UWIXEiNL
         RovHIu7r1I6zfJ/ZyyWa1bwf6Mkxi59ik6bdjy1br1kswRk7v/2CbQSRLXS4XvBa6Lgt
         a3wexn14PCJb/2fKFtvwFZFC8yH+aGFZ8HMZDPeVPRJz3wX6eh+Ci/rbPWmcDVBoVkCn
         mvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GCG1vJUaQEu+2iLRVq017BEFXsZY7y8FhTTz8045C2c=;
        b=JVsfPy2UkaTMekBXa4jZU/2FIdcnKu3s/1pC+mgTzOE2Of3QSe7UVOy3WaJ6XbhE5C
         RYkpUmYSpAm+N6K9ZpnNSDdbxVlZbsHpMuwBx1tislioXWccmF7Jj8zJWPjlJ0EAaWms
         ZIOIJ0Ab1xRG6Km60QGEgBcPIFA3L9NIkVpfBbtEbF3q/UNCQtPk6dcz0EcRXmPDV2MN
         CDRxKJmEsK2iUod1BHIo7zBcuFrODulV80glHX75uaixBbHlBGk4H1OovDNqmdoujV/X
         1B8FDdHko16/3Vc/poVQreZJhR5Pl0VmUNxIHJ7dbXkHHjMKf3UIODPaHf/qbLADtDIA
         uEww==
X-Gm-Message-State: ALKqPwdxJYyfVytG8r1li3Y7viDw9MBha15zhSB0b5bQQyvtID6c/pci
        D6i7K5rjBfpoqutkxGqhyQlmW6SvJNZfjaaXoblqQA==
X-Google-Smtp-Source: ADUXVKJOUJVuHXPi1iBskaqRIniIq+IbW2LG8MUzh0qkHXvzc+YUqSsnR79JO+xxWzpUajfQfhChvSU+rwKWNW91CYY=
X-Received: by 2002:a25:dfca:: with SMTP id w193-v6mr2602956ybg.334.1527718773689;
 Wed, 30 May 2018 15:19:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 15:19:33 -0700 (PDT)
In-Reply-To: <6e18e6bb-cc11-a1b4-becb-4115df124284@gmail.com>
References: <20180530004810.30076-1-sbeller@google.com> <627c65a9-d807-8912-b96d-ef7feecb9ea4@gmail.com>
 <CAGZ79kaEHhE=suT2-Rzrbu2P7z8KPzRdCOFNCTqsOiV0+HjJ9A@mail.gmail.com> <6e18e6bb-cc11-a1b4-becb-4115df124284@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 15:19:33 -0700
Message-ID: <CAGZ79kaaObh50ff1fT3no=jsHde+ZyacKtgbFa8ht__Hg4SDsg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/35] object-store: lookup_commit
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> I went through the whole series and didn't find any issue with the code. The
> commit messages reference coccinelle scripts that I never saw, so those
> should be struck from the messages.

I fixed this locally. I'll wait for more reviews to resend though.

>
> If anyone else plans to review, these two commits are worth special
> attention compared to the others:
>
> [PATCH 27/35] commit-slabs: remove realloc counter outside of slab struct
> [PATCH 28/35] commit.c: migrate the commit buffer to the parsed object store

Thanks for pointing these out! patch 27 might even go on top of
nd/commit-slab-to-util.
