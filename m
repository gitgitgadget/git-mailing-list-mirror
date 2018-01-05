Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B4F1F406
	for <e@80x24.org>; Fri,  5 Jan 2018 09:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbeAEJkK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 5 Jan 2018 04:40:10 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43906
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751262AbeAEJkI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jan 2018 04:40:08 -0500
X-IronPort-AV: E=Sophos;i="5.46,318,1511823600"; 
   d="scan'208";a="250154362"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 05 Jan 2018 10:40:07 +0100
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc:     Matthieu Moy <git@matthieu-moy.fr>, git@vger.kernel.org,
        gitster@pobox.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Adam <thomas@xteddy.org>
Subject: Re: [RFC PATCH 2/2] Remove now useless email-address parsing code
References: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
        <1515092151-14423-2-git-send-email-git@matthieu-moy.fr>
        <87po6pcm08.fsf@linaro.org>
Date:   Fri, 05 Jan 2018 10:39:57 +0100
In-Reply-To: <87po6pcm08.fsf@linaro.org> ("Alex \=\?utf-8\?Q\?Benn\=C3\=A9e\=22's\?\=
 message of "Thu, 04
        Jan 2018 22:11:35 +0000")
Message-ID: <q7h9wp0wod8y.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Bennée <alex.bennee@linaro.org> writes:

> Matthieu Moy <git@matthieu-moy.fr> writes:
>
>> We now use Mail::Address unconditionaly, hence parse_mailboxes is now
>> dead code. Remove it and its tests.
>>
>> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
>> ---
>>  perl/Git.pm          | 71 ----------------------------------------------------
>>  t/t9000-addresses.sh | 27 --------------------
>>  t/t9000/test.pl      | 67 -------------------------------------------------
>>  3 files changed, 165 deletions(-)
>>  delete mode 100755 t/t9000-addresses.sh
>>  delete mode 100755 t/t9000/test.pl
>
> Should we add the tests for t9001-send-email.sh to guard against regressions?

Tests in t9001 were only useful with our parse_mailboxes (they were just
comparing parse_mailboxes and Mail::Address), so there's no point
keeping them after we delete parse_mailboxes.

Your added tests from
https://public-inbox.org/git/20171116154814.23785-1-alex.bennee@linaro.org
would make sense OTOH. Not breaking Linux's flow is a nice thing to
do ... Patch doing this follows (I'll resend the whole series with
Eric's nit later).

-- 
Matthieu Moy
https://matthieu-moy.fr/
