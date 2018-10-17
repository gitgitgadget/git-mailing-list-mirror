Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4ED1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 02:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeJQKid (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 06:38:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44850 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeJQKid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 06:38:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so11763949pgu.11
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 19:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ub5vtr5JFABgNYXjk44F7S9K5VqvDKfsSfYDaRixkQA=;
        b=QsLK6JTXmOYk1YELTqIUdYk0YGTNBQVJ0UQ7vpqjaYdW0bfnBBjtDhoa1K5Q9N4cV8
         rxw2JtJhDXQE5jvfM/5l7LsF1vN1aQuMxXE52Eb6zkcKXK+/4VxQsAhICGrdFnloDlC5
         ueLLS2GExHJejC/e/+CfcuGx6I/HhWFXSdAAu/4chQ9nkqdgSSN2MkICyDDG21jM12Ep
         Kpe3wA6oNwuHcueR60YEvyoUKDU0dkVS8pndAmz7ZdkXp1AO5NwI5t+zyMuvaD6rZ5S0
         stbER7gOsU0R5qMqRjsuL97LRjhvJ6eBdOo2WcqeWyoXgpAZwKz1V3hAGnNLCpdkrh6v
         aOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ub5vtr5JFABgNYXjk44F7S9K5VqvDKfsSfYDaRixkQA=;
        b=P0fcH6NZBfOFVW7WXlGOPHmu8ie9KADEFwha0zM995fJOHTzCPj3lPa61EFKo6UKem
         3xH5tRJo4mYLqykIG4YQ8thFFrslrdJ4ksrQL3RcWV4q1Ec4F+jyCfJBY3NZp4Hq7NPp
         DtgI1NL/2JIOw/OglwfE7IxI5BY8mm9QMcT7ejAUUmWqG1UejG3xKUUsfIx8lfkgqkb2
         dLTgvdJdxAXZ2tw9UYVJ7ayzScYox3ebYEMNzzdXy9s2Rk2yPAq3tYcyZGIyIlXGHwVV
         F8RWsZR4/QwV/xEw5Qzs3KvM3L3T3bgn9eKcpmm0bk7szg7u/nApqp6c9hBK/KFakGp1
         FlCQ==
X-Gm-Message-State: ABuFfohcxyXFzBSpvIeVkp7YI0jvlsQvHvC6O9bKSq0wRTadQpuj00kC
        p56d715Uiq845pT/DMxJA9ybLuV+
X-Google-Smtp-Source: ACcGV63aeI6r1y8Gx5XclEr/JRSHg/IPH55f54XrBRoX4g/lTYveriYc+hVizZXB3iBIPaDgSOqKfQ==
X-Received: by 2002:a63:1806:: with SMTP id y6-v6mr23099371pgl.187.1539744306527;
        Tue, 16 Oct 2018 19:45:06 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id o131-v6sm24866952pgo.53.2018.10.16.19.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 19:45:05 -0700 (PDT)
Date:   Tue, 16 Oct 2018 19:45:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Hesse <list@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] subtree: make install targets depend on build targets
Message-ID: <20181017024503.GA117170@aiede.svl.corp.google.com>
References: <xmqq8t2y1o4y.fsf@gitster-ct.c.googlers.com>
 <20181016075624.30176-1-list@eworm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016075624.30176-1-list@eworm.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Hesse wrote:

> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -69,11 +69,11 @@ install: $(GIT_SUBTREE)
[...]
> -install-html: $(GIT_SUBTREE_HTML)
> +install-html: html

This broke the build for me:

 make[2]: Entering directory '/build/git-2.19.1+next.20181016/contrib/subtree'
 install -m 644 html /build/git-2.19.1+next.20181016/debian/tmp/usr/share/doc/git/html
 install: cannot stat 'html': No such file or directory
 make[2]: *** [Makefile:78: install-html] Error 1

The rule says

 install-html: html
	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)

and $^ substitutes to "html" after this change.  How was this patch
tested?

Thanks,
Jonathan
