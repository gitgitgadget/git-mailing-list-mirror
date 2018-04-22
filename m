Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690901F424
	for <e@80x24.org>; Sun, 22 Apr 2018 23:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbeDVXeH (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 19:34:07 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36219 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeDVXeG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 19:34:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id g14so7691146pfh.3
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 16:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aBg8Zf0l6ukX/xMODPAoIBFjzkAX/m8H0OSAT/YHHQk=;
        b=m51xj0bqUz1P1DQXPNfcX4oNHtmcPJnQtmCEA+/ZOeTAZEGSKeREJIaQxSDFWHpKFe
         lFzYqsbLmKq8HUSMXYRM7dHHeScJbsClb49gxvszKY3M5Rmgq63DuG59TvDe7ZiTkHVu
         VtVcs4HHBqWRN+XcgZ3j+Zd7rKOye/HgHVz0jj2sPg5STZD1SAWpW0thqbZ22jwnc1JJ
         Ku/d99k2IPOucCMfYkKOD3lj25HxcM7PS0Ogfe3P7g1zs8pJLU4Xx9lTIYb8YtCufnha
         32fR47wr85keJk2YH/buDjqVMi4fvYQrajRNVd2rL3UHI1eG0MB8SxTtToaWBHP9Ih/y
         Y8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aBg8Zf0l6ukX/xMODPAoIBFjzkAX/m8H0OSAT/YHHQk=;
        b=ckHWzRWbID3qoL5BPtAwPRo2+ix4EQJqFUMe+QhRSLY/bNHqq55p4U0UoFXYRpjQWm
         1D36Uks6dkOKFMerGzfTEhgkuNeT/yL92zUjvkXPruYzEW9uc/YLV2PovUxXe2DAU+8L
         WUo2aRE/m6g+ZShVIElTkP5aKAjrek4N4+pbacYgAwRrJ45ZB4/qe2H2nA8E/OfyRcgr
         KM27iJPmq8rUjHVGUjhYgn6RvD/vK72f8gDE4KLsjIFn3d2Es9os+GDeb2yGw1XhNyKn
         IvafxxhHzCa9bOOFLN8UTeI2q9XyMD1X49ZHLcVSo6B0gcmuNJ3wanVHTsez/8H7sm00
         v5vg==
X-Gm-Message-State: ALQs6tBnSM3HtEloQXK6urIh2tlqpzQblGt7iU0R5YdayJB8UmF+6qDW
        QfXCmEN0I8yHQeC0HRGd0bna5Q==
X-Google-Smtp-Source: AIpwx492XEpFraItgFo7m4MohupHsRWCm7vRvJjldA7SWlrH/iLrWcKtCHw91RYvrHx+iN3GbyC5Qg==
X-Received: by 2002:a17:902:5389:: with SMTP id c9-v6mr8970596pli.143.1524440045985;
        Sun, 22 Apr 2018 16:34:05 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id j1sm14888497pgn.69.2018.04.22.16.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 16:34:04 -0700 (PDT)
Date:   Sun, 22 Apr 2018 16:34:03 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 0/6] Teach '--column-number' to 'git-grep(1)'
Message-ID: <20180422233403.GE48072@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
 <xmqqsh7makj5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh7makj5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 08:28:14AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> > index 0cf654824d..7349c7fadc 100755
> > --- a/t/t7810-grep.sh
> > +++ b/t/t7810-grep.sh
> > @@ -106,7 +106,7 @@ do
> >  			echo ${HC}file:5:foo mmap bar_mmap
> >  			echo ${HC}file:14:foo_mmap bar mmap baz
> >  		} >expected &&
> > -		git -c grep.linenumber=false grep -m -w -e mmap $H >actual &&
> > +		git grep --column-number -w -e mmap $H >actual &&
> >  		test_cmp expected actual
> >  	'
> >
> > @@ -117,7 +117,7 @@ do
> >  			echo ${HC}file:4:5:foo mmap bar_mmap
> >  			echo ${HC}file:5:14:foo_mmap bar mmap baz
> >  		} >expected &&
> > -		git -c grep.linenumber=false grep -n -m -w -e mmap $H >actual &&
> > +		git grep -n --column-number -w -e mmap $H >actual &&
> >  		test_cmp expected actual
> >  	'
>
> It seems that these two used to be "even when it is configured not
> to show linenumber, with -n it is shown and without -n it is not,
> when the new --column-number feature forces the command to show the
> "filename plus colon plus location info plus coon" header.  I'm
> guessing that the reason why these got changed this round is because
> the old way was found too defensive (perhaps nobody sets
> grep.linenumber in .git/config in the tests that come before these)?

Sort of. My aim with these new tests is to ensure that git-grep(1) works
with:

  - '--line-number'
  - '--column-number'
  - '--line-number' and '--column-number' together

It seemed unrelated to be testing the various permutations of
grep.linenumber and --line-number along with the above three so I
removed these in order to focus only on the above three.

Do you think that it is worth testing --column-number with and without
grep.columnnumber as above?


Thanks,
Taylor
