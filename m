Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 948241F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 17:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbfJOR4P (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 13:56:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42536 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbfJOR4P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 13:56:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so15193421lfg.9
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImpyGEGAqcY9KrXbvIo21/wU3RNyiy9s7D1M0u/e1lk=;
        b=LSJyGy3syTbi8ZKUI2bHfd4Aqqoz1+gjS7f8ieN77J55CH0SFrq2d2ygz7I6AgohaC
         li6wkYUE1wyrCWYh0b7QDZuuLHRmqwMDNk9EghBmBxjaWtTOc0GsKOxp+9rSnIG0Ln6T
         8VXNJePY42dxdDWmmHU7VsCRLRPOsKbk1iS9ChEERnmOAV4SaCz+6sVL9fBTzrnD+kdz
         6yeZU+NSZ6HusnM/yBKxr4DmWxlyzSBOiqE1Zq4CDJU3gS/AE7VgFSbAsiGxL4jJATwG
         ayDMbuRGdx8sf2I1r1ymKo09XvVHxxl30HY+Jh5bvYBVzVFJaYGsVFnvv8az+FGM88E9
         PbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImpyGEGAqcY9KrXbvIo21/wU3RNyiy9s7D1M0u/e1lk=;
        b=taiaMoVve07IhPsPQiFK6SynxpoX34EkFYH/GEqyH9r8s3xOeQDczDuV7UM5XNKppU
         GRGc+L9QyyR5izK+XL0InQCuTVKG0tjVI66ByAAitYBtw5pa3BpCEACY8qrjY5DuCf0T
         8AtKopgZFMmL0VD59avgCgakrSMz8gTEY4Gi2fuZDoMSx9WYyvLXCGpwdKvEKVJe2isG
         fStndMsSCjjJ0oJNM7RuwP5Dfe7Rrok8uZeXveiurkJrfzxlu9cUjvrQdMEw25Gyomb6
         8bXpibgLs+VGGZekUjzjslNa7U7g6XLeu+EDPP2mhME74jKcjSKEHh746Y7j8KstQTJV
         6JuQ==
X-Gm-Message-State: APjAAAXPIZ9tplS2G6nN6+tdFbU7rEZac5kgQUCbuhpUTMj2adNopajC
        QicJDBI6f3a+9tSSWT6S412OiezAnzBVQf9nb4QWvw==
X-Google-Smtp-Source: APXvYqw5lQzJuQqgg22XUvKLYZe+VRs7d1NKRoJhS1CzVJI7AWkoNJbFFnKQt4tQegAs+CkD4eB8iS6xYIQ7ceDk61s=
X-Received: by 2002:ac2:5305:: with SMTP id c5mr22400659lfh.136.1571162172036;
 Tue, 15 Oct 2019 10:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571089481.git.wink@saville.com> <d47c5de5fc812b1fbd04bb259a522e453d4b21e2.1571089481.git.wink@saville.com>
 <xmqq4l0ad7vn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l0ad7vn.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Tue, 15 Oct 2019 10:56:00 -0700
Message-ID: <CAKk8isq0W86ONoEMxh7kiik75qeOxvznh2j1-91GEehZQDzRrA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Teach remote add the --prefix-tags option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In short, if you truly want to see "separate hierarchy per remote",
> you should consider how you can reliably implement an equivalent of
> "git branch --list --remote"; a design that does not allow it is a
> failure.
>
> A better solution with longer lifetime would probably be to use
>
>         refs/remotes/$remoteName/{heads,tags,...}/
>
> when core.useTotallySeparateRemote configuration exists (and
> eventually at Git 3.0 make the layout the default).  It would
> involve changes in the refname look-up rules, but it would not have
> to pollute refs/ namespace like the refs/remoteTags/ half-ground
> design, which would require us to add refs/remoteNotes/ and friends,
> who knows how many more we would end up having to support if we go
> that route.

I've used submodules a little bit and in some sense it seems to
already implement
core.useTotallySeparateRemote. So from my perspective trying to make this change
significantly different this isn't worth the effort and I'm not sure I
have the expertise
to do it well.

Is there a roadmap and or timeline for Git 3.0?
