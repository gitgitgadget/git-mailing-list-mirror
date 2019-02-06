Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ABC21F453
	for <e@80x24.org>; Wed,  6 Feb 2019 18:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBFSly (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:41:54 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41866 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFSly (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:41:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id b15so9020226qto.8
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 10:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w2ed6JcjbZ8lDPXqyd/TnIRx7aqIAm5G/BJr+5dRylc=;
        b=o0bPgYDXwvwkcFSJgzUUr2j2193VOfsUSaEsRZWkJ5iUVthssX9T8iwDIYkjw/v3SG
         aHIg6qgkgKArT8Xvh0dWnlIVH8LUGNP5bFC9KYS7TWh9fkWRvLRUBx3tmSSMPpjwHQze
         ivTh+030M3klHp/HjgmGoszL8dRQ8+y4HyjGd8b+plF9LYEj2Om+ejE7V6/i5/p5eHTx
         a8q334H0MGgSyXgVP2xZ+0Yht8QpBkIWq+mOqwWvbLnppdM8nelEUdpJH+H0AsCVsxCW
         cVEi4VqQnZn+CyVo1KXD6Hf7Xyf1tYV7n2M6yA/04AsDvrR8mVw9rSYlB8bxRcXkAnYH
         bfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=w2ed6JcjbZ8lDPXqyd/TnIRx7aqIAm5G/BJr+5dRylc=;
        b=Wp1lbj3swJLQ2rQeSVi/kCcnWSC3hW37+V0Dy14J1ks5FjHzOCfpG9Z02q6ddc5fTs
         L8Htx2ADVBAhDuSZ7w9Xra7v54npYfNOPNcVLxxez8sGXnAbKYde3BOXsceEvnFUcALO
         g0a3aja5m0m57MY6dpnDATRNtPwBBp/9r8UX+SYi9aQNDCznZ68XINhFU0gMja2Q8ySx
         NrLkdSJsVCdsn86hyDv/Ke64ZnXkrm+7Zd/rwIExL2Yuoaiq1CzMaQNWci0rXSbRE9C6
         MbZfMtqEWVmvdh1X8QP5G6yBJ7YZJYB6S/zVEgfz017CdlFJF9am4AybsMN/HDASbq47
         geiA==
X-Gm-Message-State: AHQUAuZXm7yOZ+kXS5NqVsY94OZnh1YO318XQMm+qtWlUg5T7Zf6OOHV
        0+nVV4c6ZQDCXxFgCiDT4FY=
X-Google-Smtp-Source: AHgI3IZAY7kPcqjz3kSGj8ryaQsUNiYsUII1H6whMfAnblbGTQF/IlDBVhJgYwxOZsIvDwZDUrD6qA==
X-Received: by 2002:ac8:4258:: with SMTP id r24mr8921729qtm.213.1549478512518;
        Wed, 06 Feb 2019 10:41:52 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id k55sm588976qtc.53.2019.02.06.10.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:41:51 -0800 (PST)
Received: (nullmailer pid 10940 invoked by uid 1000);
        Wed, 06 Feb 2019 18:41:49 -0000
Date:   Wed, 6 Feb 2019 12:41:49 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chutzpah@gentoo.org, williamh@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and
 committer idents
Message-ID: <20190206184149.GB10832@whubbs1.gaikai.biz>
References: <20190204184850.10040-1-williamh@gentoo.org>
 <20190205195212.25550-3-avarab@gmail.com>
 <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
 <87k1iekkea.fsf@evledraar.gmail.com>
 <87h8dhl0zh.fsf@evledraar.gmail.com>
 <20190206182612.GA10231@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190206182612.GA10231@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 01:26:12PM -0500, Jeff King wrote:
> On Wed, Feb 06, 2019 at 10:28:34AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> > I did some further digging. One of the confusing things is that we've
> > been carrying dead code since 2012 to set this
> > author_ident_explicitly_given variable. We can just apply this on top of
> > master:
> > [...]
> >     @@ -434,6 +432,2 @@ const char *git_author_info(int flag)
> >      {
> >     -	if (getenv("GIT_AUTHOR_NAME"))
> >     -		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
> >     -	if (getenv("GIT_AUTHOR_EMAIL"))
> >     -		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
> >      	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
> 
> Yeah, that would be OK with me. It's conceivable somebody ask "was the author
> ident sufficiently given", but given that 7 years have passed, it seems
> unlikely (and it's easy to resurrect it in the worst case).
> 
> But...
> 
> > A more complete "fix" is to entirely revert Jeff's d6991ceedc ("ident:
> > keep separate "explicit" flags for author and committer",
> > 2012-11-14). As he noted in 2012
> > (https://public-inbox.org/git/20121128182534.GA21020@sigill.intra.peff.net/):
> > 
> >     I do not know if anybody will ever care about the corner cases it
> >     fixes, so it is really just being defensive for future code.
> 
> I think that reintroduces some oddness. E.g., if I don't have any ident
> information set in config or the environment, and I do:
> 
>   GIT_AUTHOR_NAME=me GIT_AUTHOR_EMAIL=me@example.com git commit ...
> 
> that shouldn't count as "committer ident sufficiently given", and should
> still give a warning. So we wouldn't want to conflate them in a single
> flag (which is what d6991ceedc fixed). Curiously, though, I'm not sure
> you can trigger the problem through git-commit. It does call
> committer_ident_sufficiently_given(), but it never calls
> git_author_info(), where we set the flags!
> 
> Instead, it does its own parse via determine_author_info(), which does
> not bother to set the "explicit" flag at all. I suspect this could be
> refactored share more code with git_author_info() (which is what the
> plumbing commit-tree uses). But that's all a side note here.
> 
> There is one other call to check that the committer ident is
> sufficiently given, and that's in sequencer.c, when it prints a picked
> commit's info. That _might_ be triggerable (it doesn't call
> git_author_info() in that code path, but do_merge() does, so if the two
> happen in the same process, you'd not see the "Committer:" info line
> when you should).
> 
> So the bugs are minor and fairly unlikely. But I do think it's worth
> keeping the flags separate (even if we don't bother carrying an "author"
> one), just because it's an easy mistake to make.
> 
> An alternative view is that anybody who calls git_author_info() to
> create a commit _should_ be checking author_ident_sufficiently_given(),
> and it's a bug that they're not.
> 
> I.e., should we be doing something like this (and probably some other
> spots, too):
> 
> diff --git a/commit.c b/commit.c
> index a5333c7ac6..c99b311a48 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1419,8 +1419,11 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  	}
>  
>  	/* Person/date information */
> -	if (!author)
> +	if (!author) {
>  		author = git_author_info(IDENT_STRICT);
> +		if (!author_ident_sufficiently_given())
> +			warning("your author ident was auto-detected, etc...");
> +	}
>  	strbuf_addf(&buffer, "author %s\n", author);
>  	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
>  	if (!encoding_is_utf8)
> 
> I dunno. It seems pretty low priority, and nobody has even noticed after
> all these years. So I'm not sure if it's worth spending too much time on
> it.

Given this info (which came in while I was writing my last email), I
would rather see my v5 patch get in then we fix everything else later.

Junio, what do you think?

Thanks,

William

