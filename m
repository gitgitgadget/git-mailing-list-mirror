Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC85B1F576
	for <e@80x24.org>; Tue,  6 Feb 2018 07:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751924AbeBFHCK (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 02:02:10 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40526 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeBFHCI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 02:02:08 -0500
Received: by mail-pg0-f67.google.com with SMTP id g2so743982pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 23:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ex0i+iC+S09L3CqIVlBVsiBznHnZvSZ3DzUcYix23s=;
        b=abExj3wwLWNerogoUPGJRAxESbtyayYDTp2iA62uwoj6FYDMnEVZ4850D2/u2JO4It
         0GHhtA6j8nHe8uGBC46T+1v39c/LalIBaWV/8kO+QK1s+Iqh84ztEWeRH1E5VRjmGxzg
         c38YBabfrCXT7HwJ9DQJtYml6HWFv3lYWPUUuArZARm2sjsnrU86ZjC1lY7apg+VObD+
         0XKQrFM+XbTasRacTB2mV7G6gy6pkNTgQMRi8liHpVx8C370bApokXW1NxEYlX1npukr
         wptCKwO0FdBYJEtG4fVdRH20v/eYMBeEyR2FiGpZYJvLnXpTShcAU/xR7F8s5MtJ8GVD
         FflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ex0i+iC+S09L3CqIVlBVsiBznHnZvSZ3DzUcYix23s=;
        b=eQ379DwlXjXjzKVugABA53VpQekzNHJ03dk/zWsnHPgSboGep7ZbKscEB4ndOOYj6r
         6n4vF0GxZjBRCEFq3r3rsNu74ZKiyUedzvKiWB/kPrfhT8VkWGLnhtx2xXLbnMu8eGWZ
         Cj83jq8KeWueKrr9Rv09HRrHtzpLqM/D1OhEq2ELS9q8kHhbGI47acMpYXjaGksbx0NU
         anas5q2i4cx+Siy086SsvNTsinbRpM4N05D3T9MSY2nFjWZHqGv0zMNX5g/16kEozeGC
         UrFr9CNYITghwiTmBQdlyyyPNpELdOIGE6osupIjMHdxqVUsw/Leg5tU6MXawgQ5Sij2
         j8ew==
X-Gm-Message-State: APf1xPARkuSTFiAdkCqh8QITiYZ3Ahf0l85/QF++29razN9EUe/U9c6u
        WV5eGqmWVv68poIprofPVwE=
X-Google-Smtp-Source: AH8x226POnmE+uAfgkrhJThbJSFG+V+tVXTMUszMR92wvuLjOGsZ5LY1xfF0rLS6oX86fgEBNn+cHQ==
X-Received: by 10.101.72.11 with SMTP id h11mr1172860pgs.386.1517900528179;
        Mon, 05 Feb 2018 23:02:08 -0800 (PST)
Received: from localhost ([113.86.161.135])
        by smtp.gmail.com with ESMTPSA id l10sm19059444pff.64.2018.02.05.23.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 23:02:07 -0800 (PST)
Date:   Tue, 6 Feb 2018 15:01:51 +0800
From:   Chen Jingpiao <chenjingpiao@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH] commit: add a commit.signOff config variable
Message-ID: <20180206070151.GA16810@ppiao>
References: <20180204020318.4363-1-chenjingpiao@gmail.com>
 <CAGZ79kZgqDp49McgtzWRbArsK6qVz1E9Syi5tJo73F-+T4UOiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZgqDp49McgtzWRbArsK6qVz1E9Syi5tJo73F-+T4UOiA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05 01:50, Stefan Beller wrote:
> On Sat, Feb 3, 2018 at 6:03 PM, Chen Jingpiao <chenjingpiao@gmail.com> wrote:
> > Add the commit.signOff configuration variable to use the -s or --signoff
> > option of git commit by default.
> >
> > Signed-off-by: Chen Jingpiao <chenjingpiao@gmail.com>
> > ---
> 
> Welcome to the Git community!
> 
> >
> > Though we can configure signoff using format.signOff variable. Someone like to
> > add Signed-off-by line by the committer.
> 
> There is more discussion about this at
> https://public-inbox.org/git/1482946838-28779-1-git-send-email-ehabkost@redhat.com/
> specifically
> https://public-inbox.org/git/xmqqtw9m5s5m.fsf@gitster.mtv.corp.google.com/
> 
> Not sure if there was any other reasons and discussions brought up
> since then, but that discussion seems to not favor patches that
> add .signoff options.

Thank you.

I agree with Johannes Schindelin once said "a signoff _has_ to be a conscious
act, or else  it will lose its meaning."
I think I shouldn't add this configuration variable.

When add configuration variable for sign-off to format-patch have some discussion:
	https://public-inbox.org/git/20090331204338.GA88381@macbook.lan/
	https://public-inbox.org/git/20090401102610.GC26181@coredump.intra.peff.net/
	https://public-inbox.org/git/7veiw69p26.fsf@gitster.siamese.dyndns.org/

--
Chen Jingpiao
