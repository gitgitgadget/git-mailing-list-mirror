Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4732D1FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 13:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbdDLNVn (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 09:21:43 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33206 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdDLNVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 09:21:41 -0400
Received: by mail-oi0-f50.google.com with SMTP id b187so30971151oif.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4hd8Uqqj7xreRP5SIcGVcjD9Ew8nHpHTUx1LOu0EYN8=;
        b=CtCpnRreSlAZL5G09XB6VKvBS3lhLlCvX2D6k9ySV3BX7gskfDLw0N606cc90JP4qC
         SZpELmEOHc2u3JoHmqfA/P2HA1dzIdq8ZSrCaic3iYY/28Uo4FbAWiQL/RtxnvqDz10C
         GMtLS+NqV6fcmLxuAj11NdbaiFcygnaEb4mB4Ex2AW0DoUvh3Fo8jkIOgXz7MFxMa3l8
         46lqg7uzj3kzZJnt099upfuVcdsGjwC7IcfBXhr8SAs6QDzbMod5pYSWBs94yxtowTLR
         I2mZ02mGjV06exgnnTUBQ27RQRIv3mEv0/KsaM5zbPiI/0p9mc36qcwTKWcO6JXm6jNa
         fmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4hd8Uqqj7xreRP5SIcGVcjD9Ew8nHpHTUx1LOu0EYN8=;
        b=fVYlhLELDHlkhE3spLo96JrAJoUCylK9rYK8UlDXQCHON+Cfk1Aba3ys3HQNoUzaJd
         clz2INwLOlt44c23IjqYDDKC7ich4HB2WyHali5XXcz9ciUZEtRStHx6ef4s5lpqXwO2
         pR/Ht7noT2/jP30Dponx2nf9LHbLXnPjUAhv9M07yaOlqYqxeK7VrL4iN6T1rsJGFMjP
         K4KduSHdDkJbTbk7t6idSgkFJMk5rRbZlEImUW2Wh6HUgw+KqG03k7bYQTRe/mjbA4pM
         GxNGpl/zRl0bAnlIyGWx4M5XVExs1Ah38F2JMgVGnHGGZSlV0OnI4Ra4AU6gQzT32LTb
         U7ow==
X-Gm-Message-State: AN3rC/5QP18IDKLedytRUP1BTuIF0+vuol65V0W6749SrYD+oApBkCHsx8TB2xR6q9Tm9qmM1R72K1z19nnmxg==
X-Received: by 10.157.68.146 with SMTP id v18mr4468231ote.128.1492003300669;
 Wed, 12 Apr 2017 06:21:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 12 Apr 2017 06:21:10 -0700 (PDT)
In-Reply-To: <SN2PR03MB2333BCFD2E1A6A400706F94CB7000@SN2PR03MB2333.namprd03.prod.outlook.com>
References: <20170407192357.948-1-kewillf@microsoft.com> <20170407192357.948-4-kewillf@microsoft.com>
 <20170410102429.GB19325@ash> <SN2PR03MB2333BCFD2E1A6A400706F94CB7000@SN2PR03MB2333.namprd03.prod.outlook.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Apr 2017 20:21:10 +0700
Message-ID: <CACsJy8Dw8qfS6G71y3FoT9w7H=FABMx=5R=v8JcPCEHtv1vLcw@mail.gmail.com>
Subject: Re: [PATCH 3/3] reset.c: update files when using sparse to avoid data loss.
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     Kevin Willford <kcwillford@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 5:30 AM, Kevin Willford <kewillf@microsoft.com> wrote:
> The loss of the skip-worktree bits is part of the problem if you are talking
> about modified files.  The other issue that I was having is when running a reset
> and there were files added in the commit that is being reset, there will not
> be an entry in the index and not a file on disk so the data for that file is
> completely lost at that point.  "status" also doesn't include anything about
> this loss of data.  On modified files status will at least have the file as deleted
> since there is still an index entry but again the previous version of the file
> and it's data is lost.

Well, we could have "deleted" index entries, those marked with
CE_REMOVE. They are never written down to file though, so 'status'
won't benefit from that. Hopefully we can restore the file before the
index file is written down and we really lose skip-worktree bits?

> To me this is totally unexpected behavior, for example if I am on a commit
> where there are only files that where added and run a reset HEAD~1 and
> then a status, it will show a clean working directory. Regardless of
> skip-worktree bits the user needs to have the data in the working directory
> after the reset or data is lost which is always bad.

I agree we no longer have a place to save the skip-worktree bit, we
have to restore the state back as if skip-worktree bit does not exist.
It would be good if we could keep the logic in unpack_trees() though.
For example, if the file is present on disk even if skip-worktree bit
is on, unpack_trees() would abort instead of silently overwriting it.
This is a difference between skip-worktree and assume-unchanged bits.
If you do explicit checkout_entry() you might have to add more checks
to keep behavior consistent.
-- 
Duy
