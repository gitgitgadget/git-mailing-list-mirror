Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914AD20248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfCFXnr (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:43:47 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:35504 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:43:47 -0500
Received: by mail-wm1-f49.google.com with SMTP id y15so7570159wma.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dEUybmKcIPJ0umg6+qIUylZUmbuHs9v4qOxlC2ph9BI=;
        b=mkfGuLnKDw5JOZNJkp7c56Y8t2H4VBq3jVpQk99R9Ql0jbzIWu43MGgVZVa9m5SQKC
         fYlOFOjPxhMObJYnGDHB6VowtDKYWEK46Jy3KV6j+WcS2W5jRUy5O9hCRXOhSxNtdeZZ
         2Z/l6oFlTdKoh3cH0R+vIKoszw4oaeVNsu+NleZtyz9hAdO5N9PNVjr24ntFvUe3ru6H
         8uetScAlpXtJCINF6eLG7JDd5DmjOlskuSVg24A17Nn3zB9egOpm2K/wJXa2CpV4GSVY
         MQWdjkMFHyJ/avb43n3PEzTy06B62jSih63QVoAW5VyIxSY4Leaxg6l4GRQ31RA+M9dt
         lChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dEUybmKcIPJ0umg6+qIUylZUmbuHs9v4qOxlC2ph9BI=;
        b=gzp/jNX7IHyL67Jn7f4vqELVzR3AUB+AO6KjC0BHJEEBcDDVo8C4j/RHT0tuhkaGHH
         UL1XKaEfw7PC7Y0Lyr3PZmXH1pluiOd/gCcdV0JZ19Zkaci/6knI78Zn8o1Y3BCodNKQ
         fd8GBTL+BDMQFWFO5BklIuGhHqU9KQRRt2FnCbI6DzNQrm6y4yjNSwyZ6DkZQt4r7v3/
         EzakxSnl9arW3Q3xcIFfGhfgFELKqq9kRrImPjkUXylkI8RHCEMChMRaGR/rl/5KMJr4
         ndW875id0lfs2B0qP0KrkpHxxeuOlSWMnrC+Tz4vdC8EmdnIVVJPt9os9fd6JxaCrTE2
         3PUg==
X-Gm-Message-State: APjAAAUUahjRVRnFknsqDCTQB4/tGZwJXwghB0waSvIunvhFQXoGWyrY
        2y5Hh7JC+zWf94svFfdFnsPoNIuOFnI=
X-Google-Smtp-Source: APXvYqyMIMDhBT6zCACCmMv7mVWr8g/BdOwkTtqYKeTlTEATVTB+mQNnuf3nkL9dxoybb2pwJBfIoA==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr4094973wmc.30.1551915824954;
        Wed, 06 Mar 2019 15:43:44 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w24sm1685138wmi.40.2019.03.06.15.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 15:43:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
        <20190306014143.GA2580@dev-l>
Date:   Thu, 07 Mar 2019 08:43:43 +0900
In-Reply-To: <20190306014143.GA2580@dev-l> (Denton Liu's message of "Tue, 5
        Mar 2019 17:41:43 -0800")
Message-ID: <xmqqpnr3po0g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> It's safe to merge to master but it'd probably be better if we keep
> cooking in next until I can get the fixup patches out.

OK.  Or we could kick it out of 'next' and replace with an updated
series instead of "start with broken patches, with fixup on top".

Thanks.
