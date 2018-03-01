Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007291F404
	for <e@80x24.org>; Thu,  1 Mar 2018 23:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163566AbeCAX53 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 18:57:29 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35404 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163564AbeCAX51 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 18:57:27 -0500
Received: by mail-oi0-f47.google.com with SMTP id x10so5871796oig.2
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 15:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jBY8J5n/BVfodMQi8huxb5PnUEV4b31I00YEbViC0Js=;
        b=aIiSeadKIXAoVfWLSaYSmICzRScO8tOk+fSTfbHOMG/JcJLQ8ha3yprNkrOiVWomT8
         NharSQlSQ/1+7H/wcgP0J+X9BlzStY8iaL0QhbkWXIjeRbwPVrmnUZ+3RZhl6owZ8mkA
         e8R3Mau8v10XgKkOzqBZiaDCX/I8QssKmiCvTkkQCa5x/OaVNxmqJ+ZPOjc4GXo9QkbR
         +rri3K+nxYctoXqB/+Z5G5stuGun2l6BRqDQC00MyP+Ry+3TUZ9xIl0j7bhDqo26K0hM
         yzZI6QrYzNFOnr5KadsWAdZMitIfB2jNjV4s725/Hdew7b2FwcJFynTWClFLojeaGZ83
         8zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jBY8J5n/BVfodMQi8huxb5PnUEV4b31I00YEbViC0Js=;
        b=qa8kSYiAxshJrJhlcvAKq+3767NiOfO4Evkb/NcI3yKJORb8wLoPwmRyYHmqo7PmAy
         2C3M0e6c5bDClz04xmrqFKrJxP7RlRlP/T8MZSgEvcdcVUlYJnmmoG6acPJQgqXHjOSR
         xp32OaM90aqu23JKOlaIqdKsNlPHvFVFycGD/EYrTAEhHeDT9+CMqI2h81+OHuaLGdRc
         SHbgiQxiKhVCO9b2MRmyP0SixwVDyGOks+HouvZSpUJ6yVXL1dUDq3+a/L3n4NvXDqpg
         Ja2eAwubE2Yc4MZNjo5YNlBt3PH36TMUFwpM1T2/bspt9VOZV6NUPgR8dxSLhtvl6i8w
         ITXA==
X-Gm-Message-State: APf1xPB6GxXrhgEP8J4km5n6Dze8srauXzttfpunXfbUKse7P4y3V0f2
        QkeRM6mbyuGVsauJunWLmVYf3Ky3T8O8En63xdP9QA==
X-Google-Smtp-Source: AG47ELvRaetrFxRu8gyjQS1QlYkKvFUeUBSgwkClB/QoW8wYJwhUFugfb9OuYPCJvMo9VNF8E0au0tdaA1V8weBNBf8=
X-Received: by 10.202.64.85 with SMTP id n82mr2523814oia.30.1519948647214;
 Thu, 01 Mar 2018 15:57:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Thu, 1 Mar 2018 15:56:56 -0800 (PST)
In-Reply-To: <CAPig+cTPFSbT7WxyoNEOSg=3Ft1pVzkgieGp44kHnZ9=NbYsqg@mail.gmail.com>
References: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
 <CAPig+cSGJhNR8dapLXN0TU8ZpTqi7m6OQf_cCGmHc9FLGcwNyg@mail.gmail.com>
 <adf7a7a0-3571-5b68-5d15-30a9067e3826@aegee.org> <CAPig+cTPFSbT7WxyoNEOSg=3Ft1pVzkgieGp44kHnZ9=NbYsqg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Mar 2018 06:56:56 +0700
Message-ID: <CACsJy8BUKCG-yiYX3ouMVa44iEo0swHpTkhW3ho_T0PCP81DSw@mail.gmail.com>
Subject: Re: Worktree silently deleted on git fetch/gc/log
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 3:14 AM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> As far as I know, there isn't any code in Git which would
> automatically remove the .git/worktrees/B directory, so it's not clear
> how that happened.

"git worktree prune" does, which is called by "git gc" and that was
actually executed from the command output in the original mail.

=D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2 did you move /git/B away manually? For example, you
originally created "B" with

git worktree add /somewhere/B g

then you do this at some point

mv /somewhere/B /git/B
--=20
Duy
