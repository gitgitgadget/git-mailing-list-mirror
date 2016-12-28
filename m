Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331F31FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 09:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbcL1JJG (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 04:09:06 -0500
Received: from mail-wj0-f170.google.com ([209.85.210.170]:34490 "EHLO
        mail-wj0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbcL1JJF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 04:09:05 -0500
Received: by mail-wj0-f170.google.com with SMTP id sd9so147988538wjb.1
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 01:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=GxgIrqAb6MyzeIi+ENvIjEi2FcCuBN46+fstVKLk3lU=;
        b=RHZx3Na3Us+Dd/RJgvLQESnYpH10dUeGJ1oqdkuNklVs4/9n2RpA7ENmOGS5vHbnNP
         hpJRD27/levid3mZMXDXvUMKTDoAPcY30e5a2ZzPFTJqfraqz+o10UMiHQn7Q2HDoNla
         JZA6KbUPsmg7GFnjmQScFyqfwP/pOlmlpg0mIpEiFlI7Pl9R9ag0YGGRERdpJ5OCz3fb
         SGKBB0HT53lQp6qc53vwc4Yy3nkcJW4WaTrUn/lbDaxmr9SymrM2CgNLS0Mrsx4heG83
         plvR0RP0eWg1UfBzltwmWPp1PHtSwWqCEQG7qLZgF+/qwtRNoH4i+kFC3ihIIpdEUDab
         L0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GxgIrqAb6MyzeIi+ENvIjEi2FcCuBN46+fstVKLk3lU=;
        b=q4wYMmyO6q+4WJf58gsBdYve/N4etUPht5QEh4juKvYnbqxntXVt/3RBaKKmGZOKea
         ZzMCRhERpiLuKvy9yluMTb5p1BCD+q80Flg83umAq6WtBiCOXbOxdRYcEqwvWS811JHj
         se0H9/GOeQo8w8jYsef9F/ZwD20IWkf/Lhx/rUwMSuuCK2ja+/4Li+N3cMB1l6flYHL9
         53iy+yE2nlQgXJxeMKe2oV2tdHo+gHdNiTLUXnDItt0wU4DspNTPgCKuPxr4LxryUREK
         NbjmRikikVRWABeU0llo/zzzq5eY/Q2sJJxOlNgJPF+l9J6CL6t8JDR087sWLbfSQUiE
         aRRA==
X-Gm-Message-State: AIkVDXJSGdAulFBo+h/RJW5TbvF1X7ZyS+r/XWx2/rPVUEt6ogo0VbcLSsVapNwwrkAvXQ==
X-Received: by 10.194.122.101 with SMTP id lr5mr31156039wjb.210.1482916144056;
        Wed, 28 Dec 2016 01:09:04 -0800 (PST)
Received: from [192.168.0.213] (88-111-149-57.dynamic.dsl.as9105.com. [88.111.149.57])
        by smtp.gmail.com with ESMTPSA id l187sm59900843wml.6.2016.12.28.01.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Dec 2016 01:09:03 -0800 (PST)
Subject: Re: HowTo distribute a hook with the reposity.
To:     Jeff King <peff@peff.net>
References: <6e228b75-0208-63e8-b4e8-70905e3f9ea3@gmail.com>
 <CA+P7+xqHTgRvMRwgL2TJ7SRb_SR0sbtA039J_5N0xSjf3TNrgg@mail.gmail.com>
 <20161228060840.gelgcs2hd33id56j@sigill.intra.peff.net>
 <6801f971-418d-18c9-8002-9c2f7b8c8008@gmail.com>
 <20161228085248.tu54e6ug5fvpr26l@sigill.intra.peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
From:   "John P. Hartmann" <jphartmann@gmail.com>
Message-ID: <39886f48-c48f-6800-8aa4-20e0b2ab0e6d@gmail.com>
Date:   Wed, 28 Dec 2016 09:09:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161228085248.tu54e6ug5fvpr26l@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Peff, for your lucid answer to my question and much more.  All 
is now clear to me.

The problem I am grappling with is how to obtain the latest git commit 
hash and enter it into the generated code.  Configure/make would appear 
to the the time, but by then the user may not have git installed (e.g., 
extracted the project as .zip from github), so it needs to be done "back 
at the farm".

I hear that the best I can do is create a normal script in the repro and 
add to the developer handbook that "btw, here is a git hook that will 
run it automatically if you so choose".

Thank you both for your prompt and exhaustive answers.

	j.

On 28/12/16 08:52, Jeff King wrote:
> On Wed, Dec 28, 2016 at 08:42:25AM +0000, John P. Hartmann wrote:
>
>> This project is hosted on github.  If I put the hook into the repository
>> manually (if I can; I don't know that), is it true that the hook would be
>> distributed on a clone action, but not on a pull?
>
> I'm not sure what you mean by "into the repository". If you mean "into
> the .git directory", then no, you can't do that. Git will not add ".git"
> directory contents to a repository, you cannot manipulate the contents
> of ".git" directories on GitHub, and a client wouldn't ever look at them
> on clone or fetch anyway.
>
> Did you mean something else?
>
> -Peff
>
