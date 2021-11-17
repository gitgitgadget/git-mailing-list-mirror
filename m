Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073EDC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 02:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB14861B73
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 02:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhKQCzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhKQCzY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 21:55:24 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFBAC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 18:52:26 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnB3g-005VbR-U7; Wed, 17 Nov 2021 02:52:25 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnB3c-009hBo-36; Wed, 17 Nov 2021 11:52:20 +0900
Date:   Wed, 17 Nov 2021 11:52:20 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 19/23] Makefile: correct the dependency graph of
 hook-list.h
Message-ID: <20211117025220.hpqn3vfhzvihoycd@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-19.23-234b4eb613c-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-19.23-234b4eb613c-20211116T114334Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 01:00:19PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Fix an issue in my cfe853e66be (hook-list.h: add a generated list of
> hooks, like config-list.h, 2021-09-26), the builtin/help.c was
> inadvertently made to depend on hook-list.h, but it's used by
> builtin/bugreport.c.
> 
> Reported-by: Mike Hommey <mh@glandium.org>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 0a3f292bf82..bae20eb1b40 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2162,8 +2162,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>  
>  help.sp help.s help.o: command-list.h
>  hook.sp hook.s hook.o: hook-list.h

You can remove this line too.

Mike
