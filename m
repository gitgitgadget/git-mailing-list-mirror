Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00BAD2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 10:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdFAKdc (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 06:33:32 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37442 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdFAKdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 06:33:32 -0400
Received: by mail-it0-f48.google.com with SMTP id m47so15132462iti.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 03:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PQYxDqHHUTKJhciJ2G5VRURJdpopyAhhoghniG7pbr0=;
        b=fDEvPFuKF9/tBX6j6SJ59dvZLfiDS6A0bFJrZhDvoQrsYl37l75NcPdgBVbwkoX6Sn
         D/SQkl28EOCdBFp0eGgkB+BSmMUtxBpIAANIXAj2+eyIBHDoGWqUP40OuJiOl5OJQpic
         zHNbZg7gYQLR2slFi1fajnH9KzvxeAhl5+f7ihFZVLIvuyb2sJXYCcI5dMvNRXKfHTVd
         lS7vjOhlxR7dCp8D5mQNbohaOFEHg7LTZLlu/oiFffjSTxd4w3kGp12ntBlsDLf6RfFj
         on+GAE79vxPt4FqyAU+qHqb9I4CZHUmJbplTwPGDJiqfdA3ckg/nlRWevWbxoIzcSF9z
         rtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PQYxDqHHUTKJhciJ2G5VRURJdpopyAhhoghniG7pbr0=;
        b=USn9dntP4EdpccsRUbuLXSwolKGdgTkEWnzVZ7NMDHVoLE/95qCcTZySnyAkoraaso
         YJDbTicwKNYYrqiy34lpE2/Q0/srqiUOv2qf3Ay2I5TrAKe+m6FKi4rbeVPndEBW8daC
         QNvXwZEwvx5P6a+TIzXPJg0W46uqR0vQ31hEj8bdB3BweeGLBldNVV6+fzni4A9Wl7Va
         D6p9ifCLcSR/wLW6LULQqyjHROFyUVlCxKquo2Ufw1j/3KyetTPtcoevzlvYNXTTDB7+
         YkBX3Vox5NnMRv8aEZvoy89iCucS7hzCu9veQDPrKpAx2lgFmq+PfytZk9vY8wnjn8P0
         dlGQ==
X-Gm-Message-State: AODbwcD5gtN/LcQsyjslpb21bcHK6NSS1Ar/Azox2Qbq9QmRYHUZE/ul
        /wmFVNFX+Z9QFYo9BleeG6g1/fW4MQ==
X-Received: by 10.36.91.212 with SMTP id g203mr12283305itb.94.1496313211229;
 Thu, 01 Jun 2017 03:33:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 03:33:10 -0700 (PDT)
In-Reply-To: <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
References: <mvm4lw0un5n.fsf@suse.de> <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
 <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> <mvmmv9st3yv.fsf@suse.de> <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 12:33:10 +0200
Message-ID: <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
Subject: Re: Unaligned accesses in sha1dc
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Andreas Schwab <schwab@suse.de>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 12:26 PM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 1 June 2017 at 12:08, Andreas Schwab <schwab@suse.de> wrote:
>> On Jun 01 2017, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Depending on the model of "ARM" (or "SPARC") emulated with QEMU, and
>>> depending on the OS that runs on such an "ARM" or "SPARC", we may
>>> not see this---if the emulated OS has the "software unaligned-access
>>> emulation" our userland may not see a SIGBUS.
>>
>> Even if the architecture implements unaligned accesses in hardware, it
>> is still undefined behaviour, and the compiler will (eventually) take
>> advantage of it.
>
> I tried to optically follow the macros and ended up on line 87/89 in
> lib/sha1.c of the sha1dc-library, where there is undefined behavior if
> the address is unaligned, which it seems it could be. Maybe Git uses
> some particular combination of macro-definitions and I went down the
> wrong path... There might also be other spots; I haven't thrown UBSan
> at the code.
>
> Using memcpy on those lines should not be a performance problem on
> platforms where unaligned access is ok, of course assuming the
> compiler sees the opportunity.

This is what the upstream version of sha1dc now in the next branch
does, i.e. just does a memcpy() on platforms which aren't on a
whitelist of CPUs that allow unaligned access.
