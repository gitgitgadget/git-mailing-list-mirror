Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D426C1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 22:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeIHD2r (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 23:28:47 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:34096 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeIHD2r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 23:28:47 -0400
Received: by mail-yb1-f178.google.com with SMTP id t10-v6so6026106ybb.1
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 15:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVOyNvq1FrKmexbKezcqjh2k6Sr0Ns3lixFpsiLj2AU=;
        b=KhhDqdfg5UpUMeo/gthV+LNQ2gHwwVfsCw5hNU4oQXAyzZ/A2wqlbM6WPk/eDyjsbM
         8L7ywfTbDkSJMek+KQEX6k8TvS5nCi4x1aalNztTf8PEtWRBKM79J6/JPpCf7XPIEe9M
         5pk8zPkGwJbluhtQBnDfa5aRBE2tYN76V22N6SfDtWNDR7y58oj8Anelmqucj/bEEYDV
         P/7XNwU1h7qFCH6Rh4SJJAx/MBc7+RPuqNWFLSA/6t8bMnkDywK4Ej2F3ppD4vbC8DkI
         trlkUGnx9q/6Jufz7BeJWQFHBeGdQKDWdtU5kudH1NwVr0+aoTLkevbOZuETFjWis0Qi
         iR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVOyNvq1FrKmexbKezcqjh2k6Sr0Ns3lixFpsiLj2AU=;
        b=fxPQC6qrXJ+PYZoB06Hg7D9UgCCUAxDjvk0QxJP7uVw3kUPO0cbRUqUEbO7vE8NWne
         b8lKT3vG7BihEbIdbSi9hA9eRXdGp2hf0gdr8e0kXBZCsL/O5Mm/mRW40JEz7sxJeJWS
         ml26zFAJ1V3wi2sDJW4hHSXC3X+DOxidV5B0QLIk1VgM7DXNPIaKI+aYREwYEJytAAiT
         s6SZIGHlRAFDoxHjawB1LPqva27Le3bCTF9xKANkgzehdyNHw3CyvYNQnMMpmZXXEGD+
         icBv6VjCOkG8OAFY7DbcaZ2vBmgLzD/9Q3ADiTkdYF19Ud89SmzwsExatPEDrkK1p1eq
         6DwQ==
X-Gm-Message-State: APzg51C9rd+1TmkGiWzTcdL6cjeIBU3rG+AUj0Y56Cur22zL5W9snV4X
        BPHzjz8wMEOyieT6AcQCixuELna2S7qumeseG919ag==
X-Google-Smtp-Source: ANB0VdYrLDHb8ROgwds3uW7+Zst/qb/laJWK+8nn3Rx/FD2Jpjd5LoDgSaXS8pHg3IUUlww2vGG/mOfeb49h9pyR374=
X-Received: by 2002:a25:608b:: with SMTP id u133-v6mr5291300ybb.191.1536360336214;
 Fri, 07 Sep 2018 15:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <2659750.rG6xLiZASK@twilight> <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
 <20180907223515.GD103699@aiede.svl.corp.google.com>
In-Reply-To: <20180907223515.GD103699@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Sep 2018 15:45:25 -0700
Message-ID: <CAGZ79kZvuGEPOSTUqT+y6nxs6W5qaP-BbHT_WQQE7+n=RVNsrw@mail.gmail.com>
Subject: Re: Old submodules broken in 2.19rc1 and 2.19rc2
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     allan.jensen@qt.io, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 I think we
> should revert e98317508c0 in "master" (for 2.19) and keep making use
> of that 'second try' in "next" (for 2.20).

Actually I'd rather revert the whole topic leading up to
7e25437d35a (Merge branch 'sb/submodule-core-worktree', 2018-07-18)
as the last patch in there doesn't work well without e98317508c0 IIRC.

And having only the first patch would bring an inconsistent state as
then different commands behave differently w.r.t. setting core.worktree.

So for this release we'd

  git revert 984cd77ddbf0 e98317508c 4fa4f90ccd85

and then can

  git cherry-pick 4fa4f90ccd8 984cd77ddbf0

on top of sb/submodule-update-in-c, as that re-instates the behavior
going forward.

Thoughts?

Thanks,
Stefan
