Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BABAB1F424
	for <e@80x24.org>; Wed,  9 May 2018 16:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933564AbeEIQIK (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 12:08:10 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:32889 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933409AbeEIQIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 12:08:09 -0400
Received: by mail-ot0-f171.google.com with SMTP id l22-v6so40776310otj.0
        for <git@vger.kernel.org>; Wed, 09 May 2018 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fNub/wDCijh/+Z3CtgJwGs6yX4ukY3H+vSMPiH/W704=;
        b=U3c3KF6BC0EUauZfj/IwhHmTCj4xrhE8fDSqeG8CklNkgZo9zrCfbHjNMofE7Uz2eV
         IgeQC+rxrkvsQcoZhI+eTjKoUtikCFQEe9uMARKh7y3B1ne+SPrko6TlX7UyZdzU3UQd
         ezOFkwKfjHjI01621gBZBHaI3C5ytqSqndHxrhflv5UM6OXo7cFfs/wGmMqAjD6sTMtI
         oruFwlihaqec7yy4svoF1KJKmDqC5VVqeXObkH/035CaGR+/Jn1fa3LYe/0k5qtnvAts
         8lPzibjpPCe+95v0+MNGMPG2cE7kfoAUJ0m2birm+ctKJhnlRiQPFFpfaUY/GXQ4KpvM
         AMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fNub/wDCijh/+Z3CtgJwGs6yX4ukY3H+vSMPiH/W704=;
        b=AZ5ovYCBhijxe1e4aamko+1it7C1knutd5q0YvdPPqUeWCPkoWHqaPrwMDj/2XXM+I
         nD9mpWUzPrecK36g3Ok+EPumFe3GrjnjUPysrZWZlD7a70i3vhNDlawt761z2lCDD8qF
         Y/WJcM2Bu01VB+mCGwaLAM4iQJ4zA/jqNz5olYqsWKUs+PI36XjZ/dh9qsAUNBuPmgPo
         85M9QDfPSyCafoQvkFbkdr9+/rqhnXb/AsXo1Ui2y+6D+gRZLmM7TRmx7gt0duEVC28J
         gt1+tCocH8Nfts8eRG54rYmk/PW40hciuv6w0TKgdLPEaWDLWQ0upbooAnXvJK/a977j
         hojA==
X-Gm-Message-State: ALQs6tCTcR9dwvHiWnmmxKX1gtsOHAysw/TiCriUp4/pwqQjbkee+n08
        6xszL0LKzE3FJmefFOMAiw8A/kC7TvqE56YSBFA=
X-Google-Smtp-Source: AB8JxZpGi4bQeGGYvUATwYdnUf/LNhqCm1lNq1/ywkaV9wt6ThJQybGhIyPiIEb0bHGHmIRr16ROb0kE7NVDJsnoZeo=
X-Received: by 2002:a9d:2995:: with SMTP id n21-v6mr34880043otb.152.1525882088875;
 Wed, 09 May 2018 09:08:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 9 May 2018 09:07:38 -0700 (PDT)
In-Reply-To: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 May 2018 18:07:38 +0200
Message-ID: <CACsJy8De1U6FbdMi4yF_AF2OYGrhF8qLO1ZAJ1PK37p8yv0m0g@mail.gmail.com>
Subject: Re: Implementing reftable in Git
To:     Christian Couder <christian.couder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 4:33 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> I might start working on implementing reftable in Git soon.

Adding Michael Haggerty who did lots of work on ref stuff. He probably
can give a few suggestions.

You probably should also look at the last attempt to add lmdb as a new
ref backend. I'm not sure why it's still not in, maybe it wasn't the
right time (e.g. infrastructure was not ready).

> During the last Git Merge conference last March Stefan talked about
> reftable. In Alex Vandiver's notes [1] it is asked that people
> announce it on the list when they start working on it, and it appears
> that there is a reference implementation in JGit.
>
> Looking it up, there is indeed some documentation [2], code [3], tests
> [4] and other related stuff [5] in the JGit repo. It looks like the
> JGit repo and the reftable code there are licensed under the Eclipse
> Distribution License - v 1.0 [7] which is very similar to the 3-Clause
> BSD License also called Modified BSD License which is GPL compatible
> according to gnu.org [9]. So from a quick look it appears that I
> should be able to port the JGit to Git if I just keep the copyright
> and license header comments in all the related files.
>
> So I think the most straightforward and compatible way to do it would
> be to port the JGit implementation.
>
> Thanks in advance for any suggestion or comment about this.
>
> Reftable was first described by Shawn and then discussed last July on
> the list [6].
>
> My work on this would be sponsored by Booking.com.
>
> Thanks,
> Christian.
>
> [1] https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/
>
> [2] https://github.com/eclipse/jgit/blob/master/Documentation/technical/reftable.md
>
> [3] https://github.com/eclipse/jgit/tree/master/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/reftable
>
> [4] https://github.com/eclipse/jgit/tree/master/org.eclipse.jgit.test/tst/org/eclipse/jgit/internal/storage/reftable
>
> [5] https://github.com/eclipse/jgit/tree/master/org.eclipse.jgit.pgm/src/org/eclipse/jgit/pgm/debug
>
> [6] https://public-inbox.org/git/CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com/
>
> [7] http://www.eclipse.org/org/documents/edl-v10.php
>
> [8] https://opensource.org/licenses/BSD-3-Clause
>
> [9] https://www.gnu.org/licenses/license-list.en.html#ModifiedBSD
-- 
Duy
