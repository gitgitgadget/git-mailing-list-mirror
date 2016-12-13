Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB090209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753673AbcLMUJZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:09:25 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:32863 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753313AbcLMUJR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:09:17 -0500
Received: by mail-qk0-f175.google.com with SMTP id x190so128587113qkb.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 12:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0/AGfdDI+vU952v7ZAU/pRSAQq0ekB5OelcDCTW9Es0=;
        b=EV55SmpUtGkvH8c1OIiWycb24TXEhunYkILW/n3F7O9afi9o1CNnSQm3PlB4GgauiM
         ivPyyJJOUElKCis7B/X8KIGdYg8WIr6cgME/Bx7qTAGs74mFgQb7F7iBzy3E9v0FLgZv
         8v/Ap4nb5Pv5vLZLaTf+w1hrHIjb8EYo//nYhahR8ZjG2hWXWb5iqMla6AVgebpFjzr7
         /LWeNWM79jrVuQ9JKcLWe0UUu+QpsOI+P2pINOXo/F+LTI+LgN+OhNvIS889FdObdtRH
         es8axHQnM6zQaTjpT2UmWZ/zbrZ5TLUATuqPXqHA0rv4AIuxvk0dTcIpd3L0RXTb6jWJ
         KDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0/AGfdDI+vU952v7ZAU/pRSAQq0ekB5OelcDCTW9Es0=;
        b=mKDo36GSrrmLAdkNxhS0yXQnB1lFjW3kIY3LLobGVeJLGkUj010civ2TQ0VUFEN6WT
         gpFhn1t71hkM8EmPmLTm6FXHnESUynIfBQRLltxqbJsS5PScJFJPt233DRM0B5XkYrNi
         KpQzL8WTNP0r6aT6Zdizm1Cl+offSUrTxPMht1K0/hQWuZTS02FyzZHo6AKbVj1HYZO1
         mkIiQyKcVREhiPWIs0PZTWw9brDKnt3tlKEKyTEy12EFcJxVlQ0zbQhHi8B/bMmgPI8f
         PPqYBQNS91TeHNDA/MgXSdXeXwLCB6Rm25JFhToWDKTpTT+ePmreylLNlqij2a8riIPO
         +1rg==
X-Gm-Message-State: AKaTC02xt1X1jsY8V8WcBS/cAv0jEmh6BTi9h3PL8NNqzijQBwT4EWpyR7Bex87pkNGAuW6f3qCrrUMySD/k4Fdw
X-Received: by 10.55.191.134 with SMTP id p128mr80876840qkf.58.1481659756215;
 Tue, 13 Dec 2016 12:09:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 13 Dec 2016 12:09:15 -0800 (PST)
In-Reply-To: <xmqq60mn3937.fsf@gitster.mtv.corp.google.com>
References: <20161213014055.14268-1-sbeller@google.com> <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com>
 <xmqq37hr4q5t.fsf@gitster.mtv.corp.google.com> <CAGZ79kY_E8xnOpCAFQo_91FeQCs9X3fkassFYunG=adx81AcBg@mail.gmail.com>
 <xmqqtwa73ara.fsf@gitster.mtv.corp.google.com> <CAGZ79kZCza=cwtzQ7raU3ch_Z_5TDqt0AGN2fPHiRSTDu66Fag@mail.gmail.com>
 <CAGZ79kYsfybEBnWzv4OjCCLe70fNS=roZdKDbN_DSb4PDVJj7g@mail.gmail.com> <xmqq60mn3937.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Dec 2016 12:09:15 -0800
Message-ID: <CAGZ79kYM_3NWyRfk42=EshMYVZ=DSWRtn4RU4jkUE7v1EN6ngg@mail.gmail.com>
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The desired standard for submodules is to have the git dir inside the
>> superprojects git dir (since  501770e, Aug 2011, Move git-dir for
>> submodules), which is why I think an "embedded submodule git dir"
>> is inside the superproject already.
>
> Think how you start a new submodule.  What are the steps you take
> before you say "git submodule add"?  And where does .git for the
> submodule live at that point?

Well there is no way to directly start a submodule
(e.g. "git submodule create"), such that there has to be one repo
that actually has the git dir inside the working tree.

If the submodule exists already somewhere, there are 2 ways to do it
("git submodule add <URL>"  or "git clone && git submodule add")
which lead to different outcomes, where the .git resides.

> With the current system, you as the submodule originator need to do
> something different to make your working tree of the superproject
> match what the others who clone from your public repository.
>
> And comparing the two layout, the one originally held by the
> submodule originator has .git embedded in the working tree, no?

When starting a new submodule repo, yes, the git dir is inside
the working tree.

> All of the above is coming from "submodule" centric mindset.  It
> just is not centric to those who follow what others originated.

ok.

> Another reason why I personally see a .git in each submodule working
> tree is "embedded" has nothing to do with Git.  It is an analogy I
> feel (perhaps it is just me) with the word "embedded reporters in
> warzone".  These people are spread around, assigned to units to
> report from places closer to the front line and being closer to the
> leaf of the hierarchy, as opposed to be assigned to a more central
> place like HQ to do their reporting.

I talked to people in the office and got a heavy rejection on the
the work "embedded" here for another reason:

    "Does it put the submodule on an embedded device?
    What does embedded even mean?
    The end user is super confused"

So I think we should not use embed or un-embed one way or the other.
Instead we need to have another name.

I think absorb is ok-ish, as "git submodule absorb" hints that the
superproject absorbs something from the submodule.

So I will reroll it with "absorb" fixing some nits pointed out by David?
