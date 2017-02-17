Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 014C4201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964795AbdBQXFj (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:05:39 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33202 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964779AbdBQXFh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:05:37 -0500
Received: by mail-wr0-f196.google.com with SMTP id i10so6652323wrb.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DNVYvP1RamjVN18T4d7jGmMqJur+iKhzlQuMTMLxUOc=;
        b=nGRmdLju9SK0erVNKUQkqtzCFfc1fHyVWchmKZ9w76rhqwp1KoqjOO+eGF16UjmOYg
         TxQF+lgNgyTE2kycQvyONt1jcMcbTfoqyK00bFff/EhPN/HE7yKO0tbokKuoRq4aWicP
         VGg5QpKnUiEM1Aqf95HJC7TlggOr71Vfy73twS97/c42gVoOOy0gRAd/qZyO8UlGzVKA
         TaHrOUe8FSuwh6mik8zL3v3xYeKhYEwurOAL8N2CwpwhlSeKNYURZrfDztEZMjIA76TL
         52zwLgwfBbYbaC5Ui35Oh637IgP2L0qSpOXbP0ZROle+jVfcscM8ijvttYego/ZfrjXT
         rz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DNVYvP1RamjVN18T4d7jGmMqJur+iKhzlQuMTMLxUOc=;
        b=nsMEqihHd9RcC7I6lNbkYjqHk/YRjyc/9k4nm8qFJp69haP5NUw14MzUAJ94O2Zepz
         6vVNdO5ktCjjLbx/s1odaaKkAp5/IAOM/kruTV3F1CcRqtuXl+7KTl+VVp9C+lCHbsZT
         FiQvFQ4JzplTepjxwY/GaXGV0JWYmJNPEyxHx5ky4a7LDOibywmNBmGo0idK5+gOFMwD
         h68JXJEc4ugSLnee9dnF0WBmTi4KQC8DFuKYCsitdmzulRVET51y6TpPHzoeYZjvhF9C
         N5spKLdl/tRoh6OG7oTXE7lgtDLEjGZc4eKWuYTtMzYi1Ga934i8Aj2xpNRv+FAoIrXF
         e0fw==
X-Gm-Message-State: AMke39mQEN+b7h+VeAytQT7kCVaUnFM/soruDnSpGEFtw+X7K5cu/NbrBIyVpSLRRa3nFA==
X-Received: by 10.223.179.78 with SMTP id k14mr9201681wrd.34.1487372735698;
        Fri, 17 Feb 2017 15:05:35 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id m80sm3328937wmi.34.2017.02.17.15.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Feb 2017 15:05:35 -0800 (PST)
Date:   Fri, 17 Feb 2017 23:06:14 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 0/6] stash: support pathspec argument
Message-ID: <20170217230614.GH652@hank>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
 <xmqqr32wph97.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr32wph97.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/17, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Thanks Matthieu, Peff and Junio for the discussion on v3 and v4.
> >
> > Changes since v4:
> > Dropped patch 1 from the series, as it's already in master
> >
> > Instead of changing the external interface to git stash create, only
> > refactor the internal create_stash() function to take -m and -u
> > arguments.  This also simplifies the internal option parsing.
> 
> Yay.
> 
> > Make git stash -p an alias for git stash push -p, so git stash -p
> > <pathspec> is allowed.
> 
> Nice.
> 
> >
> > Interdiff below:
> >
> > diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> > index b0825f4aca..97194576ef 100644
> > --- a/Documentation/git-stash.txt
> > +++ b/Documentation/git-stash.txt
> > @@ -53,9 +53,8 @@ OPTIONS
> >  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
> >  push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
> >  
> > -	Save your local modifications to a new 'stash' and roll them
> > -	back to HEAD (in the working tree and in the index).
> > -	The <message> part is optional and gives
> > +	Save your local modifications to a new 'stash', and run `git reset
> > +	--hard` to revert them.  The <message> part is optional and gives
> >  	the description along with the stashed state.  For quickly making
> >  	a snapshot, you can omit _both_ "save" and <message>, but giving
> >  	only <message> does not trigger this action to prevent a misspelled
> > diff --git a/git-stash.sh b/git-stash.sh
> > index a184b1e274..1446fbe2e8 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -67,51 +67,20 @@ create_stash () {
> >  		case "$1" in
> >  		-m|--message)
> >  			shift
> > -			test -z ${1+x} && usage
> > -			stash_msg="$1"
> > -			new_style=t
> > +			stash_msg=${1-"BUG: create_stash () -m requires an argument"}
> 
> Hmph, did you mean ${1?"BUG: ..."}?  The same for the one in "-u".

Ah yes sorry, you're right course.  Thanks.
