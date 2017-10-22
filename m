Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84D6202DD
	for <e@80x24.org>; Sun, 22 Oct 2017 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbdJVVZK (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 17:25:10 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:43680 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbdJVVZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 17:25:09 -0400
Received: by mail-wm0-f50.google.com with SMTP id m72so6429798wmc.0
        for <git@vger.kernel.org>; Sun, 22 Oct 2017 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y58ng3GWns5PFaxDb/p5rrdFOjgaSAcSgyGG5mq+FGw=;
        b=uGRc2myOtP8m9zeB8HjYjIonJP5g1yBvgnVRecRMutVRzjmp9BYLWJUYASN5MXOTvJ
         3QJcLv6tbuu8QDKqtVQhiQJb7/xqaP9uQ8loAcX7HkRZPp4CYrlbf+9ff96gPoiXaV8g
         tldN+5oQvPnNLTnRPkB2B8l7/YUxtVLIQDB9GpnRqaHyHP4PqnzgBBamKuvZfy66H29x
         3XHF/mEV7AQWB3dCmWSJ41PnFbEAzIfYWBh0Sp56w/6QIHObEjJQ1zifaHZ7JAFLpNQP
         h5bzKjShrX4GAupow6GR9ha9GeJ9zdtXD7/IpHAgjKT7jNyilYUUiOdTjbWoKaf6yA9K
         VuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Y58ng3GWns5PFaxDb/p5rrdFOjgaSAcSgyGG5mq+FGw=;
        b=Z0dDAvr2euLQgbrf0fFM7jmVBKfl47Xh6qNP9vJuYkjBB9hJuBEavUb3ARmVtWY/7N
         U2FfSc0yfC+Jt0REkQqyouXNSHGjI+LnbCkF6ybj2MiAyaD8+2CNpPAMY0Jc+XGFqXOm
         F7TIiZDo5UQmhxcOA+0xbmthfIMcDJQkxy5916il/SZGD4qJjtwic+EYsqTK7f09HlGn
         6/NOhzec3gbbSPGUrp99i9wEU85cm+8d1iBZlvGY81hpZDl7HYuTUFE3KafTQKUxVStp
         nFIRwol7ve12heegWD6DKdiyTNcIHrlrrLlVrFmhnSW3Q/as8i+LIvlJOi3VngrHJjGf
         NZiw==
X-Gm-Message-State: AMCzsaXOcGiFQNd6guoF/k+7Cbbdl8uR7AyoZRd9ynpYu7zcnBL4AAiK
        ANExh1+Uucyj19EqxL4dlaMLf+Pn
X-Google-Smtp-Source: ABhQp+RSlaSpHCeY1vtQfx7+2b7zDA3J7rqnZsUpNtgO0Cz+4JS8mQWYa8OnO+LQ8NQNTZJyHLkSew==
X-Received: by 10.28.69.91 with SMTP id s88mr3751098wma.19.1508707507670;
        Sun, 22 Oct 2017 14:25:07 -0700 (PDT)
Received: from laptop.local (host-78-145-151-122.as13285.net. [78.145.151.122])
        by smtp.gmail.com with ESMTPSA id v88sm7516588wrc.33.2017.10.22.14.25.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Oct 2017 14:25:06 -0700 (PDT)
Date:   Sun, 22 Oct 2017 22:25:05 +0100
From:   Thomas Adam <thomas@xteddy.org>
To:     git@vger.kernel.org
Subject: Ascertaining amount of "original" code across files/repo
Message-ID: <20171022212505.wxdpfaevxw7fsn7e@laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170714-87-e4144b (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I was recently left with an interesting problem of looking at a heuristic to
determine how much original code was left in a repository.  Or to put another
way, how much the code had changed since.  In my case "original code" means
"since the initial commit", as this code base had been imported from CVS long
ago; and that was the correct starting point.

What I came up with was the following heuristic.  What I'm curious to know is
whether there's an alternative way to look at this and/or if such tooling
already exists.

What I did was first of all ascertain the number of original lines in each of
the files I was interested in:

	for i in *.[ch]
	do
		c="$(git --no-pager blame "$i" | grep -c '^\^')"
		[ $c -gt 0 ] && echo "$i:$c"
	done | sort -t':' -k2 -nr

Given this, I then did some maths on the total lines from each of those files
and to work out a percentage by file, and over all.

What I'm curious to know is whether this approach of using "git blame" is a
good approach or not.

Thanks for your time.

-- Thomas Adam
