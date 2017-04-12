Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44CE71FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 13:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbdDLNLz (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 09:11:55 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34764 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbdDLNLy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 09:11:54 -0400
Received: by mail-oi0-f45.google.com with SMTP id g204so30631101oib.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 06:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A91b73Z5yJu4ipsZRTmeTVhgvvT0brhkNSBlNgmGGWk=;
        b=Y5RonnEwypDVykKWFm22XFogVdDKktMC/QLcNytkBC84EFk5I+77UnXjmeVQC7lKUB
         jPALm2hc+MsLdg+HnIOJcAFVAVBRmEkkAUiVzM/h75fRX7XJmDbpp0hVA4PnPUqUywmS
         WcebKt6019g/QpL4lyxQtebrlwXkdJWUWdij7wRt5nbFDhyMF8MKKWMmPFkJOGn9aLr2
         3fLKnybrS8GGrPgbI2JikHxx68ekUGfv95AapHQGaRJBU3XLWzBa0dx/28ES45eTLgmb
         8RbyqgYpvPEBD1r5nHdGPbJNUuzm6EG8j3MFXRPnA9hR4HcG+hek0DOJm1CeT5zsRhjT
         jWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A91b73Z5yJu4ipsZRTmeTVhgvvT0brhkNSBlNgmGGWk=;
        b=qFCThP+s3kWReVwmSfw0Xi84/59mbPq1BKvQFUqngCAWQBUEV/HdCw4BKuF+RTARHi
         RXMQcTtIeoR2X+jpUaX83QCnPLitRxFeD0eynpd4D8jWgMi0HH1Gc46rMe1E+h/fS0kJ
         IZJsmG8ZaNiREGcbRlObukbFDz1Y7PPpsI2eHk1Eus+fXIJpeft+s+PSUIjeTyCXW4Lv
         lXcXq4U3wa3i4F1PfdJWCShtrZReUY8OPPZqWSct37w/jI+v/PcMSzoWLd1qTMENIjiZ
         ARUHEOI6G+hI0EeZ1zUV3qL1GbGC4c/c42GWb358OBS11qEyCeLb7NCak+iC0uPKnqm5
         X2Rg==
X-Gm-Message-State: AN3rC/5uNfKZTbzVpK0wF7dsgp8zrkEZaD0fJrCEXr7zjgn+oo8MxyqA8II6Cfy/qZgOOG76jWNg827LMPCQzQ==
X-Received: by 10.202.168.146 with SMTP id r140mr6256694oie.169.1492002713380;
 Wed, 12 Apr 2017 06:11:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 12 Apr 2017 06:11:22 -0700 (PDT)
In-Reply-To: <20170412130145.jjnyait5234qsmys@sigill.intra.peff.net>
References: <20170409022128.21337-1-danny@dannysauer.com> <alpine.DEB.2.20.1704091238560.4268@virtualbox>
 <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com> <xmqqvaqdqfhe.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
 <20170410171352.s7r7tzheadxjlulw@sigill.intra.peff.net> <CACsJy8B8osxd-0axJ9giaMYKuict2h1zW8TcYYuRFGXfBbdF0A@mail.gmail.com>
 <xmqqy3v6ow54.fsf@gitster.mtv.corp.google.com> <CACsJy8DPFzgxqvPzpMbmoM4sMP7oSZ=eO6DJa+dv4sY=QKHjoA@mail.gmail.com>
 <20170412130145.jjnyait5234qsmys@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Apr 2017 20:11:22 +0700
Message-ID: <CACsJy8BbHDsk4qLhVA=0QJFPutcGJpGwWrjs0_DiscDM9Q9+pw@mail.gmail.com>
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

On Wed, Apr 12, 2017 at 8:01 PM, Jeff King <peff@peff.net> wrote:
> I dunno. Maybe I am missing some subtle case, but it's not clear to me
> what the user would be trying to do by having git stay in the original
> directory.

Not sure if it really happens. But if we jump from worktree is inside
original cwd and we have to jump to worktree, we set empty prefix, not
"../../../" one. So we can't refer back to files relative to original
cwd with prefix. I was kinda hoping "super prefix" would solve it, but
that one seems designed specifically for submodules.
-- 
Duy
