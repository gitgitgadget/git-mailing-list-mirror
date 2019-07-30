Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65CC1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 17:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfG3RYe (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 13:24:34 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:44770 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfG3RYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 13:24:34 -0400
Received: by mail-yb1-f172.google.com with SMTP id a14so23452242ybm.11
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yYmevX3Za63Y/cCJ2EgoaSU/cXqQUoN0YczPB3AI7No=;
        b=f+/sRFdJsLNdgFglQ4lSrEZgkYPw80Sm3bjOPyBOKLVlgGi/YyYDOto77c3YRUxO5H
         /YDKT9vVpB4xaRSajz/o2UwSEedPZ9V1o/CmHBOAZXV4VqAe3yRsUThUWfeujd4DMvhT
         rTQqPGHTsoKmSBLe3lKEMnacCGqMh28++8o/Pyku/vT/rbJWjiJeZE9qT8tNA/UpV/Cr
         8/TzXy+17niQPKmNRunGMW5daGgtMnh6EYHNVXmE0s7Y5sSli2i42p2bCW0GFBgfshbh
         FyR+x9SBB6ZyDQEzNmNonxcr1qdQRuPp7UKEZ5d4CRtZ8pG01RMXj3NonhJ1pwHZFJnu
         Gptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yYmevX3Za63Y/cCJ2EgoaSU/cXqQUoN0YczPB3AI7No=;
        b=U9i2Nl6yVU/cehfUUNqu1jilRPQyhMr6LzY9EfBppIMOODfTgKYCgYnia/+7cuiFkG
         oPAbZD/JHDsdrd6NpGop3NDsCvTKLm0Ew4LrEgcX9/Udqg5VcpLm6tdFcZxs4lHT6yZz
         H89udaAT4GqGMgBdGDtrkqISQbGx4KzoMXZU+jcTVnb90gL0Rm2hGJNEbwtW0cN3+b+m
         cefKNGlKTGVi2gXEPi2PwBu5F9TsPJJ4C2gpqlWoQJy2ABVRbk8LTfdjAs6Xu1HhIwLE
         NkdLk4CrzzdHN55SE7W0dFST+8aVTybHDIr40lWYKH4qvzgNz/lFpQpdxCMb7hQI+wR7
         lPmA==
X-Gm-Message-State: APjAAAWMJFZY3DpjAkyw5VZmLOVHU2Q+RGFraiKY+M/04osaxcaeh/f0
        7oIDR7RNURpW/EZI3HV78lEdTTkpYYugeRJOEcwdn4UA
X-Google-Smtp-Source: APXvYqwYkI/i3+yOlaKEh7DCj55lmhfm04yDzo2/9BewYG5McFlyTod4phl+mdPgNo1fb7RdjaoqeN1fJWEIbH3+evU=
X-Received: by 2002:a25:a1e4:: with SMTP id a91mr40478015ybi.122.1564507473155;
 Tue, 30 Jul 2019 10:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAP82knNJ7YH30R-Z61ake58qERp--6hdvgGasKpHQ2TbMPraiA@mail.gmail.com>
In-Reply-To: <CAP82knNJ7YH30R-Z61ake58qERp--6hdvgGasKpHQ2TbMPraiA@mail.gmail.com>
From:   Andreas Wiesinger <awiesing90@gmail.com>
Date:   Tue, 30 Jul 2019 19:24:22 +0200
Message-ID: <CAP82knOVE5RbcDbD-SqbkoZ_4qubi96n2p3M_vgc4xGFVwTpMw@mail.gmail.com>
Subject: Re: [BUG]: Destructive behaviour of git revert
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

git revert for merges will mark merged files as deleted and commit
them as if they would have been deleted, but that is for sure never
what anybody would expect and has deleted many files unintentionally
and unrecognized in our repo shortly.

I have reproduced this issue in a very small example repo here:
https://gitlab.com/electrocnic/git-revert-destructive-behaviour/tree/master

Expected behaviour would be:

A reverted merge should never mark any files or directories as
"deleted", and merging the branch where the other merge has been
reverted should not lead to the deletion of those files.

I classify this behaviour as really really destructive and clearly a
bug, even if this behaviour is by intention. It should not be by
intention then..

Best regards,
Andreas
