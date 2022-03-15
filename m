Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CBCC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 01:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245446AbiCOBxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiCOBxH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 21:53:07 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC94610FFB
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:51:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v4so16484891pjh.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 18:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=0/NfANzvxH+/SoeG9KyXVM8G0RpJ3TkuCFLjZ5C2Bmw=;
        b=BSKQMR/7gcPL5yLDoqY0HNLG9YMCzTYFB7xbwUASDUfsMd1+4d7FVOM9pTXW7IDC1+
         szIATtShuUivY5dNnUQ74LAIv89A9w/MZ9lhSszJFFLLU5mZUU+2lph4nANnZkaPJptO
         nhdQPPRQVVRsydo+VrSz+TNSTullEu6EkXLS9Uug3kmnhH+1aMo8fcGeyur4MsAV0gCS
         hTGe/10OrcFhv78Ez+iBWyMUsWRFcJj26cuAWv298QGQwF8UzdZbRkO0Q0NgFbYmJEYp
         5ydS4bGCxu3hRy0NOXZ5Y5CQ53QPvTtMl0vqhs1/cAO+0Gc5LfH68fMEkrRWw62EIrTE
         61tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0/NfANzvxH+/SoeG9KyXVM8G0RpJ3TkuCFLjZ5C2Bmw=;
        b=WAmAdIGJ8UMziEfkSy5k+h5nTkwcfW6FGi+tCnzB/Lg4yLBI2edPf3BpsH0dBPwMbl
         OywrHmSdnluWeI403NxoN9ayUuvpJuneChLiElk+hdSaXGamWbgoa4flAB6u83Hb6UIk
         jTJ20JoobiH0cmma+UoAAHTN39sqGd6qrurFphBD+pLVFTJbqvn+Jhqi0cP3cdFctEDQ
         kGNOKTPUwyAe/gQa0q1IBeF0JsCMOuzuKazwcW4r0clNCrtzkWFMaVMYvCu0ha2s4CWk
         rYO96hRjJouWQLZVb9CLt/JDnrzQcJt3bzYjqSPJBvDoUiZYK5qttpYN6Vc3csL9G8T3
         g21A==
X-Gm-Message-State: AOAM5324k72tcP0hJjo6258r86aHfkKyU2u90bc+m5ighqRpF53DeHcQ
        bv2R0MRd2L9of5if1zQ6UBTsq/QjA58y
X-Google-Smtp-Source: ABdhPJyNfizPyBHIT7aCoF64CxTFbSYaLiG2tCsu2aRwQ+YEzh7Fv5v5k78byqYu8Y06jGN123ok2Q==
X-Received: by 2002:a17:903:40c7:b0:151:a640:d69e with SMTP id t7-20020a17090340c700b00151a640d69emr25516866pld.121.1647309116392;
        Mon, 14 Mar 2022 18:51:56 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id s6-20020a056a0008c600b004f667b8a6b6sm21313680pfu.193.2022.03.14.18.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 18:51:56 -0700 (PDT)
Message-ID: <2be1f465-efd7-fc92-210f-15ea88d54d87@github.com>
Date:   Mon, 14 Mar 2022 18:51:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: vd/stash-silence-reset (was: Re: What's cooking in git.git (Mar 2022,
 #03; Mon, 14))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5yogp6xo.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq5yogp6xo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * vd/stash-silence-reset (2022-03-13) 5 commits
>  - stash: make internal resets quiet and refresh index
>  - reset: suppress '--no-refresh' advice if logging is silenced
>  - reset: replace '--quiet' with '--no-refresh' in performance advice
>  - reset: introduce --[no-]refresh option to --mixed
>  - reset: revise index refresh advice
> 
>  "git stash" does not allow subcommands it internally runs as its
>  implementation detail, except for "git reset", to emit messages;
>  now "git reset" part has also been squelched.
> 
>  Will merge to 'next'.
>  source: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
> 

I just sent a re-roll [1] with some final changes based on your feedback
(test additions & cleanups).

Thanks!
-Victoria

[1] https://lore.kernel.org/git/pull.1170.v3.git.1647308982.gitgitgadget@gmail.com/
