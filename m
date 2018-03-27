Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B7A1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeC0QFp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:05:45 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:45413 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeC0QFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:05:44 -0400
Received: by mail-ot0-f172.google.com with SMTP id h26-v6so17602217otj.12
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmfYsAWB0GbR+hv1NzevtacCfJZ4Qis3mrkBc62Iq2E=;
        b=oj1IwoJkLd8kmPtZFi183BPhREgEZEYvSCLXBkhnzRxSSiyFw8F7q0erUHigUEzwmr
         q8Bo0JTXDXkW2N3MC9fCgW640ss3eot6w8fMK0j17awHwpQsthclKsUX+Jc2cfTWBRGF
         /nhoqIIY2xrkt+Apo+tqVcn79yb6POna63Pjtvs/W6Dn7ow/bCBjgsh1pfTbPZE+HJRh
         8yRJttp8V3r6rPdGH3Ipe/3bXBpyqZYWyvyl/tO8zZh/9s8ApvqkcPTNebyeufCjOawN
         vkLZImETA89Yrr7MbxPxm5w29xCOkQu50wNg7bnm7m3cuId3ihW0OoQ/4tJJoFHqt2eo
         ItCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmfYsAWB0GbR+hv1NzevtacCfJZ4Qis3mrkBc62Iq2E=;
        b=G4dzgujH1b7ITIhbhTKDbiyKjLhieorjEgMBiF9yjcreCTlYnopXXGnfNENNML21IF
         74NtUglqTmoB4BQF/2B3YdzelGGfI/ZObrJCw204EXIuOWFzIgcDBqTw0tlb/3o1CX0q
         jMZk0s9yGXTFiEV9kKjEKRiEzz25WusuCk6akXrUvHW9dBx5u28+OAocnNssOp6VCdXe
         CVXEGk6/nppI4kjOSApU87Dzw6NOb22fBTY0XYOL9EQncOXFv/cvYaQhv21hFYTA5xO6
         GzvTaZ31dvVUAMW5qrM/+zmKhtKmFAix4tzpbePIqNrRUu/dboEoyGnU63ore2kSfVBF
         GD4g==
X-Gm-Message-State: AElRT7FKKS7WdTg2tTZQNyoQaDaPhBququAXKHGBVdzhcw8XClFqETh/
        2tgtbHh1zG0v/iR5dG9S+gXCM5HcxO42tah57sg+pw==
X-Google-Smtp-Source: AG47ELvjOlA09oUU3ppRe7K2+CuiWm/cwVQovjbFsYivwrPojzV4c9tNKwXHHckf9XdWhmQjWYaXKsfzKtsB/uTU2dg=
X-Received: by 2002:a9d:2ef0:: with SMTP id w103-v6mr21684541ota.400.1522166743204;
 Tue, 27 Mar 2018 09:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180325205120.17730-1-dnj@google.com> <nycvar.QRO.7.76.6.1803262331040.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAD1RUU8jNudjCXN=-mucogmSFj2xqyYqyk-dfADhjceLsmBE2g@mail.gmail.com> <nycvar.QRO.7.76.6.1803271752190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
In-Reply-To: <nycvar.QRO.7.76.6.1803271752190.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Daniel Jacques <dnj@google.com>
Date:   Tue, 27 Mar 2018 16:05:32 +0000
Message-ID: <CAD1RUU9XK837mdRwicMwM5qVApzz8o2e4Eg=B0LH3SRtLqG9WQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add Windows support to the new RUNTIME_PREFIX design
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 11:54 AM Johannes Schindelin <
Johannes.Schindelin@gmx.de> wrote:

> Yes, I performed manual testing.

Alright! Just manually tested your "git" scenario myself on the Linux build
and all seems to be in order.

> I guess we should add a test where we copy the `git` executable into a
> subdirectory with the name "git" and call `git/git --exec-path` and verify
> that its output matches our expectation?

I'm actually a little fuzzy on the testing model here. As things are, this
test will only work if Git is relocatable; however, the test suite doesn't
seem to be equipped to build multiple versions of Git for different tests.
 From this I conclude that the right approach would be to make a test that
runs conditional on RUNTIME_PREFIX being set, but I'm not familiar enough
with the testing framework to be confident that this is correct, or really
how to go about writing such a test.

A simple grep suggests that the current test suite doesn't seem to have any
RUNTIME_PREFIX-specific tests. When I've been running the test suites, I've
been doing it with a "config.mak" file that explicitly enables
RUNTIME_PREFIX to get the runtime prefix code tested against the standard
Git testing suites.

 From a Git maintainer's perspective, would such a test be a prerequisite
for landing this patch series, or is this a good candidate for follow-up
work to improve our testing coverage?

-Dan
