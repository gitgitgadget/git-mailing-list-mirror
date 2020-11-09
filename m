Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC3FC388F7
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 11:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9423206E5
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 11:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgKILSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 06:18:00 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:52648 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKILSA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 06:18:00 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CV7lB3gnJz1qsbb;
        Mon,  9 Nov 2020 12:17:58 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CV7lB3V2xz1qy6B;
        Mon,  9 Nov 2020 12:17:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ZgpUuyWOS0hF; Mon,  9 Nov 2020 12:17:57 +0100 (CET)
X-Auth-Info: 79E1jdJ62QZ5khgzAqSkfkZn87k6nVMRL08SiQe/0X9VeTJ4h/tfZKDCj4CSAMkf
Received: from igel.home (ppp-46-244-183-237.dynamic.mnet-online.de [46.244.183.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  9 Nov 2020 12:17:57 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 5E40C2C3605; Mon,  9 Nov 2020 12:17:57 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git gc ineffective
References: <20201109092041.GV29778@kitsune.suse.cz>
        <87361ilv1a.fsf@igel.home> <20201109101738.GW29778@kitsune.suse.cz>
        <20201109104327.GX29778@kitsune.suse.cz>
X-Yow:  Yow!  We're going to a new disco!
Date:   Mon, 09 Nov 2020 12:17:57 +0100
In-Reply-To: <20201109104327.GX29778@kitsune.suse.cz> ("Michal =?utf-8?Q?S?=
 =?utf-8?Q?uch=C3=A1nek=22's?=
        message of "Mon, 9 Nov 2020 11:43:27 +0100")
Message-ID: <87v9eekcd6.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 09 2020, Michal Suchánek wrote:

> On Mon, Nov 09, 2020 at 11:17:38AM +0100, Michal Suchánek wrote:
>> On Mon, Nov 09, 2020 at 10:49:21AM +0100, Andreas Schwab wrote:
>> > On Nov 09 2020, Michal Suchánek wrote:
>> > 
>> > > I noticed I am running out of disk space, and one repository taking up
>> > > about 38G. Did git gc --aggressive, and the used space *raised* to 42G,
>> > > and git would report it does gc after every commit.
>> > 
>> > Do you have a lot of loose objects?
>> { for i in  .git/objects/?? ; do ls $i ; done ; } | wc -l
>> 53392
> And in the double-size repository it's doubled, too:
>  { for i in  .git/objects/?? ; do ls $i ; done ; } | wc -l
>  101167

git count-objects also shows the size.

Does it help to prune them --exprire now?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
