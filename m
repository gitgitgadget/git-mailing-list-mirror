Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E32520C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbdLADHb (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:07:31 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:36534 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdLADHa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:07:30 -0500
Received: by mail-it0-f50.google.com with SMTP id d16so965824itj.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xsasFxVm3XvdVNmbp2RRzQuR0fNmI6scYHZynxYGAsA=;
        b=mZkL7ZZGhONmXMWb+lfF2BzTtW1v9mZg7e/maTVuW5+QBhTqUQ7K1ny+35tMV682F4
         6GlAWOlIUxV43eLQ9+rYI4u/DzyKhf/9oySa3/ydG/bCviuFR3MGWtqOML4/yHp0INod
         ji1AxRcMgokcGae7E3Tjhrhf/DTE7ANiqdBkEhxicE08EKh2JjF/beAji4R5t06VEbjv
         INBXhzQceb5kuSFC4nKFoE0YPKV40xBN6b5NHgptlLc+aJK9gXxyqEOMBCK7aiqUcejk
         YNYkozdW1uKzf6GNhFIoGFFdJafi0S/eqTtIj6p1T1JuL7usUQKt4O3dxDbjv0jfnABs
         WNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xsasFxVm3XvdVNmbp2RRzQuR0fNmI6scYHZynxYGAsA=;
        b=nX0arqP7JNDYXyVwhXsWa4i/ouGqTRskMD5fvU+wPQoIUjL/hXJ8KGeb9Axd9X/A1p
         1O/ELcVsSw+54ZGoyOF9QNkD2hkyUQRplM50wvh2CiPgEHG40qHmrg2e0nVr02yMWkoj
         57lyLj76F4TUMpfI4HPg7Yw5BFJfVl02fnVHSi3VIe91Czbp5w9I+z8HtgcnaY+XQk8/
         3h2u5NHkS3iGApH8Ogdf1e+SyVAm6zIsOJ1Imq7MsdWYNUt00sf12y+6oaL1cGaHGYWv
         7tvItTVmDglkZ+PDzRq/DiPXFcoV383m17+0QJutNCJu2Ewe/aR5N4ubyPM+tZ7xmpz7
         rwxw==
X-Gm-Message-State: AJaThX6c0sfwWrpzhVKosfLuVTCMDDHJyvc84UdUEmSGS/qEGi/phOTi
        qad7EiYKfedhCkP0xcZbM4A=
X-Google-Smtp-Source: AGs4zMa6ZIbhYZvpjod6aMPRIfN4aT8QJvnr1Y+31JLpWWNeKQe6mfv8wuml4ezHb1jxp2oAqcvWAw==
X-Received: by 10.36.184.134 with SMTP id m128mr81507ite.96.1512097649251;
        Thu, 30 Nov 2017 19:07:29 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g1sm4892itg.10.2017.11.30.19.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 19:07:28 -0800 (PST)
Date:   Thu, 30 Nov 2017 19:07:27 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 0/2] t/lib-git-svn.sh: improve svnserve tests with
 parallel make test
Message-ID: <20171201030727.GH20640@aiede.mtv.corp.google.com>
References: <20171201023239.26153-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201023239.26153-1-tmz@pobox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger wrote:

> These tests are not run by default nor are they enabled in travis-ci.  I
> don't know how much testing they get in user or other packager builds.
>
> I've been slowly increasing the test suite usage in fedora builds.  I
> ran into this while testing locally with parallel make test.  The
> official fedora builds don't run in parallel (yet), as even before I ran
> into this issue, builds on the fedora builders randomly failed too
> often.  I'm hoping to eventually enable parallel tests by default
> though, since it's so much faster.

This background could go in the commit message for patch 2, but it
also speaks for itself as an obviously good change so I could go
either way.

> I'm not sure if there's any objection to changing the variable needed to
> enable the tests from SVNSERVE_PORT to GIT_TEST_SVNSERVE.  The way
> SVNSERVE_PORT is set in this patch should allow the port to be set
> explicitly, in case someone requires that -- and they understand that it
> can fail if running parallel tests, of course.  Whether that's a
> feature or a bug, I'm not sure. :)

micronit: can this just say something like

	Patch 2 is the important one --- see that one for rationale.

	Patch 1 is an optional preparatory style cleanup.

next time?  That way, you get an automatic guarantee that all the
important information is available in "git log" output to people who
need it later.

Thanks,
Jonathan
