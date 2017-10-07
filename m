Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A8D92036B
	for <e@80x24.org>; Sat,  7 Oct 2017 19:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbdJGTEI (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 15:04:08 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:52070 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdJGTEH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 15:04:07 -0400
Received: by mail-qt0-f180.google.com with SMTP id q4so36900041qtq.8
        for <git@vger.kernel.org>; Sat, 07 Oct 2017 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W6/aKrUCTHdeCgfqy5qsyHiEQxeQRufLqeh6Q3e3T6U=;
        b=AXm/QGOL41wil00UfAYjy9p/xy3sAS7CnGN29DDWCNV7T9EPcCCzHYAuyQrhvliCiE
         piCLB0Jw8fGCkZJhjSv8d06VuL8nwvITPle5msj4buUPTvNc/e6zJdO+pth3Eic0NjUa
         jj7K16ehtH02/wCXfc1T87MVlkdNzIidKxQSciojft0Gq6c5Ec4WVgiRrRwBLkemUGgL
         AVv8Nu/CXIoutRfyXn8LVZvIVlFnWSFztpuvuCacvS+hFBpbvU4T5iQUJt3BcwWFfTea
         IThXkfgh3MhmUAf6lJgKWLQ+6OVXCHvBKcnwhxD/XeUImKr2gDLAB7naTW3i+H/enel3
         yLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=W6/aKrUCTHdeCgfqy5qsyHiEQxeQRufLqeh6Q3e3T6U=;
        b=LzM4Jru5TLYAmgxhimDBaQAP4YwSHsWG5/aRMqqJC4R/Ih251MumWjQdJwl8E8gXaI
         EJVd2ixuhZoBh/WiSNlJ5jh/S0ai6zDmPfkqu+E6R6Tgse9T9kxnObdryMcxK+MUFZFw
         L2u1pJhy7HV13wLqohcNFBrF6nMhdeuMelJj56h7euuFq7Q7CONjOBJBmhpBLwR2tTii
         roryv6IRmF5VTJ0h1reIWgi4g21F44EaPa1xt2w2SFRZGyrD7wvjMDrevorAq5q5u7Hi
         uDgGMDqZVnGX8MdpuOpaFr7ivpgLk9ZkxJsFHkIcDrJCIW1KnVt19hrOPMTNTxKfWj09
         W0Cg==
X-Gm-Message-State: AMCzsaXHHO731vyYFgMaLgQ9qrwMoI5aqD08OOtuy7Ns/HdhWiYnIWtT
        wTZm8sPXxWtE5nQwZffZQu7UDMl8
X-Google-Smtp-Source: AOwi7QDZAJID5jt5KdDhCNaO8X0VqN9oIAuaci3oFKXPL6C0ArLjEpn0O2Lp7W/5HZRBsntZ4/K+1w==
X-Received: by 10.200.25.78 with SMTP id g14mr6256659qtk.225.1507403046735;
        Sat, 07 Oct 2017 12:04:06 -0700 (PDT)
Received: from zaya.teonanacatl.net (pool-71-113-173-254.hrbgpa.fios.verizon.net. [71.113.173.254])
        by smtp.gmail.com with ESMTPSA id 49sm2751383qtq.1.2017.10.07.12.04.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 07 Oct 2017 12:04:04 -0700 (PDT)
Date:   Sat, 7 Oct 2017 15:04:02 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
Message-ID: <20171007190402.GH3382@zaya.teonanacatl.net>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert P. J. Day wrote:
>
>  was just testing variations of "git rm", and man page claims:
>
>  -r 
>     Allow recursive removal when a leading directory name is given.
>
> i tested this on the "pro git" book repo, which contains a top-level 
> "book/" directory, and quite a number of "*.asc" files in various 
> subdirectories one or more levels down. i ran:
>
>  $ git rm book/\*.asc
>
> and it certainly seemed to delete *all* "*.asc" files no matter where 
> they were under book/, even without the "-r" option.
>
>  am i misunderstanding something?

By shell-escaping the *, you're letting git perform the file glob.  
The DISCUSSION section of git-rm(1) says "File globbing matches across 
directory boundaries."

# With bash performing file globbing
$ git rm -n Documentation/*.txt | wc -l
199

# With git performing file globbing
$ git rm -n Documentation/\*.txt | wc -l
578

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Whenever you find yourself on the side of the majority, it is time to
pause and reflect.
    -- Mark Twain

