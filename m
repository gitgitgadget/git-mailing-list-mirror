Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352FE1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 08:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935050AbeCHITC (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 03:19:02 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34661 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934158AbeCHITB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 03:19:01 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so26199880wmd.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 00:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p3IKmXp1Ya17eY0GHwLCZFzelQ2dd0nzHE/UwZFbFDQ=;
        b=sfPZWT8B8M+ItSj3a4+SZKFUcQXapWtVxS+b3x1BVqDIkpeEEvgw3OM9soeFvFTdCQ
         9R3O1zKxPuh97QNGfYO4/ufhzTZJz8sPibExnaBAXDc4CqY83Dfyt6lJXfMm4/x/9RxV
         1uoCgtWReLtBfhVUpv0wjhAbOBWwjAiFYe+IOsUamesau6QAlKtHrk6o5kgxlsqTWthe
         fGj/CXhfOfM+damidFUHt8iJyCJN+8rKnK4vcnkuI9aMDxje6OzkmzGZka9Src9+JNG1
         1rTfFVPN84ha1C9SmT3SAtiH0sjXLSCvBI/48YS5G1BiYODtBPSgXSpOVNoHpbBYFf7n
         h9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p3IKmXp1Ya17eY0GHwLCZFzelQ2dd0nzHE/UwZFbFDQ=;
        b=SCmGqwBGOwISjK2ufq8gASIW/6mW9mWw63/d1VbpYlh+Rxg3Z5nnqnPOK1KaUUBCl4
         q9Sms2XJvJ4xVyI366jXcmsgemy5HfD5dJ8Le1tjyJWwccIIHaD+/9jk4vBOUkXqaQcn
         ZiD1lkS0oERdZtowhz3cQl7w+uBwwDUi+u4YF/oTVxTKGzvenZCD+P8zhyX2LyC4hNHI
         3oUmhMsTeJwbsV72cw97Wks1u2DavaV3TeHeDY/mSPDtLC3yG7Bt7WPdBrigvJMfjeRx
         fiCSjMO3keDCgCTABE42JNQor8HJ+pretbqPVRqX4FqAK+LyLif6kdOhK8sa4f0wPb2D
         KiZA==
X-Gm-Message-State: AElRT7ELRYUuEve3yVPLQMFPWUP7KpodC2WLyq1d64Y1V/Hho8F8Tn9w
        lqtxsLLFo/rOSoxM7yw+pxs=
X-Google-Smtp-Source: AG47ELvO1XZU387HKwgZ2DLTIgtqZASNYl5NjkO93NVWq/bAOmsl9bgyfvvHN5ZxQfgXc/O+DQHi8Q==
X-Received: by 10.28.94.75 with SMTP id s72mr2608481wmb.126.1520497140159;
        Thu, 08 Mar 2018 00:19:00 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e18sm22371317wmc.21.2018.03.08.00.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 00:18:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
        <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
        <87h8pvm7zz.fsf@javad.com>
        <ebc73962-8dff-520c-e19d-8fcc1ef63ab0@talktalk.net>
        <xmqqwoyp5eig.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803080804420.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 08 Mar 2018 00:18:59 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1803080804420.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Thu, 8 Mar 2018 08:05:41 +0100
        (STD)")
Message-ID: <xmqqbmfzx9n0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Non-textual semantic conflicts are made (in the best case just once)
>> as a separate commit on top of mechanical auto-merge whose focus is
>> predictability (rather than cleverness) done by Git, and then that
>> separate commit is kept outside the history.  When replaying these
>> merges to rebuild the 'pu' branch, after resetting the tip to
>> 'master', each topic is merged mechanically, and if such a fix-up
>> commit is present, "cherry-pick --no-commit" applies it and then
>> "commit --amend --no-edit" to adjust the merge.  I find it quite
>> valuable to have a separate record of what "evil" non-mechanical
>> adjustment was done, which I know won't be lost in the noise when
>> these merges need to be redone daily or more often.
>
> So essentially, you have something that `git rerere` would have learned,
> but as a commit?

You probably wouldn't be asking that if you read what you cut out
when you quoted above ;-) 

There are a collection of cherry-pickable commits in hierarchy under
refs/merge-fix.  They are indexed by the branch that will cause
semantic conflicts that do not involve textual conflicts at all (the
important implication of which is that 'rerere' fundamentally will
not trigger to help resolving them) [*1*], and are used to create
evil merge when a corresponding branch is merged to 'pu' (and down).

[Footnote]

*1* One topic adds an extra parameter to read_index_from() that has
been and still is defined in a file and merged to 'pu' first, while
another topic adds a new callsite for the same function in a file
that the former topic does not touch, hence a merge of the latter
topic has no textual conflict to the file with a new callsite, but
still needs adjusting.  That sort of think.
