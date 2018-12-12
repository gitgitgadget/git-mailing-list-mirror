Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD7020A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 09:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeLLJsb (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 04:48:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36943 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeLLJsb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 04:48:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so16971443wru.4
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 01:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qroFAZxXyK0mdn+AJkEUeqhBy/6DR/SCX9QB/3oKKiA=;
        b=Wn8Z1RWaxjkzcOZ+QvMuVYV+2bOj3G6K4sBqGO3ofEUqIGvd9bWAtIsdSC0ndm6X1D
         xA9bK5VVseXFgOZVDb2YuBogZcbkjR35unAyEISxtsYhpVSkACd7qTkeggIfx0NhXBr5
         P93ld88U6OhVn2xYMo3eNjFsp7gL2TnoV7dzzKevkS6ywi7jpRAfYZSAydZgsPW3xsAS
         HmltXzYu4rIzejZUTNffPwoU8TM4xqDXE+qMN0H+Z9bCocKIkHsSbJEFMHWcjry5l7q9
         +ougIIH9+RN/JtmVLL2iBIWfCH1K9dVxE9QLxs2vLaH/UAY1MgerH0/3GnLVvCfT5eud
         a9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qroFAZxXyK0mdn+AJkEUeqhBy/6DR/SCX9QB/3oKKiA=;
        b=op9v/bu/PCWvXaI2f3lJjj/s+jF51qLGRgwCqTedTNGzr4xqvsU7Kwf3wbvXhXpbeV
         BuQysWY/PX7qBlSXIHfYZc7qM5uYpPiaZOWwAgQY7cxvCMJeRsQTBBzc1ySgX0yRoq1F
         Wcz122VGMKIjwfmLbbq1gyeR2OkLD14Xk88D+uk5THEVAH1fzId9XhUK9LHlnrdtTDSW
         XeNwlV5r20IWB2p7sJ1Pz3u7yALz+DGFlQ7nh4NgpojGzCtUHnDDr8p5m8DjRFqrsTpz
         BaFtvwd04npjSQmb9y+YRQZJTdpDhT4Ue9sVd08nUlY8fbf/QlL7GqLtzar2PX8v/YzW
         kieQ==
X-Gm-Message-State: AA+aEWY1s5SiZQIbO4N4zc5wFbu8APignwJSTgJNcwPsDEDSmSBJDu+2
        ST8Vs/0tGEKE6SZ/D2wV2ko=
X-Google-Smtp-Source: AFSGD/UBMurmfJw0rPNlbfS28cTvbSs6UdlHioqX3bqVlv5Iig9A8AtoTOivzIwCtre+UKLFJlUrFw==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr15884806wro.77.1544608108944;
        Wed, 12 Dec 2018 01:48:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w8sm17774157wrv.7.2018.12.12.01.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 01:48:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Minor(?) usability issue with branch.<name>.pushRemote
References: <871s6n43ng.fsf@javad.com>
Date:   Wed, 12 Dec 2018 18:48:27 +0900
In-Reply-To: <871s6n43ng.fsf@javad.com> (Sergey Organov's message of "Wed, 12
        Dec 2018 10:15:15 +0300")
Message-ID: <xmqqh8fjhy8k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> So, finally, it's 'branch.linux.pushremote' that is the "offender".
>
> Looks like both 'git status' and 'git branch -vv' should somehow learn
> about 'branch.<name>.pushremote' feature so that their
> output/suggestions make more sense?

Doesn't "ahead of X by N" mean "you forked from X and built N commits
on top", not "you have N commits that is not in X which is where you
would push to"?

