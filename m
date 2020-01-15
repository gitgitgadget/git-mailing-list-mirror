Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90DAC33C9E
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 03:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECF624671
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 03:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="q6GQHrOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgAODSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:18:40 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:33151 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgAODSk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 22:18:40 -0500
Date:   Wed, 15 Jan 2020 03:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1579058317;
        bh=4iM4v7ZBKi1Klm5BdLfvceFOfkAY0XSZbxBaTLsQVzY=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=q6GQHrOgBQ5VLHE+Ve5KXzpHni64mqM3f08c+nA3neEugm2nEiRoueFwmhTrS4k+j
         jrUf1QbJwDQYTsmDb3WGgXR1JTO9Y7fBH3PKpZ4yszilPdK3OkYf8YFUnC7Z0XF3Fc
         7tStwot1TDe+R0w0gsBpwuRTnBH/duOpXwJkBdao=
To:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   1234dev <1234dev@protonmail.com>
Reply-To: 1234dev <1234dev@protonmail.com>
Subject: Re: Can Git repos be hacked or otherwise manipulated?
Message-ID: <bvMqhQOr4uENl8j2zcFOY0ogJmUqTRofCGyPlPc_xaXQXSP5ds9lgdglXkjTZng9U5WSpo-Uc2_SzCTdpAvLTeruT-tW3GTDkWj9dfLznuM=@protonmail.com>
In-Reply-To: <20200114220826.GB3957260@coredump.intra.peff.net>
References: <fOv65WlolaWZ638trkwZ6nnWIaRu14wx8bYkLdqzidlHPvhYpg1f6TSa_Z7w7iFEsXSLkMzQ6EYTwo3ggF3oXrDh5U4LM_i2Rzx0BkMh7zI=@protonmail.com>
 <20200114220826.GB3957260@coredump.intra.peff.net>
Feedback-ID: jm_lYfXrrNlRjeoYk2ubMr1Ofg3d6jxZVz74GfYfMumLfq3Q9_Z5n8vqkvDBYWSlKkQ9TIGL2Vvi-4DSzBFTyQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jeff and thank you for your response!

To work around this problem, should we instead host this repo on a public s=
ervice? If so which one would you recommend?

--Jonathan

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, January 14, 2020 10:08 PM, Jeff King <peff@peff.net> wrote:

> On Tue, Jan 14, 2020 at 02:48:05PM +0000, 1234dev wrote:
>
> > Let's say you're working with a team of elite hackers, passing a
> > tarball of a Git repo back and forth as you complete your mission. Now
> > let's say one of them has malicious intent. What are the possibilities
> > that he or she can, for instance, hide changes made to a script or
> > binary that does something malicious if executed? Or perhaps maybe
> > there are other such scenarios one should be made aware of?
>
> It is absolutely not safe to run Git commands from a tarball of an
> untrusted repo. There are many ways to execute arbitrary code specified
> by a config option, and you'd be getting recipients .git/config.
> Likewise for hooks.
>
> And while we would consider it a bug if you can trigger a memory error
> by reading a corrupted or malicious on-disk file, that's gotten way
> less auditing than the code paths which take in objects from a remote.
> So e.g., I would not be surprised if there are vulnerabilities that
> could cause out-of-bounds reads of a corrupted .git/index.
>
> -Peff


