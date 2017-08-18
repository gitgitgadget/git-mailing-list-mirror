Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A7E20899
	for <e@80x24.org>; Fri, 18 Aug 2017 00:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbdHRAwy (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 20:52:54 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:37739 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbdHRAwx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 20:52:53 -0400
Received: by mail-vk0-f49.google.com with SMTP id r199so27841510vke.4
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=igygTyxNefqH4rw3qjgbhLv2BwERNXIXFwOAnO7AFVY=;
        b=c9yP7I1vbjiq74FK7o+Oc4b/fimzzP9F0l5GJsNk6D3krjQ+Zr2uEB7gC9OsLl3YDZ
         OQ4QNzTipolfm6olDgvFRJ8V4HRfjFAdwip884sPZDLGf/F30MeVnCvAgMh3luhgajoI
         kUtFv64ejhavOwpfOBCL/zZCt8b1NY0K4k1T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=igygTyxNefqH4rw3qjgbhLv2BwERNXIXFwOAnO7AFVY=;
        b=mRdj+DUGZcsSK7g2CxiC8FQl6Muo2s3QO5/3VxrGoNDB/ZTRjvQ/8nnKN3mzwMbIr1
         OcvxIgrit9waMDWRGsprKhn2gfRYwAagKs/y8EH91rLEHbEZaC67+umV+FbsVdsLUsYB
         bd3iAJD4+3ePNpxP2KtAeVzOx/WhWm3j43EXoDcoq0RFY8HQQ9iGAFwWgrgg8mcknCr/
         QBjBquNhXthcsCMY0qPJEAyN+nkFMRFFzyf9bJet2YAS31fd7KdqL0LKirO/ZUGzD4LZ
         eLh5Lpz+ZT4I/OZu0p8WSJ+0Y3NyVwQ184mZo9DUdqOZSk0A8pR3E4Y0VQ2BRQvHERWr
         uK6A==
X-Gm-Message-State: AHYfb5gsbRDCdMecYam158sc77MLTfJ8JuS2wR/G50Sn/seUl3VRr32E
        xQHCkoh9uQ9b3BVQpCRUKWEAQw+IVh1s0LM=
X-Received: by 10.31.21.69 with SMTP id 66mr1277508vkv.102.1503017572291; Thu,
 17 Aug 2017 17:52:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Thu, 17 Aug 2017 17:52:31 -0700 (PDT)
In-Reply-To: <CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com>
References: <CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Thu, 17 Aug 2017 17:52:31 -0700
Message-ID: <CAJo=hJtQa5Yo8Fcy4Yn1tFLG6Ydy846J5pzLt8sF0y_1GGb32g@mail.gmail.com>
Subject: Re: reftable [v7]: new ref storage format
To:     git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 7:48 PM, Shawn Pearce <spearce@spearce.org> wrote:
> 7th iteration of the reftable storage format.
>
> You can read a rendered version of this here:
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md

FYI, JGit has adopted this v7 draft as version 1 of the reftable
format. The file reader/writer implementations will be in the next
version of JGit. Transaction support in the $GIT_DIR layout still
needs to be implemented.
