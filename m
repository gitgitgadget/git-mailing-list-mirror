Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E28C211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 18:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLFSRn (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 13:17:43 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:36525 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFSRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 13:17:42 -0500
Received: by mail-qt1-f181.google.com with SMTP id t13so1609865qtn.3
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 10:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pU8jpy/pAklcLfuOE6uC3hrxh84IcIZ+H03ShYgGnn0=;
        b=oT5vlauBgwmVtWZrByGM3lt4ttA5E29yjj5joi8FaP3Kl15fkM1glG4bo2+ZAs1JDb
         trjqJZFvKmDykGurOMtFyy3bDyJRZR5P12cMoJ6TtaVKr+wutqbGZtMGcH+7mXxxH74+
         qREaDsXYhWCoN/0OerQVXkPbFktSVQM0GMf7hplYJK5mB1g1YY7lawCOWZ7L5H5EP59Y
         fttqv5McaIlecaf9rCUChLytNxuvtzAkwknNshKnRmugKiBlrKZz6AbjRfTuAxGP3LrA
         khJ2NkrEKEYgkS1YUI7VgYP+AeF4FA1teMiM9ShmgbnGXLs/m/yebTI5m8XUq1X6wPje
         LWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=pU8jpy/pAklcLfuOE6uC3hrxh84IcIZ+H03ShYgGnn0=;
        b=ctJVMkOb8mYKda+O/y/hofOpLr1mifEBTaRb7A/MQf5pGOi8Dal1sRvD5XT8WC5uy0
         XeXfLjRCdnOwxLJgXfaaztTZZof4K5P6S6gv5X4spBe2/Kc8Oo1W/81R7l7xzvL9WLrj
         AKBvaQplS06dzk6HTCRwCOcaKJnWd1GVNvbHqEtqVO0XDMTnrp+o/DbbZh/4AVJUStgj
         K5bPXE8nK1lJdW0Vrg7aNiXVJbmLTz2fpOUSDaxfyXb69VKRSILIGuimaUpO5Jcxmath
         iI/G+U4OPQLOzZ3M5x4nKKfTOau/UBMWaxyn398AQox8ivuMc6DL6TcyiKxVmnI5BYSM
         FQlA==
X-Gm-Message-State: AA+aEWYgdZlIBWUsrQYF5Mc5ZgHJX4jVNh9izoPue7ShS67fCl/1/Mn+
        64FJt9LN5cj/8/dL6cl9YoxFX70n
X-Google-Smtp-Source: AFSGD/UCWlg2xS9I+UlRXAHv2c5eZvzAhEN05u2CjBRn3x8uVf8Z4hhVQxX6c6vV7VpBJ/s34VZ5jw==
X-Received: by 2002:ac8:4558:: with SMTP id z24mr28372181qtn.85.1544120261412;
        Thu, 06 Dec 2018 10:17:41 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id x127sm1128646qkx.43.2018.12.06.10.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 10:17:40 -0800 (PST)
Received: (nullmailer pid 30623 invoked by uid 1000);
        Thu, 06 Dec 2018 18:17:39 -0000
Date:   Thu, 6 Dec 2018 12:17:39 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     git@vger.kernel.org
Cc:     chutzpah@gentoo.org, williamh@gentoo.org
Subject: enhancement: support for author.email and author.name in "git config"
Message-ID: <20181206181739.GB30045@whubbs1.gaikai.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

We are in a situation where we would like to use author information that is
different from committer information when we commit to certain
repositories.

Currently, it looks like there are two ways to do this, and I'm not sure
how to make either of them work well.

There are the GIT_AUTHOR_EMAIL and GIT_AUTHOR_NAME environment
variables, but  these would have to be set globally. Also, there is the
--author command line switch for the "git commit" command, but this is
easy to forget to use.

Is there something I'm missing?

If not, I would like to propose the addition of author.email and
author.name settings to the git-config system.

Additionally you could add committer.name and committer.email, but the
only reason I bring the committer variations up is consistency since I
see you also have GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL environment
variables.

Does anyone have any thoughts on this?

I don't think either of us is on the mailing list, so please keep us in
CC's when you reply.

Thanks,

William
