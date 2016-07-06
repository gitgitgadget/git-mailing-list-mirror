Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E4D2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 15:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934AbcGFPbJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 11:31:09 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36786 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbcGFPbH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 11:31:07 -0400
Received: by mail-it0-f68.google.com with SMTP id h190so15095626ith.3
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 08:31:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MG7MJrexH0gnMoYgLgKBPqSLgvg/1vZ9DznhSRbZVZE=;
        b=QhgE1QdhD93wDncpHGGOzycErgLNyi6Ewx1sQdK9La4TvqnaXCjgpB8A6bgsIeT2Md
         NqIjRYqHJQYxVeuurXHz5R338Ti1eQGn+R1mN+B2kzk3nCwb9EmkL8KeT7dvjmYaXRPd
         q8YBuswbmuKn/5JnDYn9mW1sESUFDhp/Jf/xwZ+FPPDJCWPdbPMZ0VZJKoUbOilAT5Rq
         qm9tXkbEksi1A0Pf+nKrx0fAgkXqO/AhobrCaW/BMuFi1IahM5G4WvitoPY46oIZBae9
         l32oBHMOK1Q6Y+HyhMwajiFfiKwt2qW+c8Oqai+LJ3okrG2f8qJan1pkW89tO8JlilSB
         I8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MG7MJrexH0gnMoYgLgKBPqSLgvg/1vZ9DznhSRbZVZE=;
        b=lnWpxCVk5Y+mDPzK19cYE4pLzKDuw6M+8gExQ3hNnjFRyoXZNgBrLrKE3Mbbl+JDNp
         oYmtd0EPps+o8KrVR2U52BbOOD+UoreM1bP67SN/9ZLr3jaszMF/RHGvk/ATPuel9Yxe
         8H1kbFiX2lkKNd6/B8u1Biv26CxqxK12crwc/Ef7nnJ72AzLy2wDHwRFGMmOdpEhs41E
         JCc5Wv0MhKyqjkpuT6z3zuFkZrgo1ndAmAiCA97SdgMdU69mpP/1A1jyAVvLzOQcAKHq
         TT4d8AUbxlY7Qn2YGj+DGvnyml+T8ut3F1/Dr95Iy2Iw7RLaAsS0iltZIiFwY3++G5kk
         w4xw==
X-Gm-Message-State: ALyK8tLFdtKrW8SIaABjXbxFVQfbV5aNPj9qQlwJi7ShgAGUddntfdlc9b+1nfuntRMRMebhlVOVRlVvEEO0Ww==
X-Received: by 10.36.84.79 with SMTP id t76mr20559357ita.63.1467819066994;
 Wed, 06 Jul 2016 08:31:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 6 Jul 2016 08:30:37 -0700 (PDT)
In-Reply-To: <fdb0efbeb0b41c0d9976b2d66df90d2366f81ca1.1467717729.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
 <cover.1467717729.git.johannes.schindelin@gmx.de> <fdb0efbeb0b41c0d9976b2d66df90d2366f81ca1.1467717729.git.johannes.schindelin@gmx.de>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 6 Jul 2016 17:30:37 +0200
Message-ID: <CACsJy8DY=wRfMBZn75fqjM7i4JzRbr70OCykHU_KdjSXnLY6Pg@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] Report bugs consistently
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 5, 2016 at 1:23 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The vast majority of error messages in Git's source code which report a
> bug use the convention to prefix the message with "BUG:".
>
> As part of cleaning up merge-recursive to stop die()ing except in case of
> detected bugs, let's just make the remainder of the bug reports consistent
> with the de facto rule.

If you search 'die(_("bug:' in this patch,  you'll find 5 instances
where _() should be gone too.
-- 
Duy
