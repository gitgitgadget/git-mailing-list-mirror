Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A57320248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDNVVB (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:21:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39666 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNVVB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:21:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so17651586wmk.4
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ngXGWOUm9tY5goc/v7AfDX3+lAhDVF3je14UtzNpUl8=;
        b=Ao40vQRwTwBO1zSW5OwLyht7dhID4REaVkQatnC3tJv2OKQVW97gwOzj2Z107fbAZe
         QyK3Dyn0Mt/vKBD1B8OKklEiEl/cM1CPV73o5xy1fA7VGY0Tma1H9XZnh32ZUW9Svi9r
         I8R0aVYswRK6MT1bT6qHpxB8oAfS1JoNjjSk/9+K7BjtJLvYf6prFg1QnEnhDzOppzNQ
         D7Wuo/EhX7hYJtiiWikL2rN7lDMtXykxAmTNXmMlMJlUv0ayqv8FxzYfcQRwoNOqkPdA
         rab4ZmP0TxhgHjV4NBZWTqxxs2MzOtNqmcFOLlsGGPAuegZBXlV3vNMR+0RhdXbID6te
         25Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ngXGWOUm9tY5goc/v7AfDX3+lAhDVF3je14UtzNpUl8=;
        b=Ce22e9nAwS4o7I4/5/Qd365ffzttxNB74G7RM9IuuFsHPdsntPcfAtaZmqoS/NbCe4
         TIx4I67Vdzamncb8Q8gpwz+Izw7YtFwrEfCOqK5ijLMHG6k0vdY7cJtGpzCB8rL/0HS0
         mG0mce74k/3dWIAPUzoL5U7lCLleHT1IYmDZ8f7l7kvaUxMnPY6fwXiu4T4UcMaEfgOq
         H6Y/OKP9I3G6O2lKm+JPjfVYB2Ln+aiE8f1G0eLthfN0nuv+jrVORGwByce7ReZEUVvR
         BCmJ72cHp1uB9Ce9j6a9v7PRCI0cf+8Ys4b3ng37w3+i/rRk2EuP6iFxsuQE2iz3CSLd
         YMlg==
X-Gm-Message-State: APjAAAXRLdx33zYZR2cSyioxRt21rKFMMUdkImpDqsV8oFI2p7d+a80U
        lnS+O6KkHYTotoKFgvPD0jkdnnvx
X-Google-Smtp-Source: APXvYqwyTWs11R3goV0AufaM6PYhIKAjJyo8AE/PPgb/pucY38xb1BKti5AxZEA9UwgswSyFK5B3jw==
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr18778887wmg.79.1555276859073;
        Sun, 14 Apr 2019 14:20:59 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id 84sm28162044wme.43.2019.04.14.14.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 14:20:57 -0700 (PDT)
Date:   Sun, 14 Apr 2019 22:20:56 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: incorrect range-diff output?
Message-ID: <20190414212056.GI32487@hank.intra.tgummerer.com>
References: <20190411111729.GB5620@ash>
 <20190411220532.GG32487@hank.intra.tgummerer.com>
 <xmqqo95bxo4p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo95bxo4p.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > I'm not sure what the right solution for this is.  I think one thing
> > I'd like range-diff to do is to add the filename, or some context
> > (e.g. is this part of the commit message etc.) to the @@ line (not
> > sure what that is called?).
> 
> Perhaps the inner diff can be done with the usual funcname/xfuncname
> logic so that the real function name of the payload is on the @@
> lines (they are internally called "hunk header" lines, I think).

The inner diff is actually currently done this way, however we then
strip out the funcname.  My understanding is that that is mostly done
to get rid of the line numbers which can change between ranges, so I'm
re-introducing that, while only stripping the actual line numbers
out.

I do feel like the filenames should probably have priority in the
outer diffs hunk header lines though, as we can only add a limited
amount of information there, and without the filename, the function
name might be less useful (or it may be not useful at all, for things
where we don't have proper funcnames, e.g. for documentation).

> And then the outer diff (i.e. the one that compares two inner diff
> output) can use a special funcname pattern that says "treat the
> lines that begin with '@@ ' as the function name line", instead of
> (or in addition to??) the logic that says "lines that begin with
> 'diff --git' have interesting information" which led to a misleading
> piece of information in the range-diff output under discussion,
> perhaps?

I don't think there ever was a logic that says "lines that begin with
'diff --git' have interesting information", but rather that's how the
range-diff was interpreted, because there was no indication that those
lines don't have interesting information.

My series implements something very similar to  what you're describing
though, except I'm introducing a new type of header for the filename,
as I think that's more important, as mentioned above.
