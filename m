Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66ABC209FD
	for <e@80x24.org>; Fri, 26 May 2017 04:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035155AbdEZEiG (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 00:38:06 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36615 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035147AbdEZEiF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 00:38:05 -0400
Received: by mail-io0-f182.google.com with SMTP id o12so3279608iod.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 21:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HMRJJSsuLy9vZoVou9X0888Hu/8DCk+D6X6B9HPsGyo=;
        b=cy/+iKCnvjPOEZRo0sSfzshXCIZCcaY7D/9fvip22s4UDGsAil6WyI+uyd8ajiy6A/
         G9YkpMWQ7XRlLbttodLQvcE2XcQKYbECnDaZEVbB1oCJj1xUZuyE2Ngr8JWrH3B3jZ8W
         BcPujActjkTy2/SNSeR/zYJLLA2IrTehfq4ZjLJwGUd4kFImIpvCKsG/lr+993Ad4Qc5
         OBxSYwH/TlqBc+1uoF46f914csldmRIcUvGdNgceZADJoEBnP9e73Z/eIUyQ0WBB3YN5
         lc/uoPE58CwvaqnuwJ4FgOJUQ5SyCsojbTpYxNij5fmc8y9Qy17lSYB+nV8MHm046XY/
         fnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HMRJJSsuLy9vZoVou9X0888Hu/8DCk+D6X6B9HPsGyo=;
        b=JNoVwgkkKBmZ5Atc67st1IZEDdHNZtQY9qj/vOzIWB76s5cj9gU9rj9nSzR1dGq+0b
         Hu82KlQH7n8C/iN02pm6AXHylaVL3YcSM0B8imRppnrC5GPqt3zSSM90uk4bt3QkG7bv
         tzdVnrX7NdIbXNT72Pghbx7mh/U0iWAy2oz6rbp1q5dy8AOAs+CxOpDGTkmBDGGYp8wF
         JGOTz2tWiTqJO3U1+cH4azgcxC95gnuK0NZIkesSANfQYWAK/GKlu0XClyuJL6xKxyOU
         sDMtcCzUsdAbGKIH18SAZ15PVCp+WFotsnw90LgCJ4viN1LpAGYJYkku5hUPKG/ry+Uf
         POng==
X-Gm-Message-State: AODbwcDxUb/FAUvEUwLSPNLmSCBuy9biKk2UqlQHYkKUisxYnuUseewF
        UUNpecEVk1Vrs0NE1hs3KXpsUSxLC3ga
X-Received: by 10.107.4.200 with SMTP id 191mr47807882ioe.223.1495773484763;
 Thu, 25 May 2017 21:38:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.18 with HTTP; Thu, 25 May 2017 21:38:04 -0700 (PDT)
In-Reply-To: <xmqqpoewcy05.fsf@gitster.mtv.corp.google.com>
References: <CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com>
 <20170523131231.zqjkymypbilv6tyf@sigill.intra.peff.net> <xmqqa863jiyf.fsf@gitster.mtv.corp.google.com>
 <20170525180407.ni2oed5wk3qsd2ch@sigill.intra.peff.net> <20170525182230.552dif62zqxuufk3@sigill.intra.peff.net>
 <xmqqpoewcy05.fsf@gitster.mtv.corp.google.com>
From:   Tyler Brazier <tylerbrazier@gmail.com>
Date:   Thu, 25 May 2017 23:38:04 -0500
Message-ID: <CAAZatrCQZq5_Jc=O-6guyKx1BcOcTNOmWoqwGNrbotnK-VXacg@mail.gmail.com>
Subject: Re: `pull --rebase --autostash` fails when fast forward in dirty repo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Does git accept outside pull requests? I wouldn't mind committing the
fix for this once it's been decided what the fix should be. (It might
help my resume ;)

On Thu, May 25, 2017 at 6:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Anyway. All this has shown me is that it's probably pointless to do this
>> timing at all on Linux. Somebody on Windows might get better results.
>>
>> But regardless, we need to do something. Correctness must trump
>> optimizations, and the question is whether we can throw out the whole
>> conditional, or if we should just restrict when it kicks in.
>
> Yes.  I personally do not mind going with the simplest approach.
> The optimization thing is relatively new and we were perfectly happy
> without it before ;-).
>
