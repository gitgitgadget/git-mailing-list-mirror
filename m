Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C991F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 11:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeKSVja (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 16:39:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36707 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeKSVja (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 16:39:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so15781052edb.3
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 03:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=URIXo9+y6qIWGVY3q1tXFo4rBVf0gydQNv5ZDCxc0V0=;
        b=aTa9Uc5OfLTo5gy3Wb+VaF9CIA5HSqByQCGolHCf4MG0d0aDL+g/IPLpZQLSLfCQ/L
         JgDiXzH3ViS3yOah/4Z/fZC33PjGwj2xpSJsVmDjp6X7RRX2Lkq2PMM+d6uIB+kwSP/t
         T/B9fPRYpDrBZzvjANE8O2Rs5JOKUZdyMBDvul2R8U5lI5nDBpuep3KwiNA5P6pB7mY3
         twNCcg/wIjIzMAallbttWj+s122Gs0nFVVTSSkXZjdaDSBiR2lVRrgYzj3SPKLVTXy3+
         PjXAaspD+INMTKBlFhNq3URgTze+OpqwK3SjeB64Pwslk2K0KyhHFR59i6u5hzzUFTGi
         hHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=URIXo9+y6qIWGVY3q1tXFo4rBVf0gydQNv5ZDCxc0V0=;
        b=oJL5Q1eJPFOjiCirWNi6I8x9go7ovSQyKeXWNvlu3xv34G11bvT4jSAOpAj7uSDf2N
         souxnR4HJg+KUGCX+UD4vva3vP7I0woSoNToU87Mj9bdI9RxwFCMRuCodnZSVpAHy+PF
         Lj1Ew/X09yyBpaDRM52XiGje49SOfrGBHw15QuQZ7v6uKouDP3Cc9A8CnLzF6EgpvllX
         g083TBFCyMu8WVCE06WhsxlmbHQ85k2T3VpJhRTKCMwJGFFIUCUa9GPaCqzjCWlcrzbz
         o00u9eVGFM8t1IRyygpQjufvzNPaG2qnahchk/6NAEFpKDgapccPJkRqdNjcCsENgkVi
         owlw==
X-Gm-Message-State: AGRZ1gLNiAS6iFGsxNMNA1T0Q6ATZsC/hrHsOx+svQo8238f2JfR83yp
        vF8Tn4uQHhzXk8w33EgdJa8=
X-Google-Smtp-Source: AJdET5fpHPTN2BWvhkrAhbU3lgklIXH60rZ84xfPajvvZCFyc6mYecplT9amCHGCH6r3nb5kgKk7bQ==
X-Received: by 2002:a50:bb08:: with SMTP id y8mr19897838ede.10.1542626169848;
        Mon, 19 Nov 2018 03:16:09 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id w24-v6sm842672eja.71.2018.11.19.03.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 03:16:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Make :(attr) pathspec work with "git log"
References: <20181118164800.32759-1-pclouds@gmail.com> <87d0r217vr.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87d0r217vr.fsf@evledraar.gmail.com>
Date:   Mon, 19 Nov 2018 12:16:08 +0100
Message-ID: <878t1p1fnr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 18 2018, Ævar Arnfjörð Bjarmason wrote:

> On Sun, Nov 18 2018, Nguyễn Thái Ngọc Duy wrote:
>
>> When :(attr) was added, it supported one of the two main pathspec
>> matching functions, the one that works on a list of paths. The other
>> one works on a tree, tree_entry_interesting(), which gets :(attr)
>> support in this series.
>>
>> With this, "git grep <pattern> <tree> -- :(attr)" or "git log :(attr)"
>> will not abort with BUG() anymore.
>>
>> But this also reveals an interesting thing: even though we walk on a
>> tree, we check attributes from _worktree_ (and optionally fall back to
>> the index). This is how attributes are implemented since forever. I
>> think this is not a big deal if we communicate clearly with the user.
>> But otherwise, this series can be scraped, as reading attributes from
>> a specific tree could be a lot of work.
>
> I'm very happy to see this implemented, and I think the behavior
> described here is the right way to go. E.g. in git.git we have diff=perl
> entries in .gitattributes. It would suck if:
>
>     git log ':(attr:diff=perl)'
>
> Would only list commits as far as 20460635a8 (".gitattributes: use the
> "perl" differ for Perl", 2018-04-26), since that's when we stop having
> that attribute. Ditto for wanting to run "grep" on e.g. perl files in
> 2.12.0.
>
> I have also run into cases where I want to use a .gitattributes file
> from a specific commit. E.g. when writing pre-receive hooks where I've
> wanted the .gitattributes of the commit being pushed to configure
> something about it. But as you note this isn't supported at all.
>
> But a concern is whether we should be making :(attr:*) behave like this
> for now. Are we going to regret it later? I don't think so, I think
> wanting to use the current working tree's / index's is the most sane
> default, and if we get the ability to read it from revisions as we
> e.g. walk the log it would make most sense to just call that
> :(treeattr:*) or something like that.

As an aside, how do you do the inverse of matching for an attribute by
value? I.e.:

    $ git ls-files | wc -l; git ls-files ':(attr:diff=perl)' | wc -l
    3522
    65

I'd like something gives me all files that don't match diff=perl,
i.e. 3522-65 = 3457 files, or what I'd get if I constructed such a match
manually with excludes:

    $ git ls-files $(grep diff=perl .gitattributes | cut -d ' ' -f1 | sed 's!^!:(exclude)!') | wc -l
    3457

From my reading of parse_pathspec_attr_match() and match_attrs() this
isn't possible and I'd need to support ':(attr:diff!=perl)' via a new
MATCH_NOT_VALUE mode. But I wanted to make sure I wasn't missing some
subtlety, i.e. that this was implemented already via some other feature.

I thought I could do:

    git ls-files ':(exclude):(attr:diff=perl)'

But we don't support chaining like that, and this would only exclude a
file that's actually called ":(attr:diff=perl)". I.e. created via
something like "touch ':(attr:diff=perl)'".
