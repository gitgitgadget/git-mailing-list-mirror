Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CF71F405
	for <e@80x24.org>; Wed, 19 Dec 2018 21:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeLSVqz (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 16:46:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39817 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeLSVqz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 16:46:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so3384311pfc.6
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 13:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rkznFft/Pi9W2/mywssioW38KdjMZMsJJP343KCPfSA=;
        b=YVL6FUkrb9xtB7g3pxU+cuupyXLWBBHMDFmNZ2mcHQCpXFORmpUC/dzGgkHkrfVLbC
         9wr/d4VaD/0HS+2Fus3gsBiPcQ0dN9D6gm87SlE7ucQtoM5G1xohaT0/35QTb5ZtTSjO
         tHYsnQjStwFv0AgfQDiFPIDXnqc6YNgoGsN08qCu7Njo0CKRl1r7GNhANdXQcRbwUOCd
         cUPoItUSNZhUclBp4HT8HyFyq9zkx+w2L0JI9hPC5ESxqRlYeYU70iNpU9QHj94OROtI
         +OmztfL60Je50rvhr55uWq4+e6s466e6PinCSmkh2vPT08dBfpQMqMMUS8vUCl4JvBWQ
         M/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rkznFft/Pi9W2/mywssioW38KdjMZMsJJP343KCPfSA=;
        b=WBAqxHtF5jTygFsNEB23/d0SCyNlSNP4Bz1fQtS/Ht3DB9GYPvHtUgGIgNV/d9DCcL
         CSYM3QzXTQkYX+s6gJkBBKAuV8J6dAImsyIid0tiM4+mUXQS+AZ8tJ804t+yOx5VFsSC
         1vHuEfw2qRUQe08Ge/wsMuPIaOfuf78prmT0B31Bd+MZ00IrW7/E+afMjiQ+4fHNKO4F
         XtszN/+N3Dempuk/CKSM4QLrnkgMjo2gwsfrINJ9fQhE/ukhIHvT+MzcvIlRRs8MMrTt
         OXXMa8soTgyKG3NofZuiOlVpNPu5YxXJQDzVAo2oSvrWCSo2ocIYWP6+7PJ7tc4gf8gu
         H4OQ==
X-Gm-Message-State: AA+aEWbO22AabNo2ObvRiauj56m3xeAx/klTRQlQ6bI1Y6uW0IbwmD6c
        zq51a1Yb00dZ2rI+kTNQV8Stjyt6
X-Google-Smtp-Source: AFSGD/UcWnMpDeAUPXK+HBK8AHOoqFcTS98tvY/v5+s2EZ1w0Lhp/NPeSjZ8BSSWTEs5t799Bsca7Q==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr20629964pgr.432.1545256013831;
        Wed, 19 Dec 2018 13:46:53 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id m198sm33339408pga.10.2018.12.19.13.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 13:46:53 -0800 (PST)
Date:   Wed, 19 Dec 2018 13:46:51 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH 0/1] add author and committer configuration settings
Message-ID: <20181219214651.GB228469@google.com>
References: <20181219183939.16358-1-williamh@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219183939.16358-1-williamh@gentoo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

William Hubbs wrote:

> this is my first patch for git, so please be gentle. ;-)

Thanks for contributing!

> I am in a situation where I need to use different authorship information
> for some repositories I commit to.
>
> Git already supports setting different authorship and committer
> information with environment variables, but this setting is global so if
> you want to change it per repository you need to use a separate tool.
>
> This patch adds support to git config for author.email, author.name,
> committer.email and committer.name  settings so this information
> can be set per repository. It applies to current master.

The above information (except for "It applies to current master") is
very useful to have when looking back at the change in history.  When
sending the next version of this patch in response to others'
comments, can you replace the commit message with something like it?

In other words, it is very useful for the commit message to include
this kind of information about the "why" behind a change, beyond the
"what" that the patch itself already provides.

> Thanks much for your reviews, and I would like to publically thank dscho
> from #git-devel for assisting me in preparing this patch.
>
> Also, since I use a screen reader, it would be very helpful if you put
> your comments in your replies as close to the affected code as possible,
> preferably directly below it.

Fortunately, this is already common practice here, but the reminder is
very welcome.

By the way, if you have other feedback about Git accessibility through
a screen reader (both the project and the tool), I would be very
interested to hear.  Presumably in a new thread. :)

Thanks and hope that helps,
Jonathan
