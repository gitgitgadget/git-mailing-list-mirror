Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3E220193
	for <e@80x24.org>; Mon, 24 Oct 2016 21:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934704AbcJXVqF (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 17:46:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33857 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754239AbcJXVqE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 17:46:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id d199so11728236wmd.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 14:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=GsREeMFWBQ7yrcLEtJ5amSTEJMjEFK9XNyn6/1DsS6c=;
        b=VsqX9lkcmNwMW4LBwsn0KrWyE3uDQ1jpp2tsXH/6fze6/cDX4e+PfaPLg0rCV7C8jp
         awIHL/Ey94yO9JfaEDBOlM3lfpEtHYGfdoe4vUAYUKoLKPVEWb8CNHm3GnE5/M4/rwVv
         i5UBXnKKnvP4UDpBtQBH3z8kZ4whc68U6DMRYZdUAKkdZimZ0nVfUkp4bGd5f88ju+oH
         Wf5C2RRHGFiaVDKGpnHurTNU8+/NipWst/VvGL9fSDZxR+/8K7D9T1aRmXkMctgZD+Gy
         YhwUEcas32WX2xQwhsikaItcSVNzGunt5qYfjs6aE2sCe7TzGx+25FL2hoyUxIVoPiAP
         +cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=GsREeMFWBQ7yrcLEtJ5amSTEJMjEFK9XNyn6/1DsS6c=;
        b=c5LhjsQTEYJvYvvD8Vmk/fcCwmVITxd8iJMLwH1vsS++N1KyV2kpK7WGLEfe3JToUr
         KVYlcfG0L6O50avrxS8VI1M9Pe0GMMCkqmfkpY/irINmj6amm3ONgLxf8hUppbvmHIg8
         sLOvjkHVIK6SsnZ3abMExMi4QGKZohfTvPEonTV07lqH9vw0cjRh2/4RljfN4C7ApCAj
         rcANYlNbYqDbnOLx6VHVgFq/RmzZeIbC9W98DIYzYGfis2+pFvajwi5b4qTodSwPQ4GF
         UpvoXM3jcQzrfUneAZDhf418ksHLokZAo7vmMPnOfcbEM9HfCxTclLfgbia24PwdIjWH
         m2kQ==
X-Gm-Message-State: ABUngveUGzb1QaVftCdpBrvaJ5u9SmXvoIh9c8I/5e354jkVIJp8IqPdJHtrlf+tXKqgIQ==
X-Received: by 10.194.94.168 with SMTP id dd8mr13109312wjb.96.1477345562906;
        Mon, 24 Oct 2016 14:46:02 -0700 (PDT)
Received: from hostname_variable_in_muttrc (94-226-13-126.access.telenet.be. [94.226.13.126])
        by smtp.gmail.com with ESMTPSA id 198sm16855213wmn.14.2016.10.24.14.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Oct 2016 14:46:02 -0700 (PDT)
Date:   Mon, 24 Oct 2016 23:46:01 +0200
From:   "m." <botmetkas@gmail.com>
To:     git@vger.kernel.org
Subject: An anomaly, not a bug
Message-ID: <20161024214601.GA11699@hostname_variable_in_muttrc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Concerning ".gitignore", experienced using git 2.10.0

Starting code using one or more spaces or tabs from the left
margin will have git reading .gitignore and ignoring(or
un-ignoring) the command-instruction.

Example: Starting .gitignore

/*
        # above line is duly read.  Then un-ignoring
        # something but starting the command further to the
        # right will have git not reading that line

  !/nottobeignored.file

End .gitignore

Note: the comments can be started away from the left margin,
as normal in all unix-linux configuration files we know of.
Git follows this behaviour fine.

The lines containing commands, on the contrary of regular
convention cannot be indented by spaces or tabs.  Quite
unusual, confusing, not in the sense of conventional and
easily adverted in coding git.

Could be we are missing out on something,

Git command line tool is a functional tool now in our setup
for two years, first noticed this alien behaviour in this
version of git, on osx, the fink(osx package mananger)
binary.


