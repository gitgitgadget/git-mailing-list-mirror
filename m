Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7318A2018F
	for <e@80x24.org>; Sun, 10 Jul 2016 21:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289AbcGJV3s (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 17:29:48 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35677 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237AbcGJV3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 17:29:47 -0400
Received: by mail-oi0-f44.google.com with SMTP id r2so124289883oih.2
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 14:29:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NXsrVLsrIbL+mfpLyjEP84/8yZK3JVsHPB5Mu0NfaCY=;
        b=j7eGMPLa9PKTLZBTrpAWUy/6mBQaIDmE5URBe6dGz3BBh2XafJSC001D+RRt0XTIED
         8+HGEGuKkuw9ot/UViOgmIzlImKvl7hb40kLAjIfNEac/ObDsAUohBWUl0Fu/tOItz9i
         FM/FRFlXhELERho6bDOD/iUtKpWP9O9bKLVlXZj+9cVfSWjARFsiihZtiyN+OgzxpV5N
         IkwMLbsJpz4oPMjXRPmequqmEJmBUR6OFgghuyoG6X1oklz6KUCr4S8C8eoDNc+d17f+
         hTVlY/IEeK4mfhuYaY/ryDOQB11+NieySMJl+rcr3SnGu2qpzg2cnLSUuDp0VE85RT3x
         ltQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NXsrVLsrIbL+mfpLyjEP84/8yZK3JVsHPB5Mu0NfaCY=;
        b=ALd1Ox3hFMLK/E0laefkBuoLhnPg37vir66tWxE6GY2IMT1L0kEAJQxT5xGNTDbF5C
         x02K4IjgwwGj5rATpjoNSat2zrq8Cd4xbunD6zULi6m357jYoZN9J2youlaeapWpY8/F
         qtYtoXTfWxSiPxY5uezynJD1fIg9FkCHH+zdEaW+PxQmMjPOR3KtIwkAtBt5xm9c7yWz
         l3WwbSjSdQceSUUX9oQLVicAFKGz09aRvFADnzVKJpRWmcyG3JnGxilWCmaC4DPzyEwc
         LRsFDkS+QdbVU6kipUrhRz7KUKLqPfkdytJ+TgaF/ZtYnYvDz3MdgBoDxwC3phV9h+Ux
         AZpA==
X-Gm-Message-State: ALyK8tItS3B29Lvzq9zNEQ6L9MZxZ5BLrlh8eJOnwZie1/zcJjYQWPp+JdezhGgscll2jJigOs94PUcJa1C6bA==
X-Received: by 10.157.12.248 with SMTP id o53mr9247880otd.0.1468186186913;
 Sun, 10 Jul 2016 14:29:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.221.68 with HTTP; Sun, 10 Jul 2016 14:29:46 -0700 (PDT)
In-Reply-To: <CA+55aFwvZqqSkphgL+UBqfXnSGAFEzmqyH83OMGnpco3ZVZUnA@mail.gmail.com>
References: <CA+55aFz=sZnABJr6F2yF_xvx6J6fZod6BbiL2OwszEnjjn-dEw@mail.gmail.com>
 <87eg712v5o.fsf@linux-m68k.org> <CA+55aFyJP8FLaBtsMekzQDsCjDbFPa-qUZNHZNpvva2vZTRGgQ@mail.gmail.com>
 <CA+55aFymKO5Bi2qZ-zaiZKQAk7RxusEMJ9Y0Gw6ywdznK+TaRQ@mail.gmail.com> <CA+55aFwvZqqSkphgL+UBqfXnSGAFEzmqyH83OMGnpco3ZVZUnA@mail.gmail.com>
From:	Linus Torvalds <torvalds@linux-foundation.org>
Date:	Sun, 10 Jul 2016 14:29:46 -0700
X-Google-Sender-Auth: dJBtFvZ8oBgvavEoHFSbVxPuJp0
Message-ID: <CA+55aFx=qT9mNo1MDkQuzB=V7=STSc_Knmj=6589qi=tSZs1ag@mail.gmail.com>
Subject: Re: Odd git overrflow bug?
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 2:21 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm not sure why it doesn't happen in current git master, because that
> function is the same, and the logic around expand_tabs_in_log looks
> similar too.

Ahh. Commit 43ec55091553 ("bisect: always call setup_revisions after
init_revisions") is in master, but not in v2.9.0

            Linus
