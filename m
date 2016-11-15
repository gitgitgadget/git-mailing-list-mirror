Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C764B2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 17:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbcKORmR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 12:42:17 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36073 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbcKORmP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 12:42:15 -0500
Received: by mail-qk0-f176.google.com with SMTP id n21so144307906qka.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 09:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HMwUOKfDJueY8Ks9NzH4VP0gGpIzSpM8dXRfg0ke0lw=;
        b=AoL9krVVVCgzHKRAs99yC05MT/rRT7ip0IPGR/lbL00SiJv5BfdbAQehfu3rkD+3QL
         h2ollHMJpWr2A75ZpGNuO/Iv2igAXMjSOhLi9hpf64GfCuE/rvzNNKsjW4Bt4EAN60Nj
         QMwL3zyNya5yCUMl5QYPMW20RhG48m4BpnN6CsJJaxqCwLZefRlgz30YjuCpzXT8VOmj
         yEa2k0kca64+n1gS9ktiK06Ocd6Ffkbr/P3/wXiZuQ7SDbbzXxPl8/uZc1gfgOF1DEjB
         N8BmFRQso6KOhr0SdXcNyLv5TbMtYWr4HhEx0ywz7gmhyPY8tKEZ11ru6uP9lXFpAcqx
         oimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HMwUOKfDJueY8Ks9NzH4VP0gGpIzSpM8dXRfg0ke0lw=;
        b=HljT8WvcKMpxGRhKix+Kv/vGvKWKaCDzUxVKUOL135GQiJzRRqek7QuNP+28K1Z5Cy
         y4iHNO/g1oJJxUdUuWlUcuxH2yuIzW2b1mjnar6EWoVp0R8ZzombIRgNloqGE4tGJ+d+
         RHDqtM6FafVFJyYPboTcZHCKs2AbpL48Ki68LGbMs5iN18E5zCPtE7VsiIiP7reHKWPM
         PtpGtfYzyI6Mc3Jt+nbBBrV4u9N1PbYDcHEp3IZCMh4/0ZNns61inkHTMO1+gSmkAav+
         woU98zO6eyMWT+Pmsa/R7wgFA3Lli7Fy/2o7D7w8NWEWu5TWKslSp6taw+YBXf2n3obZ
         /rsw==
X-Gm-Message-State: ABUngvdnEVI9xp5iCjpZb/7v3d/OwC9aaa1fmm6CbrTOodDdKQEWj/gXXdQIykPaWuqHUObUCniUa2w4Unc7kFhz
X-Received: by 10.55.67.81 with SMTP id q78mr21172982qka.53.1479231734804;
 Tue, 15 Nov 2016 09:42:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 15 Nov 2016 09:42:14 -0800 (PST)
In-Reply-To: <1478908273-190166-1-git-send-email-bmwill@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com> <1478908273-190166-1-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Nov 2016 09:42:14 -0800
Message-ID: <CAGZ79kbiXYKBjJL75bkgAOC+STTKk0F=9TVafpcT-50+ZAcStw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] recursively grep across submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

coverity seems to dislike this part:

*** CID 1394367:  Null pointer dereferences  (NULL_RETURNS)
/builtin/grep.c: 625 in grep_submodule()
619                   is_submodule_populated(path))) {
620                     /*
621                      * If searching history, check for the presense of the
622                      * submodule's gitdir before skipping the submodule.
623                      */
624                     if (sha1) {
>>>     CID 1394367:  Null pointer dereferences  (NULL_RETURNS)
>>>     Dereferencing a null pointer "submodule_from_path(null_sha1, path)".
625                             path = git_path("modules/%s",
626
submodule_from_path(null_sha1, path)->name);
627
628                             if (!(is_directory(path) &&
is_git_directory(path)))
629                                     return 0;
630                     } else {
