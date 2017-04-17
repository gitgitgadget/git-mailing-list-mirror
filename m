Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 216731FA14
	for <e@80x24.org>; Mon, 17 Apr 2017 10:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdDQKaa (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 06:30:30 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34240 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdDQKa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 06:30:29 -0400
Received: by mail-oi0-f42.google.com with SMTP id x184so49805119oia.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sy64lchVkLrVIC6OlYKjbHlmtbfkAV83sYmy9snqFZk=;
        b=S9p2K/HX7jcDFCUkfDmPs8LoFXbsXCfvYnw7VIk79h/t/fEz3sDoSmlh4N6dnwG9GW
         BAbAvhM6m5sSHaquK4EgQbP/Cis1hBWGKr2vesXHp1tY7++69xRqirqvNpTM6nD/70Hn
         +HiHtZfdVfpD8UBGGll3i+8wch46jA18BQTnSNSKdlgb0TVgeaghYiE7IGVGYOuK97nu
         i86N4WUcSPZqYoVci0UHj0BppOq5jIjbGXBDwVI6LouxgEQSKhlHUy3ewhGrOWiI1s0U
         xrA8ZdWk/6FX98EeAbBVQf1+QBXFUnQg8WSPrpQrGX/bEO9etzkv1tm59GoupK6IMFof
         oGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sy64lchVkLrVIC6OlYKjbHlmtbfkAV83sYmy9snqFZk=;
        b=K1mdqMPEuWTZkefLit03eOwjbCm8eqreqOahANdvEB9aBrMMQM3oSEsNYS4HQ8QUCq
         i3DU3o2v1MJZmm6kcdyCZRBNOuvpXawz3lQdEO8af/W2Y9xFOWCYMj34HEXc8zq1FD+O
         ldpcnOAY60cun3zBlAg5YRgkwoeDzpUEXmhSJmvgCAjTp9FieFm7d5BS9nw/IHlDVgrY
         NWv224fgJqQGWNPGT3TwA6I1I16QUSxJVFyQXSW4MZr2Od3cQzHP1RnkesmSnDOU/xVs
         oHE6Kiny9Dv3ApQe3/m9usLCSlXu3AoHAcpnZXevbdmqlTZQ5rXpMicWKIdyGXrL3WF9
         qrFg==
X-Gm-Message-State: AN3rC/6BrCaZMuU2xM+kFWKWfgBz8Q5XfjR+/kNkt2SA9OiwbNRh/9+C
        nHar21La0Medf/reMtkQuBZM5kULNQ==
X-Received: by 10.157.5.102 with SMTP id 93mr5136258otw.10.1492425028792; Mon,
 17 Apr 2017 03:30:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 17 Apr 2017 03:29:58 -0700 (PDT)
In-Reply-To: <20170413212909.eb7zrhs7rzk6nxl6@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1704091238560.4268@virtualbox>
 <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com> <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
 <20170410171352.s7r7tzheadxjlulw@sigill.intra.peff.net> <CACsJy8B8osxd-0axJ9giaMYKuict2h1zW8TcYYuRFGXfBbdF0A@mail.gmail.com>
 <xmqqy3v6ow54.fsf@gitster.mtv.corp.google.com> <CACsJy8DPFzgxqvPzpMbmoM4sMP7oSZ=eO6DJa+dv4sY=QKHjoA@mail.gmail.com>
 <20170412130145.jjnyait5234qsmys@sigill.intra.peff.net> <CACsJy8BbHDsk4qLhVA=0QJFPutcGJpGwWrjs0_DiscDM9Q9+pw@mail.gmail.com>
 <20170413212909.eb7zrhs7rzk6nxl6@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Apr 2017 17:29:58 +0700
Message-ID: <CACsJy8ATXZZ27wHFHCUUoAbAjOzaaOUDrn=enSu8dsaCOk=fLQ@mail.gmail.com>
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danny Sauer <danny@dannysauer.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 4:29 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 12, 2017 at 08:11:22PM +0700, Duy Nguyen wrote:
>
>> On Wed, Apr 12, 2017 at 8:01 PM, Jeff King <peff@peff.net> wrote:
>> > I dunno. Maybe I am missing some subtle case, but it's not clear to me
>> > what the user would be trying to do by having git stay in the original
>> > directory.
>>
>> Not sure if it really happens. But if we jump from worktree is inside
>> original cwd and we have to jump to worktree, we set empty prefix, not
>> "../../../" one. So we can't refer back to files relative to original
>> cwd with prefix. I was kinda hoping "super prefix" would solve it, but
>> that one seems designed specifically for submodules.
>
> Ah, right. I think the issue is that "prefix" really serves two uses.
> For things like command-line arguments, we use to find the original path
> after we've moved. But we also use it for "where in the working tree
> are we".
>
> So with an out-of-tree cwd, we'd want to set the first one to the real
> path ("../../whatever" or even just an absolute path), but the second
> one would probably be empty (i.e., just pretend that we started from the
> top-level).
>
> But that would require first refactoring all of the cmd_* functions to
> handle those prefixes separately.

Yeah. I probably shouldn't start another series until all others of
mine settle. But if anyone is changing cmd_*, I suggest we take this
opportunity to pass "struct struct startup_info *" in the as the only
option. argv/argv could be stored there as well. And you can add
"cwd_prefix" to present that "../../whatever" (I would avoid the name
"super prefix" until things settle), or just keep the original "cwd"
in there and let people do whatever they want with it.
-- 
Duy
