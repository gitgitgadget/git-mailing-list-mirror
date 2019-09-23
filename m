Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05AE31F463
	for <e@80x24.org>; Mon, 23 Sep 2019 11:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfIWLpd (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 07:45:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38491 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfIWLpd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 07:45:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so8933672wmi.3
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 04:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VnXhZgL7t2DWQxV6xkEEXoBeerJco2o1xjaeNpOS+GA=;
        b=oKlWtunjLhyFRoLi1xNLJdu3+p4Ufca6WbAGLePCHIb3CUzWAgPGIkbYtW+g9E0vTl
         eogtuD8INt5j9KUW9s80VWljfeqj6Lnas5O04kTgScyX/90Eqp8nBvvgf4WC2jbAqp/Z
         T3+dgLfjk8ndPVkw0Pxi5q+s33pjntskLDHA4h2YXjgkdCOWJuRIYTsO5UAgNwy7bHCh
         MWpaBGi4jxd9wtyjQFuFa7LkXuHSYbUmMjuGTq122xB3OQktM4FvVV1/XYDphg/R3ZWc
         3jgMJ3X1JW3i1cjMSOYlv7+mNFcPRNAfBINQYpYaicTj5q750X+igNdJQw3Ajx+S8Fwr
         oa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VnXhZgL7t2DWQxV6xkEEXoBeerJco2o1xjaeNpOS+GA=;
        b=Pzmh58VEqMAeeyABpk69NKg/lerdeerNpQOkcQMTNLv8HEOvEftOfBOQ82kwSXXK/I
         w4gWAUbrm5WMeNmyJOVmHbvS9iYYRTOe4CUFf6SIDmpPvkEwsaMb4s8g3mXGe9nqmpwW
         lQyt/lXbvA/Nu/00IKWEjOczLV1OcCJlJPiZYtnuheuBHISkKY62aKTwvyvXAGwAKu5d
         ytGAM9frv92gw7LIq2d7BuW8WJ59bvM7d+Ec+nyfAu+ENnM2fihc9dAY0jhBODMKZenX
         UyAsJb7Qi2e621OhSpIHiNiLC6laW6/Gsckw1IY3teQ0kh4Kp0rqXrDoef35tlMfB5Qh
         jhSg==
X-Gm-Message-State: APjAAAVYpf+LIj7PAXGGoC7Ohey1mCyQxAxQ/Sny9PUESpl6V5Y/RDwt
        ue2yKcgHD/SgBKuDLfnsZPWIizPz
X-Google-Smtp-Source: APXvYqzyatQKb0meYHgK0Pz5Gs9P+TzCeG1q85WIlScvCl/VcVnY8s+EERkE2XJlrb/bEjbMKVJADg==
X-Received: by 2002:a1c:4945:: with SMTP id w66mr13167608wma.40.1569239131006;
        Mon, 23 Sep 2019 04:45:31 -0700 (PDT)
Received: from szeder.dev (x4db53381.dyn.telefonica.de. [77.181.51.129])
        by smtp.gmail.com with ESMTPSA id t14sm9786266wrs.6.2019.09.23.04.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 04:45:30 -0700 (PDT)
Date:   Mon, 23 Sep 2019 13:45:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Zeger-Jan van de Weg <git@zjvandeweg.nl>, git@vger.kernel.org
Subject: Re: [PATCH 0/1] git-config --add allows values from stdin
Message-ID: <20190923114527.GG10866@szeder.dev>
References: <20190917133135.190145-1-git@zjvandeweg.nl>
 <20190922031128.GA76333@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190922031128.GA76333@syl.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 21, 2019 at 11:11:28PM -0400, Taylor Blau wrote:
> Hi ZJ,
> 
> On Tue, Sep 17, 2019 at 03:31:34PM +0200, Zeger-Jan van de Weg wrote:
> > When adding or updating configuration values using git-config, the
> > values could all be observed by different processes as these are passed
> > as arguments. In some environments all commands executed are also all
> > logged. When the value contains secrets, this is a side effect that
> > would be great to avoid. At GitLab we use Rugged/libgit2 to circumvent
> > this property[1].
> >
> > The following patch allows a value to be set through stdin when the user
> > passes a `--stdin` flag.
> 
> Interesting. I had thought some time ago about making an interactive
> line-oriented 'mode' for using 'git-config(1)', which would allow
> callers to add/delete/fetch multiple variables using only a single
> process.
> 
> This would satisfy a more general use-case than yours: particularly my
> idea was grown out of wanting to specify or read many configuration
> entries at once when using a tool built around Git, such as Git LFS.

Getting multiple configuration variables from a single 'git config'
invocation is already supported fairly well, in the sense that it's
not at all difficult to parse the output of 'git config --list -z'
into a map/dict of the language of your choice.  Though, of course, it
doesn't offer the normalization and unit conversion of '--type'.

> I had not considered tying '--stdin' to the '--add' (implicit or not)
> mode of 'git-config(1)'. It is an interesting idea to be sure.
> 
> On the one hand, it lends itself to other modes, such as '--get'
> combined with '--stdin', or '--unset' in the same fashion. One could
> imagine that each of these would take either a key/value-pair (in the
> case of '--add') or a set of key(s) (in the remaining cases). The most
> desirable aspect is that this would allow for a clear path to this
> series being picked up.
> 
> On the other hand, tying '--stdin' to a particular mode of using 'git
> conifg' seems overly restrictive to me. If I am building a tool that
> wants to fetch some values in the configuration, and then add/unset
> others based on the results using only a single process, I don't think
> that a mode-based '--stdin' flag gets the job done.
> 
> One happy medium that comes to mind is a new '--interactive' mode, which
> implies '--stdin' and would allow the above use-case, e.g.:
> 
>   $ git config --interactive <<\EOF
>   get core.myval
>   set core.foo bar
>   unset core.baz
>   EOF

I think the option should still be called '--stdin' instead of
'--interactive'.  Consider the rather similar 'git update-ref
--stdin', which allows creating, updating, and deleting refs in one go
as well.

> (An off-topic note is that it would be interesting to allow more
> fanciful options than 'get', e.g., 'get' with a '--type' specifier, or
> some such).
> 
> I'm not sure if anyone actually wants to use 'git-config(1)' in this
> way, but I figured that I would at least share some things that I was
> thinking about when initially considering this proposal.

Once upon a time I had a script-generated repo with 10+k remotes, and
3 config variables per remote.  The resulting configuration file was
over 1MB, and creating it by forking a 'git config' to write those
configuration variables one at a time took over 18mins (IIRC).  I
ended up special casing the writing of the initial huge configuration
file with simple print() calls, which only took about a second or two.

So I would welcome a more general 'git config --stdin' that could
write configuration variables in bulk.

