Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8D91FD09
	for <e@80x24.org>; Sun, 28 May 2017 23:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbdE1Xwj (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 19:52:39 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36671 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdE1Xwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 19:52:38 -0400
Received: by mail-pg0-f43.google.com with SMTP id x64so14970239pgd.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 16:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hjW5TcuDJPkBAgwQqNsecMOcZKAB1bxL/YqlB+XozIo=;
        b=incz/cJgb0KKsQkxWJbx7UWC+XUm0YM4vnjedEEs4nvCaRZK7cfBnvAPp1cHZGx6k1
         Xmb9v341Guch8n0BngQF7XFgkQm76mCGhDYrAQP7tqgA0IOcJEIJJ4Ns/XF7tT+eBQDW
         aMrfPPyBEnZDeCv8hXeKYsNfDrZLn5yHOy5WToJGK0k4lbzGaX41Y+vV5dW4wmVTPx+l
         ze9itTjAZ9uHhijqRh/54SpBT2KGWLjvuvq//bIsN4BljuQgRjg8XH1nJvZ6mimgoUN7
         vHXc+JfuQVzKOishBtuE/9qsvSpiWor1hPcS0QwA08trYJ4d9Z3sNOs4O8fTvleM3iSb
         +JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hjW5TcuDJPkBAgwQqNsecMOcZKAB1bxL/YqlB+XozIo=;
        b=r3q5GiLI08CtStoAT/XDWuv7IHKwg22mUbaC8U6pam7yFZeT1ByByglRoOW3vxwrxt
         mkPj7cWDMfxXwIpMLUbldiNw/SntcYxUhRElpRCXUhe208BBbrm6kEIftgPYfBkMQi59
         RVE7q5iENqkMiSdT74iHQr+O2tuwrbP8bRDfGx2z/6vecUZZVBFjNwnVWdiYurX+NVhR
         Czz0ILxP9v/h5cN9f3lnGgbtTgrAcS1kGpMf+h9BPQwlClVmAKUO1326OKq+Ra6clBte
         usMMmgnpgyZVVn2M5MBMix/SVE+2vB/RSBnjAAudRMWJdXoqNlszDRrqOpB/0EgStfTO
         YNHw==
X-Gm-Message-State: AODbwcCOebyoeNR2Ohpr6ZGt4Y7Cg4k9xXtouPFvt2GVBuW3vAEIKS4c
        1QN09rI/l0n3EQ==
X-Received: by 10.99.102.7 with SMTP id a7mr15314263pgc.216.1496015557811;
        Sun, 28 May 2017 16:52:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id p4sm16964489pgf.21.2017.05.28.16.52.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 16:52:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: filter-branch does not require re-export of vars
References: <20170526173654.4238-1-asheiduk@gmail.com>
        <20170526183702.jrjkykhldz74pquq@sigill.intra.peff.net>
Date:   Mon, 29 May 2017 08:52:36 +0900
In-Reply-To: <20170526183702.jrjkykhldz74pquq@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 26 May 2017 14:37:02 -0400")
Message-ID: <xmqqlgpga69n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, May 26, 2017 at 07:36:54PM +0200, Andreas Heiduk wrote:
>
>> The function `set_ident` in `filter-branch` exported the variables
>> GIT_(AUTHOR|COMMITTER)_(NAME|EMAIL|DATE) at least since 6f6826c52b in 2007.
>> Therefore the filter scripts don't need to re-eport them again.
>
> Some old shells keep separate values for the internal and exporter
> versions of variables. I.e., this:
>
>   foo=one
>   export foo
>   foo=two
>
> would continue to export $foo as "one", even though it is "two" inside
> the script.

Yup, that sounds like a grandfather's war story at this point,
though ;-)

> However, I think POSIX mandates the behavior you'd expect. ...
> ...
> At this point, I'd be inclined to remove the text as you suggest and
> either make a small note at the bottom of the page, or just omit it
> entirely and assume that anybody on an old non-POSIX shell can fend for
> themselves.

Sounds good to me.  Thanks.
