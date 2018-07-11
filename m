Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C514D1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbeGKSFB (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 14:05:01 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:43631 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbeGKSFB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 14:05:01 -0400
Received: by mail-yb0-f193.google.com with SMTP id x10-v6so10370084ybl.10
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bW4TkSz8UMKxzltN3sM8YwvJ+B9a9nOcMeuwPVjEZn8=;
        b=k5xdM+3KJtDNneHZxMIa0X3a25bNx0Xz9KGqi0kUr/H9BhqRJMuy0IaogdpXGXNspJ
         71Yn/NjyD2sIHkfc6QSBqOwLGdXoWHBf+HNirneXe5JCJaqSVfVSlo8/MHPnsshhz4w2
         N90NLj/vfGNdFo7J6lhT78Vvps6L4t3ZUNE00GEOZChxEQetOSZQtqC7t+47zhChtrDb
         m0J/+8dIK3lzY3VS0SSCO87DVGuN6I2+4vVU8PUBl4LS3AorKivwMmOsnZBUUqRrCQzk
         iy47LDQsLcoeTN0es7b7/KB9KfBHAfJG/Udxk/ZGfqnfbknOLg3HJWWDngTIv/gxzACh
         nAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bW4TkSz8UMKxzltN3sM8YwvJ+B9a9nOcMeuwPVjEZn8=;
        b=fUVlPAoFNeKRQzi/Mz8FkCF+qY9Shpf/M3/3pZanxHQ1mYNL0AcUq0iedfEYK/HRdP
         QQPSGKia8tygGMku3LRoq6qlXdv4+e4jZhThIUdoV+vPS8DUYJcTH3P0IEMmfoPGMxyd
         XcGOxqCklMzE86Z5Vnw7mWd7znzPD+9D4eSIKAVbxyGz81B6bbdF+e9U7FibiWEygUzq
         3tL0ZzW0wq3tawUfw8Q5QB/FOeBlVPwtk7/Amvd7VSe3/rLn+gOH76UuRojg8WbPt7Z6
         gYtlprdqb5XyOEv2iaKYc940uPh+Uk4/d75kzM0p012jasvAgxbksYrBDTU2WJdYL/GL
         Qnug==
X-Gm-Message-State: APt69E0l9+Fe/4z2YchlsSDDCE9WVLcZrBX/H02X/VyueemhobhIYxy6
        SCbzdrPoA1fxWLUvyE60ecp4m/KK0dNiu2oNFTYNBN+N
X-Google-Smtp-Source: AAOMgpdQj3JMZuyWUKLSL6/HeQSHyj2WJdlz9UD2W0iUu5NxKXF+Bal9TCjRgPIYfNbzfF4lW7EuvM+/gdAw8rkKNGs=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr16066540ybp.352.1531331974109;
 Wed, 11 Jul 2018 10:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180711175420.16940-1-benpeart@microsoft.com>
In-Reply-To: <20180711175420.16940-1-benpeart@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 11 Jul 2018 10:59:22 -0700
Message-ID: <CAGZ79ka=HfzKprETBJ=+sdQsUZPXgHsgoqNWkbHprUGgLMggUA@mail.gmail.com>
Subject: Re: [PATCH v1] handle lower case drive letters on Windows
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 10:54 AM Ben Peart <Ben.Peart@microsoft.com> wrote:
>
> Teach test-drop-caches to handle lower case drive letters on Windows.

As someone not quite familiar with Windows (and using Git there),
is this addressing a user visible issue, or a developer visible issue?
(It looks to me as the latter as it touches test code). In which way
does it improve the life of a developer?

Thanks,
Stefan
