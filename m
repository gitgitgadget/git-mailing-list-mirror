Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEBD72036C
	for <e@80x24.org>; Thu,  5 Oct 2017 01:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdJEBqz (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 21:46:55 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:44466 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdJEBqz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 21:46:55 -0400
Received: by mail-pf0-f171.google.com with SMTP id t62so5999384pfd.1
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 18:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ok23Jwo+EZ0k9awtGiGBPGWGExIkDAQt+MSZEksnhUE=;
        b=SM0tBymvuX3FbrIqUQ5H6n5nLmKKuliT0p6vtfCs5qBsBiD/ab1aRl4fs0Wp69qQPM
         NxN7KPUOnmdQincbsygoU0Se+/+M9NVERsttB4oFa065xp+daZ2kcQgb/6lJnMOoXhZz
         D6UxLSzbtDQDZ67a0q6lIuK/BnJZGo0IrVmsoXwRn9FUU2N3TYBbvu3X2hpqoXq0iGgY
         TNA/OWi6KrhaP7QIH9mNcto6ipVsQBV2xqFZhg9Vhh8td/jrfBDWyi3M7NDRNhhUwJy5
         o6K3haxeYAOCK5KMQCjBjDHQTqsfENe8GNIKGCHnVD+HP2un9s58iuBP/te0X3OrvYCF
         upZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ok23Jwo+EZ0k9awtGiGBPGWGExIkDAQt+MSZEksnhUE=;
        b=s1ulfk7TOLAOOHyhYPg4+kkIGvQ01P/oum5KSSrM2oWdeyX421f3bBU9mOggH7Cawv
         A4z42c7K3xIEVulb8JIwWwE31cN5+ikC1yDqfaUv82TuKZ0Pl/xvU7p/xPdgr+JfPg1I
         QDundETbA2iUsZXktDD2G9KV7IUvFbQMnuxAnJPuRqw4OylXtvsqFSJsfMtVreJpw5aB
         ZiPbcaWoQuizS2/llMSEJUlSSP2ozPWSCcKdQJ9f9l6O/UNjwJ9L1P97Cv/1HJFPj01W
         8PUmvtBHrDANzdCCVmzGacutf63Yv/uwuM99e2tFYqyeUQoBhU3Ihcfyi61wJw1KuRUO
         Gl3A==
X-Gm-Message-State: AHPjjUhXiT2ypcOMRGHhNH5Y78Q+V9bYFCIKbvZltJlEiT8zPE6MsQuv
        0PShRUgMyaUYLpNou97VpzU=
X-Google-Smtp-Source: AOwi7QCHc6TZDsY7yw8mVfJ8Xf0Bc6qVhe3e1XyTwhl9oGyDRp7GQhoOa2IEd7RLVVWtMP3BFsLwSg==
X-Received: by 10.99.177.6 with SMTP id r6mr19357190pgf.194.1507168014362;
        Wed, 04 Oct 2017 18:46:54 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:960:8965:26b6:313])
        by smtp.gmail.com with ESMTPSA id i12sm25050438pgr.21.2017.10.04.18.46.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Oct 2017 18:46:53 -0700 (PDT)
Date:   Wed, 4 Oct 2017 18:46:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
Message-ID: <20171005014651.GT19555@aiede.mtv.corp.google.com>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
 <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
 <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
 <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
 <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
 <20171004165947.GN19555@aiede.mtv.corp.google.com>
 <xmqqbmlm9y94.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmlm9y94.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> 	git checkout --renormalize .
>> 	git status; # Show files that will be normalized
>> 	git commit; # Commit the result
>>
>> What do you think?  Would you be interested in writing a patch for it?
>> ("No" is as always an acceptable answer.)
>
> I actually think what is being requested is the opposite, i.e. "the
> object registered in the index have wrong line endings, and the
> safe-crlf is getting in the way to prevent me from correcting by
> hashing the working tree contents again to register contents with
> corrected line endings, even with 'git add .'".
>
> So I would understand if your suggestion were for
>
> 	git checkin --renormalize .
>
> but not "git checkout".  And it probably is more familiar to lay
> people if we spelled that as "git add --renormalize ." ;-)

Good catch.  You understood correctly --- "git add --renormalize" is
the feature that I think is being hinted at here.

Thanks,
Jonathan
