Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EFDC2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52D421775
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OZemIhq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGUbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:31:12 -0500
Received: from mout.web.de ([212.227.17.12]:43487 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgBGUbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 15:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581107462;
        bh=vOzdZats5GkTiqW9mlWOzUswcFJ3Bzndrp0OpHd0BOM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OZemIhq/H7G8t0EVsnEwLl2M/FO8EjnBEUq0aRJf1vZ6cpqukWIjsjshL+NqJrgPT
         V7CvDUg17wPxcdjEqk1iYyXAzTE4GMWitYqDAnL3Krpjz5RG3wDYWeXNK+KcOXpR6H
         QOu50sM50v+8BrXmpnKVSbxAXHh53Uso1wSWwGpY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOilO-1ivErg1RFG-0069FY; Fri, 07
 Feb 2020 21:31:02 +0100
Subject: Re: bug? illegal text in commit log
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
References: <20200204010524-mutt-send-email-mst@kernel.org>
 <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
 <xmqqd0arfyw8.fsf@gitster-ct.c.googlers.com>
 <e271bb17-376d-426f-61b2-86971f1cb02b@web.de>
 <xmqqlfpf3qh3.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3cd137fa-b879-9850-0b81-5f907623ee6d@web.de>
Date:   Fri, 7 Feb 2020 21:30:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfpf3qh3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bX/VmUR7Ur5j8t3MKi+RhFwvbevFfhDJD/dVdDoIkpfxBWmZcqR
 V820cEzcvnXnZR3xmIrY3S2Trj2uUEa05cXgT58k+o5+1/N2UG8ju85HX7657Hq6FjPbwgP
 fsJQ9YPxrTeS6JfPmFJPHr8ZqUkBLlXmBeIwXqoBBEK3dSn5sLjNe9+w0iUugBrr66u++IO
 cE5eC5fasuRVbpTIxUANw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R8dDWS3nqG4=:3xajpPqeMvD50RrsU3qi93
 C21kRVrSPuu0np++CdR3RUa9c0oxnD3GDoZ0dEVAzwL8pEv1FIoVzpxG5vg6WhHcTu0n7BEwn
 2HURIsgkaPYnUZgL8H94C3KK7Kcep2AdutxquuGOJoZVgeWV0pDzNuz4lDxtYzcQNS57HGckT
 8r1qOrHLGPs8O7ERMr8jVOtt3ZJXSkou6igrxiv/hAMyoPcxFhrEOgoAbEJgbWSk1N1qNBCRR
 LG3mp7jvWGtzvcvDHhBCD+Qv+Voew+ixL7k4k52BMG7jOOfM2ZBGfbXsotHD38pxDLQP1at7M
 WkD9+4nt99Qq5EcK6txtxn742zBdjczELD0YpKasy09L26Y5wnsy01EQuwayqHAdCaXqbnvWN
 0RhVJYTwqJgXqvDNdzFmotUpUsBSU0hf+1dgReva/+GqRfIp3/7kQbpHqcVx+CqyC9R4dtQEo
 hCRIudOZELUYJK6PfDjpJzHi/pecDYuuydrJp7Ug0jF+EXNsdPk1blxzANaA0DPrJ+dTRJF3y
 w6Gk0MdZydoX/yDBb4+RA1RUIcW9C5qjVC7IPaUOEEDtJDaxrY7OW6sn+iX2qI+exM48MimFC
 zl11efZ2p3FnyPmx/Msm7xewX8k1ICPyO6pPxBglXMXHQwKgqVOW7ZBav9vZr0dwolYL/jHg0
 WBmiauuzEz/Rul7EzvzXSObSliAet1eUo6M3IvmJCrNjzBloj11KoO8oyT5mnDjW1o3cvOfOv
 bqFkYpTvQrJO8Rnt0ncuI9o8YoXiUmydl9q+qYDyPRCIZADboFywbDlDDEMkqv9jDlrR0rdUT
 kWjDVm0bNXlzGN2VAptzilQcm8/QMUh3WsEN361r5hqyyZapOAqV/kqvSql0yDwgUOiLOpRF+
 CTWoQnOmiKx64u/EzDcFikZXdTXTNEsfUcPL5uifB5uIWGk9T55yRI+Hvw9Hf3ctJGABgZ1Os
 heAMQrWP3hUM801oJeg6bkZ7BEVty4fOgwWk1I+aGiVer6n5EVxelcCwLkSv8AItnPnybDylx
 WBBaNs7LcqRw5glrEfa9lcDdR+BJPKzkIo7NjmXb77DpZ6ZjJvk0NfVxQ0edtckoio6tc06eS
 jxoG6aHtAenQJfLXcraicmVA/q8lqjFBHwgXuH+v8Lag2UMRkjbaxM6Ys55e908D+7HhN1qnA
 heBcylYXt8S9e3FTjLde4uPqDCtu5tvLQQco5v5Uzuo+kUiqGT2bQA7hu4auSVFZKZT+Lm8nt
 b9hm/VUOCebB2V+eG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.02.20 um 06:40 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>>  * the first line that
>>>    - begins with "diff " or "Index", or
>>>    - is "---" (and nothing else on the line)
>>>    signals that the line no longer is part of the log
>>>
>>>  * but if it finds a line that begins with "diff --git" (or
>>>    optionally just "diff "), do not blindly assume that is the end
>>>    of the log, and instead try to find the first "---" line.  If
>>>    there isn't any "---", then take that "diff" line the beginning
>>>    of the patch, but if there is, "---" is the end of the message.
>>>
>>> The latter rule is the new one.  And there is no need to change
>>> format-patch output.
>>
>> I like this idea.  It will probably be tricky to implement, though,
>> as mailinfo currently goes through the input line by line and has no
>> easy way to look ahead.
>>
>> Ren=C3=A9
>
> Another issue with the approach is that it will be fooled if the
> patch is about removing a line with double-dash and nothing else
> on it.  Unless we can trust the numbers on hunk header lines in the
> "sample patch" embedded in the log message, we cannot reliably tell
> if a line with "---" on it is such a line, or the true end of the
> log message.

Such a patch could be cited in the message as well, with or without a
correct hunk header.

Full patches in messages might be rare, lines starting with "diff -"
(perhaps talking about a certain diff invocation) or "Index: " (in a
language where nouns are capitalized) are probably more likely to occur
in the wild.

My problem with the situation is that innocent-looking commits that
can be diffed, pushed and pulled suddenly fall apart when used in a
mail-based workflow or with rebase am.

Supporting hand-edited messages is especially hard.  Git cannot warn
the sender, as it's out of the loop.

Bottling the message by adding some kind of header would be watertight,
but senders of patch-like messages would need to take care to use a
large enough bottle (update the header).  Clever rules can cover
common cases, but will leak sometimes and might be hard to implement.

Ren=C3=A9
