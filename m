Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467461F461
	for <e@80x24.org>; Tue,  9 Jul 2019 20:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfGIUvw (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 16:51:52 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:36869 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfGIUvw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 16:51:52 -0400
Received: by mail-io1-f41.google.com with SMTP id q22so24338356iog.4
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 13:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRDo5kykJWyqQPNlAx1HNkoFIeizvwaghtbk+Wqx+Vo=;
        b=q1VxN7Ka1l73hTp6dLc/UMoT3BHBdrZqFipAlvB2uiveN6p3j5pWX3Nh82tsPRTrtL
         XauJtCN0AJuJRd4/DIDjRqKYZvyAZMv4eioZlxNQm7vNiuJxqtW4TurF1jqhj7CrWQjf
         zbF8YeINXQR5siMFPtdSNDKfCM/9x/KCyrTCG/MqUjCUkdKkNDd1Ux7SPSeOIkaC/p8d
         YCaO64qlHkIepakhCai76mGlQMTBggVHG9ey4oYgMKnxHnOcRUAxgrVsQ2D0lEFoDcFj
         2xYBRKrwxGpZkSm9qbN1eJx/cgouGCxMH0hfSbzdNygqVJtlI0HqLugjszcLi/3iiouU
         m5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRDo5kykJWyqQPNlAx1HNkoFIeizvwaghtbk+Wqx+Vo=;
        b=TC5VpAlRjWKpoeepj5KqMews/XwEAURqaiS8EDhJGdv8DovSCQqNP+2a64P3FBC2yc
         Nf/ugEnkyWM4w2r08jwG6+mBxDdA2o21m3ui7lvjSofZbOMYlbRH89J2eNSkAUW5EOwD
         2Rn5qIEivMGIEwn68WYvbY931UcIwaLAAikaM9d6tCWuHa4tsWhUIqahGwlIeQY1K4zp
         yuy3DQvObDvRXclUyK65nTZmwJhbbygrf2Jj3YG6CKGAwJY2WWvJsYL9GNjZJVKO8f10
         qUuo37u149E9tc+AQXwXmSyztVh74p3AClku/7g2F3QZjAXV2sQxJsq4rPVZfwXD4Cl8
         G9Ug==
X-Gm-Message-State: APjAAAXczHSGFizCUL4MCkUc2LXlc2IiNY2gQgZb+da+tHmGxA0ZZCp3
        NhiX+9/6olhaO8uJiWBbM6QZ1m62mtjF/SkDrskQFg==
X-Google-Smtp-Source: APXvYqzhElS3yti0dZAKj3INJCZ9QpgG2/k8spgx2/SQFCw6d2rczfRfDk5ESB1yid1zHwdxj6smE2SZmrhjpi8VH1U=
X-Received: by 2002:a02:cc8f:: with SMTP id s15mr29760852jap.94.1562705510798;
 Tue, 09 Jul 2019 13:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <423596682.8516.1562665372094@office.mailbox.org>
 <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com> <1152121968.7459.1562688927235@office.mailbox.org>
 <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
 <275487563.12198.1562691633735@office.mailbox.org> <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
In-Reply-To: <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 9 Jul 2019 13:51:39 -0700
Message-ID: <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
To:     Elijah Newren <newren@gmail.com>
Cc:     usbuser@mailbox.org, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 9, 2019 at 1:33 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Jul 9, 2019 at 10:00 AM <usbuser@mailbox.org> wrote:
> >
> > Additionally I would also want to change the wording for --ff-only, as it currently reads as if it only performs a check (which would lead to the expected behaviour) but does more than that, as it prevents "real merges" altogether.
>
> You've lost me again, I think.  You expect --ff-only to only perform a
> check, i.e. to not update anything and thus only report on whether a
> fast-forward would be possible, but leave the branch exactly where it
> started no matter what?
>
> Or is it just still not clear that a fast forward by definition is not
> "a real merge", i.e. it means to update using a mechanism that doesn't
> involve creating any new commits?

I think this is something I've seen come up on the list before[1]
(Roland can correct me if I'm wrong). What I've seen asked for before
is the ability to pass the combination "--ff-only --no-ff" and have
that:
* Ensure the branch to be merged is fast-forward from the current
branch (i.e., to ensure no merge commit is actually necessary), but
* Create a redundant merge commit anyway

This retains the ancestry (as in, it shows where the branches were
merged), but the merge is always effectively a no-op (no risk of
unintended interactions, the sort of subtle breakages where the merge
succeeds but the code on each "side" isn't entirely compatible,
resulting in broken compilation and/or tests and/or runtime).

Best regards,
Bryan Turner

[1] https://public-inbox.org/git/CAP4gbxqjHzqHhPuNK8UOwPMa46g2=vcNSk1AvGjxN8s+ou-0Dw@mail.gmail.com/
