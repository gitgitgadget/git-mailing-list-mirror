Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E291E1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933382AbdA0Ron (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:44:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57167 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932953AbdA0Rog (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:44:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B30896111F;
        Fri, 27 Jan 2017 12:43:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mZdh0aGubNSflnpebspbV8S0+OA=; b=L4ExQe
        ZtiUYmbK0EUgR9rFp3SH8mD0U5eGbJTIb+tneplXs6koTMaBkjCx5vJ1f9GGoeD7
        NVJgvE9AdzKxEK8TuViHH2S01qM/+ZkNXcexDJCDf2mPLhMpUAgu5dEFWTFbWpoB
        OHZ5e+97RvM5KoJ+ZiMi1UJs3XDFRkrNeL3Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r2s1Bqc+VBSqFR5HcxfuwdRoSsorR/6A
        eru59RQNxF0MWqRWdt7uPgLmysh9oB7CDHA1W30l1aOHv8lVkSf06hEnN3vm8Idc
        VFCOEGn9QuyH3O2Md8Rpt5Bzz5NtGnRMb1Tp/hW6/EaJYbw4UUmtx2ro299xHwS4
        Xgh6wP3Cu+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAB706111E;
        Fri, 27 Jan 2017 12:43:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B5CF6111D;
        Fri, 27 Jan 2017 12:43:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com, git@vger.kernel.org
Subject: Re: SubmittingPatches: drop temporal reference for PGP signing
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
        <20170125002116.22111-1-sbeller@google.com>
        <33E354BCDB9A4192B69B9B399381659E@PhilipOakley>
        <CAGZ79kaRdtKD7DNJRWXsyg07GbTM4OsKUmHHcFczEMJA1YK2KA@mail.gmail.com>
        <baff65ba-1e98-d5a7-5b5a-a50a7fc723ee@tngtech.com>
        <xmqqpoj965yf.fsf@gitster.mtv.corp.google.com>
        <4B89512D54614F09817EA9901A8B625D@PhilipOakley>
        <60e9abdf-cc37-33d8-e7eb-8a3370ffe1cc@tngtech.com>
Date:   Fri, 27 Jan 2017 09:43:22 -0800
In-Reply-To: <60e9abdf-cc37-33d8-e7eb-8a3370ffe1cc@tngtech.com> (Cornelius
        Weig's message of "Fri, 27 Jan 2017 11:49:26 +0100")
Message-ID: <xmqq60l01jr9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19E0B1CE-E4B8-11E6-BB48-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cornelius Weig <cornelius.weig@tngtech.com> writes:

> -Do not PGP sign your patch, -at least for now-. Most likely, your (...)
> +Do not PGP sign your patch. Most likely, your maintainer or other (...)

It has been quite a while since we wrote that "at least for now", so
it probably makes sense to drop it.

>> Maybe even s/by signing off/by adding your Signed-off-by:/ to be sure
>> that the reader knows that it is _their certification_ that is being
>> sought. Even if it does double up on the 'your'.
>
> I don't think doubling on the 'your' will make the heading clearer. The
> main intention of this change is to avoid mixups with pgp-signing and
> that would IMHO not improve by that.
> Besides, I find the colon in the heading a bit awkward. Is the following
> version as expressive as with the colon?
>
> -(5) Sign your work
> +(5) Certify your work by adding Signed-off-by

I am leaning towards agreeing with Philip, and my gut feeling says
the presense of the colon, would help a lot.  It would visually
click to readers what we are talking about.

At the same time, I think ending a section header with a colon would
be seen as "awkward".  I would have written it more like this to
avoid it:

    ... by adding "Signed-off-by: " line

I personally do not mind having "your" there, either, but I can see
that a section header wants to be kept shorter.
