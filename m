Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797101F461
	for <e@80x24.org>; Thu, 22 Aug 2019 17:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfHVRTm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 13:19:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40252 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390299AbfHVRIY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so4369632pfn.7
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L6T3nu2wGnQFOWEFZFU36n3P80k2EY9ZaPrlyYz01vg=;
        b=ABMjCcqYUaK7LtADWjnnQUt+BiM+qEVcBXI3YLqpNW8SNadhNVlfkh3qeZ8FezqJM1
         FoJNEO5K5a3rgldsqfh7AQ1u0J5EceI4iykxOVpXHFxQe8vxyENMbPfBk6vjNblvJNpF
         aekkEB/pb5yVnRP9meNsDtWT8kHOi60jx8cjgkqRt5taJwZ4ubiqgkkwdql/+GMCjkMU
         kopwhsrnbsJbH9PU8/2IOHmKnOWTssot0x3O4EiOKXOafbMCAFTrIIam/9IhT5Za45BV
         eoKPOA3y54EqBEDV3P9sJaUKv4jrRaEs8CxRFZqZ0Xj/7PBh3SgyBsjEZcbfgONzUO5f
         /GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L6T3nu2wGnQFOWEFZFU36n3P80k2EY9ZaPrlyYz01vg=;
        b=FW2ij/JFo2Hzy8RT1vya3CSy85hi0lrQ3tajDRZIoMVhIxXcZAURZK7EMEuaRhVv2v
         nskqIu1PVGqfB+mEBNUPoSgh0Y3ZAnLlXFPCX+/lEokmDCn//slpSDdUjtHGNSgghTC9
         wnEI7NRLMtfUI5nHzK2txZyZD0oIM9poZNxC/he6srgB39NqKn+TofVtUYmzaTeHuU6o
         tlY9IRJNRdqnppHZJnVgBgDf9+YHjgi40VuC+3em5x7YR62kbDeAyL8X5S0m8lU/KHzp
         muSgEW9RLlQH+E99AFvhE+3l/wiFraG8eUw4IZP+ljQc/IS88ljdWfz4Mw8bzwOhxG8O
         9png==
X-Gm-Message-State: APjAAAVoqRjY41GNWHhJ+HyceFNYvytmsf6icS3UHCgUuj4clxt4NgQx
        /ugCLyXRj6mJSOhTktJZiu39qw==
X-Google-Smtp-Source: APXvYqxb0czLHHDZLbkgNFfL1sYEXNp3iFMQkwRoo7RTldcUs6g+tGj8XavhsGGxo/VJmNTT1zUd8g==
X-Received: by 2002:a17:90a:ac0a:: with SMTP id o10mr690673pjq.143.1566493702935;
        Thu, 22 Aug 2019 10:08:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id u24sm23810537pgk.31.2019.08.22.10.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 10:08:22 -0700 (PDT)
Date:   Thu, 22 Aug 2019 10:08:17 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190822170817.GB35435@google.com>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 09:58:48AM -0700, Bryan Turner wrote:
> On Thu, Aug 22, 2019 at 5:32 AM Giuseppe Crinò <giuscri@gmail.com> wrote:
> >
> > Note how `git log` discards the ending quote character:
> 
> <snip>
> 
> > root@NBR1710R:~/repo# git add foo
> > root@NBR1710R:~/repo# git commit -m 'first'
> > [master (root-commit) a78e11f] first
> >  Committer: Les Actualite <root@NBR1710R>
> 
> If you look closely here, in the "git commit" output, you can see
> that, as Pratyush indicated, it was actually "git commit" that dropped
> the trailing apostrophe, and "git log" is simply presenting the
> information as it exists in the repository.
> 
> If your goal is an accented "e", wouldn't it be better to set your
> name using é, rather than a trailing apostrophe? "git commit" would
> likely preserve that without issue.

Hmm, I don't think it's a good idea to get into the business of telling
contributors how to write their names. There tends to be an axiom that
"all assumptions developers make about human names are false."

Does it make more sense to replace this strbuf_addstr_without_crud()
setup with something more intelligent (i.e. checking for matching crud
on either end, like ^[$crudchars].*\1$? We already check for matched <>.

- Emily
