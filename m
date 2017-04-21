Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840381FAA1
	for <e@80x24.org>; Fri, 21 Apr 2017 22:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426048AbdDUWKG (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 18:10:06 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33132 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425929AbdDUWKE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 18:10:04 -0400
Received: by mail-io0-f177.google.com with SMTP id k87so137148934ioi.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1gk4VSsMi+ADClOqc/lu/IEbTbdmcy8Xh805q2gJ03k=;
        b=jkWjCdcXTilfdY7jF1UKFHFxZ1z/I7m9u7sdQMeqRMXt2ZJkZG/ePRycWCe5nJZEim
         sBowIh3N/nzygR+MFQwzFDiaXNy1mQqd5hWtUf1fnYovUVapoSQzjFQaNhFbw7SCs033
         57lTZiK+o++phMl7N7xALQZ77/x+3SA4ZAnWi0bMRy3r9m5sqppxbV/jVo3KxlscvSaw
         G9GjloqerLaXHoSXX6xk4p7VhSg3uCzUeU9CKPv7BHWLLhKk2y6gQpw0DMxW2GhrWD2j
         96KQFZ72BTgAzQ3qYM5Imr7BDiIPSZ6Swy+dOvm1IpJY4mIOLH6V7uuS/eoddSMC5ZID
         oBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1gk4VSsMi+ADClOqc/lu/IEbTbdmcy8Xh805q2gJ03k=;
        b=qg4uL+Y4V2XfhGLdWP3aB5b8c/cEOX2rp0+xzdM+QduyzrYKB4TtfI9cbqPu8OzXY7
         LbueXGmjDx5749nk4Xtg1vWl8OBDYl0Xi744pdwajqQhrZzLBjs3xMb7tIayzvbB2/8c
         kHLi9XlWDLT/uxeC0jOMya2OD3khX6F88rR6dpuSk6w8oC2ECBKx5gY0vwG+P/iovymB
         F8edblt7pJv7s46tvcbopvX9rlSTRjGdXcM578vTBsI0XgEA3ARp3QSG3mKWz2IPupoC
         rxD5YxVCO4on/ATJaxCTWADoXm0VwOqe+bhsdO+Mi00k03zpRW47QlJp2mWkCHRS8zOL
         a/KQ==
X-Gm-Message-State: AN3rC/4Fc5Ye5ECcmK+QSQ4jswn1lOt48DuOdDvxkcayRitY5NQSYAYP
        +zCj9NNmipush8vD517eUvohyuGFYEds
X-Received: by 10.98.72.88 with SMTP id v85mr14353442pfa.8.1492812603559; Fri,
 21 Apr 2017 15:10:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Fri, 21 Apr 2017 15:10:03 -0700 (PDT)
In-Reply-To: <20170421220155.GA142345@google.com>
References: <20170421220155.GA142345@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 21 Apr 2017 15:10:03 -0700
Message-ID: <CAGZ79kYBgvzkO66pL3buffAChKtPu2Xt5Q4FUoiijYHj591aCg@mail.gmail.com>
Subject: Re: [GIT 2.12.2 REGRESSION] git cherry-pick -x
To:     Brian Norris <computersforpeace@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+Jonathan, who worked on trailers

On Fri, Apr 21, 2017 at 3:01 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> Hi all,
>
> I haven't tried bisecting precisely, but somewhere along the way git
> cherry-pick -x regressed between 2.9.3 and 2.12.2.
>
> Looking at upstream linux.git, I can do:
>
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> git cherry-pick -x 7b309aef0463340d3ad5449d1f605d14e10a4225
>
> And see the following ending to the new commit:
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>(cherry picked from commit 7b309aef0463340d3ad5449d1f605d14e10a4225)
>
> On 2.9.3, this worked fine:
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> (cherry picked from commit 7b309aef0463340d3ad5449d1f605d14e10a4225)
>
> This issue doesn't happen on all commits; maybe it's bad parsing looking
> at 'Signed-off' and the like?
>
> Regards,
> Brian
