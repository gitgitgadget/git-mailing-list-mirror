Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7E4C33CAC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDBF218AC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jXATI1bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBFRa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:30:29 -0500
Received: from mout.web.de ([217.72.192.78]:44961 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgBFRa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 12:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581010221;
        bh=NHZ5YJPJQqq3LvpkeddJjQiqNviymPTOKtfhS/3SVhM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jXATI1bsMhV2pPwiZycGv0PkP15lC4v1ROiEv3F0V29C8cGz21fCyYFPv6ptLRoRU
         Hn1zZ9HvSYLNbjmD/J93qE9m3iZZNw8+ww8JLV+aGSlWz0llxe4Q7IONByzhyoh4T8
         09R51z33fHFH65PFiNMTxC7lxtjRmWe5TrTZ2HBw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lo0dI-1jSV9x2LYO-00g2fQ; Thu, 06
 Feb 2020 18:30:21 +0100
Subject: Re: bug? illegal text in commit log
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
References: <20200204010524-mutt-send-email-mst@kernel.org>
 <b005193f-24b7-7b6f-f3dc-c7a98db14ed7@web.de>
 <xmqqd0arfyw8.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e271bb17-376d-426f-61b2-86971f1cb02b@web.de>
Date:   Thu, 6 Feb 2020 18:30:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0arfyw8.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fibc24gUl7iS0NYqBgZKtp0ltRGZFnDGWJbM+L94QcKMHeNif2w
 Ox0Qbca20EFHrEAxY4Nj8LBO0bU5H9mKkYTkC8zBrfFFPIjva9cKjnyI53oLXzYlGjJiHCN
 3M4I29iAiNHG2hDiWP18g/loSzwsGVxzV25QvD/ND5J2gUojvOftxdHzZlxBDfvdTZqDD5L
 oxe7ePoNN2xsRoH7ZU4Mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y6N/z/Muk9Y=:3f6AHB/UTWalps+fJmAN42
 rO9X8FLRWs67BzE5NzNiMrpoLaZV+Xvi04au+ErG53TPsOWZEh5ThgZjc3v2xEZEFoSEzacDy
 EW8UWwbWTI+QDUh/i2WnCdyexzHW6QRPKq9Fut/ty9AREMLPo8j8qTSdJra2Eqkjeh5hOCZD7
 hOhHe127gHx5IXz2EsRM88sCmqsC+2ursYELz8fkWXcDQ25B5GC5cOsI148XUDyDGkN3ks+D/
 m/PB/1BewHoeGsMICvRqlcfWsLgpRExLxQt3mqurDBuLL9G2YK0/nEkp5qkB3gtTXvA3nMvsw
 OuKy2uyK1m/8wWWbLBbht6KTrhjglfWtCWaY3NKlXgMKJM9ttJMRZJFbAd1AqGOdoItRKXvy5
 +L862qta14TsvyfspzGkLaimuaL+e+aTyWZiLNboCvoCZVtOGgqgUgRS7gaa0W3MjoK7Gh5MA
 7fZoJRkaOHwRyUp5mYAOfi3I5x4zLisTtUTGx1UOsoeQwV4finXYJLiGbZOupJRmJ+/OBFOuP
 fOf7PjDRR5S+zrO+lJnuEtnAwMYMgGCO+F/y4MZJrzk39XoT94pQFXZX2Oy+VRwzcSCc/Rw8k
 X/ZBjpi2LgITWdrxaQeoq27sGjWjxRqMJ6IIvYdfdjSqVVS7m/6gC04J6J0ra1kO821AVKte6
 o/ODfVivW1sz2gpQBHZyXLl6wRJVRKJBTzNXUco6V3NKMHAY673a5r+XUs4dSNFWtrUj5ZZqo
 9Cpeapsm73cu991DGXylJcIa2KVpIoGaHRu0ExWSgdQbdYSlU5gADcUr3EB6dRQ14si9BZ/VZ
 GNL1fWKAOxOiqrMxq/+KvVW/LmNuqOQ+8mY9XbnTfpn+SQlQiyBg+Hsp7006zaa8QfcZnqsHi
 /SacCkEkuzucn7eQdnsCcziy9zqSNhvvFapxC3LNYf1qtFrJrxH+gW1NkHofaC2ImtsVh5mvZ
 oIRR2RDDZGdZ+F0EIEX2+gMDeC2+HA/EkqfrXRdPdi43R81Y/pbWgwmEX0ksmLVSPauS5fxeT
 iWCj0GW/jEr3hYtO8TJFv5+giJ8hwGzbswbavgulnp9I7KmkKxWwxxYGyNT9yvQhAnPb5X27o
 AN6kYOBqDzp3xOWQh0LTtYCfp84iuVkA0ERn7jDA2S7HqZqvkqPzxSnbl4I3isQt9G4ZGXC4Z
 xfB8yk1esj5Z6MyA+PpQaMxwBduasoJTCroAs3RnMjzZgcSU7f9eoxsquN8gx96swrC7c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.02.20 um 17:45 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Like a Lines: header specifying the number of lines in the commit messa=
ge?
>
> The only part of the workflow that can count the number reliably is
> format-patch.  But the output of format-patch is designed to be
> edited further, and expecting users to adjust the number when they
> make such an edit is a bit too much.

I didn't think of that, but certainly did edit the output of
format-patch before myself.  I suspect the effort to update the header
would be bearable, as it doesn't need to be exactly right and is only
needs to shield the part that looks like a patch.

We could not actually use "Lines" as the name for the header, by the
way, as it's already defined to be the number of lines in the whole
email.  Mailinfo would ignored any patches sent using a MUA that adds
such headers.

Anyway, adding a header would not cover the case where someone adds
a diff manually (and without indentation).

> As nobody in the discussion seem to care any e-mail source other
> than format-patch, we may probably be able to teach mailinfo that
>
>  * the first line that
>    - begins with "diff " or "Index", or
>    - is "---" (and nothing else on the line)
>    signals that the line no longer is part of the log
>
>  * but if it finds a line that begins with "diff --git" (or
>    optionally just "diff "), do not blindly assume that is the end
>    of the log, and instead try to find the first "---" line.  If
>    there isn't any "---", then take that "diff" line the beginning
>    of the patch, but if there is, "---" is the end of the message.
>
> The latter rule is the new one.  And there is no need to change
> format-patch output.

I like this idea.  It will probably be tricky to implement, though,
as mailinfo currently goes through the input line by line and has no
easy way to look ahead.

Ren=C3=A9
