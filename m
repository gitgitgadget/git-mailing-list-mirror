Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07DF520248
	for <e@80x24.org>; Sun, 31 Mar 2019 18:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbfCaS52 (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 14:57:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50229 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfCaS52 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 14:57:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so7974355wmi.0
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ha83I//HhSx8Ckrgd7oDyYu2HsDGloRLQUsBmLEO16s=;
        b=R9kjvQ1hhLzrZa+oi0qUmzh0EIN4MXEM6LpCr6brCmfaqG38DPfunghcI1P1wLGl+b
         92gAn8/DPJIpf3PPYj8OTvQFRS1OzIdRmlaUncO5nunKltdU7JosIsSJhSGVkbb46xDY
         XwwQCaHIGfQllvViFFg7rNNl+w2Wozt6wTkGm6gOidFL8ZA/NCiGVWJGQ7JTjN87ynWf
         oHTm/KDj67Pfg6SpqUH0dAJdXKc7BcuiA5rbfa6NgJdqsckv7KPhjvkEI1/Vbw60uiyJ
         JJofevAAUaHEEYkQhJahfSlgDAyQLNdcOR/KA6SDqZh4Yv661XILmMz/cdJyzlxsqUHd
         YSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ha83I//HhSx8Ckrgd7oDyYu2HsDGloRLQUsBmLEO16s=;
        b=TxltfjUuj1hXzaSCwGYeVpMY6kAGP5AFc4ZpvmKMAzYWFsHoaneEcvnuI6ZHSgOUJ3
         OpbzDb7sNCLAHIx//IPTDl2WjqscKjR1iNob6149NS5we7LQ+eGj0kU+Xoxnnx7sqhIG
         Brg88YZMmDjf9lj43BwpPeagdBv1FCwQkuryqfYA7At9exQdWOakWXfMM8f4+YtwrF4t
         L+x7iN18ENTsi7Ck5TvYKlIzikVFU6ttVutfzDuUt8l6ljvRQpRnnQq6DeCTWRUuwZML
         2t8IytrMCkxZtSaW4tQm2rCUjXPhbTeKjD4iCwDdb85GiSDM4KAlU4qkF14iGhoAD6Eu
         GFiw==
X-Gm-Message-State: APjAAAUoq2zZVzcedRl8CdcDn6acYcBnF7FXlg7yR4cika+7xiGBwCRX
        P+aOGgNN5gzFf8TvtEjJgBMNF56J
X-Google-Smtp-Source: APXvYqwFJVSbp+gDCxCL2AcVs99p2SsAeDT2g2kOQ0YemMmpfovbTSSbXx+pk9aIZYHBdNJPjlxjhg==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr9833741wma.2.1554058646737;
        Sun, 31 Mar 2019 11:57:26 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id z14sm9171981wrv.78.2019.03.31.11.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 11:57:25 -0700 (PDT)
Date:   Sun, 31 Mar 2019 19:57:24 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     jonathan chang <ttjtftx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [GSoC][PATCH v4 4/5] t0000: use test_cmp instead of "test"
 builtin
Message-ID: <20190331185724.GW32487@hank.intra.tgummerer.com>
References: <cover.1553954776.git.ttjtftx@gmail.com>
 <731463ed9892c283b6acb0ce69e097769e43de62.1553954776.git.ttjtftx@gmail.com>
 <20190330193842.GR32487@hank.intra.tgummerer.com>
 <CAOAu_YKMuy2vWQqZz+=-7JGhce9BEdMqsr8HOKZOJVq=chpqVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOAu_YKMuy2vWQqZz+=-7JGhce9BEdMqsr8HOKZOJVq=chpqVw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/31, jonathan chang wrote:
> On Sun, Mar 31, 2019 at 3:38 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 03/30, Jonathan Chang wrote:
> > > Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> > > ---
> > >  t/t0000-basic.sh | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > > index 3de13daabe..49923c5ff1 100755
> > > --- a/t/t0000-basic.sh
> > > +++ b/t/t0000-basic.sh
> > > @@ -1118,16 +1118,18 @@ P=$(test_oid root)
> > >
> > >  test_expect_success 'git commit-tree records the correct tree in a commit' '
> > >       commit0=$(echo NO | git commit-tree $P) &&
> > > -     git show --pretty=raw $commit0 >actual &&
> >
> > This line has been introduced in a previous commit.  If the file was
> > called 'output' there already, I think that patch would be just as
> > understandable, but this diff would be a little less noisy.
> 
> Make sense. I tried to make patches from last iteration untouched,
> so I don't break anything.

This is what running tests, and reviewing your own code are good for :)

>                             And I was wondering since I'm only
> appending patches, if I should also append the PATCH number as
> [PATCH v3 4/3], to reduce the number of emails. Now I realize that
> by making it a new iteration, we can also make some improvement
> to reduce the patch noise.

Right, appending patches using 4/3 for example can be done in some
rare cases, but since you already modified patch 2/2, a new new
iteration is required anyway.

So yeah improving the overall series is always a good thing.
Especially since I see you already included the range-diff, it's not
very hard for reviewers to see what changed in the last iteration.
