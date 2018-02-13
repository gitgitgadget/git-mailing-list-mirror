Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6531F404
	for <e@80x24.org>; Tue, 13 Feb 2018 17:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965256AbeBMRdF (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 12:33:05 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:33363 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964849AbeBMRdD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 12:33:03 -0500
Received: by mail-io0-f171.google.com with SMTP id n7so22151491iob.0;
        Tue, 13 Feb 2018 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hQsVc0Dry6abNWmc+2PT8Ft1YwFIVjZIjZALjHFKeEo=;
        b=oKNnf5mMV09PBJYm1V2qgkIxTKeAaPz/lKs5fVUD29flqyX9x/S1m23JOT09DUWye4
         zSWuoAa6bvId7aWUNEMjXuMEITS+c/j47diXEn0zo9qxTR8blW9x08/qQR5r9liihI4c
         fDaPmcQ3NQ4j9XMhzqT7g6W0QPwRZINSY/a/JjRbl/iyGkuh6jGb0sI2S06MUcCMWt04
         rgch/sS1TlnLRqlVehv/QU5PTvGBZPRQM2aJsfHPkVtlrcyDs7QPX5+o5jv0MTLI7pC/
         sP+oKgOgVTJ0BMuIyumE2F2XiyqDf/KBpqbLrPcWbjhODNAbMTdyVnLXCan4flUdegkQ
         +QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hQsVc0Dry6abNWmc+2PT8Ft1YwFIVjZIjZALjHFKeEo=;
        b=ofTITm9J4mq2tHTs25OYjb9uLReVd3Rk7nsVNde6zTQ+Udqh/DHd+7m+ONYVg89tIC
         ZtRtbhuc+wzejQIu6HiIhCHvx1jPZvSoeBNssPo3aeiV3ycpmnzJ3iLf9id/BYxasBqz
         Iosav3Zcyb5aW/jB7GvwstubmdOfbfljPT4LkkOAOynE+7mSNUOQtK6KBJNjx2t0eNcD
         tOUOLsIG0q5vIwOALLzjsZqrDbTwc6vXKhBJkpGmV5tjSvM4VXlNs8HUSViWSp9+jWiv
         OKpH9ZBnR45KmqwewrshgJsYEweSIKcVrtA0ybLpLBNXXuoeoj+TXweo9Nz1PGubbVS1
         PK6Q==
X-Gm-Message-State: APf1xPC31lQ3uuwfb9b779c4Tc0urs1beS+9lXgrSvJmwoBsPtrfQ3go
        4cHrnQsGUVNG7euMKv8WSrzfKBrQQ7nZsZNypkSrtkeH
X-Google-Smtp-Source: AH8x22490nGLT3uA3wy78p+sULMZs8/EvfIirfetMbRaHVorYL3Jd2UvtYnwfGFikQjQPNKdm3YEIeaQZMnQ31pu7WM=
X-Received: by 10.107.132.18 with SMTP id g18mr2266350iod.46.1518543182878;
 Tue, 13 Feb 2018 09:33:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.135.221 with HTTP; Tue, 13 Feb 2018 09:33:02 -0800 (PST)
In-Reply-To: <xmqqmv0crepg.fsf@gitster-ct.c.googlers.com>
References: <20180213080036.3bf3a908@canb.auug.org.au> <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
 <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
 <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com> <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
 <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com> <20180212222157.0a3bd472@vento.lan>
 <xmqqmv0crepg.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Feb 2018 09:33:02 -0800
X-Google-Sender-Auth: RLJeNAPNsu-SnY8G5XVzo3Ipv2Q
Message-ID: <CA+55aFxkYTeY9h=VHFXi=gbXsnsHCRMAVZ9=1_EsFGSqr0sj9g@mail.gmail.com>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 9:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> That makes me wonder if another heuristic I floated earlier is more
> appropriate.  When merging a tag object T, if refs/tags/T exists and
> it is that tag object, then an updated "merge" would default to "--ff";
> otherwise, it would keep the current default of creating a merge even
> when we could fast-forward, in order to record that tag T in the
> resulting history.

Oooh. Yes, that sounds like the right thing to do.

So the "no fast-forward" logic would trigger only if the name we used
for merging is one of the temporary ones (ie .git/{FETCH,MERGE}_HEAD),
not if the mentioned tag is already a normal tag reference.

Then it's very explicitly about "don't lose the signing information".

I'd still have to teach people to use "--only-ff" if they don't do the
"fetch and merge" model but literally just do  "git pull upstream
vX.Y", but at least the case Mauro describes would automatically just
DTRT.

Me likey.

           Linus
