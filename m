Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409C01FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 01:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbcLABVu (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 20:21:50 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34118 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbcLABVr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 20:21:47 -0500
Received: by mail-pg0-f49.google.com with SMTP id x23so88251992pgx.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 17:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ikDmdQyXRszmQ2wFFQ+QiBc1VKGEStn8cPXlHR6Vh/I=;
        b=Vs2fTXtXzJ1QbtyzZzH+APfEKkEBhAy4dkj3mDRep8naOU2sBUua3lePru7wVeqXBA
         L1HSKuPggPtgCcsqkAOI8wlE7CPK2DXC9m3z97j1gVrircpud7oUVXKwqvDoHBkIU/bC
         uOvIFnDs93WIWgjnfWNGAY4BGOUyjDNBpBomsDC89infPxNga+eDThC+R1/U//hPna5p
         K9FSbPabvRlZXhn/LPpY+LKnTrMTduvYB1wbMRA6iMuA/3mJ/sqH5tCDO2bQK0P+fhEM
         Pgq5ADSLe4PyVA6ITqF6u8oTg4ATZ0+q0TR6v+6NpCnWN2qvkOwpu1O1ePfdQOJytAp7
         3O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ikDmdQyXRszmQ2wFFQ+QiBc1VKGEStn8cPXlHR6Vh/I=;
        b=YncEQwzJ92lCCatR+P7yBWRKWFypy4uZjiRpnN/ci1eBjE14HZbMDq01UxH0h0ciUo
         xXGjzBTi5cz9nDEnOqXchea5oBpm4OpnCx1NqKYTKSukZll0DOAa4M1WsBINkiJ22+cr
         pdfw9T2JD6p37un6sjoJhRsq6h+db2Ap/KxbIT7KD5gYkruVEVFVoPKRe6iP2wjUn4x3
         wLLQQnljaBYntlRWzHOJnlg8P5PPjFGD9MMSP/RNj+ECvOK5mnoief6ux+M2kmSS6/Zp
         UNdNG6/dY+ozR5E4Zvh02YKXVCM4J4ox+tQUUfZTBHAidV5g29xy32LpbbD8blwb0vhI
         Agvw==
X-Gm-Message-State: AKaTC00YiCB+3PBWzdx8Z2lPsq3i+wxG/JM1XGVGgt63Dy5+ajFl0S3QSxV+elq8U+/Y9g5t
X-Received: by 10.99.124.66 with SMTP id l2mr65358574pgn.116.1480554882280;
        Wed, 30 Nov 2016 17:14:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ddc5:5173:1b11:9434])
        by smtp.gmail.com with ESMTPSA id v77sm105430262pfa.85.2016.11.30.17.14.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 17:14:41 -0800 (PST)
Date:   Wed, 30 Nov 2016 17:14:39 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161201011439.GF192901@google.com>
References: <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
 <20161130234248.GB192901@google.com>
 <20161130234636.6az7xfywzprpn6ly@sigill.intra.peff.net>
 <20161130235952.4j63gkdlbobjitdb@sigill.intra.peff.net>
 <20161201000437.altjlcsn4u7rwe5c@sigill.intra.peff.net>
 <20161201000824.GE192901@google.com>
 <CAGZ79kaaJgsa8SsvWiGkmKQU7Wv_PD6O50ybm=rxPySk=z9N7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaaJgsa8SsvWiGkmKQU7Wv_PD6O50ybm=rxPySk=z9N7Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30, Stefan Beller wrote:
> > Oh interesting, I wonder if there is a way to not have to perform a
> > chdir since taking a lock to lstat wouldn't be ideal.
> 
> I think we could rewrite is_submodule_populated to be
> 
> int is_submodule_populated_cheap_with_no_chdir(char *path)
> {
>     return stat(path + ".git")
> }
> 
> i.e. just take the presence of the .git file/dir as a hint to run
> the child process?

I like this approach, its a quick (thread-safe) check to see if the
submodule is interesting.  If there happens to be an error with the
submodule's .git file/directory then the child process will fail out.

-- 
Brandon Williams
