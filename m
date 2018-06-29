Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2880C1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 18:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755396AbeF2Sij (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 14:38:39 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39466 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752683AbeF2Sii (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 14:38:38 -0400
Received: by mail-yw0-f195.google.com with SMTP id 81-v6so3862986ywb.6
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DhEbTAS4/05rAK8Q2TJGjp37Q+CJdL8Jdf85rsZq68=;
        b=d0le0NbuLaniPeHq0uoEE/vxTN5fXcToP5dS7FijGtLUDiz4h+FnQHb6uSXxAk7CDA
         5tMesz4t+LhxuSQZEEhEZ4BzJDpI9DPwcI7iiaiUhyxXaMPXFqzJLGoV7re2qKimrDYd
         JMkLw1qfzcdFr2VdkgkvD4zPOnFajmzQePZXvkbOkSNKEf7gpj2QnvDTfEkjX82tcSD5
         agUU5z3U0umnnGF4ZS00jCOzPhgOwNOFAVbN7rNM7e7NCnsmaZPNT0wAID6SaYwp+oaJ
         0BK8eYiJ+ui03hMdzXJW6zKUiaNq/AZ3og48OvQfHfzToeAmRHP2PtnEr2quvOx2yaNq
         A90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DhEbTAS4/05rAK8Q2TJGjp37Q+CJdL8Jdf85rsZq68=;
        b=nmz5XoZ5n2gHOtHlHvz+aewztr+0euBS4MGzcWMed+eyagKyd7EuwkDtAAIpnhUpYF
         nTxeSBq6Rr/9QvaODS4vdDNjNJKfnvZRwgTqplEfRXhPUPL6JxyXEt4+k2v0OrCNofL3
         KzpRNCX7Q85jWT5kjq4UJ3SMv8Hn4ETFrNJP/dASXrzw+IhPh+CNl5Iek7Tkms66BafY
         dx849jpBvWW0h24EmyCF1fnT79L77PKixW3uyGtzPY2pdRxOLudIgUXnCAhfdjYW01Lo
         x1tFgkRyT5dnVTSL6rX1FKbOxgzUtlwz7M37XFrntILX2XfTjwdH9WLcx3ex2QlTQck9
         M4JQ==
X-Gm-Message-State: APt69E1IvAQBDJV+IDFeDF6leryreLVuXSOTNO5fpSmQvfgFlN5vPB5w
        So/n+9ZqCBtEYEmkyQjQJ8CyrbCpZX3uQAsH0VIEWA==
X-Google-Smtp-Source: AAOMgpfIUs8l6L8TVWt1oyZlDvNqPWL1olLUkj9vYIq061nXCyxe2uODUjgWg3S/opHx8ptkSCn16Q+G5LsxIl1Vhu0=
X-Received: by 2002:a81:3743:: with SMTP id e64-v6mr2788635ywa.340.1530297517272;
 Fri, 29 Jun 2018 11:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180629021050.187887-1-sbeller@google.com> <20180629021050.187887-3-sbeller@google.com>
 <xmqqh8llv690.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8llv690.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 11:38:26 -0700
Message-ID: <CAGZ79kbG29SbsR=+7qwM+++Jk+G2AWYswQY1tYJy2KMSCKr8FQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] .mailmap: map names with multiple emails to the same
 author identity
To:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 29, 2018 at 10:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > There are multiple author idents who have different email addresses, but
> > the same name; assume they are the same person, as the world of open source
> > is actually rather small.
>
> Thanks for an interesting experiment.  As with 2/3, I suspect that
> most of the contents in the patch may be correct, but I'd rather see
> these confirmed by those whose names appear in the patch.
>
> IOW, I would not feel comfortable applying a patch, unless it looks
> like this (just taking a single person as a random example),
> and I do not mind many such individual patches:

right, I did not quite expect this patch to be applied, though it looked
like such a sweet shortcut.

I might just email all of them and ask for them to update
their .mailmap entries.

Thanks,
Stefan

>     Subject: .mailmap: unify the same Ben Peart

cc'd Ben, so we could start here with a patch. :)

>     These multiple author identities in our history are actually the
>     same person.  Map them to the latest address.
>
>     Signed-off-by: Stefan Beller <sbeller@google.com>
>     Acked-by: Ben Peart <Ben.Peart@microsoft.com>
>     ---
>
>     diff --git a/.mailmap b/.mailmap
>     index ff96ef7401f..2607846582a 100644
>     --- a/.mailmap
>     +++ b/.mailmap
>     @@ -5,54 +5,86 @@
>      Amos Waterland <apw@debian.org> <apw@us.ibm.com>
>      Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
>      Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
>     +Ben Peart <Ben.Peart@microsoft.com> Ben Peart <benpeart@microsoft.com>
>     +Ben Peart <Ben.Peart@microsoft.com> Ben Peart <peartben@gmail.com>
>      Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
>      Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
>
> It may be even better if we can arraange the author of the patch to
> be the one who is involved, with "Helped-by: Stefan".

ok, I'll think how I can help but not write the code.

Thanks,
Stefan
