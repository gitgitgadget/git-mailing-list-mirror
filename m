Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02BF220248
	for <e@80x24.org>; Fri, 15 Mar 2019 20:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfCOUhO (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 16:37:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43884 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfCOUhO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 16:37:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so458494pfd.10
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 13:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+sQQQ4w28eaAwDUDqL/kHDszUPvSG4oNb5uleHSYPG8=;
        b=a9DK564gVtcWCl8K2/yxah8Wt2rFvDQy8ajoQmxCVryelhG7YkLSvQxbcQV5dn4MrI
         VnOFRhESAFFxl4VTO1l8EjRSIjiUlXkI9jjJwvc1bviLcPKBSAm/Yo1UxBvrAK3DdxC3
         jiOvqtdqRQO4StxyQwi6obetGuQXH7XoWYTBFgpXvnm1NnDh9LolJjDuhaJvk9gdmCB6
         B3BbcwVKq9837Tr11EXzuuYeFqnxx3YsPfn3TgZIMPScnPO06CgfxAJpHoPefjBna228
         otSwmOqtkkfp169tBZxjYlDA8Q0vpnq+Io0ftSeM656a4wNnhYNLvx1gjKDDgW9ebJiN
         SsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=+sQQQ4w28eaAwDUDqL/kHDszUPvSG4oNb5uleHSYPG8=;
        b=DReKrOLT+iDF7KGn29ItlWlPhx1V6rAZJafabMqt1OT/4G5bbOCTZ/g/X6hSj3IXlw
         +3pihvAmjvDuq3Nvzpxk3Nc+Pj3ZK0+HxovWQqfz1qdd3xP1ir+S4fFek6KFHSjlevNd
         /aWnaXVFq9k8ykWTpdcHw637pOLHlVvTD2lpHcAapmTvwwaVKqVVeOzfOew8GXYEz6c5
         sMa7bWLwVXQTH4QgyYaiGJgCeklQM9v4G5UUo5Pio4vh+9+7SvzZyUdfstH49vGZbEGW
         bJAwoknxHZ3zpa1cuf0mnVWVnENBiciC7QJ4cpHBtWrNFJgfArl/41BEY/Dyx+ZSrY7P
         LW6w==
X-Gm-Message-State: APjAAAU0fnEu+KNVKCwmhYuR19/jTfVr/prwIHJf7I4Appre+zLRPZvx
        kpLDovuwTbcP8Cfi1V3YQci/oDV6vVGjmA==
X-Google-Smtp-Source: APXvYqy5+rlotEyX/6GK1J7C4i+7Js2DTiUrHiGWY/PK73B7FQmA8WIb5Ukt70MkqctLTpCVXsHFXg==
X-Received: by 2002:a17:902:2ba8:: with SMTP id l37mr4928266plb.17.1552682232843;
        Fri, 15 Mar 2019 13:37:12 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id g13sm4143121pfm.159.2019.03.15.13.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:37:12 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:37:04 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 0/2] Randomize / timestamp trace2 targets
Message-ID: <20190315203704.GC47591@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, git@jeffhostetler.com
References: <cover.1552519463.git.steadmon@google.com>
 <nycvar.QRO.7.76.6.1903141531160.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903141531160.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.03.14 15:34, Johannes Schindelin wrote:
> Hi Josh,
> 
> On Wed, 13 Mar 2019, Josh Steadmon wrote:
> 
> > Persistently enabling trace2 output is difficult because it requires
> > specifying a full filename. This series teaches tr2_dst_get_trace_fd()
> > to randomize filenames when a directory or filename prefix are given as
> > targets in the GIT_TR2_* envvars. It also allows expansion of a
> > timestamp template string into the current UTC timestamp.
> 
> Given the problem you try to solve, would it not make more sense to use
> `getnanotime()` than some randomized file name or an ISO date format?

For my specific use case, getnanotime() would probably be sufficient.
However, others requested the timestamp feature before I sent this to
the list. I don't know whether they had a specific use case in mind.
