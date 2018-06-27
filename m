Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E6B21F516
	for <e@80x24.org>; Wed, 27 Jun 2018 21:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965918AbeF0VWx (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 17:22:53 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33795 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965891AbeF0VWw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 17:22:52 -0400
Received: by mail-oi0-f66.google.com with SMTP id c2-v6so3220969oic.1
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2pef2mLVSBkWz82zOjnQ2itEOLFGkxJdKqjTo58KLoM=;
        b=kQ5YXzZo20gHFzhk5sEyAxHkyMz8HDVYNDvOFGWWuz5zHoQ17LrTVKwxTQAI+B8poC
         YRAAcIvzTT2fyErUp1wfr5h334TaUp25TqHhBNrpikGvLkp9nVJrxg0lVLFiZYLlS+f4
         srleONm+jEkY1gys4lO57VMHAa/9FKyw5JGhPTuPXkiXEYSwq7WmPeVPiuRS0oRlXdCC
         6AE7UOOlEsSe8KMcsSXQbmuBrV1slhXUKxFP0j/sZhX1X3K0A+IU+Z5lkdBb71aIKbO3
         VmgDgKKsOKU+GbZZSGJBrA9HVDkSbjnzqo9CIGnKgjtNFWqdnEt4GjYvXiI5HL6eq2BL
         BtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2pef2mLVSBkWz82zOjnQ2itEOLFGkxJdKqjTo58KLoM=;
        b=lSSx5cLuvM4GduJUap6g2rUiV+n0x1DfFdVwV/sVJTtyi3ABNFX73Rqtb9lJe5RzmX
         HmIDXZjkd04esi1aoTun4HpZSXI37hyK1nqtuvVLuyV/gVl/GPWYjrQmFmJRv7+AGAM/
         PwfuTWhXPjqxL/As+e55HDfeTdx8ADZeN4LD7WoEX3XgpcKEwMdMrTIF6mJAHDL87lee
         xx2jZs8tg/5FBK3EqKM24HeNrvRHenGc1xDs7dgJxCzcL3puRuBpWKJXvsLWqmKKE0fv
         Iu1zx2cqb+VpIIFPn289h+sayzmeHUbdf9nnmaxXo6oPkt8MNhEZBEejAFx4K2O864yf
         /aRw==
X-Gm-Message-State: APt69E2GACCGceeiB8QjnxFWNdO2Bh4eIDniv1q1Fqzaz+d38nPPQUMN
        nKYZBfI66M5RJmVHgRWlXekBrg==
X-Google-Smtp-Source: AAOMgpf6ASc02lRnNB1es5dI+3jf5nzIQhbTkgP6TjMACAITNuZhtQlIOYmur4r6jlmCmlbYVRqqZg==
X-Received: by 2002:aca:b4d4:: with SMTP id d203-v6mr2064142oif.79.1530134571413;
        Wed, 27 Jun 2018 14:22:51 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id v141-v6sm2291764oie.34.2018.06.27.14.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 14:22:50 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 27 Jun 2018 16:22:48 -0500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/2] grep.c: teach 'git grep --only-matching'
Message-ID: <20180627212248.GA1282@syl.attlocal.net>
References: <cover.1529961706.git.me@ttaylorr.com>
 <f156bd7c897359926ec407e805ecb0630a8b12da.1529961706.git.me@ttaylorr.com>
 <xmqqsh58gp3p.fsf@gitster-ct.c.googlers.com>
 <20180627171657.GA26628@syl.attlocal.net>
 <xmqq6024djf2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq6024djf2.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 02:11:13PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> Just initializing match_color where it is defined at the beginning of
> >> show_line() should be sufficient, I think.
> >
> > I think that we could also use the following, and leave the `if
> > (opt->color)` conditional where it is:
> >
> > diff --git a/grep.c b/grep.c
> > index 48cca6723e..b985fb3ee0 100644
> > --- a/grep.c
> > +++ b/grep.c
> > @@ -1448,7 +1448,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
> >  		      const char *name, unsigned lno, ssize_t cno, char sign)
> >  {
> >  	int rest = eol - bol;
> > -	const char *match_color, *line_color = NULL;
> > +	const char *match_color = NULL, *line_color = NULL;
> >
> >  	if (opt->file_break && opt->last_shown == 0) {
> >  		if (opt->show_hunk_mark)
>
> You say "we could also", but the above is exactly what I suggested,
> so we seem to be on the same page, which is good ;-)


Ah, sorry -- I misinterpreted your meaning "initializing match_color
where it is defined" to mean bringing the large `if (opt->color)`
conditional up, instead of just assigning to NULL.

Let's do that and leave the `if (opt->color)` block where it is?


Thanks,
Taylor
