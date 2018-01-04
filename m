Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75371F428
	for <e@80x24.org>; Thu,  4 Jan 2018 11:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbeADLvD (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 06:51:03 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:46861 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752947AbeADLvC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 06:51:02 -0500
Received: by mail-wm0-f41.google.com with SMTP id r78so2996018wme.5
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 03:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ThNYIRvucQk5hhJuu8M69IWgz4Q21SEuk0hm+DjXXxY=;
        b=n3fFHWFP3ntdmN8qGcsv23/6gJwMyRs9xLNWKpfgrYqdPNyehoZ/lQ5E8c+ctXVL0f
         Ji0AlE8gtkg0hcMC9Xe/JKDlnmXcC7y69no4/wIt42UKQN/eVcmR8yc3MpxOoQrcZlTW
         zfcALMBbFKvMlLgi6JBlwah571dI8N73nFnDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ThNYIRvucQk5hhJuu8M69IWgz4Q21SEuk0hm+DjXXxY=;
        b=JIfJ9RJ+rp1SK+skTvFNd6qtmmVxviiKL1O67ORIFdePnZR6BzbAnqQjzVib/RYM9e
         hT7gsggs46e2DOSJqZbHEflWIRRG5uW7jD9kiXqOE+/Dda+tj029iZnrBZVa/sOJ516F
         2cvSwXWU4e5fZDiDfMPkv2MQrEEBDeUBXaBXFSszw8lZ6NAPQh4bJwElNQsyzNYadzNp
         ZlLl0+itTxMvMYDyZL6f57hFOU0SLtnq48EjKae+2Bh8FySlJ+3bbUGpO4Cs90+ELLxS
         c9NXDffAJRpmh7nMZnFC8AmoDReHwc6d15LRIKsX3qv1pLaDhang6J7MKCM+qP20/Glq
         uIJw==
X-Gm-Message-State: AKGB3mJPyETpRilgWFWBoS1Y/CAsjOvxScvH5jz+7ZfkpVEIiAiZLjtQ
        +uTa0vUM62RtlOlnC4xoFLCNag==
X-Google-Smtp-Source: ACJfBosp5OUcYZlBzWmNapgwdaJa2DhXuV2JJypi5J+NoujQ/ZQNIolkXTgyeXfOjosTgRIfvltUCg==
X-Received: by 10.28.142.75 with SMTP id q72mr3758273wmd.45.1515066661168;
        Thu, 04 Jan 2018 03:51:01 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id e197sm10891120wmf.4.2018.01.04.03.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 03:51:00 -0800 (PST)
Date:   Thu, 4 Jan 2018 11:50:58 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 7/7] wildmatch test: create & test files on disk in
 addition to in-memory
Message-ID: <20180104115058.GF29210@dinwoodie.org>
References: <20171223213012.1962-1-avarab@gmail.com>
 <20171225002835.29005-8-avarab@gmail.com>
 <20180103130232.GD29210@dinwoodie.org>
 <87h8s3cbmn.fsf@evledraar.gmail.com>
 <20180103144149.GE29210@dinwoodie.org>
 <87d12qdaa5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d12qdaa5.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 03 January 2018 at 08:14 pm +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jan 03 2018, Adam Dinwoodie jotted:
> 
> > On Wednesday 03 January 2018 at 02:31 pm +0100, Ævar Arnfjörð Bjarmason wrote:
> >> Does the fixup above in <878tdm8k2d.fsf@evledraar.gmail.com> work for
> >> you, i.e. changing $10 in the script to ${10}?
> >
> > This fixes some but not all of the failures: I'm now down from 42 to 24
> > failures.
> >
> > Updated verbose test output is at
> > https://gist.github.com/me-and/04443bcb00e12436f0eacce079b56d02
> 
> Thanks lot, looking through our own commit logs I believe the rest
> should be fixed by this (prior art in 6fd1106aa4), it would be great if
> you could test it, I don't have access to a Windows machine:
> 
>     diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
>     index f985139b6f..5838fcb77d 100755
>     --- a/t/t3070-wildmatch.sh
>     +++ b/t/t3070-wildmatch.sh
>     @@ -23,6 +23,15 @@ create_test_file() {
>             *//*)
>                     return 1
>                     ;;
>     +       # On Windows, \ in paths is silently converted to /, which
>     +       # would result in the "touch" below working, but the test
>     +       # itself failing.
>     +       *\\*)
>     +               if ! test_have_prereq BSLASHPSPEC
>     +               then
>     +                       return 1
>     +               fi
>     +               ;;
>             # When testing the difference between foo/bar and foo/bar/ we
>             # can't test the latter.
>             */)

Confirmed this fixes all the outstanding test failures.  Thank you!
