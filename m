Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD369C433E1
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 15:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B2420657
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 15:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGQPJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:09:18 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgGQPJR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 11:09:17 -0400
Received: from [192.168.1.29] ([82.228.182.34]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.184]) with ESMTPSA (Nemesis) id
 1N0X4c-1kjrEz2CBA-00wZBv; Fri, 17 Jul 2020 17:09:13 +0200
Subject: Re: Git bisect run should check for the existence of the script
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <9cea8076-be96-19c5-c368-288193daedd8@abou-samra.fr>
 <xmqq1rlclte2.fsf@gitster.c.googlers.com>
From:   Jean Abou Samra <jean@abou-samra.fr>
Message-ID: <8c683b56-d17a-78ce-67bb-477e5b307df9@abou-samra.fr>
Date:   Fri, 17 Jul 2020 17:09:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rlclte2.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:ntNoas+LgrohYuQtSxrb6lDfbol8T7fmNYd0VUjIjTRUEQkwW6r
 byp23gx6oa9ww0TYekdCztVkGBPucuBQ6+Zfsui2z2cXGlbrvrshYBOfUChtkhFa3wXQrqW
 4W2xgI9B9Tduku5eNLf1xUS2caSKRx3E7rTEz72IkNUYw29KQoQfFwl74fLcucJIJwIjcTD
 8293EVLJsTd8pRf0vA0GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vcrGjR92Huc=:jAS5VqhkbxyNLhGbsNlWi2
 MXSfInZn9LaJ64HihwuXOxhGXmzhFwXfPXU0IOhZoFJvs2hafHcUqpMBbve16oESttyqS2ALS
 mqM3NnlQIM24faBzEFzSwiuzpITEP6p6cL+PiS5bk1X27tPqb/tPYPOr53yhtdVTWtOkqvms9
 xql72dusC1/rC+wK7RQ+GLoCWM7K9inHZOtUM1DHX5FWmgEs1vmWhS83vAeQzMuD+cCPkYfOk
 vqbfu91wgLG8ujJ2m4412QvN3P6f0gw6o+ufre1tb7JfH+R2fzVGuKxh3gagN+umOo2ddLV18
 B5K1HnxAdevFPgEaP+iXypbC0cJv1LEaXKpFUTHvHFzZUxvwmeY69WDE3u0jNR5YBEpdliKPB
 vTCIP67bqTOhd0SmJPd3JiVCJbdBbkF2KK1w37LMT4p3W0j35SNDQ2t0OtzhjOWjwR4Si03bf
 gjZqmGnu1NHDvP5iQ87gtsnfqGlYB4NFitfHyuUpq5sAgiU9viwEp/W4D/B3MGktWU1+5DNuF
 ovYPBmQpkdwhem1U53MMA5chti9KiFqCb/Piy+NiGDidURRqPoMDTZBXKeYMhBHtQVr7auVDd
 NlKixD072Ek6ed5FK7fX6CYkjwYpj9YTj+sZB8C08kkS1IYt1LrdJsD/AJm+GuX0k+A5QPkvQ
 ZgcflGew1YzOPfNgSYwefCy1S/mIKyUfnWO3GXk+YnbBv7+v8jbRHvZIEzp2UNVFNdt3BUidP
 0LT2v96DuWDaXNQhaYRxWzJ/k/uYc8rFAG11dL1T8ZMVfw7rxpU53bULZoC1dwdf7N0oE4Yw0
 V9MZJJ5yGP9BkUhQADCeOpIt9+7J6yICIqNeB2AHzyNdeom+1Yb/aMN7AxHyil9+jDs6iwm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Le 15/07/2020 à 16:55, Junio C Hamano a écrit :
> Jean Abou Samra <jean@abou-samra.fr> writes:
>
>> $ git bisect run ./non-existent.sh
>> running ./non-existent.sh
>> /usr/lib/git-core/git-bisect: 247: ./non-existent.sh: not found
>> Bisecting: 2 revisions left to test after this (roughly 1 step)
>> [6fc732a2116e2c42b0431bb7e2a21719351af755] Fix typo in docs: 'created
>> by th' -> 'created by the' (GH-21384)
>> running ./non-existent.sh
>> /usr/lib/git-core/git-bisect: 247: ./non-existent.sh: not found
>> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> Yes, it would be nice if "git bisect run" can reliably tell that it
> got a "not found" error and not a "test performed by the script did
> not pass" and stop at the first failure.
>
> On the other hand, the "./non-existent.sh" script could be part of
> the tracked contents (i.e. some revisions have it and the working
> tree has it when they get checked out, some revisions don't and the
> working tree does not have it), and the user is trying to find the
> first revision that stopped having a working script in its tree.  In
> such a case, the script that does not exist and the script that fails
> need to be treated the same way by "git bisect run" as failures.
>
> So... I dunno.

Perhapsa --not-found-as-failure option could help?

Best,
Jean Abou Samra

