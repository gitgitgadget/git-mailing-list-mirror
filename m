Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D45F20248
	for <e@80x24.org>; Mon, 11 Mar 2019 16:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCKQKQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 12:10:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37196 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCKQKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 12:10:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id b3so4429941otp.4
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDJwAU81i1xlVocdDsCyasXzjaAPuMalv3r8dJ6SQ1A=;
        b=Gu3KJtWiTr4KPWqQLPewLi5Lyy397rlgfgN2D/QlI10IxbNKIMy+iD8ewJzFe4y3ko
         qb4tHaYnnXPqgkKVxMkuVtk7p3WL4dKcTmr3y5dgFw3Wkw6p+PQvzflBpfZndvs3hYmN
         ZSvobyWbACMb7Q5P/UDX8quLr+z5IUu5a646j5sTK9pU6+lIr3PGvEKzVGEBqXtqQv2s
         ACwQNJDx2tCtosKvfolr0c8gd/uqkuxweBARt37F2JPN+MclRTF0MDr2eDnvr2KA1mnX
         MMWh84MO0DJXcy4aI6NEOKtOD6SsRIKKf0z5Sn9pGJK8msEPE4Ldpzlt5PUjmekHLYOY
         MMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDJwAU81i1xlVocdDsCyasXzjaAPuMalv3r8dJ6SQ1A=;
        b=qf682zPKAjuF1g1qKLr7HhjZBs4vrh4R3k0ipmizXyr4d5PE6iNR5HXMCYtiqY3Kkh
         VifEHfXT4Yng/jtSbDA7Vj0HBRH0fAEsKiF8Z0v8AXnutow+IEYhJ4STYaf/dfEeiN7I
         uT0tDwpO1solWV5ykD/PJHV4xXlPpOzsiE6LrHa/DdxPYcxjiIis7MDz+eiOX7prfEO6
         pRP/RoAvdWVUPPyGTQR0sXTqdUYkZqhFsaTSG6BXYrQiuUa6by4c4ww16GhkogQPPnOv
         o5A43Vnll0HkI3trU3RFp+461Vkaq+27IrXLRr9bd6KBJA3539pQYd0meNFV4px6Nn0P
         NO5Q==
X-Gm-Message-State: APjAAAVLydQbdQLkY6M4OScVuczC1bca7zGi2q59N+aq2e3YmWVLjPCy
        AeFxylFrS3iPt3jMS0TopRJNlgUSBQ5BH0tXlvc=
X-Google-Smtp-Source: APXvYqxYLv/paVA9/g1G8TUahBy+j9hdc7QpQANlfjZPqkddH6ue2KgtIBI8L2q8Ii27UrNuFsXUtFRL19rs5DHQ0LY=
X-Received: by 2002:a9d:7dcb:: with SMTP id k11mr21723015otn.192.1552320615393;
 Mon, 11 Mar 2019 09:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190310081023.64186-1-ttjtftx@gmail.com> <20190310081106.64239-1-ttjtftx@gmail.com>
 <CAPig+cSMZrQFrLXoO5KE1uonUxmnYHikr-e6GAq_n6vx3+sPJA@mail.gmail.com>
In-Reply-To: <CAPig+cSMZrQFrLXoO5KE1uonUxmnYHikr-e6GAq_n6vx3+sPJA@mail.gmail.com>
From:   ttjtftx <ttjtftx@gmail.com>
Date:   Tue, 12 Mar 2019 00:10:04 +0800
Message-ID: <CAOAu_YKas8ZL+8qwwD-bPhnkdxMWB_JybOmBJW1ea4BVxoMQNg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 5/5] t0000-basic: use test_line_count instead of
 wc -l
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 5:51 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Mar 10, 2019 at 4:11 AM Jonathan Chang <ttjtftx@gmail.com> wrote:
> > Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> >
> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > @@ -1136,8 +1136,8 @@ test_expect_success 'git commit-tree omits duplicated parent in a commit' '
> > -       numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
> > -       test $numparent = 1
> > +       sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l >numparent &&
> > +       test_line_count = 1 numparent
>
> This transformation makes no sense. The output of 'sed' is fed to 'wc
> -l' whose output is redirected to file "numparent", which means that
> the output file will end up containing a single line no matter how
> many "parent" lines are matched in the input. Since test_line_count()
> checks the number of lines in the named file, the test will succeed
> unconditionally (which makes for a pretty poor test).

You are right. I will make sure I have thoroughly reviewed my patch before
submitting next time.

> Also, the filename "numparent" doesn't do a good job of representing
> what the file is expected to contain. A better name might be
> "parents". So, a more correct transformation would be:
>
>     sed -n -e "s/^parent //p" -e "/^author /q" actual >parents &&
>     test_line_count = 1 parents
>
> > @@ -1146,8 +1146,8 @@ test_expect_success 'update-index D/F conflict' '
> > -       numpath0=$(wc -l <actual) &&
> > -       test $numpath0 = 1
> > +       wc -l <actual >numpath0 &&
> > +       test_line_count = 1 numpath0
>
> Same comment about bogus transformation. The entire sequence should
> collapse to a single line:
>
>     test_line_count = 1 actual

Thanks for the help.
