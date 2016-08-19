Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC0E1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 14:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbcHSOmu (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 10:42:50 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35759 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754167AbcHSOmt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 10:42:49 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so3523900pad.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6+kidOmEcY90lDu+VC60Cqbnub7y/oxxtcsqHOESFbs=;
        b=tgNGyldqgHsKnTjxFXsn+HnzujJVYkt/U2qjXNHM/bV4ltQWGjFS17dvkmuWagqQaR
         ZI0ROp2k6Lks5zQ29G1MRVhTvrlHk2WKZb2van1J+avjHrdOs5y9Y2dP5WXe5luYRPus
         3AJtMDxWIy76vS9XOzvYUvPqbjlQCZxYQsQsPsZfy12hr/NaUlhgwK8n+H6EZQV6Zlr3
         FmX6yGnLlW6uPrpVHRuQX3wV277EctNzFJpynz7s5Rt2G/76M9x9a2KSqyV7xXpbGCHo
         h/Y7eEPzaRaMCy4Hqb0oMOeKTT1D2w/AIsqC7z8kpjuhKPo/PP/DrbLlQEGsDW/s3uWi
         9L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6+kidOmEcY90lDu+VC60Cqbnub7y/oxxtcsqHOESFbs=;
        b=cbTc9j/40LdvK10Dz1eSaaSkWfyEU0+9T67crlSdH4CJOCfN8PMHQ5Wg0KADzuRQnL
         RZ/jAIb6xdNyu1efWDvSTmUtkoMu0mlttKFFYIJh/Z72JaBkQelA0Dr2gRh+RGwIjAOT
         LV+ObbUJ/mngRh9Lme3fbPmeL0ambwIWGERGBc+tm4lvG+HNCkhe+vdOXyoXeDWyjDIc
         rlm7hH7XmYQL22nJUXxSOOb6HBCIhO1oAVaGVUpQzn136L7SpdHtT2o6kwZ4Pmz/fAkw
         hVDHcmMHBA2kbMNZ1C8VqXd66zd3slshBxCAc8Vz9etTdj/HhJykMNS/niKLMDZ+dDbi
         nLaQ==
X-Gm-Message-State: AEkooutUHBXv4stWqLfJpLnqfpdZqg6H4aCBcRNx8ruJoXj5fW9sgVn6bunpANmgOQa+iQ==
X-Received: by 10.66.139.227 with SMTP id rb3mr14311075pab.26.1471617758064;
        Fri, 19 Aug 2016 07:42:38 -0700 (PDT)
Received: from tci.corp.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id z187sm7241549pfz.39.2016.08.19.07.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2016 07:42:37 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
X-Google-Original-From: Brian Henderson <bhenderson@yp.com>
Date:   Fri, 19 Aug 2016 07:42:35 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brian Henderson <henderson.bj@gmail.com>, git@vger.kernel.org,
        peff@peff.net, e@80x24.org
Subject: Re: [PATCH v2 1/3] diff-highlight: add some tests.
Message-ID: <20160819144235.GA29458@tci.corp.yp.com>
References: <20160817153124.7770-1-henderson.bj@gmail.com>
 <20160810085635.GA1672@starla>
 <20160817153124.7770-2-henderson.bj@gmail.com>
 <xmqqziob8b6i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqziob8b6i.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2016 at 12:09:25PM -0700, Junio C Hamano wrote:
> Brian Henderson <henderson.bj@gmail.com> writes:

<snip>

> 
> > +
> > +# PERL is required, but assumed to be present, although not necessarily modern
> > +# some tests require 5.8
> > +test_expect_success PERL 'name' 'true'
> 
> If the platform lacks PERL prerequisite, this will simply be
> skipped, and if the platform has it, it will always succeed.
> 
> I am not sure what you are trying to achieve by having this line
> here.

I originally didn't have this line, and my comment was referring to the
t/README which says

   Even without the PERL prerequisite, tests can assume there is a
   usable perl interpreter at $PERL_PATH, though it need not be
   particularly modern.

There is current functionality in diff-highlight which requires at least
perl 5.8 (the utf8 functions). I was going to add a test for this as
well, but I'm not super comfy with multibyte chars.

Eric recommended adding this line, what do you think?

would `test_set_prereq PERL` be better?

> 
> > +test_expect_success 'diff-highlight does not highlight whole line' '
> > +	dh_test \
> > +		"aaa\nbbb\nccc\n" \
> > +		"aaa\n000\nccc\n"
> > +'

This (at least to me) is desired. See comment for `sub
is_pair_interesting`

> 
> Hmm, does this express the desired outcome, or just document the
> current (possibly broken--I dunno) behaviour?  The same question for
> the next one.
> 
> > +test_expect_success 'diff-highlight does not highlight mismatched hunk size' '
> > +	dh_test \
> > +		"aaa\nbbb\n" \
> > +		"aaa\nb0b\nccc\n"
> > +'

This is undesired behavior, but currently implemented for simplicity,
see `sub show_hunk`

Do they need comments or something?

<snip>

> 
> > +	test -s diff.act &&
> 
> Why?  If you always have the expected output that you are going to
> compare with, wouldn't that sufficient to do that test without this?
> Besides, having "test -s" means that you can never make sure that a
> certain pair of input does not show any changes.  Perhaps drop it?

I was trying to address Eric's concern for `printf` or `git commit` et
al failing. Also, this file will always be a diff, it just might not
having any highlighting (so not empty?).

I'll take another stab.

> 
> > +	diff diff.exp diff.act
> 
> Use test_cmp unless there is a strong reason why you shouldn't?
> 
> > +}
> > +
> > +dh_commit_test() {
> > +	a="$1" b="$2"
> > +
> > +	printf "$a" >file
> > +	git add file
> > +	git commit -m"Add a file" >/dev/null
> 
> Avoid sticking a short-option to its argument, i.e.
> 
>     git commit -m "Add a file"
> 
> > +
> > +	printf "$b" >file
> > +	git commit -am"Update a file" >/dev/null
> 
> Likewise.
> 
>     git commit -a -m "Update a file"
> 
> The remainder of the file invites the same set of questions and
> comments you see for dh_diff_test() above, so I won't repeat them.
> 
> Thanks.

thanks for the feedback.
