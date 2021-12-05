Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45DAC433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbhLER3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 12:29:09 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:40834 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236660AbhLER3I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 12:29:08 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id E850C19F5CD;
        Sun,  5 Dec 2021 18:25:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1638725139;
        bh=dvSdTBDabUgJmk9I40adNXC8Vigc1clvQeFljJdfRas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JdoxYtIJZaiJ+ItSYSoPLhMt/7dBnfAxIjuajuIbAliX5outRra/cRQc1HuRJ7/zo
         ncPTg9xijMNOUqp3X7HRdgFCJK13Oug/cM8mdwJZgkYE3ZyP0OcC6NA/OUo0pxDgKg
         79N0EPXoXV4ROa3I4GuPOUebYagrAasFqvMKWjGQyqIebOg3YIKlPBR24HV/4lvnP6
         iQFHtMxfMgv8jUnpk8E5+dWDMACUKFtNhb2fBTbrAxB5xYT3he+5GrU2TpMupeQ8e/
         +Jmz3rr+f7atKIzIqHSuWxrSH8j8UMjDlDM3k/8y3UmXb1nadepdpIyzrOufRC2V/e
         nRtQb/JAEb3IA==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/10] Factorization of messages with similar meaning
Date:   Sun, 05 Dec 2021 18:25:28 +0100
Message-ID: <8718669.4XknugNGDb@cayenne>
In-Reply-To: <xmqqfsr7mrs5.fsf@gitster.g>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com> <d687f69b-efdc-6b1c-c63c-8544ff37d1c2@kdbg.org> <xmqqfsr7mrs5.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday, 5 December 2021 08:31:38 CET Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Another aspect is that translators lose context. For example, "%s and %s
> > are mutally exclusive" may have to be translated differently depending
> > on what kind of text is substituted for %s. In this example it's
> > probably always command line options (I haven't checked), so not an
> > immediate problem. But something to keep in mind.
> 
> Yup.  I do not think we are quite ready to have two identical msgid
> strings to be translated into two different msgstr strings.  We've
> briefly talked about pgettext() a few months ago, but nothing
> concrete came out of it, as far as I can recall.
> 
> 

As a translator, I made sure that all the messages are with the same grammatical structure where the placeholders are only command line options. The same messages with placeholders are meant to convey exactly the same meaning at all their use point. We have all the control on the source code to tailor them so that one message model is only used with specific types of variables (options here). That's another reason why I was proposing to define and name them.

If needed, "%s and %s are mutually exclusive" could be turned into "options %s and %s are mutually exclusive" to make it clear that the placeholders can only hold option names.



