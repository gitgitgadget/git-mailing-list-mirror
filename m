Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510E6C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 13:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiEXNEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 09:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiEXNEG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 09:04:06 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184316338A
        for <git@vger.kernel.org>; Tue, 24 May 2022 06:04:06 -0700 (PDT)
Date:   Tue, 24 May 2022 13:03:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1653397443; x=1653656643;
        bh=m6thyEpPGc+A3bmZ5T+gIPUsj5qqbjL19PqX4bs8eTY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=ojte8s1fo4DdLty+/CCd07hlRxVJvr38zll3Z3pHI/shEg4TLbQxzL6K+bjamM5ZL
         Gcwhcg47H+rtNfolXIr7z1Jl5Dik+ky0m/FyzJk+YXf/XKBwhRFlXQFgTEi/Kh07SD
         LCSlFgyGVVNbtiPbGWdsskkztYgzIQ7ydCyaw+M09gJ9dROs9XDFfBDgNdOx1YU32R
         XH1lwQgxYDtV0EC+6giX7o2bzGPuPz1M1N1t319XOyJSIaF5t1G43GQmgxGS+iyRDT
         Q4NW5hnQ3WAUKisrmoWL3nKvESzv1M5tFWx06zijHSEJMxwTxOMz6eEP9EgpRmHAGz
         6QlahGAam3thg==
To:     Junio C Hamano <gitster@pobox.com>
From:   Carl Smedstad <carl.smedstad@protonmail.com>
Cc:     git@vger.kernel.org
Reply-To: Carl Smedstad <carl.smedstad@protonmail.com>
Subject: Re: [PATCH] check-ignore: --non-matching without --verbose
Message-ID: <hl3lllnkPVswb8IZoaMCS62N42epy97_8rLH8qrvSGCbKoovP5_qjtq4nrot5-h-q_7KOu-JpPX4nC0f74BXm6uWdtxosa6z5niHqAJKRUw=@protonmail.com>
In-Reply-To: <xmqqilpwru9z.fsf@gitster.g>
References: <pull.1236.git.1653310466062.gitgitgadget@gmail.com> <xmqqilpwru9z.fsf@gitster.g>
Feedback-ID: 27944746:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Not commenting on the patch itself, but ...
>
> > find . |
> > git check-ignore --verbose --non-matching |
> > grep $'^::\t' |
> > sed -e 's/.*\t//'
>
> ... feeding grep output to sed caught my eyes. Isn't that equivalent to
>
> git ... |
> sed -n '/^::\t/s/.*\t//p'

That is indeed equivalent. TIL about regular-expression addresses in
sed, thanks!
