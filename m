Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8381201A7
	for <e@80x24.org>; Wed, 17 May 2017 23:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbdEQX7v (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 19:59:51 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34168 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbdEQX7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 19:59:50 -0400
Received: by mail-pg0-f48.google.com with SMTP id u28so14161995pgn.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 16:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FydoiTWPyH6+qLtCHqikPRe+d6TFfjUnGf8esYPh4zo=;
        b=g1JBVPxjPgqnYKBmt5KZd+Zxrg3Fs0WaxkYC99N1W2oJkZmoBRP9IhGiGdUsanvbaR
         NVAUlyk/oyBGw7np327ulFQDdBI4X3I6J/ILUHuEzGUhAHcA3dH/uwWviSeGilbHsneY
         82evvwBAHfMBgPCS3sXuSCve1ORePMn85g0wyooN6+TF7vm5o5dUWXHR+TdzDR+/tWFE
         gEN49rkzJqMar6sP7932i1pylR0Iwe4bFD8gQg1wbntq9BxFO9k/LeVtYrKmBc7FivHC
         VZxgZVdB2s5Sb4JrDe3ZJcEIBfhAHEFwsT05HFVM4JQs24N+h6bP1TjfoGerlKAAR6cW
         pQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FydoiTWPyH6+qLtCHqikPRe+d6TFfjUnGf8esYPh4zo=;
        b=PrFLLH1GxwXLczU7kiKT4GvFUI890jH4W2qcmQ8m53bAtJ63vbELxDKFkHLj28ub4X
         H0Ajs3SX1CRjvrCKq8JzeCfOLPZ625Z/cZxrKIb8G/mkg5AcBqVDAJ/e2atkPk/tnKh8
         zqy3Co0kEunpUXRbULQCQ3dhU3APQkPH+ssz1u1psfzMBYuUZBw6iI2M4Y/zbRLmgK5e
         zGWki0DaJtX8jGWWLt2TgABkZB+W7H4Cypplp0807xx+TtISPmPnyvjMtabUobxxWeGn
         sqHYz08qBHwEQYExkRyuUgWzyXYt0Rg1l8zoamieZ0AzbjqzCslNMhxqczZzTyLFVFoh
         nAYA==
X-Gm-Message-State: AODbwcCa3elYehqdTw+xYicoq3nEAohGFWRzZcOAIgIsh+sPV64BNWbb
        1ArPp3WaDTedZXYz
X-Received: by 10.99.127.73 with SMTP id p9mr1248742pgn.169.1495065589924;
        Wed, 17 May 2017 16:59:49 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1838:1185:c4dc:8c8d])
        by smtp.gmail.com with ESMTPSA id p10sm6129838pgf.63.2017.05.17.16.59.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 16:59:48 -0700 (PDT)
Date:   Wed, 17 May 2017 16:59:47 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Joey Hess <id@joeyh.name>
Subject: Re: [PATCH] tests: add an optional test to test git-annex
Message-ID: <20170517235947.GC185461@google.com>
References: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net>
 <20170516203712.15921-1-avarab@gmail.com>
 <xmqq7f1gyzep.fsf@gitster.mtv.corp.google.com>
 <CACBZZX4Jppr7ht7m444EjW4CDYX5CMvnxtStH4bF=A19TYKcZg@mail.gmail.com>
 <xmqqbmqrwzu1.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5BrASFemN2VviMjH-AqnxU6veLVmjRdn1iYuA9fgKQog@mail.gmail.com>
 <CAGZ79kYX8ct4GKDbZxGJmR5kkVrs4zjnaKOaD8Dm8rKx8aPA+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79kYX8ct4GKDbZxGJmR5kkVrs4zjnaKOaD8Dm8rKx8aPA+Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17, Stefan Beller wrote:
> On Wed, May 17, 2017 at 12:33 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > On Wed, May 17, 2017 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >>
> >>>> Well, it is one thing to place git-annex under CI to make sure its
> >>>> latest and greatest works together well with our latest and greatest
> >>>> (and it may be something we want to see happen), but driving its
> >>>> tests from our testsuite sounds like a tail wagging the dog, at
> >>>> least to me.
> >>>
> >>> To me this is just a question of:
> >>>
> >>> * Is it the case that git-annex tests for a lot of edge cases we don't
> >>> test for: Yes, probably. As evidenced by them spotting this
> >>> regression, and not us.
> >>
> >> And I'd encourage them to keep doing so.
> >
> > The point of this patch is that we can do this more systematically and
> > reliably, not have people discover this sort of thing after a major
> > release.
> >
> > I.e. we can be pro-active about this instead of waiting for bug
> > reports to roll in.
> 
> We can be pro-active without this patch, too. ;)
> I guess this makes it just easier for someone out of the Git community to
> be proactive in searching for defects.
> 
> >
> > The utility of this test is that sometime close to release someone
> > (e.g. me) can run it, if it fails let's see if it fails on the last
> > release version of ours, if so it's probably upstream breakage, or
> > like with the 2.13.0 release if it's OK on 2.12.0 it's our bug.
> >
> > It'll never trip some random tester up since you need to explicitly
> > opt-in via EXTERNAL_TESTS=1, so honestly I'm a bit puzzled by these
> > objections. This incurs no burden on either devs, packagers or users,
> > and would have demonstrably detected an issue we'd rather have wanted
> > to know about pre-release than post-release as is the case now.
> 
> I think this patch could spark a discussion what we expect from our test suite.
> Is it a contract that we promise, as in "Here are some blessed workflows,
> our users should see and imitate"?
> 
> This patch sort of feels like (a) we let others dictate the contract to us
> and (b) we choose the easy way out as we do not write enough tests on
> our own, so we force downstream to help us out.
> 
> I guess it is appropriate to compare this level of testing to other external
> tests, such as cppcheck, travis, coverity. For some of them (travis) we
> carry some code with us (.travis), not so for others (coverity would benefit
> from [1] that I carry outside of Junios tree). Admittedly these external tools
> are all focused on testing, not on building on top of Git, which brings
> in other expectations from these tools.
> 
> [1] https://github.com/stefanbeller/git/commit/0781fbafb9dd2a995ba62a9af5f7581e3cf05359
> 
> ---
> As mentioned in the other thread[2], the idea was floated to have this test or
> the downstream project as a submodule, and if you are interested in the test,
> then you would obtain the submodule and run the tests (in there?)

Despite working on improving submodules, I'm still very skeptical of
adding submodules to git.git, at least at this point in time.  I just
feel like the submodule experience still has a lot of work before we
begin using it...Though My feeling may be completely unfounded.

> That would have the benefit of less 'uninteresting' glue logic for those who
> are not interested in these tests as gitlinks may be easier to ignore
> for a developer
> than code. (Less data to fetch, git-grep also doesn't yield results
> for the uninteresting
> parts as these submodules would be uninitialized).
> (The more I talk about this "downstream tests in submodules"
> idea, the less convinced I am)
> 
> [2] https://public-inbox.org/git/20170517113824.31700-1-avarab@gmail.com/

-- 
Brandon Williams
