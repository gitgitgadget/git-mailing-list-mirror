Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4F21F404
	for <e@80x24.org>; Fri,  2 Feb 2018 02:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754560AbeBBCO0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 21:14:26 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:44734 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753654AbeBBCOX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 21:14:23 -0500
Received: by mail-yw0-f170.google.com with SMTP id x62so12073880ywg.11
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 18:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=UBCfpkOtHOgLQW3dxrwX1CFOARuCGulWAJVaM1ZIFgs=;
        b=DiHpXoEcd/K5++F3zByAjYfzxR+GEYJmvpLJ9IQPBngMtMxHVUiG/ELtDjAjqyvECg
         EjbzhJ7w6y2Axi6tE2H93nhv6Aylc7u7wFz0ddcJ4Dslhd4mJ1sPayk22+jzcUplEQpW
         5lWOub0GpLJIAJbQZ4JkY8Yt/yaqsATprnfCYXRFLataMwDozdFMzMCKNkfhRT+4Cpnk
         ibyv1WQIB5s7/Qh6j5/nyXakhlVHWHOoe7RV5lQnlt8DtYX8Zuo+v272WPdEMiPb7mKG
         8UwFNWG4rrShEql8zq0RYBucn5egMf2IbLn7Q24qQni4DF8U+M4Jm2H2gPcmW9MkzDl9
         Xs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=UBCfpkOtHOgLQW3dxrwX1CFOARuCGulWAJVaM1ZIFgs=;
        b=eJSxYz/j5lDa8vF9RwjOE3upVq8CWqQtzeFvHxA0Rd5pJZ6JN3Gu+X1rVmUgErMh/Y
         GDki/jDSpcoKmOH19DEhFnAV1k/2971DOQ9UZNSL/AOBmMzwVS1JdIubjAQyelk6yaEP
         UiD0cayvXOqEgz+uZwlxyUzRxxy/SsVyF4EtLIbqpbKuFz/gTXHKL2aU5AH7xlolTtz8
         ihsu9tKdeGlgOD8XbLDVaXY7NpCtp76AvyXTMFAtSi0CgBxwml5aXPXn2kgoWTOokYPC
         xB6TYyjnnPsQy4rvyD01POiwaLhMrOj9cFQfe2HfShkugg8rxSjNpHuFD0YyNhbQ0hPH
         HgSw==
X-Gm-Message-State: AKwxyteJhog5NiZ+UpXkLzNTKxtNHQjRUhfs6S63MCFjar9Yh8W5hJNN
        4itKy0TBu3AG1soex8viZZug0zEsXr4NeWggU3ZcduGj
X-Google-Smtp-Source: AH8x226GQn4rwBLkE+SD3GArAP0ZLyACVeNUC16IIREAXWGCPXIVm+W7/q0SVArjbUNW6A7qP+Hy15jzwitQ1F9Z0rU=
X-Received: by 10.129.67.31 with SMTP id q31mr27953805ywa.464.1517537662608;
 Thu, 01 Feb 2018 18:14:22 -0800 (PST)
MIME-Version: 1.0
Reply-To: timothee.cour2@gmail.com
Received: by 10.37.115.7 with HTTP; Thu, 1 Feb 2018 18:13:52 -0800 (PST)
From:   Timothee Cour <thelastmammoth@gmail.com>
Date:   Thu, 1 Feb 2018 18:13:52 -0800
X-Google-Sender-Auth: b-xWKfTzME4i24eV175yKs8lAYQ
Message-ID: <CANri+EwfsgS-s0TeeX0E6XoCnmCeq=CB0UDQ9=gjSXbe8C_5GQ@mail.gmail.com>
Subject: how to ignore whitespace changes with --color-moved (git diff move detection)?
To:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this PR from october 2017 was discussing a patch that'd introduce
`--color-moved-[no-]ignore-space-change`
https://public-inbox.org/git/20171025224620.27657-3-sbeller@google.com/

however not sure what happened since then as I can't find in `git help
diff` options even after `brew install --HEAD git`

it's a really useful feature as it's a common use case (ppl move
blocks and reformat in same PR)

If it's not merged in git repo yet is there an easy way to try out
this feature? (even if experimental)
