Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2CE1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 16:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfBFQ0d (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 11:26:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44182 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfBFQ0d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 11:26:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id v16so6390852wrn.11
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 08:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tdv4wZ/w/zLLemwc+wSC/gv+cX6ZVxyEo9fosZ8VYJ8=;
        b=j6BSJ+sC6QkyO45cJWb0I1tpgmpQj3KxhKWOoZ/j7XMJnKzdmbpSBIFWzLKOzl00qs
         5PJN6qc20uawvVpkIOl9v2U/AI8VU/ncVbg1CYy46qb2t1PtOXCkaUK2DAx7NyRS6TI/
         FmY6TjespRq/F9HUWzpW0WPjhq3nr+flhOdHMDAhXWb3tbKLDO9l7NNvnhOVSw7osPdP
         sS+Pf63iauiCUu8UNVzTaXxgZNDRKy3UrkQmOInl+/K7TlS42KAtf0MeoUuRMbD0WJ09
         fl0qTAz/BUb7S2IwqAwKhazM9b5wauykQyhedDm2nXJYDi0AJe9py9vXngw2kyvPDDA/
         mxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tdv4wZ/w/zLLemwc+wSC/gv+cX6ZVxyEo9fosZ8VYJ8=;
        b=mV6hawMXTp6b/+gWrS1bcC9x/7KaG7GryGhYGqVhvfm1uuhV8IM1APk9C0rHclRa1S
         vy6Ax+wmnwOAsrF2It4SMMKD1we4RtgzM7VVZM+4XbvlCnSqCOeO7ipL+NbrNdN8L9EL
         IdCJxLu01CJEzPJH4DtXcimEQl6DDwKTnOVElmOYvX115CmKepRkYESA8uMAAFYwmKW9
         6KrfnEm+VjNIS7TbhZiLke1M4a5aso08dTeuM0u8sGWLj0tPpmuJjQgytB3dpHMnG6DY
         S1aveo1wum6kP5883irrUI3u27PoaZRrivMBAEAY9F2/MnjAdDBWLlXl4rcac1u8vmvr
         zUAw==
X-Gm-Message-State: AHQUAuY5dyHHwz8dLgo8PwBmZUvhpzzwU4InMLfFt1zXwcmlJ/bbh5A/
        8FXZP0zr8D51iqjeuo78r6AKXvEn
X-Google-Smtp-Source: AHgI3IZ0i/27xt9mZNDx/npX7NTO0XSHvEPzwP1P0oHhcjoAnUo34aohYajqKJuyCYSg71a08n0GxA==
X-Received: by 2002:a5d:6086:: with SMTP id w6mr772021wrt.308.1549470391578;
        Wed, 06 Feb 2019 08:26:31 -0800 (PST)
Received: from szeder.dev (x4dbda645.dyn.telefonica.de. [77.189.166.69])
        by smtp.gmail.com with ESMTPSA id q8sm23660742wrr.9.2019.02.06.08.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 08:26:30 -0800 (PST)
Date:   Wed, 6 Feb 2019 17:26:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-p4: remove ticket expiry test
Message-ID: <20190206162628.GL10587@szeder.dev>
References: <20190206151153.20813-1-luke@diamand.org>
 <20190206151153.20813-2-luke@diamand.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190206151153.20813-2-luke@diamand.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 03:11:53PM +0000, Luke Diamand wrote:
> The git-p4 login ticket expiry test causes unreliable test
> runs. Since the handling of ticket expiry in git-p4 is far
> from polished anyway, let's remove it for now.

I can't judge how far it is from polished, and whether it's worth
having this test or should be removed in the meantime, but I would
like to clarify this part from my previous email that you might have
interpreted as a suggestion to remove these tests (it confused even
myself on second read):

  > I wonder why that failing 'git p4 sync' is
  > necessary in the first place, and whether it's really necessary to
  > test ticket expiration

I was not wondering whether it's necessary to test ticket expiration
_in general_.  What I really meant was whether that first 'git p4
sync' was really necessary in that test 'git operation with expired
ticket'.  After all, what we want to see in this test is that 'git p4
sync' fails with a specific error message when the ticket expired, and
when flakiness hits, then this first 'git p4 sync' does fail with the
expected error message.


> A better way to actually run the test is to create a python
> "fake" version of "p4" which returns whatever expiry results
> the test requires.
> 
> Ideally git-p4 would look at the expiry time before starting
> any long operations, and cleanup gracefully if there is not
> enough time left. But that's quite hard to do.
> 
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  t/t9833-errors.sh | 27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
> index 277d347012..47b312e1c9 100755
> --- a/t/t9833-errors.sh
> +++ b/t/t9833-errors.sh
> @@ -45,33 +45,6 @@ test_expect_success 'ticket logged out' '
>  	)
>  '
>  
> -test_expect_success 'create group with short ticket expiry' '
> -	P4TICKETS="$cli/tickets" &&
> -	echo "newpassword" | p4 login &&
> -	p4_add_user short_expiry_user &&
> -	p4 -u short_expiry_user passwd -P password &&
> -	p4 group -i <<-EOF &&
> -	Group: testgroup
> -	Timeout: 3
> -	Users: short_expiry_user
> -	EOF
> -
> -	p4 users | grep short_expiry_user
> -'
> -
> -test_expect_success 'git operation with expired ticket' '
> -	P4TICKETS="$cli/tickets" &&
> -	P4USER=short_expiry_user &&
> -	echo "password" | p4 login &&
> -	(
> -		cd "$git" &&
> -		git p4 sync &&
> -		sleep 5 &&
> -		test_must_fail git p4 sync 2>errmsg &&
> -		grep "failure accessing depot" errmsg
> -	)
> -'
> -
>  test_expect_success 'kill p4d' '
>  	kill_p4d
>  '
> -- 
> 2.20.1.611.gfbb209baf1
> 
