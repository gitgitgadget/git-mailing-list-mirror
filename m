Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99AD31F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 10:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJKRwH (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 13:52:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44691 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJKRwH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 13:52:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id z21-v6so7733615edb.11
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xCUjgPsHKEGLvxbVwbCbZkcRy5juJPST/uMVbCJCgkk=;
        b=B+EvFVlEzaug/dqUIWpYJsi4NQS1zx7jQrdHOb9CoSHkEbKiqeR8p/OunuZb0Gisum
         1gHKpgWByCK6tn/ZdxBTrxCWrOgRULdOIJLOgom3gkexOPTCrWkutHg/stiKtDAU965+
         N7afi7kILeyG+ZokwMC3JY3O0dX65GKAlDRk/MNpTXp1Xne7j1o/fMmSxvE35tQaca/J
         zXEiO4NX8DH/jppjhWtpji/1YekjSJUt9sR4tWSrqbZ9qP4M4tQs5eVy7PT/W1LDGVpy
         69n9IjE6q7Y2LYJnwsrtvH4ht+KyAMdrazv97lfVthC4jt6KQXGKo+OPk8A4QNT8tTw5
         IF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xCUjgPsHKEGLvxbVwbCbZkcRy5juJPST/uMVbCJCgkk=;
        b=osdcSVWbEAbQId68djYoA69wh6vPCNqW6a4HF0h5KKy4BCHfoCOrgXkbgQt5+LwOVR
         2AaomR2LWaFkM+E8VWp87VryVj/rkyN3NTZlMhXda81Vi/7Dc0Hi3IQz37Xp82XhgvAO
         bnJL1pj5RMJJGPsPHnLsajyLVUNluFQuDI7TnUmNjrnZ0P4uoGRN9pIPNB/A1KKcUNT3
         gn7IV4Y0YjdBp6M6RVX3a55JuwSaNjdZVn8V8KPOUr1zag7CHAMy2VLMmSNErwyml0GG
         SNtGVpmsraTsxc8XgroLBv9/sxTB9aJNC5Q6U1ENRB8ptOdS7eBqEz0tD7M8pUfyzrd1
         OBhA==
X-Gm-Message-State: ABuFfojZcg/Dxy/WsFAjILiIdQlO/2KdiK36Sosl2fY7IiQrd3LpGvFy
        43tjhgpS/1H+bUo81EUuVvg=
X-Google-Smtp-Source: ACcGV61BUA8ryjhwc/fxuB+6nXZ87q1/QfXz+Jd4ebOzZWhrbShGrkPeYx48NpHyrxH3whryez64Zg==
X-Received: by 2002:a50:9247:: with SMTP id j7-v6mr1919060eda.124.1539253528671;
        Thu, 11 Oct 2018 03:25:28 -0700 (PDT)
Received: from szeder.dev (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id w56-v6sm8884652edw.79.2018.10.11.03.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 03:25:27 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:25:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert & cherry-pick: run git gc --auto
Message-ID: <20181011102525.GH23446@szeder.dev>
References: <20181010193557.19052-1-avarab@gmail.com>
 <20f33df8-7ba8-af26-e0c8-16152345c85b@talktalk.net>
 <87ftxceqxc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftxceqxc.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 12:08:47PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 11 2018, Phillip Wood wrote:
> 
> > Hi Ævar
> >
> > On 10/10/2018 20:35, Ævar Arnfjörð Bjarmason wrote:
> >> Expand on the work started in 095c741edd ("commit: run git gc --auto
> >> just before the post-commit hook", 2018-02-28) to run "gc --auto" in
> >> more commands where new objects can be created.
> >>
> >> The notably missing commands are now "rebase" and "stash". Both are
> >> being rewritten in C, so any use of "gc --auto" there can wait for
> >> that.
> >
> > If cherry-pick, revert or 'rebase -i' edit the commit message then they
> > fork 'git commit' so gc --auto will be run there anyway.
> 
> Yeah it seems I totally screwed up the testing for this patch, first it
> doesn't even compile because I'm not including run-command.h, I *did*
> fix that, but while wrangling a few things didn't commit that *sigh*.
> 
> And yeah, there's some invocations where we now run gc --auto twice,
> i.e. if you do revert, but not revert --no-edit, and not on cherry-pick,
> but on cherry-pick --edit.
> 
> So yeah, this really needs to be re-thought.
> 
> > I wonder if it would be better to call 'gc --auto' from sequencer.c at
> > the end of a string of successful picks, that would cover cherry-pick,
> > 'rebase -iu' and revert. With 'rebase -i' it might be nice to avoid
> > calling 'gc --auto' until the very end, rather than every time we stop
> > for an edit but that is probably more trouble than it is worth.
> 
> That seems a lot better indeed. I.e. running it from the sequencer. I do
> wonder if there should be some smarts about running it in the middle of
> a sequence, i.e. think of a case where we're rebasing 10k commits, which
> is a gc need similar to what happens in the middle of "git svn
> clone". So maybe something where we gc --auto in the sequencer for every
> Nth commit, and at the end.

How would that affect setups with 'gc.autoDetach = false', or, more
importantly, platforms, where 'git gc --auto' always runs in the
foreground?

