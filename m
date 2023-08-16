Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0FDC04A6A
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 13:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245557AbjHPNbX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 16 Aug 2023 09:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245604AbjHPNbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 09:31:16 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE94E52
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 06:31:15 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37GDSmPj1826925
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 13:28:48 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, "'Taylor Blau'" <me@ttaylorr.com>
Cc:     "'Andy Koppe'" <andy.koppe@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <20230715103758.3862-1-andy.koppe@gmail.com> <20230715160730.4046-1-andy.koppe@gmail.com> <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com> <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com> <xmqq7cpwjhr1.fsf@gitster.g> <006574bd-4d53-495e-8cfe-677ede521908@gmail.com> <xmqq350kjfk8.fsf@gitster.g> <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com> <ZNv5PQlkn6tbUcH7@nand.local> <20230816022420.GA2248431@coredump.intra.peff.net>
In-Reply-To: <20230816022420.GA2248431@coredump.intra.peff.net>
Subject: RE: main != master at github.com/git/git
Date:   Wed, 16 Aug 2023 09:30:57 -0400
Organization: Nexbridge Inc.
Message-ID: <000901d9d045$e780f790$b682e6b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK2iEj3UYOva04rtepGq3XGG6Ck6AGB+JDGAiSBonABWk1vJgKEKMhRAcxDmJkCXFI7vgIst0xsAYUClvsBU/EmEq2t4W8Q
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, August 15, 2023 10:24 PM, Jeff King wrote:
>On Tue, Aug 15, 2023 at 06:16:29PM -0400, Taylor Blau wrote:
>
>> > An alternative might be to exclude one of the branches in the
>> > workflow file, as per [1].
>>
>> I think that this should be relatively straightforward to do, and
>> would be preferable to dropping 'main'.
>
>That was my inclination, too, though I wonder if that might cause hassles for Git for
>Windows:
>
>  $ git ls-remote --symref https://github.com/git-for-windows/git HEAD
>  ref: refs/heads/main	HEAD
>  a67b85bf88ddbccae96714edb64d741ddfc3a1c9	HEAD
>
>I'm not sure how big a deal it would be in practice. Obviously they carry patches that
>are not in upstream git and could adjust the file themselves that way. But it might
>introduce extra friction, and in my experience changes to "meta" files like this can be
>a hassle, because you often want them independently on every branch (though in
>theory this one only matters for the "main" branch itself).
>
>So I won't say it's obviously a bad idea, but it might bear some thinking on what the
>ramifications would be for downstream.

Would it not be more convenient just to add a GitHub action that set main = master for each push?

