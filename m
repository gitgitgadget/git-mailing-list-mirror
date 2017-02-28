Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1E3201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 19:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbdB1TyJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 14:54:09 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34429 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdB1Txv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 14:53:51 -0500
Received: by mail-ua0-f178.google.com with SMTP id f54so25833293uaa.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 11:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JdCZaFFeAYHtKswp78sfnKKbGkinUk7UdWMFiAv1+50=;
        b=UUcaeK9BfGEWITcO8kde0OBr9BCmQeY1uIATGXaK+6o8pqpBwvaiQrI+n/8N2Ab8dX
         EwUW0X+rH6LW8y2aypGM4RP+x3qcbSK1iVgRsNaTMrKCajj5sRfFGnnE5VBUhwTZkonH
         hxUdpNW4k7Hl4iDcMQE1ro/tazqcdiD8dkkZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JdCZaFFeAYHtKswp78sfnKKbGkinUk7UdWMFiAv1+50=;
        b=cFegcknqwSBtA6BlnQ3ZrHUXieC2w7bH72IIYHOYXvSuynJdlGJ2JpwnYqKMqxTzEX
         6VmcIkzn7+YgJDAc70L1SBWcBMdXrn1U93A+lesVQKnTpSdLsTxySwjZvJQcYpGOsIKP
         BintKW1V1wnzJAqEQPEuzzRPsp4rgK9WdCxOrURP3sK9AzqntGtgebHRZyzaJlCrU0lt
         v/vE4eSyQA17NUW713Csf9HFa9e9WHLJwruHPtNS/4m6pIreczXR6tdltgUU6yK26hCJ
         TdzDWSD5qvsXmqwsHkJbMjR/KxyUbn6YQoXICp/FQA5kFIGSUCTdY2FFEqatIWav7aaG
         AuHw==
X-Gm-Message-State: AMke39mAhp9k8aHQdKet7dw01R94SrScQMTdXldI/d4r/B27sKA/C0PPkqGB5IElrI2FezHzF9nU/ttVime51g==
X-Received: by 10.176.71.87 with SMTP id i23mr1911979uac.144.1488311547635;
 Tue, 28 Feb 2017 11:52:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.77.78 with HTTP; Tue, 28 Feb 2017 11:52:06 -0800 (PST)
In-Reply-To: <CA+55aFxTWqsTTiDKo4DBZT-8Z9t80bGMD3uijzKONa_bYEZABQ@mail.gmail.com>
References: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net> <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net> <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net> <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net> <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net> <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <xmqqefyikvin.fsf@gitster.mtv.corp.google.com> <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
 <CA+55aFxTWqsTTiDKo4DBZT-8Z9t80bGMD3uijzKONa_bYEZABQ@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 28 Feb 2017 11:52:06 -0800
Message-ID: <CAJo=hJuB9JkTZSRbhN2DX0gBqpjddU=Sk8iRV9++TYRv4xKA6Q@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 11:34 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Feb 28, 2017 at 11:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> In a way similar to 8415558f55 ("sha1dc: avoid c99
>> declaration-after-statement", 2017-02-24), we would want this on
>> top.
>
> There's a few other simplifications that could be done:

Yes, I found and did a number of these when I ported sha1dc to Java
for JGit[1], and it helped recover some of the lost throughput.

[1] https://git.eclipse.org/r/#/c/91852/

>  (1) make the symbols static that aren't used.
>
>      The sha1.h header ends up declaring several things that shouldn't
> have been exported.
>
>      I suspect the code may have had some debug mode that got stripped
> out from it before making it public (or that was never there, and was
> just something the generating code could add).
>
>  (2) get rid of the "safe mode" support.
>
>      That one is meant for non-checking replacements where it
> generates a *different* hash for input with the collision fingerpring,
> but that's pointless for the git use when we abort on a collision
> fingerprint.
>
> I think the first one will show that the sha1_compression() function
> isn't actually used, and with the removal of safe-mode I think
> sha1_compression_W() also is unused.

Correct.

> Finally, only states 58 and 65 (out of all 80 states) are actually
> used,

Yes, at present only states 58 and 65 are used. I cut out support for
other states.

> and from what I can tell, the 'maski' value is always 0, so the
> looping over 80 state masks is really just a loop over two.

Actually, look closer at that loop:

  for (i = 0; sha1_dvs[i].dvType != 0; ++i)
  {
    if ((0 == ctx->ubc_check) || (((uint32_t)(1) << sha1_dvs[i].maskb)
& ubc_dv_mask[sha1_dvs[i].maski]))

Its a loop over all 32 bits looking for which bits are set. Most of
the time few bits if any are set for most message blocks. Changing
this code to find the lowest 1 bit set in ubc_dv_mask[0] provided a
significant improvement in throughput.

The sha1_dvs array is indexed by maskb, so the code can be reduced to:

  while (ubcDvMask != 0) {
    int b = numberOfTrailingZeros(lowestOneBit(ubcDvMask));
    UbcCheck.DvInfo dv = UbcCheck.DV[b];

Or something.
