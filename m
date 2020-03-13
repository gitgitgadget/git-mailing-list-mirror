Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6996C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 15:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC58E20724
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 15:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nGQ+pjqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgCMPW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:22:26 -0400
Received: from mout.web.de ([212.227.17.12]:50883 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgCMPW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 11:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1584112944;
        bh=JfjOkytEIko75jNBXP721HiSqFKRHYl8sNz4UniWEcY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=nGQ+pjqfG/8ckDz/RNxZAy8ly6gGIrrtRWpxAhAf5UbqgWjtuf/gqe81naGNKXJ7+
         b8tRmW/iUz3s+hcA3jemeKNztsAWboZeI9IZcZz10dsB327RUvQzAkyDQ59KPvm6GY
         I6jIbT58miX0dgr7prqCoM7ppw8ZuTa3zLAwXSro=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBTIY-1j4UP00jYs-00AX60; Fri, 13
 Mar 2020 16:22:24 +0100
Date:   Fri, 13 Mar 2020 16:22:23 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?utf-8?B?UGF3ZcWCIFJlZHp5xYRza2k=?= <pawelredzynski@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Question on case insensitive systems.
Message-ID: <20200313152223.4glbokvfcmexrx4n@tb-raspi4>
References: <CAOTQ0KvpO5iVFsMqz5WPZd8uEd9_SRxQvznvEEB05jnTTWXBBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOTQ0KvpO5iVFsMqz5WPZd8uEd9_SRxQvznvEEB05jnTTWXBBg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:NUXkrgECjyB3tqwn8n+tXiPGHpnVUjbfg+i+2W1ZQKkFiqYbxSd
 nhyLuNYbMQnO9upE5N7peoyH8r2CGAFInzxlmUvi3BkLRLiw9bkR55yHQex/m3Zz5y3IoDi
 CLYD4sBqqgkvwU5ApXgd+bCIA9iqxOxZvKKd72cYPX0LVODvP/uM+usEG590G4LP/UDiiOq
 1FmZ/ercbry6CEKcEP7Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zm+APsSG9Us=:wZjLvSJ6z2w+2NWvt4qGeY
 EMl/MHWgpZEAvtWQj08oeLLDDuswKZuxPDTQTmEm9r+XcgVLfw/CNX8uIYhryWstnsvL69ByB
 awwuEQUvhFh5btn+Qo5KK8krG5DEWEEAEF2a91OnRXg3147a6Wye+dXhOhZR320U92iSsS+PQ
 5EqR0jqbD9lHDBwCGGWcLN1ZgiHg2xdA0X4kiuU3afJ5xaXUuTIopIXVghn7X9H1k8kRYKTTS
 uoRjXJ3OlrnJnKj8hQawFyR/zKtSX9inLrYZeRurrDWerHuGdIdtYCz7CdshbP3PlzqkgNctw
 pJbcrscecJ8vkhdp66USDkIuPt9hw4R77YsDoKG2ev/joB/4e5D7fdW75dHWo9nRqnqIyjI0q
 KXGNWasIES1tMv82qu9haDLxPclhCcDjHkKdFWTnKBZq5Ows1Mx49if/ftmu4TJ0Vk1wShvyf
 SgAziNWyWj+39ip6HiGwIG4pAHLXJ6jpf64Aphg/ibDtcbvOjVEnXmAXds5VJS78eO+y5q9if
 TfU7vGKccrF9QQj/bxNVIUm+k23Y52aswKACMM9VcBktic+9CG8gd1S02qpKTAkrwIayZYCEJ
 TXoYcItxvup2pqboolbvscw3Ym+r1ojmgD1SdONpDwP9JB0becFf8NdxRPzV+rSavcFdh2zt2
 idDxYlAi1hoPm/utQ0xiaRA6Y1vxaNMbhC+6q6farXaX/ZAXaGPrKi7TFm3k35aGvaQ51QhgP
 h7ZIBe0iFtnfxgWEnzeEi1ikUhImsxaEWQggjVfEbH2jPMDGIQ7w4LSWprB0CQXaZe+3A8Cx+
 GnTXKsUclShnkgbp7i6W6JM8sfZHXVeD19xrglXFbxw7scA+5q7b9KISOY8+2E1o5EYNzMOA2
 0a/cyshHs20Va/GPMosbeQL4kQjnsN2lGtnlLJeYIX6T0vvhb5lwjJs6gyFODkFuqVwtRJgwS
 2wErIb9Z7O+KgNtm0nnbitPFh/sSZt4rOxpAoRUEjpCk8QFlYSKjHJVNosNZfI2Zp4bkxio3j
 NSugK2X27JyavsVCeiLlcFLjA0mCAra5DnHEAZOFNsz6Orhh87gRa35GLR5Z7jl3PYilr0Fwk
 RDiNynF+a7Pnw7DeDyo/sjMUwAMHvYKC5u2JIlKpVVPLsav3ZaW2CixgrngIChOWAR+ihjHbn
 QNheHcPJhkZinbCvMU8osKElCbTHq4RLjXTmMsEn0ikDPpWA1oIT0hd6+X990/wnYYt7g5oar
 kS6KbmjYgOVmSHf10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 13, 2020 at 01:05:46PM +0100, Pawe=C5=82 Redzy=C5=84ski wrote:
> Hello,
> I noticed that check for filename collision on case insensitive
> systems happen only upon clone:
> https://github.com/git/git/blob/c522f061d551c9bb8684a7c3859b2ece4499b56b=
/entry.c#L499
> and
> https://github.com/git/git/blob/c522f061d551c9bb8684a7c3859b2ece4499b56b=
/unpack-trees.c#L445
>
>  What if collision exists on some commit that is checked out only after =
clone?

The OS will overwrite e.g. the content of "FILE.TXT" with "file.txt" if
both exist in the repo.
(Or the other way around)
As a result, "FILE.TXT" would have the contents of "file.txt" which is
typically different, and Git will report "FILE.TXT" as "modified".

>
> Is this behavior intentional (eg. for performance reasons)?

That depends on the definition of "performance".
The Git-developpers have not yet implemented a better solution,
since most of them do such things in their spare time.

As a consequence, we haven't been able to measure the performance
on a computer running Git.

>If its a bug, can I volunteer to solve it?

I would call it a feature, worth to be implemented.
And of course, you are wellcome to solve it.
I (and probably many others) are happy to help with code-reviews
and other tips, hints, suggestions.

> Best regards
> Pawe=C5=82
