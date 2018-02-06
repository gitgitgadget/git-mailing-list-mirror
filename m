Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7628B1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 23:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeBFXVA (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 18:21:00 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:42458 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbeBFXU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 18:20:59 -0500
Received: by mail-yw0-f182.google.com with SMTP id u17so2606623ywg.9
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Y9MeachahMVtSaDIVMcQv+c7uMkpW+N7PjxIEddmTs=;
        b=Tslu46h5LvAaXqJd04EuHJGLVQgZEOqH4QI8VXYFH/gtZ/J+5OSy99zB9qm1Q3oOv6
         BNJdR0FWRidGtII7QqStSY1cbYP6F1ZEjbX6LMew7FuNBdteZaE5Rfh0U6JHjH2t+pOe
         CESl2/WkhRRQGHrfTmcVmdtftYY9CN97FFL8xXNJ6AKtXE1csouqtEHOimH1Rcy9p38d
         sAiLR8UfOIhel8lQq1XkTd2EzEupB2gFDIahvhaOVD1qDVcnR580ueOX5vLQIrNwqXQ3
         KTJfdsBrkV3WRWHePPgrnJq10N+crLhp3XP9z3jaj1TEnpOzcZ6Pb2QJPRgYwVKKn+yB
         ejAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Y9MeachahMVtSaDIVMcQv+c7uMkpW+N7PjxIEddmTs=;
        b=F1G1c7ph7uNRIs6tKrOzhS/iTy1GFRYtbp+zDQLT/sUDH5peDhnCo7FsAdfwYVDpwE
         MalmDr9caMXwHzBc7vKCjkWoNfEoITT4/NXMI4h4L/iYwIG6FJaat1ewJvUQvqJvKtcc
         kpCnaY3PZ5LqfWGNNGzfS9f5xAZ/AQILUV4cOezMh3IGnYLt7zJa7lsCmqZR4guPZuNx
         pV2S4DFJ4+4GI3T47ceJfSAT1ba5iuBE/ZEDQ+aKYPhHrEYpLcMrdPG7ZQU11XuW91yh
         IRYShlJz6/76VHbx/EcxCBtGgXN31kzAwvfYEp2eJjuqhwQEo5cYa85islKXc2Yvpvm0
         p16g==
X-Gm-Message-State: APf1xPAK4n1dKua2uTfxL7+Kt9m/f+d0tIUcnhR1yu7ZQGIvuJstTLOJ
        6eBNoAtmnyC6qDJCmqfxmDmGuVHncgtDGa0ehULUhrFfTpA=
X-Google-Smtp-Source: AH8x227lk7NJJcEuH5fMff/wg0e4kVjVnvT8/PowUXu7SqVJ0htAZA2g9dbFcEujcE+z/edGkZPIlmrbrCGDOHQSwWI=
X-Received: by 10.37.59.204 with SMTP id i195mr2775543yba.420.1517959258521;
 Tue, 06 Feb 2018 15:20:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 15:20:58 -0800 (PST)
In-Reply-To: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
References: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 15:20:58 -0800
Message-ID: <CAGZ79kYstN9ATPGKZjnk-hJ6jRsx9Oz0b2hQ5cTiqVqMNDCsyA@mail.gmail.com>
Subject: Re: BUG: fetch in certain repo always gives "did not send all
 necessary objects"
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 3:04 PM, Elijah Newren <newren@gmail.com> wrote:

>
> Does anyone have an idea what may have happened here or how to avoid it?

According to Peff this got fixed
https://public-inbox.org/git/20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net/
and but you've had a corrupted repo from back when you were using an older
version of Git.

Did that repo exist before d0c39a49cc was rolled out? Then we can keep that
hypothesis of "left-over corruption" as Peff put it.
