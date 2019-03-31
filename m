Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C7520248
	for <e@80x24.org>; Sun, 31 Mar 2019 05:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfCaFRM (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 01:17:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41133 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfCaFRM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 01:17:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id v7so4734905oie.8
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 22:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8gARghRkwGbjO00pt/DZEi+1LWb7fBlwH2ESBv1COM=;
        b=hMB1tdFFbBntX6C7NAuTwqSxjteBdZuetgduP3gT6r/UFfb7YBcaWbvY5Kpr94QXI3
         B+UZDizKkuapjyI2UGgG0oMQFKzmACHMn71WYTJe2/T2ur2EJkS4kHb/0FQjS/p3PB2J
         pY4fbNRMePoB4msiGZ3rKYPTYumzx5jH+8VTkDuTAx5FBjetHKedw3/wVM+hZ2S8kJUl
         6cIRIaK6XC3v3cm86UybXY9UlzMxwYRW1r3Z1tBTRsis5IynNbhPs+ZK7AEYnOKU89dj
         zCugCnRbHwHhRYO2yW/sCGgFYQJBLGbxcnVmgmpjzYDK2qSQGBYE67EtZPhgrCuJGxTR
         pTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8gARghRkwGbjO00pt/DZEi+1LWb7fBlwH2ESBv1COM=;
        b=MpYlc2NffQSNHDTUUkwxW173sUGSvcdzqVUo8vbCytpvHicdD9DxSwKyceIw1BFihr
         HfwoMImwcEPoAMtJjCDvRdEdhPblSCpnWP4J8wgmpmf7HLvRWkhoxq2/POO1UDltSjb/
         HH7UeY6I+hGIsEenuhLOqz1Flr6Ff8eFQHZozjfv4GTm++jYYlx/YKAjp7eqOMVb2f7x
         r1i4igaetz05jALRa9ux2DqvdLBp7wRffOZ7hWkt/Lkn7RJtqfN1DD4CnXDpBb89kQAo
         D48PdefthmABForQDrdh29hVWBMP/Z/lxYnzP70d6SkDr5m4Gl9zpMkekaxSHr91/jWa
         srzA==
X-Gm-Message-State: APjAAAVv0MZneb0evN3cveUinI2XWNcY54atfM84iAaoAGtC+Swy0r9o
        NJmRfjXa7sfV8ekOWg77UygzCBMMO/PSyVI+7Cg=
X-Google-Smtp-Source: APXvYqy+muqADGt7E8OA0T5KAxQ1Ya7phJ4+J5eXGKZE7OqczYeuWY/e86TIYVdRE1jpVGj8pzObDnDXcmnf0zQXewc=
X-Received: by 2002:aca:4dc2:: with SMTP id a185mr9022681oib.167.1554009431495;
 Sat, 30 Mar 2019 22:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553954776.git.ttjtftx@gmail.com> <731463ed9892c283b6acb0ce69e097769e43de62.1553954776.git.ttjtftx@gmail.com>
 <20190330193842.GR32487@hank.intra.tgummerer.com>
In-Reply-To: <20190330193842.GR32487@hank.intra.tgummerer.com>
From:   jonathan chang <ttjtftx@gmail.com>
Date:   Sun, 31 Mar 2019 13:17:00 +0800
Message-ID: <CAOAu_YKMuy2vWQqZz+=-7JGhce9BEdMqsr8HOKZOJVq=chpqVw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 4/5] t0000: use test_cmp instead of "test" builtin
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 31, 2019 at 3:38 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 03/30, Jonathan Chang wrote:
> > Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> > ---
> >  t/t0000-basic.sh | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > index 3de13daabe..49923c5ff1 100755
> > --- a/t/t0000-basic.sh
> > +++ b/t/t0000-basic.sh
> > @@ -1118,16 +1118,18 @@ P=$(test_oid root)
> >
> >  test_expect_success 'git commit-tree records the correct tree in a commit' '
> >       commit0=$(echo NO | git commit-tree $P) &&
> > -     git show --pretty=raw $commit0 >actual &&
>
> This line has been introduced in a previous commit.  If the file was
> called 'output' there already, I think that patch would be just as
> understandable, but this diff would be a little less noisy.

Make sense. I tried to make patches from last iteration untouched,
so I don't break anything. And I was wondering since I'm only
appending patches, if I should also append the PATCH number as
[PATCH v3 4/3], to reduce the number of emails. Now I realize that
by making it a new iteration, we can also make some improvement
to reduce the patch noise.

>
> > -     tree=$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
> > -     test "z$tree" = "z$P"
> > +     git show --pretty=raw $commit0 >output &&
> > +     echo "$P" >expect &&
> > +     sed -n -e "s/^tree //p" -e "/^author /q" output >actual &&
>
> I'd find it a bit more natural to either first create the expect file,
> and then do the 'git show' and 'sed' invocations in two subsequent
> lines, or do them first, and then create the expect files, rather than
> interleaving them.
>
> I'm not sure either of these by itself is worth a new iteration,
> unless there is also something else to fix up.  But it's something
> that you might want to keep in mind for future patches.

I thought about all three options, starting with expect files being
the last, but found that most test_cmp seem to have expect file
created first, then decided to make the creation of actual and
expect be on consecutive lines.

Now I would probably move the creation expect to the last line.
Thanks for the review and suggestions.

>
> > +     test_cmp expect actual
> >  '
> >
> >  test_expect_success 'git commit-tree records the correct parent in a commit' '
> >       commit1=$(echo NO | git commit-tree $P -p $commit0) &&
> > -     git show --pretty=raw $commit1 >actual &&
> > -     parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual) &&
> > -     test "z$commit0" = "z$parent"
> > +     git show --pretty=raw $commit1 >output &&
> > +     echo "$commit0" >expect &&
> > +     sed -n -e "s/^parent //p" -e "/^author /q" output >actual &&
> > +     test_cmp expect actual
> >  '
> >
> >  test_expect_success 'git commit-tree omits duplicated parent in a commit' '
> > --
> > 2.21.0
> >
