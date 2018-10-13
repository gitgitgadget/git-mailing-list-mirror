Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2550D1F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 00:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeJMIFK (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 04:05:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35214 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeJMIFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 04:05:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id y19-v6so12958993edd.2
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IylICp6b/TUyWuWLML+/89veKhai8FJnqfsubom0/vs=;
        b=OZJpDs8Xy6qMqFU1wOYCMRWNuOEUyevNp8w96hD1VdP87sNWxPWvgleRRnFDNIvMt3
         hxy3x+9jLb1mBMhn5WCcgzcRkfnXjzRvjwX5z69F8Xyrfe/73JJF8RdAfMEi69+F5rL3
         UFNRB/f24nrWGOLcEH/sG9vTE6Aebr49QDvwcpfWagbmx2E+WJCp6xLW0J/USkjlS9p4
         gzWvqLaoWlTHyvDRXbbz5gps7to0yzbT3gvGgMa5wwz2iTuOf/bX9BMSTA8+rblwH9fH
         NHMXmbEBXypS70kKcuwOkDqnSwHFknGFQH7TWAWVM0eyDdcqiRhulshaP+fEt2d8H6RZ
         jlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IylICp6b/TUyWuWLML+/89veKhai8FJnqfsubom0/vs=;
        b=rX4/pR63DA+TN3iChS7kfVfBG1QsErR81zHYPG6aumb9HlzVZdbLOOogbU8K3gNV1Q
         meA2NxlaJto1Ir/4sbUApGHePLLqjdG5AOKI/hLKHOimG/IHXBxwojVL97KGcyUNTyez
         KZHAtlgCYGiLg7C858odG4RAwasAhNdfojDnUOJpZD9uE2cU47jdtBjKTjvf5J4dI5lc
         V1GZOIdpV5cnEvRknLTR6bt5htPfDImQKVx1XOpVbFeC1rpQfW7pML5owKbp4q9kN3Es
         TNwX0q8DgBnLDtpSf41knivL16NIlDOzcsBAvTmBF3wlznkQP4EiH0CmMbbUfxAi4vFr
         TZfQ==
X-Gm-Message-State: ABuFfojtYUMRJIP9Z6J2nj2leK0TyoI535AFgxEQpKKAK2suENe0VDiI
        UkTQugJXIUNTDxlzQfvLnNiQLflPyu31rvanmWDW9Q==
X-Google-Smtp-Source: ACcGV61J4R9wXdZoMCBbzkX8fnhmxP0IB+vzpN1WUGSHFT7bbmm0cPnVrtJ5eH+6YBE5MtpfBxkXfy9GOT5+LJRIJ7I=
X-Received: by 2002:a17:906:f45:: with SMTP id h5-v6mr9518739ejj.106.1539390614251;
 Fri, 12 Oct 2018 17:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181011211754.31369-1-sbeller@google.com> <20181012185037.GA52080@aiede.svl.corp.google.com>
In-Reply-To: <20181012185037.GA52080@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 12 Oct 2018 17:30:03 -0700
Message-ID: <CAGZ79ka9L+s8PdREL04MOag-x68SzCc4xHn-JShVFPest6YxZg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] Bring more repository handles into our code base
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 11:50 AM Jonathan Nieder <jrnieder@gmail.com> wrote:

>
> It appears that some patches use a the_index-style
> NO_THE_REPOSITORY_COMPATIBILITY_MACROS backward compatibility synonym
> and others don't.  Can you say a little more about this aspect of the
> approach?  Would the compatibility macros go away eventually?

I use the macro only when not doing the whole conversion in the patch
(i.e. there is a coccinelle patch IFF there is the macro and vice versa).

It's quite frankly a judgement call what I would convert as a whole
and what not, it depends on the usage of the functions and if I know
series that are in flight using it. The full conversion is easy to write if
there are less than a hand full of callers, so for the "small case", I just
did it, hoping it won't break other topics in flight.
