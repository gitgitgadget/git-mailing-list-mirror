Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3A01FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 18:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422646AbcK3Syi (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 13:54:38 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:32789 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932197AbcK3Syg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 13:54:36 -0500
Received: by mail-yw0-f178.google.com with SMTP id r204so163156317ywb.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 10:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EBbz/TCFCW18f289ocLiOxOJ4uHjnDHhV2skFPS0BHY=;
        b=ja+ehtYzAq3ivpI3HxcPCn5mboFh2qsFbdmN+tRf4/G+FBx+A9FKidhT+Ev/5N3o21
         qA/DkD0s44/SmpjY0EbK0sdAks32I6w5wue2D7lzB0opmfKPNzdHZ1q3T6l726VzvBY1
         tm12LCk1PlOxKBeuDk9aztYKGuEt9VOj+KXrqbMpjxAdoPxv+owcJrOb584juLMAtlQK
         jhLA0CWwtB7m6ESpFa90ITVNFH10pIm4h3dv16YOfHeumS7m82sFM9XjMYRyb9igy/kl
         nCRpch7JsHP3ipqvLS69N+htgvhsp8Z3OO7yqc/nf2CqdfDhNI/FB6eFqO1RZwXjItYk
         ootA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EBbz/TCFCW18f289ocLiOxOJ4uHjnDHhV2skFPS0BHY=;
        b=JOJmaS8WELopNW1/Bxjb2lUrtdoa6zNGCpcOL/ZsnwQGt/qUxQeQLcq1WfSA7akOf4
         t2vkqxjszmyA1NHzWN9JSg8AhuJej7YkUgvZYSbSvXsaa4ZtUMpScAdgz/W6btRuCwlH
         XP0WN0kbDb65X5ZMiSwQgbl42zW0kDzzpqiZHUiqlajAiCEFcSD8NTXHBAjICs4tKG3U
         CAJ1kSZEkwTsJk3PR+hvVjaXLycMCEyZa2fIPZejsEZObK6wUdkFVX16Qqy/QS2JAIbl
         +rrik7iXZZpBZ2EM2Fm0deT6xajo8WzXA4ildGOlm9H+JIgcHhEQVURPiZP2RBDE3rqm
         wPPg==
X-Gm-Message-State: AKaTC00wqqVEbW2cTKeq07QFvLalAg1Oc2pEYR+k31ohv311YByZluJepcUO/8OLt6QE76oG3vXqiPptV0wXDg==
X-Received: by 10.129.108.216 with SMTP id h207mr37765150ywc.52.1480532075888;
 Wed, 30 Nov 2016 10:54:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.98.77 with HTTP; Wed, 30 Nov 2016 10:54:35 -0800 (PST)
In-Reply-To: <xmqqeg1udkg4.fsf@gitster.mtv.corp.google.com>
References: <CALO-gutW80d6RLdXAtYA2m2GWOchAjNNPy3YCsr31_fCss512g@mail.gmail.com>
 <xmqq7f7mf4rs.fsf@gitster.mtv.corp.google.com> <CALO-gutJbM=LA3q8vdmbQJLoeCFAJWfPHFo8f1vz-5KJHVxJ6g@mail.gmail.com>
 <20161129214604.c5xcw3d2a5ydpx42@sigill.intra.peff.net> <xmqqeg1udkg4.fsf@gitster.mtv.corp.google.com>
From:   Eli Barzilay <eli@barzilay.org>
Date:   Wed, 30 Nov 2016 13:54:35 -0500
Message-ID: <CALO-gusHzTaLg=7X=KqYB==Yz_6yH6qkh8GDK54Lacu5ofD2pw@mail.gmail.com>
Subject: Re: gitconfig includes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 4:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I think it's arguable whether "--global" should behave the same.
>
> I know you know this and I am writing this message for others.
>
> I admit that I wondered if "a single file" ought to cover these
> short-hand notations like --global and --local while re-reading the
> log message of 9b25a0b52 (config: add include directive,
> 2012-02-06).  In other words, I agree that it used to be arguable
> before we released v1.7.10.
>
> It no longer is arguable simply due to backward compatibilty.  The
> ship has long sailed.

I don't have any strong opinion, but FWIW, the use case I have for this
is as follows: I sync my ~/.gitconfig between my own machine and a work
machine.  On the work machine though, I like people to have work emails,
and I wrote some scripts that verify that.  For my case, I added an
include of a ~/.gitconfig.more which is not synced, and has values that
override the ones in ~/.gitconfig.  Since I'm the one who also wrote
that script, I just added an "--includes" to the check so it won't barf
on my setup, but had it not been my script I'd be stuck.

This is all a "FWIW" -- in case anyone thinks about use cases for a
possible (future) change of the default.

-- 
                   ((x=>x(x))(x=>x(x)))                  Eli Barzilay:
                   http://barzilay.org/                  Maze is Life!
