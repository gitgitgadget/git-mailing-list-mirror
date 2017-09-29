Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C7A20281
	for <e@80x24.org>; Fri, 29 Sep 2017 22:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbdI2WpL (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 18:45:11 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:47576 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbdI2WpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 18:45:09 -0400
Received: by mail-pg0-f44.google.com with SMTP id d8so505736pgt.4
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 15:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rxScXq4V5YZdEGRbjTQdaEurB7M2Es3Ew++Z+YgY68M=;
        b=MyERcLcbUhcgQnDBsVmp9e48g5DdpT4Rs/qb4Z2C7049jFMdG8zU9wxuGI5sBNCwcZ
         XRKGfdHJs2sEUS5xd4Ue+gwRIs0Mh5OnVdhN7Zl0gEle3GDauoW3s6nxF+QbpUalPFCM
         NY3vtfVMiQAxXlBGav18mQF2NLSfPeeLTTwEO+Eq5z14JDcJMjrqN1IK4HBeseed7w1w
         awclsVyTXb902DIV5kIO6jPk6Z2C5Lv5C/7techGd4ipOQyUZZ0+ruWZ6//O5AcwhlbC
         IhgvUCREvprUoVPputE6Mzu0t+obl6/HQAjsRast+enjwG+TUVY05HrDXuMCqxKMtqqU
         VgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rxScXq4V5YZdEGRbjTQdaEurB7M2Es3Ew++Z+YgY68M=;
        b=PRWTk+R7LGjE6u1l1j7EfrjFMoDMfLWx/T083fN15xm1mQBsRuXG+lauTN8WI5DBxN
         +LjXd584qO+jNnXPWEpD/7qIQYiONZXTPGULd2fM+uIfl8Dmnto9iv5Jk9kOH+iLSK+5
         csWlOj73l2MUfYEyfcWNbqeuTMy7EMeQJ10Kry1tTQYLYaBAHc23BLEIwjzPRre//bmg
         vtnHpeWOEIfqFaVwnxFxINpXDvsgCdsK6FsXrx8KZGOONJhrv9Ol9jZMccfDESg1sBYe
         gco0m/3OsOqMCe/lBbXzoomrbjRTaWnoVFcNjNB58HRiwow2lRPlsXKiVeSw+CVLFIw0
         dBwg==
X-Gm-Message-State: AHPjjUg8Ll6teSvFl3EnnSi1ScaVtkpwAytbZ+y0Gt0+yIgdDHEZ+cfm
        OoMa7jDAB6IJTeg+T7raFbo=
X-Google-Smtp-Source: AOwi7QCr0/WC3Qn4aYYX0AicRuQYbUq4IebPcNr4cCJdM6G+rrgBOvkBe4pKE7up3E7fAsK9IC/WFw==
X-Received: by 10.98.0.87 with SMTP id 84mr9094664pfa.177.1506725108441;
        Fri, 29 Sep 2017 15:45:08 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c47c:760e:a02b:2eef])
        by smtp.gmail.com with ESMTPSA id n18sm7839581pgd.69.2017.09.29.15.45.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 15:45:07 -0700 (PDT)
Date:   Fri, 29 Sep 2017 15:45:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] clang-format: adjust line break penalties
Message-ID: <20170929224505.GN19555@aiede.mtv.corp.google.com>
References: <073f00fa11930a3607e34828e7563e1b2dc27d2a.1506709551.git.johannes.schindelin@gmx.de>
 <20170929184032.GK19555@aiede.mtv.corp.google.com>
 <c1230d5b-ff84-8cf4-8ae7-b8387bf4bb04@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1230d5b-ff84-8cf4-8ae7-b8387bf4bb04@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer wrote:
> On 09/29/2017 08:40 PM, Jonathan Nieder wrote:

>> Going forward, is there an easy way to preview the effect of this kind
>> of change (e.g., to run "make style" on the entire codebase so as to be
>> able to compare the result with two different versions of
>> .clang-format)?
>
> I just ran clang-format before and after the patch and pushed to github.
> The resulting diff is quite big:
>
> https://github.com/sbeyer/git/commit/3d1186c4cf4dd7e40b97453af5fc1170f6868ccd

Thanks.  The first change I see there is

 -char *strbuf_realpath(struct strbuf *resolved, const char *path, int die_on_error)
 +char *
 +strbuf_realpath(struct strbuf *resolved, const char *path, int die_on_error)

I understand why the line is broken, but the choice of line break is
wrong.  Seems like the penalty for putting return type on its own line
quite high enough.

My Reviewed-by still stands, though.  It gets "make style" to signal
long lines that should be broken, which is an improvement.

> PS: There should be a comment at the beginning of the .clang-format file
> that says what version it is tested with (on my machine it worked with
> 5.0 but not with 4.0) and there should also probably a remark that the
> clang-format-based style should only be understood as a hint or guidance
> and that most of the Git codebase does not conform it.

Sounds good to me.  Care to send it as a patch? :)

Thanks,
Jonathan
