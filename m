Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D4620A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 00:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLIAWh (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 19:22:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52124 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLIAWh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 19:22:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D64992DE91;
        Sat,  8 Dec 2018 19:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ndiZ/WeePuHT3S1Qx0MmUA6T0NE=; b=SdYjIT
        FTwfjxjpwE9fXLxmUlaLBIN+S4az3djjyFnlwGX33dh0DIZ3MAp/S3zuI88b+8+r
        LfJoVlq39thAnj10A/1zcjYd4pdw25gNcVYOzDKR+j7+S2Gd+nAIg5KNPdAUTzAa
        t8PN98xRwku/9FPDGbKex+PnWLa5Rrdja6okE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D++iSiPd1z4ySp/Frk//9PY5LanZqMlp
        TaU3VQmrCiBXPKneQRGYVHHmfduwpWd5YWXYyI5/66Bo7RNpGJAyysK+5rM/TRal
        qsUNXfQO6TdH+ySNG+huoR2DiAwdcP29FWVLeXoiT5uze+o5LFVwQdR7l3/kSNdf
        5r8dX2DLFTo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE4CF2DE90;
        Sat,  8 Dec 2018 19:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E5F442DE8F;
        Sat,  8 Dec 2018 19:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-rebase.txt: update note about directory rename detection and am
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
        <20181204231709.13824-1-newren@gmail.com>
        <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
        <CABPp-BG=4K9VCc8zuUm0KTRG5cHPijtvQTK4QXWRVbSFu3o_fQ@mail.gmail.com>
        <76537e8b-3b66-e1f1-eb4d-e9e1c18012df@kdbg.org>
        <xmqqr2ewbevt.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHzESYnQy5JwXvtXyLHgHR9u3UNVOZF2gU1m_uTMGkyfg@mail.gmail.com>
        <bd67cd33-dbe8-03a0-e760-c7bb23854084@kdbg.org>
        <xmqqmupjbnhq.fsf@gitster-ct.c.googlers.com>
        <66479695-d17e-c9cb-4cb7-8c74e3855032@kdbg.org>
        <CABPp-BGSmyAb_d52TLS=7oQyMYxt=EYjNdDofY4nzLd9CYvwuQ@mail.gmail.com>
Date:   Sun, 09 Dec 2018 09:22:29 +0900
In-Reply-To: <CABPp-BGSmyAb_d52TLS=7oQyMYxt=EYjNdDofY4nzLd9CYvwuQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 7 Dec 2018 10:46:34 -0800")
Message-ID: <xmqq8t0z7dmi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84D51C74-FB48-11E8-8EFB-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 7, 2018 at 9:51 AM Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> From: Elijah Newren <newren@gmail.com>
>>
>> In commit 6aba117d5cf7 ("am: avoid directory rename detection when
>> calling recursive merge machinery", 2018-08-29), the git-rebase manpage
>> probably should have also been updated to note the stronger
>> incompatibility between git-am and directory rename detection.  Update
>> it now.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>   Documentation/git-rebase.txt | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 41631df6e4..7bea21e8e3 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -569,8 +569,9 @@ it to keep commits that started empty.
>>   Directory rename detection
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> -The merge and interactive backends work fine with
>> -directory rename detection.  The am backend sometimes does not.
>> +Directory rename heuristics are enabled in the merge and interactive
>> +backends.  Due to the lack of accurate tree information, directory
>> +rename detection is disabled in the am backend.
>>
>>   include::merge-strategies.txt[]
>
> I was intending to send this out the past couple days, was just kinda
> busy.  Thanks for handling it for me.

Thanks, both.  I can live with format=flowed, but would appreciate
if we can avoid it next time.
