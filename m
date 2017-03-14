Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654BF20951
	for <e@80x24.org>; Tue, 14 Mar 2017 23:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751001AbdCNXhE (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 19:37:04 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33573 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdCNXhD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 19:37:03 -0400
Received: by mail-pf0-f172.google.com with SMTP id w189so657670pfb.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 16:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wm1WTBQyBZoj52xm5uNddVffQ9ji5mMmxozN8PE9ojI=;
        b=KE1biGUyNPgqKtjJkGVRuq+Ez+BWVJNGTvwo9iB5ECMAFKGwItSZQZWNH9NfyiC5JF
         L6tW+NRAjecMP+Hdzdk8w8K6QpsWT2J/YOGZ8gzKSMjIXmoj8WH/75s6WKSHTlX/fK1F
         Fua9XtuThAkNVDHAzjz/3/oUoN9PGddB5BjZL9WyYpK0ptPazoWR7NkyydbpWnM/Oasd
         mN7i691uKOZDJE7c6Zq7dGchJkcDKWahnJp8BGHdElV+xMeto9QOACLMSLB8vScF16CI
         v86EwBudSafi3GEuuMFp0f2P70WNQ50l5d3cpcZM6WbyVKJzUSa4PjCnaHM3rr3UHscR
         b4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wm1WTBQyBZoj52xm5uNddVffQ9ji5mMmxozN8PE9ojI=;
        b=Y29xNl8wr53bK3ZSxvnw+2VjV/hW/hKlatIBtxzyUa8gY8EkGtORc6gwwCWSX3MmKd
         4lrkDu2N2rI2UwcPZguGVQsLBo1FYsonLj6g7qBMHRd6pX8JS/YN/AiqtLi++ESaa/Ei
         dYMOWvHbLZZJbaY0ZNwYYEvS1BH83vKiNi2iglme7O5OmsiaDwP8GoPV85MtPabhbBVm
         TviQfbo+QOqUUy18mYGv248o/kYOZ3Cn1g3pRWHV9aqtXBg+wZD4/pSuojF+F4mpinw1
         auXc2XDjn2VQ29HWfVZkVOOTg3Hp5De7XCbQN7EtK9MZ+CJ9qOyz1bJrnIxgaROYEUCV
         grIw==
X-Gm-Message-State: AFeK/H0DSeTamLSoiyrNDyRvEU0Gv2qPo1RHNkaKU1IVTGb1V5W9gemeluEK8ENwqLlxUmm6
X-Received: by 10.84.129.132 with SMTP id b4mr410978plb.54.1489534621751;
        Tue, 14 Mar 2017 16:37:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:491b:baa8:63f0:3cf1])
        by smtp.gmail.com with ESMTPSA id m6sm134724pfm.22.2017.03.14.16.37.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 16:37:00 -0700 (PDT)
Date:   Tue, 14 Mar 2017 16:36:59 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 02/10] submodule status: use submodule--helper
 is-active
Message-ID: <20170314233659.GE168037@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-3-bmwill@google.com>
 <xmqqd1djkay4.fsf@gitster.mtv.corp.google.com>
 <20170314225002.GD168037@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170314225002.GD168037@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Brandon Williams wrote:
> On 03/14, Junio C Hamano wrote:
> > Brandon Williams <bmwill@google.com> writes:
> > 
> > > Signed-off-by: Brandon Williams <bmwill@google.com>
> > > ---
> > >  git-submodule.sh | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/git-submodule.sh b/git-submodule.sh
> > > index 136e26a2c..ab233712d 100755
> > > --- a/git-submodule.sh
> > > +++ b/git-submodule.sh
> > > @@ -1010,14 +1010,13 @@ cmd_status()
> > >  	do
> > >  		die_if_unmatched "$mode" "$sha1"
> > >  		name=$(git submodule--helper name "$sm_path") || exit
> > > -		url=$(git config submodule."$name".url)
> > >  		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> > >  		if test "$stage" = U
> > >  		then
> > >  			say "U$sha1 $displaypath"
> > >  			continue
> > >  		fi
> > > -		if test -z "$url" ||
> > > +		if ! git submodule--helper is-active "$sm_path" ||
> > >  		{
> > >  			! test -d "$sm_path"/.git &&
> > >  			! test -f "$sm_path"/.git
> > 
> > The $name is no longer used after this step in cmd_status function, 
> > as the sole purpose of learning the name from the path was so that
> > we can ask if the submodule has .URL defined and the query is done
> > by name, not path.
> 
> Thanks, I'll remove computing the name.

Actually looks like it should stay in for now. It's used to exit if
there doesn't exist a path mapping in the users .gitmodules for a given
submodule.

> 
> > 
> > This actually raises a question.  
> > 
> > Shouldn't "submodule--helper is-active" ask about submodule while
> > identifying the submodule in question by name?  Or do all (or most
> > of) the callers start from path and ask is-active on them so that it
> > is handier to let them ask by path?
> 
> As you can Stefan already discussed the path is a much easier handle to
> work with simply because that is what is more readily available as the
> name is an internal detail.
> 
> -- 
> Brandon Williams

-- 
Brandon Williams
