Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF5B1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753811AbdAZSSF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:18:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57592 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753213AbdAZSSE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:18:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3219D63FEE;
        Thu, 26 Jan 2017 13:18:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UVrI7eBS3mCrEzWM0IRV30O8bqk=; b=fiIqoh
        XcZ3j3YiuO+OJl87ADmdc4r+9VjQRmtpvZwmljkKcIj1hzWcdX13GzsvTdLc8Pkz
        iM61KoZCqZYI7HIXw3lMWjN+nOA1ISodihrt1tBzfoNUZ9s0JXPrUFWqROtk0Dew
        2VG2Y2ylMbe144ZTuM+xOHR1riHyHcTgMZqts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tFwxrNbHwJ/CKi0nLodUo+bTcRSFiqCI
        ZqXGkpLD06EW0vcOtNP4S65LGB46dPj4hcW1C6u4L6TuYbcbWmOrOBfiKd51ZuJo
        L0/HfWCm4kNZkRrQ5JD7N394MUjNX/dqVZfrhWu6FSD1W9RlXnju6DY8jsp56v04
        vCWV9KWfMdI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2786363FED;
        Thu, 26 Jan 2017 13:18:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40FFC63FEB;
        Thu, 26 Jan 2017 13:18:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        thomas.braun@virtuell-zuhause.de, John Keeping <john@keeping.me.uk>
Subject: Re: SubmittingPatches: drop temporal reference for PGP signing
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
        <20170125002116.22111-1-sbeller@google.com>
        <33E354BCDB9A4192B69B9B399381659E@PhilipOakley>
        <CAGZ79kaRdtKD7DNJRWXsyg07GbTM4OsKUmHHcFczEMJA1YK2KA@mail.gmail.com>
        <baff65ba-1e98-d5a7-5b5a-a50a7fc723ee@tngtech.com>
Date:   Thu, 26 Jan 2017 10:18:00 -0800
In-Reply-To: <baff65ba-1e98-d5a7-5b5a-a50a7fc723ee@tngtech.com> (Cornelius
        Weig's message of "Thu, 26 Jan 2017 14:30:14 +0100")
Message-ID: <xmqqpoj965yf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C63325EE-E3F3-11E6-B234-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cornelius Weig <cornelius.weig@tngtech.com> writes:

> How about something along these lines? Does the forward reference
> break the main line of thought too severly?

I find it a bit distracting for those who know PGP signing has
nothing to do with signing off your patch, but I think that is OK
because they are not the primary target audience of this part of the
document.

I however am more worried that it may be misleading to mention these
two in the same sentence.  Those who skim these paragraphs without
knowing the difference between the two may get a false impression
that these two may somehow be related because they are mentioned in
the same sentence.

The retitling of section (5) you did, without any other change,
might be sufficient.  It may also help to be even more explicit in
the updated title, i.e. s/by signing off/by adding Signed-off-by:/

Thanks.

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 08352de..c2b0cbe 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -216,12 +216,12 @@ that it will be postponed.
>  Exception:  If your mailer is mangling patches then someone may ask
>  you to re-send them using MIME, that is OK.
>  
> -Do not PGP sign your patch, at least for now.  Most likely, your
> -maintainer or other people on the list would not have your PGP
> -key and would not bother obtaining it anyway.  Your patch is not
> -judged by who you are; a good patch from an unknown origin has a
> -far better chance of being accepted than a patch from a known,
> -respected origin that is done poorly or does incorrect things.
> +Do not PGP sign your patch, but do sign-off your work as explained in (5).
> +Most likely, your maintainer or other people on the list would not have your
> +PGP key and would not bother obtaining it anyway. Your patch is not judged by
> +who you are; a good patch from an unknown origin has a far better chance of
> +being accepted than a patch from a known, respected origin that is done poorly
> +or does incorrect things.
>  
>  If you really really really really want to do a PGP signed
>  patch, format it as "multipart/signed", not a text/plain message
> @@ -246,7 +246,7 @@ patch.
>       *2* The mailing list: git@vger.kernel.org
>  
>  
> -(5) Sign your work
> +(5) Certify your work by signing off
>  
>  To improve tracking of who did what, we've borrowed the
>  "sign-off" procedure from the Linux kernel project on patches
