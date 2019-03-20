Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F23020248
	for <e@80x24.org>; Wed, 20 Mar 2019 21:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCTVpJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 17:45:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33411 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfCTVpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 17:45:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so743047wmi.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qRnPgWuJ7dyxcNY9mJkKMnz212KjglQpZEW94vgQTf8=;
        b=RAC1qIZi6kWorUlVD10/DL9I3T7fLGVh8I7qH1OY0RQ6prLtYCCRa58Wx+NDDn59aS
         pNlVbAJEs+FKKDMtsKEyAS9YmG2QiDf9ssvt8M8Bz65mfjKYvtBm3FrHB9mPv8QxWIHL
         4vrQo3dz2o8Ip6RyrUOHhBP4K9iwDuv7GqxBgJEIVM0SCPwcmkfYVzGHvF8IlRZ3sg4C
         CtFODMhQTtur8Cq3u5Z4FzAms1Vz+QRsRvnkt7OYeF8uTWwfpA+VjXi9A+xN1TzqT53Q
         VlnCxp1wlN0mjceRGJC/8OxX1Dpbat0GsvFp6FO34wyRZRrRjA6mbyVIF8VTBL9J25za
         AiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qRnPgWuJ7dyxcNY9mJkKMnz212KjglQpZEW94vgQTf8=;
        b=CDjCbxpAkJMxdHV7ejysVmifRAXBmJ5gLN7xPunRx6fFKxnzWNQ6h0eax7UFq2dzUX
         +sE2+ZB53WYfg7nbctN1fP5Zd2/J4PB3eXue2ZH1Ge9Nw+xctVdSJqfsPJ+iZdaoPycZ
         doOrDnWKMlSQGTHwIYdmJ8sUnwJaqOzLNFzzxX7wmBUd4RYoYmdaLiSkrMwhX0ClB2x1
         prmL1KAaTvYAEfPgHmIOtsMGnh722VkeaKmYNkDRr15L6esml8HtTFoiczWKd0ZN1UI1
         YeQPmbJFtkvGd2ycgAohXlImVStox6I5xaHpyoTpmbLSaKz74xkJIfD5JXkdWCKBjZOR
         hyBQ==
X-Gm-Message-State: APjAAAV54FNI8+DJhXvAetuGwbGH82Z0AWE6JpfZSOp/qQA/TyEDMOIy
        zpju3CQRv+taX8+vVtNaeB8=
X-Google-Smtp-Source: APXvYqxmJB2OCdeDXTs3avHyzkHSu4qzDFXKc+YijoSJLuYGH71bWR5NhX29cSempez3/nUUJ57uIQ==
X-Received: by 2002:a1c:4d:: with SMTP id 74mr277256wma.1.1553118307068;
        Wed, 20 Mar 2019 14:45:07 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id v6sm6594839wme.24.2019.03.20.14.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 14:45:05 -0700 (PDT)
Date:   Wed, 20 Mar 2019 21:45:04 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [REGRESSION ps/stash-in-c] git stash show -v
Message-ID: <20190320214504.GC32487@hank.intra.tgummerer.com>
References: <20190319190503.GA10066@dev-l>
 <20190319231826.GB32487@hank.intra.tgummerer.com>
 <xmqqwokuwe9w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwokuwe9w.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Subject: [PATCH] stash: setup default diff output format if necessary
> >
> > In the scripted 'git stash show' when no arguments are passed, we just
> > pass '--stat' to 'git diff'.  When any argument is passed to 'stash
> > show', we no longer pass '--stat' to 'git diff', and pass whatever
> > flags are passed directly through to 'git diff'.
> >
> > By default 'git diff' shows the patch output.  So when we a user uses
> > 'git stash show -v', they would be shown the diff, because that's the
> > default behaviour of 'git diff', but not actually directly triggered
> > by passing the '-v'.
> >
> > In the C version of 'git stash show', we try to emulate that
> > behaviour using the internal diff API.  However we forgot to set up
> > the default output format, in case it wasn't set by any of the flags
> > that were passed through.
> 
> Well explained.  It might have avoided such a bug if the code did
> not manually stuff the diffopt.* structure fields (instead, e.g.
> prepare an array of strings like {"diff", "--stat", NULL} and let
> the option parser diff_opt_parse() to do its job), but that is
> lamenting over water under the bridge.

I actually think this is still a valid point.  I'm not too familiar
with the diff API, which is why I missed this during my review in the
first place, but I feel like using 'diff_opt_parse()' is still the
right choice here.  Both to fix this bug and to avoid potential
further ones.

Let me give implementing using that a try, I have a feeling like that
might turn out to be better code.

> > So 'git stash show -v' in the builtin
> > version of stash would be completely silent, while it would show the
> > diff before.
> 
> That sounds reasonable.  Thanks for a quick diagnosis and a fix.
> 
> > Fix this by setting up the default output format for 'git diff'.
> >
> > Reported-by: Denton Liu <liu.denton@gmail.com>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  builtin/stash.c  |  4 ++++
> >  t/t3903-stash.sh | 18 ++++++++++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index 51df092633..012662ce68 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -761,6 +761,10 @@ static int show_stash(int argc, const char **argv, const char *prefix)
> >  		free_stash_info(&info);
> >  		usage_with_options(git_stash_show_usage, options);
> >  	}
> > +	if (!rev.diffopt.output_format) {
> > +		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
> > +		diff_setup_done(&rev.diffopt);
> > +	}
> 
> Hmph.  Does this result in setup_done() called twice?  As it would
> indicate another bug in the original code if setup_done() was never
> called, I am assuming that another setup_done() call in the same
> codeflow is already there.

No, it is not called anywhere, will fix that as well in v2.

> >  	rev.diffopt.flags.recursive = 1;
> >  	setup_diff_pager(&rev.diffopt);
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 97cc71fbaf..e0a50ab267 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -612,6 +612,24 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
> >  	test_cmp expected actual
> >  '
> >  
> > +test_expect_success 'stash show -v shows diff' '
> > +	git reset --hard &&
> > +	echo foo >>file &&
> > +	STASH_ID=$(git stash create) &&
> > +	git reset --hard &&
> > +	cat >expected <<-EOF &&
> > +	diff --git a/file b/file
> > +	index 7601807..71b52c4 100644
> > +	--- a/file
> > +	+++ b/file
> > +	@@ -1 +1,2 @@
> > +	 baz
> > +	+foo
> > +	EOF
> > +	git stash show -v ${STASH_ID} >actual &&
> > +	test_cmp expected actual
> > +'
> > +
> >  test_expect_success 'drop: fail early if specified stash is not a stash ref' '
> >  	git stash clear &&
> >  	test_when_finished "git reset --hard HEAD && git stash clear" &&
