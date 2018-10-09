Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7ACE1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 00:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJIH23 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 03:28:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35236 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeJIH22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 03:28:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id y19-v6so89828edd.2
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 17:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qU39mFJNwWShj6dfDnT/owCOd3d+GCNOXQARJ7UP8No=;
        b=Mp9wYaSOsdwd7r/xCrtUEU485bMEm8o/TBKuqXjSXL10v1yIoEEKttDkGh4Y68ayd5
         Qq9C53Y/pU90/hvNw66MIneMZ4+/Gxzu3nXM4nUqXEAuibJvpT/gxOaEC20zh4L3nVfc
         N5TO3pYQBr1H4L/Zej/vuJhyN9q0uhodD2dMyEzLRt4mlbNg1kDJVchX4zK0P9U/Od2u
         XCYKbSTFcSAMdI5j6dhTdo7uYdKi3WXfNd/ATXPeFtvnlt48xQGDR7/GoKeN36UskdN7
         nybduZFuOrdez8ZewaCTXABlERvQq7ga+IVcPZaj1f2lrh1Mk8OCc1J59LuyKkFtye+T
         Nuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qU39mFJNwWShj6dfDnT/owCOd3d+GCNOXQARJ7UP8No=;
        b=GHht7fJDwlrznnPwun8LhIpLbSD6szaYWoC+dpqoijdvAfi1bfOM6nyYXQwhyvAW17
         8NOLKACcgaxQ1nlppNjPuRXt5ipa7qLNSK7JTRenmykydUV3K61MVZnmWxyuojqkTIPw
         whBKlWguSONR1/qrFiPatgYY3cBmzjA+A2NRhdBLTg4JDYCTWiPCOrtTSlOwdfxshSpa
         vd/D0xxmMEInQAI3u/lA9Rqr3GfKSqH3eOBfo+qV+cN1TBYnupXU1ptowQcYcn8+Dzk5
         e80/euRSY4rybNZkEL5SJoKOfAQLuZTWzSUdauBtpTLyERFqNPGzWG+aJUBvYAHPLSvh
         JjvQ==
X-Gm-Message-State: ABuFfoj3+YnKNIUc9sQ/U6VDd+qy1JNgv6cw4s7PB8nu/OVd2YxN9yRy
        jybQCYXr2hxOVR/kcAKenv1OceM+jssc6qndhA/Mvr9RZwF2GQ==
X-Google-Smtp-Source: ACcGV61HZkcJymnnMzPWzojS92NVu5JKOWoL3S1of3V3+k5Qui3NynV3XGmgE+MYPLm2ayUDGu3U2IRWUo3O2KcNvus=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr31631530eds.25.1539044052058;
 Mon, 08 Oct 2018 17:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181005224557.31420-1-sbeller@google.com> <xmqqh8hyvbnd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8hyvbnd.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Oct 2018 17:14:00 -0700
Message-ID: <CAGZ79kaxDch0qGWV612it+kLFhnfVhh+f_97kBf=KJFL-CJJOw@mail.gmail.com>
Subject: Re: [PATCH] builtin/grep.c: remote superflous submodule code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Antonio Ospite <ao2@ao2.it>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Well, submodule-config.c has its implementation and another caller,
> which technically is outside submodule.c ;-)

i.e. there is a typo in my commit message.
I meant to say submodule-config.c

>  repo_read_gitmodules
> has two more callers in unpack-trees.c these days, so perhaps we can
> do without this last paragraph.

Gah, looking at that code, did we have any reason to rush that series?
c.f. https://public-inbox.org/git/20170811171811.GC1472@book.hvoigt.net/


On Sat, Oct 6, 2018 at 5:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > After ff6f1f564c4 (submodule-config: lazy-load a repository's .gitmodules
> > file, 2017-08-03) this is no longer necessary, but that commit did not
> > cleanup the whole tree, but just show cased the new way how to deal with
> > submodules in ls-files.
>
> The log message of the above one singles out "grep" as a special
> case and explalins why it did not touch, by the way.  You probably
> need to explain the reason why "this is no longer necessary" a bit
> better than the above---as it stands, it is "ff6f1f564c4 said it
> still is necessary, I say it is not".

That is true.

For grep, the reason seems to be, that we check is_submodule_active
based off the index, i.e. using
   module = submodule_from_path(repo, &null_oid, path);
as the deciding factor, which falls in line with lazyloading.

However the use of the specialized gitmodules_config_oid
in grep is also guarded by the same commit ff6f1f564c4.

Going back to the use case of unpack-trees.c,
I think that we need to keep it there as alternatives
seem to be more complicated.

So I guess I'll just resend with a better commit message.

Thanks,
Stefan
