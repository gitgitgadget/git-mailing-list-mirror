Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4F71F731
	for <e@80x24.org>; Fri,  2 Aug 2019 14:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436661AbfHBOWV (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 10:22:21 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:36010 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfHBOWV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 10:22:21 -0400
Received: by mail-qt1-f179.google.com with SMTP id z4so74094316qtc.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kJ545pFE42hRRFkNgDnDWvGuI0dMYU6vf2EXTWiloao=;
        b=JAKWTR5hHkI/aAAUVXtIw015CaZ+dNqXzehJsmzhA7V0a7OK5fdX0Js6oVkqW/L5iC
         lgTaOuuPhek8UGXMLmMZgFW4CklxNrFcsE5Ihn0b3NjhLo6fq0m+VQu+vmXHYAF9AGf5
         txul/UBAiD4NmKdOmIDX+xA5lebO/2n6jTxx3DQ5FR9yx/9jxdmaxrhMO7gSA5TeVr9Q
         u+PomwuBlqjaiLCajdFRNiIRPdfHcMjJ/WCsRym31mKNrj8dwVvur8Uv7aaZnA57eS6j
         zTfdAwgp4Yjp39HKLGaDIWY3jLhjCokIqMzBMZq4DU8YPqnN4duuQnoIattvZcnZsZ+8
         +Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kJ545pFE42hRRFkNgDnDWvGuI0dMYU6vf2EXTWiloao=;
        b=PC9gZwRxgy+GPPWQWnKfAtf77MEn70V6kghUUEgPXsrC0R2rg2Ja2VoQ397ZBHUOEM
         HrdLjANOkrSG9r8w2cM5QNdaI93dDocTY3XKwd+GKwGhwiLT2nJWLeOsHR1BZkgJqUqs
         ceCAPxm/IlAs17qIYHs13+KLyeCegHHY4fWSXpQ2LAzOTh/LPVR/RdZUC/qjLL/LA7HQ
         7Hmw9eINLdAJFOgLZyOHD3Kke526Ksv9YGvjBgErLFsFuqLZHbRsldgc2FlVXrfkQ4bx
         XvztObuGQW1qM/SZzmGWJ0JKlubjopchdCdbB6CiLOtPI7Y/aBrKeBFhWiO9txzaBNug
         kMRA==
X-Gm-Message-State: APjAAAVNv/l19+9OhEnzyOPLpiL8vpn4lVG5EvowJaldDI5Jam5vQSVJ
        6vBVQak4Ij/ZyovtxUd/sYo3xETx+q8=
X-Google-Smtp-Source: APXvYqy0998r8IfyWcbzpE63HNF6wZa5rfbvND+XAz1isf24PNh0WEWvM153JoBmxCRsI31vwhYUWQ==
X-Received: by 2002:ac8:37b9:: with SMTP id d54mr96815568qtc.189.1564755740050;
        Fri, 02 Aug 2019 07:22:20 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c93d:405f:d008:26db? ([2001:4898:a800:1012:7a71:405f:d008:26db])
        by smtp.gmail.com with ESMTPSA id d141sm32030630qke.3.2019.08.02.07.22.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:22:19 -0700 (PDT)
Subject: Re: git-log on a file, and merges
To:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAA01Csp=g08N4+S1HKAjV2a12VJNSJU0UYdAU6LW1jGWLD9SLQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <05c77291-48d1-a592-6296-d8a8bdb16b02@gmail.com>
Date:   Fri, 2 Aug 2019 10:22:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CAA01Csp=g08N4+S1HKAjV2a12VJNSJU0UYdAU6LW1jGWLD9SLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/2/2019 5:38 AM, Piotr Krukowiecki wrote:
> Hi,
> 
> I have merged a branch into master.
> 
> When on master I do "git log -- some/file", it does not show commits
> from merged branch (which I know they changed the file).
> I have to add "--full-history" to see the commits.
> When I run "git log" (without "-- some/file") I can see the commits
> without using "--full-history".
> 
> This seems not logical, and contrary to user expectations. Harmful even ;)
> 
> Am I missing something?

Hi Piotr,

You are falling victim to an issue related to file history simplification [1]
and a (probably) bad merge. You can read more about how this can happen at [2].

When git log reaches a merge commit and one of the parents matches that path
exactly, only that parent is walked. The other is ignored. In some sense, the
other commit did not contribute changes to that file (because we only took
changes from the other parent). This makes the history look good and enables
some performance boosts.

Basically, someone must have gotten a merge conflict and used "-S ours" to
wipe away the changes from the other branch on that file. You can find that
merge by running

	git log --full-history --simplify-merges -- some/file

You will see the merge commit that un-did the change somewhere above the
commit you are expecting to see in the history.

Thanks,
-Stolee


[1] https://git-scm.com/docs/git-log#_history_simplification
[2] https://docs.microsoft.com/en-us/azure/devops/repos/git/git-log-history-simplification?view=azure-devops

