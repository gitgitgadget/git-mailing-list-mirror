Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4B8C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 13:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhLENhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 08:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhLENhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 08:37:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC34C061714
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 05:33:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u17so9243976wrt.3
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 05:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GEfUUOCFW+nR0JbXVPc96SjjN32quaP2GeMebnEgZgw=;
        b=Sw8KGPJwb6+IuBzmlbZbnErSmZ1Jc+NioD0Nl0kDFZWHC/FXa5jKmuakZokpxbvnCd
         iyfZh8ig5it4fiCc4Uiz9OU3JXHqQdRM7zXVmzbj4eOvtdkak4QYJTxIvBj9SPPFIi1+
         FZ4SavxV/eYhIMhmLYxLQMmc3I97q/nqew1bG3Io7Ti36L0bk7ZOPx691mXjITNlqvKT
         s9LbikjCc1kX7jgJKErCzOQE6oRVu6FpY6Fw6kgzPJNJWBh54bIY3kA3qp9slLHqIZK1
         9CPAF11rVleJKzyCrfLT13PJbmmhJArK2a6hkBMSZk1BvHawOed/+I63lgotZKt3cwW4
         Rukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GEfUUOCFW+nR0JbXVPc96SjjN32quaP2GeMebnEgZgw=;
        b=Zbof1fXJYmf+WLbvbHA7nTpSAehtpbbi/5dZXsIFls+RE8Qnzraa2LBYGTmWsRqRHQ
         p6+AfBNuLmJFlE3KQJjAmN+4umbwN7EMzxvPkXwTQhHafXFEsvxNsT41YCtPagY8q9gZ
         7EonfxUOP4lImCqos0vT7Lo9jrpl0VBvjySrulH6d+wPCRoqM3WbWk5GbfNkSmO4Zkc2
         gvbyP5zxQtPZ1H3exXTB8Dk4OPg2qaYI1oEIWbGExWm5uln55ZJOrPWLs97C02bjxlzD
         0H3I5ZoWzceYXSn52o4pbN6xeJcvAMKu3WRY4AHLT9XbEcedmNtJtR+tdW6YNkBqX1qY
         0qzA==
X-Gm-Message-State: AOAM531D8vJF84tboCnnDyv5nB9CFhSozNZe7HrYEhoI2ghRP10eVV+t
        fu4xDpEAkKR8yQDR/Fn3RbA=
X-Google-Smtp-Source: ABdhPJw92fqL++/lx8F2v+IziqDMQoDNjujm9num0fFNV7p6oM6+L+9/PNxMqg4t9AGkRzY7UUuQXw==
X-Received: by 2002:a5d:414a:: with SMTP id c10mr35345527wrq.493.1638711235931;
        Sun, 05 Dec 2021 05:33:55 -0800 (PST)
Received: from gmail.com (194-166-87-56.adsl.highway.telekom.at. [194.166.87.56])
        by smtp.gmail.com with ESMTPSA id o63sm8065635wme.2.2021.12.05.05.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:33:55 -0800 (PST)
Date:   Sun, 5 Dec 2021 14:33:52 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] grep: clarify what `grep.patternType=default` means
Message-ID: <20211205133352.ukucgvynpuvypfnn@gmail.com>
References: <xmqq7dcq62af.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7dcq62af.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 02:10:48PM -0800, Junio C Hamano wrote:
> Back in the days when the "return to the default matching behavior"
> part was written in 84befcd0 (grep: add a grep.patternType
> configuration setting, 2012-08-03), grep.extendedRegexp was the only
> way to configure the behaviour since b22520a3 (grep: allow -E and -n
> to be turned on by default via configuration, 2011-03-30).

The 'the "return to the default matching behavior" part' is a forward
reference, so I tried this instead:

Commit 84befcd0 (grep: add a grep.patternType configuration setting,
2012-08-03) documented that grep.patternType=default falls back to the
"default matching behavior". Prior to that, grep.extendedRegexp was the only
way to configure the matching behavior (since b22520a3 (grep: allow -E and
-n to be turned on by default via configuration, 2011-03-30)).

> 
> It was understandable that we referred to the behaviour that honors

"It was" -> "It is"?

> the older configuration variable as "the default matching"
> behaviour.  It is fairly clear in its log message:

I guess %s/behaviour/behavior/

> 
>     When grep.patternType is set to a value other than "default", the
>     grep.extendedRegexp setting is ignored. The value of "default" restores
>     the current default behavior, including the grep.extendedRegexp
>     behavior.
> 
> But when the paragraph is read in isolation by a new person who is
> not aware of that backstory (which is the synonym for "most users"),
> the "default matching behaviour" can be read as "how 'git grep'
> behaves without any configuration variables or options", which is
> "match the pattern as BRE".
> 
> Clarify what the passage means by elaborating what the phrase
> "default matching behaviour" wanted to mean.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Whether the eventual deprecation of grep.extendedRegexp is a good
>    idea, we'd need something like this to clarify what these two
>    variables are meant to interact with each other first.
> 
>  Documentation/config/grep.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
> index 44abe45a7c..72f5e03614 100644
> --- a/Documentation/config/grep.txt
> +++ b/Documentation/config/grep.txt
> @@ -8,7 +8,8 @@ grep.patternType::
>  	Set the default matching behavior. Using a value of 'basic', 'extended',
>  	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
>  	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
> -	value 'default' will return to the default matching behavior.
> +	value 'default' will use the settings of `grep.extendedRegexp` option
> +	to choose between `basic` and `extended`.

Yes, much better.
Maybe "settings" -> "value". Probably subjective but plural sounds weird
since grep.extendedRegexp is just one bit.

Also this introduces a local inconsistency: above we write 'basic' and here `basic`.

>  
>  grep.extendedRegexp::
>  	If set to true, enable `--extended-regexp` option by default. This
> -- 
> 2.34.1-251-g6783e24198
> 
