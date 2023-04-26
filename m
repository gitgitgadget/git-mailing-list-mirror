Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C083C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 21:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjDZVQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 17:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZVQn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 17:16:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEA4E51
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:16:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-506bf4cbecbso11364623a12.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682543800; x=1685135800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8vIQ3HPml87s/vAXMlV0QB3XlEu6RAzSrlYW6egOhk=;
        b=SLvq+adD6y7B8lnssJJBdHz5W1zpJEWnN44Mzfe6j6QBUb1Ykuxv5FBLTUPh1Bx9EN
         nSZispzfNQ982NF4vMpBcpe21h1fa1V+JcM+2GMzBvbXiQPrAzI8l5FYxAK3c9ffxwWv
         XqLWlm/12yphaUMxdQQcPVOex7zmNdW+aT4uuSbvRUl1JQU82NjCcQdyCh+dBMDYZ1Bt
         z17bcd+rCTYAlHV33aX9+c0FNrWNj26D6agMHB/eBYqryQsnGE8uToX77j+W8ldpzfhx
         D4Gec9yr0fQ4XEUouRGEH+l8Nbp+nQ3LEDObxfLPYzLG1C5zi3W3RlR3q6zIpKc84xoI
         wtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682543800; x=1685135800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8vIQ3HPml87s/vAXMlV0QB3XlEu6RAzSrlYW6egOhk=;
        b=bdzJRaOE0dxwYchv4GGmnx1J/k+oPhNNDXhYHu3bNMqSqGpoMSx4W6WfzWl10XVd3G
         oeHrEAlqxgvLAbzFjSZ7YjUohLE/mgYr1hodwa8mOQLZOne4HRGGR6AcLQXiEu02kUSZ
         t1U6n7aK6yjlYbNVN72lDWMfwYCGjUyin3FDxqYpzOPhldXmBPhEgT/wQAJyWgQs0Z58
         U9JICJgnab2uMguiFtwm/gjEFk40jq4xKEzu9ZUcobtr9cXy4fDflPjyUIhkcTyAWTT6
         WcLj88P0tCaGlgvgduIP32CbVKEqD8ZGOqTAmXaNAvT2IW7M+ho62LeVqwSSTB//zSZJ
         PCug==
X-Gm-Message-State: AAQBX9fP6Eis2xaKQskyiBHPvlQ/N9svrEzgYjPFS3b7CfOCA0INwIqR
        L60f7upDkXdueU//AQdvc0LXOtiB8xewVPgdHlI=
X-Google-Smtp-Source: AKy350avbm9MRoNkYatR3736nVP+itljuDqtAq30Imk1G4xWdk8Lau4z+DNzP4vWo9DTSU2rg+j/sI0OSCPNY7/GFeU=
X-Received: by 2002:aa7:dd0e:0:b0:506:bc1c:5595 with SMTP id
 i14-20020aa7dd0e000000b00506bc1c5595mr18688322edv.31.1682543800218; Wed, 26
 Apr 2023 14:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1485.git.git.1682495081131.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.git.1682495081131.gitgitgadget@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 26 Apr 2023 14:16:28 -0700
Message-ID: <CAPx1GverCci3SZQEMvFX_q7r3XSTKmPizfcj8QcvGNud7reY9g@mail.gmail.com>
Subject: Re: [PATCH] revisions.txt: correct a mistake in dotted range
 notations section
To:     Pooyan Khanjankhani via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pooyan Khanjankhani <pooyankhan@gmail.com>,
        Pooyan Khanjankhani <p.khanjankhani@digikala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 1:00=E2=80=AFAM Pooyan Khanjankhani via GitGitGadge=
t
<gitgitgadget@gmail.com> wrote:
> From: Pooyan Khanjankhani <p.khanjankhani@digikala.com>
>
> Insert a missing 'not' word in a negative sentence.
>   ... but are [not] reachable from neither A or C.

There's a peculiarity of the English language here that means you
should not use the word "not". The actual error is using "or" as
the conjunction, instead of "nor": the construct should read
"neither <alternative 1> nor <alternative 2>", and it means that
both alternatives are rejected.

That said, there's almost certainly a reformulation that uses
language less-confusing to non-native speakers.  Perhaps
this is better (I haven't actually made a commit of this, it's just
a diff in place):

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 9aa58052bc..5460820377 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -305,14 +305,14 @@ other, e.g.
     $ git log A..B C..D

 does *not* specify two revision ranges for most commands.  Instead
-it will name a single connected set of commits, i.e. those that are
-reachable from either B or D but are reachable from neither A or C.
-In a linear history like this:
+it will name a single connected set of commits: those that are
+reachable from either B or D, but not reachable from either A or C.
+For example, in a linear history like this:

     ---A---B---o---o---C---D

 because A and B are reachable from C, the revision range specified
-by these two dotted ranges is a single commit D.
+by these two dotted ranges is the single commit D.


 Other <rev>{caret} Parent Shorthand Notations


Chris
