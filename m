Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB8C3F2D0
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 20:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5C4215A4
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 20:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCJUJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:09:34 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35835 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgCJUJe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 16:09:34 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48cR581Kbmz1qs07;
        Tue, 10 Mar 2020 21:09:32 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48cR5811cwz1qqkt;
        Tue, 10 Mar 2020 21:09:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 3yi2nBlPHdEK; Tue, 10 Mar 2020 21:09:30 +0100 (CET)
X-Auth-Info: YTpZ0AqJa2+nCReBHEm57NHQsyabl8OjZCJ2bi9kFCqa/vnP/HxngAjhZK1P3OLI
Received: from igel.home (ppp-46-244-171-17.dynamic.mnet-online.de [46.244.171.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 10 Mar 2020 21:09:30 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 0169C2C0B99; Tue, 10 Mar 2020 21:09:29 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?J=C3=B6rn?= Engel <joern@purestorage.com>,
        git@vger.kernel.org
Subject: Re: new file mode 160000
References: <20200310184111.GD1443@cork> <87lfo8m3fu.fsf@igel.home>
        <xmqqo8t4hu0n.fsf@gitster.c.googlers.com>
X-Yow:  I can't decide which WRONG TURN to make first!!
 I wonder if BOB GUCCIONE has these problems!
Date:   Tue, 10 Mar 2020 21:09:29 +0100
In-Reply-To: <xmqqo8t4hu0n.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 10 Mar 2020 12:47:20 -0700")
Message-ID: <87h7ywm0p2.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 10 2020, Junio C Hamano wrote:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> On Mär 10 2020, Jörn Engel wrote:
>>
>>> Something weird happened to us and I have no idea how to reproduce it.
>>> A developer managed to create a git commit with the following content:
>>>
>>> diff --git a/foo b/foo
>>> new file mode 160000
>>> index 000000000000..b7e7816c1266
>>> --- /dev/null
>>> +++ b/foo
>>> @@ -0,0 +1 @@
>>> +one line of content
>>>
>>> File name and content obfuscated, the rest is verbatim from the git
>>> commit.
>>>
>>> Now, file mode 160000 doesn't make sense to me.
>>
>> 0160000 is S_IFLNK in MiNT
>> <https://github.com/freemint/freemint/blob/master/sys/mint/stat.h>.
>
> Yeek.  That sounds like a ticking time-bomb.

configure can detect that (NEEDS_MODE_TRANSLATION).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
