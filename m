Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A3F51F462
	for <e@80x24.org>; Fri, 24 May 2019 11:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390918AbfEXLhP (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 07:37:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390760AbfEXLhO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 07:37:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so9690467wrt.1
        for <git@vger.kernel.org>; Fri, 24 May 2019 04:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ar9Gt2EKyFQTnkPcAIDQaeF7EbeHQWypTtnlcXSq8so=;
        b=foUoRWZPrPCdFhMYL3KRR7bRwnV6FQej8jLP5L4XWYQ4bpGX+kXYtHYUipHAZ08lpB
         +jvuuecsBx87yKJu5ulCn3zKwQxPSI78h4mdfKOb3XA9xO/7IhqCLyV8oMUybDhmhmcR
         rKLQ8L5oZn89I72dlMwEYOButS/VqUzM0LCxeEwZ50FE4kyPVHXsaEeqRe4s64jveZ3h
         6MRN+CIO7dU+6vtUtM7ilQaJen7bYvtqvqxIx+wxP/tKH215qlXd2JPafTkBdbMhJy0K
         AvW0P+7G84/smx/A83Tc3oWedm+Ztf8q+m9g7LufA2TajOLna2XwGSfteRSxKZ7vPAKw
         KpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ar9Gt2EKyFQTnkPcAIDQaeF7EbeHQWypTtnlcXSq8so=;
        b=IBc2mawkaLyNJP6yQ8px01L5q5iw1wd/+kgedM0OojigFnQzEUCql5SwGl1BYeBdV/
         M3NOlL8rz28ZsHuU5naShxRW+CySUwwdzg1ic+h8elJgwdPDKI3DjJke8RUauG7mnVH6
         q6A4AjRhsvw507QCgrRTjnpETGlnlvvG5Yq4qRw7sww6fhsN161iTaLAj9bPBETl5GBK
         VArnXM2KFF695DjUwIljhMdLe0fBflPjHhV8VWypD7MIov8ikeufCS+7GNyNvl50uJK9
         XmdNpJk54mGsJ/A4f7hekg/48wG9hCJMAeUUZ60hDFV3O5KYuhxbhW0qhSzaIkWhudl9
         SKsA==
X-Gm-Message-State: APjAAAXtNWIvm8GTM0gBToZUIYss+rcs00KeOCbmJ6hi9s7hTxTHVfdC
        kkCl+8tQZtfptY5ZKCqm0Yed2I8V
X-Google-Smtp-Source: APXvYqwYSXnjk7dybwpQla9qpKvCRnUAKlCs3Tys+f75QOR8oiKyIhET+CI43xzri8YKBsn9k0xIhg==
X-Received: by 2002:adf:e309:: with SMTP id b9mr61019672wrj.135.1558697833222;
        Fri, 24 May 2019 04:37:13 -0700 (PDT)
Received: from szeder.dev (x4db30b59.dyn.telefonica.de. [77.179.11.89])
        by smtp.gmail.com with ESMTPSA id f16sm2172351wrx.58.2019.05.24.04.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:37:12 -0700 (PDT)
Date:   Fri, 24 May 2019 13:37:10 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Karl Ostmo <kostmo@gmail.com>, git@vger.kernel.org
Subject: Re: standalone library/tool to query commit-graph?
Message-ID: <20190524113710.GG951@szeder.dev>
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com>
 <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com>
 <86blztq8ap.fsf@gmail.com>
 <87tvdkg7ld.fsf@evledraar.gmail.com>
 <20190523222031.GC951@szeder.dev>
 <f05405d7-c78d-a0e4-75a1-d623f977400a@gmail.com>
 <20190524093459.GE951@szeder.dev>
 <87o93sfahj.fsf@evledraar.gmail.com>
 <20190524100653.GF951@szeder.dev>
 <87k1egf7pz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1egf7pz.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 12:49:12PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> > On Thu, May 23, 2019 at 07:48:33PM -0400, Derrick Stolee wrote:
> >> >> On 5/23/2019 6:20 PM, SZEDER Gábor wrote:
> >> >> > On Thu, May 23, 2019 at 11:54:22PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> >
> >> >> >> and since the commit graph doesn't include any commits outside of
> >> >> >> packs you'd miss any loose commits.
> >> >> >
> >> >> > No, the commit-graph includes loose commits as well.
> >> >>
> >> >> Depends on how you build the commit-graph.
> >> >
> >> > Yeah; I just didn't want to go into details, hoping that this short
> >> > reply will be enough to jog Ævar's memory to recall our earlier
> >> > discussion about this :)
> >>
> >> To clarify (and I should have said) I meant it'll include only packed
> >> commits in the mode Karl Ostmo invoked it in, as Derrick points out.
> >
> > No, even in that mode it will include loose objects as well, if it has
> > to; that's what the "and closes under reachability" part of Derrick's
> > reply means and that's what I showed in our earlier discussion at:
> >
> >   https://public-inbox.org/git/20190322154943.GF22459@szeder.dev/
> 
> I should have said "include any commits outside of packs [to seed the
> revision walk]".
> 
> As you correctly point out there *are* caveats to that, e.g. it's
> possible to have packs & loose commits but you include everything
> because of reachability.
> 
> For the purposes of the discussion Jakub started upthread the
> not-quite-correct-but-close-enough mental model that we generally tend
> to accumulate loose objects that later coalesce into packs is close
> enough.
> 
> I.e. for that reason for most users a "git commit-graph write" won't
> produce a graph with all reachable commits, e.g. try cloning git.git,
> "git am"-ing a patch on top, and generate it again, it'll be the same
> (unless you picked a humongous patch).

Ok, with this I finally understand what you meant.

And it just reinforces my long-held belief that '--reachable' should be
the default for 'git commit-graph write'...

