Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408F020248
	for <e@80x24.org>; Sun, 17 Mar 2019 20:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCQUGN (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 16:06:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37096 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUGN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 16:06:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15so14773362wro.4
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GKaoqGufR8VuGmYTxEqpMgQbQ2iB9iz71czLd2n3+ok=;
        b=ZXRM3V7SETScMhdAR8JFjB5jC0pLwwRn7yJpCFbhMbIxvrpV9K+wr1JXg02UJj2i0H
         whA2/XfJl5PY6cZ9z1CH/7N7k6Y0yLbX5TMrniZETcY1a4qUvvNv6v2CY20kRPvXHHrW
         l+e/ahTOTSWZSgpuOyxx5qWEB6UGptVaMcd8lGXSfnPlbVXRTHC1aMhGTvd/pRgW1O1r
         8YHM4vC582ri2fsJKGwN6bvbzUIVWz/5OFgbWCagt+0Abi/4wVXmTxHHIyhOJV9ZLpDA
         +IIPQXLiEPeTdbAozVNQGmERM7qthQqKPrfF7oTpa2uIgAlfhkMCzxieuu+XmPZKauZU
         pckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GKaoqGufR8VuGmYTxEqpMgQbQ2iB9iz71czLd2n3+ok=;
        b=bvHiWZJEZix0Kmyj3kbfRLFn8wNSApuKB1HrsBlkuXXXq64QtorghF3vHsHVgeJGR1
         L3F+yF7/eTnwSTtRIQXOFhOwu2qKhsxlm/djmfKjoUBnq3Vd0sIfiUc80tMaHm48e/0L
         X8jNOQhWGNYvemEbvMzFwNn8qrMlBcRrtfrCq1YCnVnPd8a1euZjPq1ApgprqYj5l56F
         33k1IvEXmFKSXcNPA/WYCNcX0PCUFB19IEbiG9fDqUMWMv2w7OZEhHgDHSPittxNcxYI
         SJ1qohrAM+QeKQHl7j8cCKRf0DU+xx/xU9KMTubMZg9d3G18sNBv6A+xcWmODAE4Y+fh
         FxQg==
X-Gm-Message-State: APjAAAWJZnjJ14INAKeFkxmPFZPxVvIkNi7Muzo0LNFU/XdCT0oP0DAg
        Cf7sKnmT3RQl96dCF2wuUVw=
X-Google-Smtp-Source: APXvYqx4+OH8KKIW7FtOVCFQLL1bLhEeTnSoX/orF7bqoy2wX4sAU8TSNwT3NZesGYmDXiRm86FfHA==
X-Received: by 2002:a5d:69c1:: with SMTP id s1mr10498443wrw.245.1552853171282;
        Sun, 17 Mar 2019 13:06:11 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id w8sm6867372wmc.0.2019.03.17.13.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 13:06:09 -0700 (PDT)
Date:   Sun, 17 Mar 2019 20:06:09 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v3 3/3] t0000: use test_line_count instead of wc -l
Message-ID: <20190317200609.GA1216@hank.intra.tgummerer.com>
References: <cover.1552835153.git.ttjtftx@gmail.com>
 <bc3dee82a91592e50fd39c5a332b13b76fefa009.1552835153.git.ttjtftx@gmail.com>
 <87h8c1a1mi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8c1a1mi.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/17, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Mar 17 2019, Jonathan Chang wrote:
> 
> > Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> > ---
> >  t/t0000-basic.sh | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > index 47666b013e..3de13daabe 100755
> > --- a/t/t0000-basic.sh
> > +++ b/t/t0000-basic.sh
> > @@ -1136,8 +1136,8 @@ test_expect_success 'git commit-tree omits duplicated parent in a commit' '
> >  	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | sort -u) &&
> >  	test "z$commit0" = "z$parent" &&
> >  	git show --pretty=raw $commit2 >actual &&
> > -	numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
> > -	test $numparent = 1
> > +	sed -n -e "s/^parent //p" -e "/^author /q" actual >parents &&
> > +	test_line_count = 1 parents
> >  '
> >
> >  test_expect_success 'update-index D/F conflict' '
> > @@ -1146,8 +1146,7 @@ test_expect_success 'update-index D/F conflict' '
> >  	mv tmp path2 &&
> >  	git update-index --add --replace path2 path0/file2 &&
> >  	git ls-files path0 >actual &&
> > -	numpath0=$(wc -l <actual) &&
> > -	test $numpath0 = 1
> > +	test_line_count = 1 actual
> >  '
> 
> ...of course reading this series in sequence I find that 50% of my
> suggestions for 2/3 are then done in this patch... :)

Indeed.  I think doing this in a separate patch is a good idea, as it
makes the previous patch slightly easier to review imho.  But I think
something to take away from this for Jonathan would be that this
should have been described in the commit message of the previous
commit.  Maybe something like

    This commit doesn't make any additional simplifications, such as
    using the test_line_count function for counting the lines in the
    output.  These simplifications will be made in a subsequent commit.

in addition to the existing commit message would have helped save a
bit of review effort.
