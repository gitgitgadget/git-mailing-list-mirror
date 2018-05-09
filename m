Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4CF81F424
	for <e@80x24.org>; Wed,  9 May 2018 05:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933702AbeEIF0B (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 01:26:01 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:36090 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933383AbeEIF0A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 01:26:00 -0400
Received: by mail-ot0-f181.google.com with SMTP id m11-v6so32610026otf.3
        for <git@vger.kernel.org>; Tue, 08 May 2018 22:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=22fnNfRAYi/9r1uAZhTo3/04wn2PMXaJv5motg4OMy0=;
        b=NRP7Ub9SuaHAVfIl2RtMjPemQssQHPeKQS2REpapUPRkZmqLlDcq+0qacCSlcs/u6Y
         OHX3JEdWTca5kuQKuG1VwHFnMGO6rQuK5ztAWv71rzE79/SklNDPt8p1r+iT9jqie6EZ
         54cTVjXqxdxlKQBQ0Q/A4guv3Qx0CUKzvmcEvRrwGsnjzG/JZ2gLXUNn04xmDOFhNr9J
         XzTYfbJ6ELBRgCjjYDZWgxuw32xlG6PJ2EGGRmMsOxC2apw1BQxRDFzcfxeFJ2FxathK
         5yXrpUKeFMidAq6Kar3KnJzXOwHY2bFQB7ChOAeu2YQ9wwvTIDMO8IhQOsYR9O2yMcC2
         a1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=22fnNfRAYi/9r1uAZhTo3/04wn2PMXaJv5motg4OMy0=;
        b=m0Bc0VPHQCAHSnBVPr12popQUM0lWEKMSzYLP5o34UVWQgs7CU8K6gAIGqrU14TjND
         tqe+ZVQ6hzcxXeLNWu70fFw2RCuDB8W4CYPtegO7lirjeqMt8XUbS3TPkqLUeDSJ/WU8
         InnQhry7B3C7i4GhiwpVPAEe9sjF1/rLXYh6A9dmhiM1eFzcKCv69HXnUu2mWb3kaDvD
         z+GCErh8+YQtJg3kK26A/TbZKNP65zBr4dgHeycDyRm5PYCMi9pAYH1q+er2zPZz+Pzt
         GtuO+SaxNepTOFHYE/tuk6WStSYlpAoB6gqAtvpFOKrjHJRrzE2xqXjumCS+PAUs66Eq
         /wCg==
X-Gm-Message-State: ALQs6tCYyb/9wB17XRCzDre+WsxpwdYzEQ+OGO+7JLumAD43DU1vG9I7
        0k8AWCodnU6j48ooxp2xLrwbhtnCig==
X-Google-Smtp-Source: AB8JxZqpaAYScH6DWPEyXM73chPT9soxOBj34eV495sRG0k4gSqR0pg3HxCXF4Hmwg0LnI/WAH4Hng==
X-Received: by 2002:a9d:422a:: with SMTP id q42-v6mr17014212ote.42.1525843559793;
        Tue, 08 May 2018 22:25:59 -0700 (PDT)
Received: from ?IPv6:2601:646:8882:d798:99bf:25bb:ed44:e5b3? ([2601:646:8882:d798:99bf:25bb:ed44:e5b3])
        by smtp.gmail.com with ESMTPSA id l67-v6sm7538525oia.56.2018.05.08.22.25.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 22:25:59 -0700 (PDT)
From:   Leslie Wang <qiwa@pensando.io>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: regarding fix on "git clone $there $here"
Message-Id: <2F384E33-2101-4D90-986B-FAE2FC2AD7C5@pensando.io>
Date:   Tue, 8 May 2018 22:25:58 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.5.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git experts,

Recently we try to upgrade ubuntu from 17.10 to 18.04, then we found one =
inconsistent behavior on git clone.

At 2.14.1 or 2.15.1, if I run command like=20
 - mkdir /tmp/111
 - git clone git@github.com:111/111 /tmp/111

because it will failure, then /tmp/111 will be removed automatically.

However, at latest 2.17.0 which is part of ubuntu 18.04, seems like git =
clone failure will not auto remove this folder. I notice 2.16.2 and =
2.17.0 release note includes this fix. So just wonder to know if prior =
behavior was think of bug, and this fix has change the behavior.=20

 * "git clone $there $here" is allowed even when here directory exists
   as long as it is an empty directory, but the command incorrectly
   removed it upon a failure of the operation.

Thanks & Regards
Leslie Wang=
