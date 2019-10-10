Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D5B1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 11:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfJJLHi (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 07:07:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38197 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfJJLHh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 07:07:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so6321326wmi.3
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 04:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YO1bz5wg0YT2brfpJmMe32FQunRrS94L1UDffs/ADHQ=;
        b=vJBwd6sOOeu7PFjv28LmgyiWfhLFbtxN580hebngkg2lJLJiLngycSdkIjLGHYYOAd
         x3qoLnlOWKqWCD/bMYQTwKalWJuTMg1qJYws2URcCxB/aGPZtooD+7KE1L0LxRu67u/E
         LACa3UYxi6JiBhgJPVeEMjWaAKtQ7isU8qMCQyUol5voWC5JC7WNeEbmfa3Ndbr7nw4u
         ee+ejlWaURr9UYbDQ1qwvqk6fSv0Ad28Mr8zVhWUL+tyQlbH7eEfNlb7FOxvp4TCTnuj
         AMsedc2WqXS4Y7y6y9RDVmK15X8bvzc/sJl0B1L9XgKkfc1kji5NxzT6Bo66yaQ6rKl4
         wUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YO1bz5wg0YT2brfpJmMe32FQunRrS94L1UDffs/ADHQ=;
        b=Ca9o/74XYaQMkGwLkgu9d8BsaNlWmvWWsIp/S7LscfTkBYF41lmQMoESON8EV2FOtG
         DLwg76Qk26dypvxPIMJrFGnrjSIPNr1w7EPtMEML/bMVBdjgjsSnxeC6ICqcTxP2+SFA
         z5dwfNI7g66Nt/eMkNoq0DboRlthgGwd//92u6B/t5q/YmIrGmUd2I6Tpn5FhOa5aiWp
         bTwdFoAmqTcfe8akPYI1+0shpJDq1o73bHOP7zAtvsIds3HH5mT5agWFH1ALXCLP4l4o
         Dj47TnRSmVe0AN3cSbdmqx0gHSj53xXRvivJg63oElmBY3GfbMlaI+6t4UHXKMndFhtF
         vB7w==
X-Gm-Message-State: APjAAAX11L38P7aAKTlnugtpqdlCFY8VxadjY3Wc4vwD9BELWzRo0mph
        uBQGLDpcdseuw6ZM73O/GHs=
X-Google-Smtp-Source: APXvYqxkgDSQrAFQpIos46MrUdc/i7KEypTkxMXDM+HpVOxv5pPoq9PKXwGcxCgzD6ntuGHrzVM05Q==
X-Received: by 2002:a1c:a8c9:: with SMTP id r192mr7140489wme.152.1570705655895;
        Thu, 10 Oct 2019 04:07:35 -0700 (PDT)
Received: from szeder.dev (x4dbd29c2.dyn.telefonica.de. [77.189.41.194])
        by smtp.gmail.com with ESMTPSA id t203sm5849579wmf.42.2019.10.10.04.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 04:07:35 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:07:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     William Baker via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, Johannes.Schindelin@gmx.de,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/1] fsmonitor: don't fill bitmap with entries to be
 removed
Message-ID: <20191010110732.GJ29845@szeder.dev>
References: <pull.372.git.gitgitgadget@gmail.com>
 <pull.372.v2.git.gitgitgadget@gmail.com>
 <08741d986c2b51828f115ab50f178d62e9982978.1570654810.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08741d986c2b51828f115ab50f178d62e9982978.1570654810.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 02:00:12PM -0700, William Baker via GitGitGadget wrote:
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index 81a375fa0f..87042470ab 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -354,4 +354,17 @@ test_expect_success 'discard_index() also discards fsmonitor info' '
>  	test_cmp expect actual
>  '
>  
> +# This test covers staging/unstaging files that appear at the end of the index.
> +# Test files with names beginning with 'z' are used under the assumption that
> +# earlier tests do not add/leave index entries that sort below them. 
> +test_expect_success 'status succeeds after staging/unstaging ' '
> +	test_commit initial &&

This is confusing: this is the 29th test case in this script and it
creates an "initial" commit?!

The first "setup" test case has already created an initial commit, so
this should rather be called "second".

OTOH, none of the later commands in this test case seem to have
anything to do with this second commit, and indeed the test case works
even without it (i.e. 'git status' still segfaults without the fix and
then succeeds with the fix applied), so instead of updating its
message perhaps it could simply be removed.

> +	removed=$(test_seq 1 100 | sed "s/^/z/") &&
> +	touch $removed &&
> +	git add $removed &&
> +	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-env" &&
> +	FSMONITOR_LIST="$removed" git restore -S $removed &&
> +	FSMONITOR_LIST="$removed" git status
> +'
> +
>  test_done
