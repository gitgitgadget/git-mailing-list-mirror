Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 649091F453
	for <e@80x24.org>; Wed, 26 Sep 2018 01:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeIZHQX (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 03:16:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33115 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeIZHQX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 03:16:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so12423251pfn.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 18:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1P5o0yfghl6fCiB/ecO8cbN4wTrqdIVGcCiFaEeuNp0=;
        b=tbvjCE6mEidsY+p6bK6XolBCfwF+zWpuISP+6Oin8H4xfJf5Oy7RJNK4oeN8I/W5vM
         1duCDfEOswC5sE+rHx4BlU+6Ltimt36O7VMUsssLaNuFyTwBJOkTS2o58MaWkeebOx2b
         +AH94kNL0ycGYpboERhhD+oeLCkGPnEhQkMnXTFEaCEiBNmwcowDVE+FoUzgQSuB4Vc1
         FfqlWW2FLomQxzAzIgNIWYbRdJvmI+G+u9qMt5I0QMXCW8OmG2w+ibdohcO3ZQYX8AfF
         Tx2bplrG2p5SVhJ48Sj3CoBuYD4AuaxFQtCG0wPJNuOCwO+SaHhym8+be1UzW07FUMT1
         Zg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1P5o0yfghl6fCiB/ecO8cbN4wTrqdIVGcCiFaEeuNp0=;
        b=D/KzH006FMTER36CRgdWDBpl/KamsUnrz3sQ6/S+vArOtPdqJGSrPw6i0/2lEQO8c/
         jB7rSyq54OikdotKOH3tDULsEU58J7uRQ9TiCJx2pBDX2KkxhUYaIVwOb76WBLHenY8a
         s5zPZO+0+bItXIonSRpyfIz3Vzugjxm6u7kzlXzZif1E85Pu+KsiqpPjSQ8hK3BzCldJ
         QwtigVSRdgJT7x9WN6IwTIEd7tfcTOBAhku0UrFYBYc/BqIQJlltKQveSi1GF+Lj2cdM
         F9OFH30Kd8Z6OxWKOGshcwwKYVQo++2kJ36rc2pnfnR3Li/qDImjSZpSy27TfQQwk7Su
         bezA==
X-Gm-Message-State: ABuFfoiPFxQPaSx97WRuBTfdMuOXQZY54yCfmfysrZ0L/oHQD6mEKO59
        d25qZ/ArOksW8i2J1MqakDF5/w==
X-Google-Smtp-Source: ACcGV60FAgOI3zR0JW/SUkb1k66z5CdiG/6SIhhDEPbwALmf325NkI4PWqP0x0x8D+nolfR610Fh3g==
X-Received: by 2002:a62:280a:: with SMTP id o10-v6mr3578742pfo.129.1537923968993;
        Tue, 25 Sep 2018 18:06:08 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id d12-v6sm4866363pfn.118.2018.09.25.18.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 18:06:07 -0700 (PDT)
Date:   Tue, 25 Sep 2018 18:06:06 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180926010606.GJ4364@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <xmqqfty2v9qj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfty2v9qj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 02:09:08PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > +core.alternateRefsCommand::
> > +	When listing references from an alternate (e.g., in the case of ".have"), use
>
> It is not clear how (e.g.,...) connects to what is said in the
> sentence.  "When advertising tips of available history from an
> alternate, use ..." without saying ".have" may be less cryptic.
>
> I dunno.

Thanks, I think that I tend to overuse both "e.g.," and "i.e.,". I took
your suggestion as above, which I think looks better than my original
prose.

> > +	the shell to execute the specified command instead of
> > +	linkgit:git-for-each-ref[1]. The first argument is the path of the alternate.
>
> "The path" meaning the absolute path?  Relative to the original
> object store?  Something else?

It's the absolute path, and I've updated the documentation to clarify it
as such.

> > +	Output must be of the form: `%(objectname) SPC %(refname)`.
> > ++
> > +This is useful when a repository only wishes to advertise some of its
> > +alternate's references as ".have"'s. For example, to only advertise branch
> > +heads, configure `core.alternateRefsCommand` to the path of a script which runs
> > +`git --git-dir="$1" for-each-ref refs/heads`.
> > +
> >  core.bare::
> >  	If true this repository is assumed to be 'bare' and has no
> >  	working directory associated with it.  If this is the case a
> > diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> > new file mode 100755
> > index 0000000000..2f21f1cb8f
> > --- /dev/null
> > +++ b/t/t5410-receive-pack.sh
> > @@ -0,0 +1,54 @@
> > +#!/bin/sh
> > +
> > +test_description='git receive-pack test'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +	test_commit one &&
> > +	git update-ref refs/heads/a HEAD &&
> > +	test_commit two &&
> > +	git update-ref refs/heads/b HEAD &&
> > +	test_commit three &&
> > +	git update-ref refs/heads/c HEAD &&
> > +	git clone --bare . fork &&
> > +	git clone fork pusher &&
> > +	(
> > +		cd fork &&
> > +		git config receive.advertisealternates true &&
>
> Hmph.  Do we have code to support this configuration variable?

We don't ;-). Peff's explanation of why is accurate, and the mistake is
mine.

> > +		cat <<-EOF | git update-ref --stdin &&
>
> Style: writing "<<-\EOF" instead would allow readers' eyes to
> coast over without having to look for $variable_references in
> the here-doc.
>
> > +		delete refs/heads/a
> > +		delete refs/heads/b
> > +		delete refs/heads/c
> > +		delete refs/heads/master
> > +		delete refs/tags/one
> > +		delete refs/tags/two
> > +		delete refs/tags/three

Thanks, it ended up being much cleaner to write <<-\EOF, and avoid the
unnecessary cat(1) entirely.

> So, the original created one/two/three/a/b/c/master, fork is a bare
> clone of it and has all these things, and then you deleted all of
> these?  What does fork have after this is done?  HEAD that is
> dangling?
>
> > +		EOF
> > +		echo "../../.git/objects" >objects/info/alternates
>
> When viewed from fork/objects, ../../.git is the GIT_DIR of the
> primary test repository, so that is where we borrow objects from.
>
> If we pruned the objects from fork's object store before this echo,
> we would have an almost empty repository that borrows from its
> alternates everything, which may make a more realistic sample case,
> but because you are only focusing on the ref advertisement, it does
> not matter that your fork is full of duplicate objects that are
> available from the alternates.

I could go either way. You're right in that we have only a dangling HEAD
reference in the fork, and that all of the objects are still there. I
suppose that we could gc the objects that are there, but I think (as you
note above) that it doesn't make a huge difference either way.

> > +expect_haves () {
> > +	printf "%s .have\n" $(git rev-parse $@) >expect
>
> Quote $@ inside dq pair, like $(git rev-parse "$@").

Thanks, I fixed this (per your and Eric's suggestion), but ended up
removing the function entirely anyway.

> > +extract_haves () {
> > +	depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
> > +}
>
> Don't pipe grep into sed, especially when both the pattern to filter
> and the operation to perform are simple.
>
> I am not sure what you are trying to achive with 'g' in
> s/pattern$//g; The anchor at the rightmost end of the pattern makes
> sure that the pattern matches only once per line at the end anyway,
> so "do this howmanyever times as we have match on each line" would
> not make any difference, no?

I admit to not fully understanding when the trailing `/g` is and is not
useful. Anyway, I took Peff's suggestion below to convert this 'grep |
sed' pipeline into a Perl invocation, which I think ended up much
cleaner.

Thanks,
Taylor
