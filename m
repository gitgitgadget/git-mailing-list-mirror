Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34221F404
	for <e@80x24.org>; Tue, 27 Mar 2018 17:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeC0Rn2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 13:43:28 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36672 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbeC0Rn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 13:43:26 -0400
Received: by mail-lf0-f41.google.com with SMTP id z143-v6so34525942lff.3
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zjMYre1Ab5wkP3hKtx2P8jM/Gtb2CHfSnR3MYmCMeaM=;
        b=a2bWaUM4bJS/jefMJpXY3LN2ELqvgNk8y277bfKbvQ7b+0aXCPj8ZaJOKnZ34zb0b/
         HK3MAiyPcAD6Lx1aPJ6tuS+22ZtfF3D/g1IdFtgvhAXzpmBOBezhxXWSp1OOiuQi6Hrk
         9zCv/8bIciIlq5oXc+1my6yUwUaTj4orksjcZljBiEfzIqVRRLyfUgblE6te0TrQXqV3
         jKm6xNLLyTah43dv5VnJQ3RwSTlV/BYb+H61/0flRqT6E4zFPSJQ5RPRjZ7MB04toO9D
         Wq9Uj2ecmJYxv4sVjBQ23DNhE7Q6fsZkyUypS5wcFU8LoYoBLeeZSAsKPGFIdKAeLbGr
         VCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zjMYre1Ab5wkP3hKtx2P8jM/Gtb2CHfSnR3MYmCMeaM=;
        b=WAD3rPSmKyLRtwY8cHQhI7IdU03J0f9qUlivXU4IpdR2JqNk0LkjwImax4GFg+l26f
         mkBBo0ubWDeDzGlGq1oQESsBhpS9LUSSDoQCGizlKsY5PQstkNX5Y6Tg9CstyZLWzJNA
         v47zNyJq+oihmmkN6lXPn91nHUPmm6gR5NtSBm1WALeWGJSgId20NNjBB2RWrtEqdajU
         1eHGP5dLLgKf8kaFpmJ5+B84IYKF4gJrotGT5wtLobIT1QbRNVV98g81ObCkzR9GQ27V
         2Yp8LPbvKGYS8Qf0ROb1CKj9M8B40AMkXuNPawH7QZQ1nZmrkH9sFzfIt8iJqi5FJkzk
         /pzQ==
X-Gm-Message-State: AElRT7G7FvJUk7/mSevhjDSBxx8SGAllZjX9tTLpE71AbxOw+MWkShFh
        UrvYmV5ejvBn0cE0jbAQIzexa/SCMsF1EHcARd3l9uZfc88=
X-Google-Smtp-Source: AIpwx49JtmE+hhKsPgisN2OS6zp9J2h8Ky3ico550oR5A+DG9AQujeJe8wzxbrkMkrNdx4jb81+mzEDfxFwAjvD+oFQ=
X-Received: by 10.46.85.196 with SMTP id g65mr198638lje.10.1522172604587; Tue,
 27 Mar 2018 10:43:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Tue, 27 Mar 2018 10:43:03
 -0700 (PDT)
In-Reply-To: <2bc6f6a6-bf53-b87c-af02-156ad006a878@jeffhostetler.com>
References: <20180326143136.47116-1-git@jeffhostetler.com> <20180326143136.47116-2-git@jeffhostetler.com>
 <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com>
 <ad15ccab-088d-b827-a9fa-c83d397c3479@ramsayjones.plus.com> <2bc6f6a6-bf53-b87c-af02-156ad006a878@jeffhostetler.com>
From:   Wink Saville <wink@saville.com>
Date:   Tue, 27 Mar 2018 10:43:03 -0700
Message-ID: <CAKk8isp5NncyDuGNhWctQfmjToWa8nAzHODi7SjbUW2i2R4kiw@mail.gmail.com>
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON format
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, peff@peff.net,
        l.s.r@web.de, Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> the leading spaces are required in this case.
> the pretty json output contains 8 spaces for that sub-structure not a tab.
> is there a preferred way to denote this in the test script?
>
> Jeff

I've used "git diff --check" which I got from Documentation/SubmittingPatches.

-- Wink
