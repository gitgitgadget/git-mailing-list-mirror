Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 133AB20191
	for <e@80x24.org>; Thu,  4 Aug 2016 01:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbcHDBLS (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 21:11:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34076 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbcHDBLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 21:11:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so39161201wma.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 18:09:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=lDhGIXdX3ME/Y7q+sre8HJUBypZ4Wz1NgCVWEo7IR/s=;
        b=hN30bBjIufgJhIh6nAKsngrbhaPAYtBiSMtHxFqvS3ZO4G1Cbqi+mrA4eP2o8w9LUE
         5ziouLVdiR5K8/DAjU53F980f5CEnLqsIzHfOUyWE9fki3RgAcwlC4hdQ3jqUWU/u1zR
         CDR1z5nZOYBgsA9ZTmvB4HExD8dojfVc/US8BMytiWSjDhEhWRr0JBpS3c51eS7i+L+c
         KoAOf6Ol3AYFB2oxtjzqFzCSGNUykIZblS2N92vdKTKzGkfMwxm+prL24NKa4gN96AFC
         MDVE3ESrybWIIzS/TG7LQDIrsAlQbTcCvUbFShHTOnhvydp/JfHtiBTYotFmWtsQpVA8
         TgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lDhGIXdX3ME/Y7q+sre8HJUBypZ4Wz1NgCVWEo7IR/s=;
        b=gerGhXZhDkadXQWnczH13az4TzZM78F3xSBrHh8kyKPwDsEpgdWFvanqdy+mowXbKK
         V6DBUcywas0t51UCS1p+sth260e1VaAXBEe+QiO520JtFTaj7JucOWcfuRnqEXxElQza
         nDn2TsFbYtQF4EMmEJ6US3p61n5lBXGlheLiPWS1zJ2GKM/stadzHAM7niKeb+FX8svo
         egiDAAfsyjtdEbWngIT/tkfCzQkeH2x558KdpN9zFctZZxRa5UtdOOlLPS8oRfLYZSQN
         5YDtUjJM2VVSft+Kr/NfU2ZuRT2+I4Ybihee0NUXRh+Z9rwza/kNCLnrdI6YEPnFO9A+
         90Wg==
X-Gm-Message-State: AEkoous9Kod2P1DXOmDddgho75tzVAs8ed1owrGP+byf74P3t5stDIF+zQWmyzEKal3WZc3JIHi4eB4kFz6flw==
X-Received: by 10.28.35.86 with SMTP id j83mr66185982wmj.18.1470272991131;
 Wed, 03 Aug 2016 18:09:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.124.228 with HTTP; Wed, 3 Aug 2016 18:09:50 -0700 (PDT)
From:	Britton Kerin <britton.kerin@gmail.com>
Date:	Wed, 3 Aug 2016 17:09:50 -0800
Message-ID: <CAC4O8c9uogrxVX-rqkdt9mL+afOsvSs5=aZCzuPmfB-z-m_3sg@mail.gmail.com>
Subject: refactoring a branch with e.g. meld how?
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I've been asked to seriously reorganize and compress a big branch (75 commits)

What I'd like to do is make branches foo_flattened with all commits
and branch foo_reorganized
starting at the ancestor, then work by incrementally doing
meld/commit/meld/commit/etc from foo_flattened into foo_reorganized.

I hoped to use git difftool -d foo_flattened foo_reorganized, taking
advantage of the symlink behavior on the right hand side, but it links
the individual files not the entire working tree, which isn't too
useful since a lot of the changes introduce files.

Is there a git command to help with this or should I just be making a
copy of the entire foo_flattened tree and work from that?

I recall running across some command that I think was supposed to let
you have coexisting working trees of multiple commits or something,
but I can't find it now.

Britton
