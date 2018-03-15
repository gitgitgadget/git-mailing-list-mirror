Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027821F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeCORm2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:42:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43136 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeCORm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:42:27 -0400
Received: by mail-io0-f193.google.com with SMTP id l12so9513037ioc.10
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BvSUI27ijD2UFkDt6n9+AElVjmRQjL4jcSQhSO0+KfE=;
        b=cwwps8yxXWm79Qsj1IOZlw/S8L49rGTtCPpGxCd25S4oInm9/womiv2OV6J5YAQQ5g
         yVp8+CQo76g/BcmT1eNjeJNrZeDV0ZjeJv7Z6MELVeTWLOHce2yS6kRSAzkm5eGXjlGE
         JoTIGhwMOxSrEN2HKHgyOiiT/Y2e2iW09Vivb2pXwqKnevWwQ2M40MeoxuHys7XS2cRc
         TfZyTiJDiY4FQTjGdqrdGqkTFv+eDSzRgOsxmlMf6MrXs27k7DatDnoD9vFNRlNPxHBt
         7iI/iYzYfu4pBOrqjK+lQRV78kUtF3HXwDVWVHqVj+Z4gPmbqmUbFa8rmf0xH9mRTg57
         rnJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BvSUI27ijD2UFkDt6n9+AElVjmRQjL4jcSQhSO0+KfE=;
        b=amQ8RIr9WKqzoeCMXjn2tyGB/VoUrcZH3VzYquX+afSQ291xtQ4d6xVN0lEmP9s0mT
         mcCor32EIYp2bdIbAMRN3odRTuDUGN9JbSf/jHpp9h+kRAp2i3X5i+bvSBf/tH5LWNIV
         b+iEAgkGSXME1O6NSrdg73npCjQW0DCS2dBLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BvSUI27ijD2UFkDt6n9+AElVjmRQjL4jcSQhSO0+KfE=;
        b=XucURDwDnpDdMmMaL0oHp6BlzJEGA6ddw97IJoivUNPUIVYtFAYyhwwOpyMsuOd3Kx
         qv5M4+hk5hQgIBGo5EMnSG9rvij8yiEt/dUz7NfItxhNtgmDvXHCICbstH/EMegIzv3f
         CALX7jP+gZpvm7U4UOfCCGUMixBY8sleR9+Hae1vQBFoPcEyZ8o4HdE5v8C6Q89qFQTG
         nBD6m99xXQN7X/uDxvHFQ34HpmvUP2XB8o77eoMg85PoLeYS+XjkRJNk6gRENU9TsAt2
         A2wZwXxZYCpyzsHiUm7kaKnZ6vikdxaY9KSLIsijOBtHHfZHNXSAlnw2/oRFpTgCRx6w
         qURg==
X-Gm-Message-State: AElRT7E8Tl3HQijeP3DHyTQbj+iOYutddEthfF9hJhn88b51o6qViDEH
        2f4YE3kU2kQkSBsTbe+qFOXLSPTkqwU5NZ5fjPK6hA==
X-Google-Smtp-Source: AG47ELuckGnFMZ/Y34j5GDRhfU2G+hGVTJCP9eST6ioZ+g9xqj4CTqYjLJuYt8/57AeW2v3DoIb1IxX2k/6pir/K/Vg=
X-Received: by 10.107.186.196 with SMTP id k187mr3339695iof.257.1521135746521;
 Thu, 15 Mar 2018 10:42:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.135.221 with HTTP; Thu, 15 Mar 2018 10:42:25 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803151804390.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180313203935.5084-1-avarab@gmail.com> <20180313203935.5084-4-avarab@gmail.com>
 <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org> <87y3ivdkvp.fsf@evledraar.gmail.com>
 <CA+55aFwU5fwWx2+DdBp=XCpG2Orx+rA8KxPVtGHxpgHAZs=h2Q@mail.gmail.com> <nycvar.QRO.7.76.6.1803151804390.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Mar 2018 10:42:25 -0700
X-Google-Sender-Auth: tGUzgBhmHpqq7nv5YTshXL0UZFo
Message-ID: <CA+55aFz6J2j_o0b1JfPSPUX0t3703oFtrpcot29_cgbKi7EnOg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Makefile: optionally symlink libexec/git-core
 binaries to bin/git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 10:05 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> The most sensible thing, of course, would be to *not* link the builtins at
> all. I mean, we deprecated the dashed form (which was a design mistake,
> whether you admit it or not) a long time ago.

That's probably not a bad idea for the builtin commands. At least as an option.

We do end up still using the dashed form for certain things, but they
are already special-cased (ie things like "git-receive-pack" and
"git-shell" that very much get executed directly, and for fundamental
reasons).

As to it being a design mistake? No, not really. It made a lot of
sense at the time. The fact is, the problem is Windows, not git. I
know you have your hangups, but that's your problem.

               Linus
