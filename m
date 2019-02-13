Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05501F453
	for <e@80x24.org>; Wed, 13 Feb 2019 13:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbfBMNPm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 08:15:42 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51395 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733075AbfBMNPm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 08:15:42 -0500
Received: by mail-wm1-f50.google.com with SMTP id b11so2421740wmj.1
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 05:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=/UGp7hrBHqzz/T097Hm7RYDZSPCno9EquTNGykP+Mrk=;
        b=kSksLfGiPn4mrYo/iFaUw+yt394Td2tX4TSeqUh4593AWiD33LZGs0znYnUyGuL9WM
         SJ0eKItlyU2t227vjah3hk5kzpqVINRGknfwUBiHQ8ta5t3Xsd9TXDBv6I6Q2BsiXy5K
         RRVjl9G2sxv3XFl8xRv58w9V5MXP1YSMzc0E/0EMlsCcGyJS0rZk2dQabx4Zc5L3a6x6
         dCYiks2ePyg5lHV3SBWemd/jfNaWH78KsszS8FwxjlFaQNgqA6oUj5tTqxWEnONudEZW
         McDowU5Ssw37VUL6jlSD15rs/OD7moKp6HutaFZxkMkXTdshlXmG071CtxXCaCG9ecwA
         RQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=/UGp7hrBHqzz/T097Hm7RYDZSPCno9EquTNGykP+Mrk=;
        b=q7pSckn5U9RPzoOvxg4e921ciArQI4mXBrVHaohS5NwxMrN/Gbu0S85vAcrkTWTZeT
         mdhoiLrYRH4EbMaXPmOo4cbiEMymNkh90NC07y/TPpA5wt634kX1t7CwBMhnWLaUTeOG
         zqjrmi39wNyP+/GvWs8oH4SKysB6S4mcIgIEixBLa231Mp0D3sR0CuF0CrmyWITOAsVN
         0wE6JJg9Gond8X8Z9f2wwNTZjSwXzKEKIt4lv+dJ3AFLvC1yoPMJdEJJvCzvXEU+u5a1
         nNVIKKNM/w1EtI/Ee48sHXqB6RNbSYuQeuyKC4G2hnxp8Vyu7mLqmMOAZ9wDzvY9qE0g
         kH1A==
X-Gm-Message-State: AHQUAubLq/vV72FVQ2pCctGO/GUzRBdButB9aYwFm6CN0qyYMnyj8oqw
        6CazljWX/U7ff3eDq3KBt7Q=
X-Google-Smtp-Source: AHgI3IalnCVD/dXS8xxA9MDitV0FO/Nwdr2BUxuqZoa7iX9uiEQuW6qQDIB4O6FT9LpXbhjOTiH6zQ==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr279331wmh.87.1550063740105;
        Wed, 13 Feb 2019 05:15:40 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id v6sm33328939wrd.88.2019.02.13.05.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 05:15:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 14/15] trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
References: <pull.108.v4.git.gitgitgadget@gmail.com> <pull.108.v5.git.gitgitgadget@gmail.com> <00b25da38bd107b543a34833e5e363385c9eaa37.1549043937.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <00b25da38bd107b543a34833e5e363385c9eaa37.1549043937.git.gitgitgadget@gmail.com>
Date:   Wed, 13 Feb 2019 14:15:35 +0100
Message-ID: <87h8d7kex4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 01 2019, Jeff Hostetler via GitGitGadget wrote:

> +test_expect_success 'event stream, error event' '
> +	test_when_finished "rm trace.event actual expect" &&
> +	GIT_TR2_EVENT="$(pwd)/trace.event" test-tool trace2 003error "hello world" "this is a test" &&
> +	perl "$TEST_DIRECTORY/t0212/parse_events.perl" <trace.event >actual &&

These & similar tests on some systems ...

> [...]
> diff --git a/t/t0212/parse_events.perl b/t/t0212/parse_events.perl
> new file mode 100644
> index 0000000000..a2776ba216
> --- /dev/null
> +++ b/t/t0212/parse_events.perl
> @@ -0,0 +1,251 @@
> [...]
> +use strict;
> +use warnings;
> +use JSON::PP;
> +use Data::Dumper;
> +use Getopt::Long;

...because JSON::PP is not a core perl module. See
e.g. t/t9501-gitweb-standalone-http-status.sh for how we deal with this,
i.e.:

    perl -MJSON::PP -e 0 >/dev/null 2>&1 && test_set_prereq JSON_PP

Then later e.g.:

    test_expect_success JSON_PP 'event stream, error event' '[...]
    


