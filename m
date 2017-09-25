Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60948202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 23:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935623AbdIYXoc (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:44:32 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:52103 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbdIYXob (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:44:31 -0400
Received: by mail-pg0-f46.google.com with SMTP id k193so4909218pgc.8
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D55uMxZKqA3JmcbLywCVJtl9E2JXSMVvqOtbTlZu0jI=;
        b=WHPvEPTg+jPMB4YMaIqMOInyqXDkov/96W4/zJYXdeBZ+S7E4QyCpkcjpq+Qlivkn/
         t7N4tNq/ep9t8vks+aEIEPNyT83snwggIvF7XZueXw4VksNVRl269xSP52JjW0Hrx1OU
         frAMjVjGHnop73L74iD4h99aDfoA/B4Ty/PTQCqpH4LsVBE8KxSgJc7W77En00kSWSzH
         uc9hhO0AWFpCVsh/BLDz8LyyUKRLEK3nWIA95OaoOTcSijBHl3B2TOEYlD8aIZIcepMA
         DGIlESwsemqRLwFtD26xfCaEvdkpf79iTWxejzut6hrKxgHMNpdF/mj5ZD6l4OMx0bBK
         ys0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D55uMxZKqA3JmcbLywCVJtl9E2JXSMVvqOtbTlZu0jI=;
        b=YJLK4TnwCC+H1nuAoRtHKKPwc/FS/dOx4WMOpTAWk/haeTNmh6dqHJQpJk9T0ujCpw
         xnpspdey9c8kgeluYUv4cINsKUTe3FHUQ53TlTY2sAZU1jVLxsIcMOQ1d4RgUAtYSP7G
         56RKONBF4N1RsotyUBILlba9qHDAPsbs4ECuM4HWfPhHLWIUdKENrCSV58qa+C3pejBG
         4tHTG5SXH+b6JmVhsEn1mnTl+on6TJdCnNcYRWOrcY2jXoPnLVVawBfHspE5JFY24+y0
         9TPiubYafGw2IJgYY5K6UkYcFANybDCWXgQxdV+h4NpxjfFcs9mQuqEcltAvQTwv6TjJ
         97vw==
X-Gm-Message-State: AHPjjUh6oFqM43M78vxU67u9D82W8+1pIKFQ2lXAVQ+Zm1dCrgGo3mMJ
        zwXuJuwOWSG5A6t/m8s5kqpS+m8X
X-Google-Smtp-Source: AOwi7QDljwZYQ//MOKUuJRQiRkZNglVnEoHN5RKTCfUO7gIdZE2xltXAQe7ndkpIvJ1U9yVGLyt8iA==
X-Received: by 10.159.247.200 with SMTP id v8mr9248679plz.135.1506383071154;
        Mon, 25 Sep 2017 16:44:31 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id l131sm13722878pga.24.2017.09.25.16.44.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 16:44:30 -0700 (PDT)
Date:   Mon, 25 Sep 2017 16:44:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation: consolidate submodule.<name>.update
Message-ID: <20170925234428.GJ27425@aiede.mtv.corp.google.com>
References: <xmqq1smxj7md.fsf@gitster.mtv.corp.google.com>
 <20170925191011.29863-1-sbeller@google.com>
 <20170925191726.GE35385@google.com>
 <CAGZ79kZZJe=EYh7wecAWneVKrWoBLrPoWuMWmC219vzWVzP6mA@mail.gmail.com>
 <20170925222229.GG27425@aiede.mtv.corp.google.com>
 <CAGZ79kY4tAfYERj1V2AL+piqWe6nw0qA+AHqm5w6ch9WiL86pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY4tAfYERj1V2AL+piqWe6nw0qA+AHqm5w6ch9WiL86pw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> By as-is I refer to origin/pu.

Ah, okay.  I'm not in that habit because pu frequently loses topics
--- it's mostly useful as a tool to (1) distribute topic branches and
(2) check whether they are compatible with each other.

[...]
> On Mon, Sep 25, 2017 at 3:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Maybe we should work on first wordsmithing the doc and then figuring
>> out where it goes?  The current state of the doc with (?) three
>> different texts,
>
> such that each different text highlights each locations purpose.
>
>> all wrong,
>
> Care to spell out this bold claim?

In the state of "master", "man git-config" tells me that

	[submodule "<name>"]
		update = ...

sets the "default update procedure for a submodule".  It suggests that
I read about "git submodule update" in git-submodule(1) for more
details.  This is problematic because

 1. It doesn't tell me when I should and should not set it.
 2. I would expect "git checkout --recurse-submodules" to respect the
    default update procedure.
 3. It doesn't tell me what commands like "git fetch
    --recurse-submodules" will do.
 4. It doesn't point me to better alternatives, when this
    configuration doesn't fit my use case.

"man git-submodule" doesn't have a section on submodule.<name>.update.
It has references scattered throughout the manpage.  It only tells me
how the setting affects the "git submodule update" command and doesn't
address the problems (1)-(4).

"man gitmodules" also refers to this setting as the "default update
procedure for the named submodule".  It doesn't answer the questions
(1)-(4) either.

Thanks and hope that helps,
Jonathan
