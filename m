Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02798C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D0A2070A
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 21:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JWsBcOAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgCXV06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:26:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54887 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgCXV05 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 17:26:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CAC45AD9F;
        Tue, 24 Mar 2020 17:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kuzvFsX3h3nBDHUAHz9Me+F8VMg=; b=JWsBcO
        ANfUp2i8xcXJxeozQ4sro49DLgp387YfAF8LsH4ehoTQ1EzbZZZlepMaCDBMqCHs
        bv5HKa9iCFqr1Mg/sk6k/HqX2TiPrQYrjFCRhHo56ZYVg2cld5v9Qt0W33hdobg0
        AyupIeBt5zuYG1P6p3vr2MUwbDZHw2N/ARHi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ksY20SfxFJVeAL4ETiB7omMSkjaEpsZW
        zIZRdfYUbmmT9CH6qWn6UtlFr5BDwwboNl5pbon8HF8wq1whC3RUscfz2Io6f7vF
        bvqNS6Pcucar8bVladzwWX8czAfJElWz8ycMdOX2+cf+XbjkBprvfh+bMdM+8Qfk
        HuCU3pjpr7Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 031295AD9E;
        Tue, 24 Mar 2020 17:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8440A5AD9D;
        Tue, 24 Mar 2020 17:26:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC PATCH 1/3] doc: grep: unify info on configuration variables
References: <cover.1585027716.git.matheus.bernardino@usp.br>
        <7ba5caf10de75a2e0909318b04c62f5827a3fa56.1585027716.git.matheus.bernardino@usp.br>
        <CABPp-BGzeL8O73bB82=+4RFvdAXTgofg6H_xgSEXG7Euj=47Bg@mail.gmail.com>
Date:   Tue, 24 Mar 2020 14:26:54 -0700
In-Reply-To: <CABPp-BGzeL8O73bB82=+4RFvdAXTgofg6H_xgSEXG7Euj=47Bg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 24 Mar 2020 00:57:41 -0700")
Message-ID: <xmqq4kud1m1t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F076076-6E16-11EA-885F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
>> index 44abe45a7c..76689771aa 100644
>> --- a/Documentation/config/grep.txt
>> +++ b/Documentation/config/grep.txt
>> @@ -16,8 +16,11 @@ grep.extendedRegexp::
>> ...
>> +       Number of grep worker threads to use. See `--threads` in
>> +       linkgit:git-grep[1] for more information.
>> ...
>> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
>> index ddb6acc025..97e25d7b1b 100644
>> --- a/Documentation/git-grep.txt
>> +++ b/Documentation/git-grep.txt
>> @@ -41,34 +41,7 @@ characters.  An empty string as search expression matches all lines.
>> ...
>> +include::config/grep.txt[]
>> ...
>>  --threads <num>::
>> -       Number of grep worker threads to use.
>> -       See `grep.threads` in 'CONFIGURATION' for more information.
>> +       Number of grep worker threads to use. If not provided (or set to
>> +       0), Git will use as many worker threads as the number of logical
>> +       cores available. The default value can also be set with the
>> +       `grep.threads` configuration (see linkgit:git-config[1]).
>
> I'm possibly showing my ignorance here, but doesn't the
> "include::config/grep.txt[]" you added above mean that the user
> doesn't have to see an external manpage but can see the definition
> earlier within this same manpage?

I think so.  Also, the new reference "See `--threads` in git-grep"
added to grep.threads to config/grep.txt would become somewhat
redundant in the context of "git grep --help" (only "See --threads"
is relevant when it appears in this same manual page).

Readers who finds the reference in "git config --help" still needs
to see that --threads is an option to git-grep, though.
