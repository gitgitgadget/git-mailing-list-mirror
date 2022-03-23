Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ECEC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 22:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbiCWWQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbiCWWQM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 18:16:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EDA8F98C
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 15:14:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id o6so3812973ljp.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VrXfTEeUlFP0PUrFGS8cwzoeuUgOtg/+z2YuSleGZOM=;
        b=kkAV+CNuYo6KQP/XkWU+baxJg2dyXPL/2CL9ehHEFexS9AlXc2kJqJj8y5UxdcB0x5
         GCDU5Yze0u06Gr0ZtY8r9kuX7NmQuu317nDe7bEsmxwB/tRlZpAx76R3+69PqcJ3ah6x
         FvFopcHDW+R+0W5wZQxEuKQXY1Si7Bs/9EoaHJmg3ymziHAyLcKj1lTQfQARAOODxho6
         vYgRZzHf4XlttxMjWxwikkmAeqnUxNDBBrGGZA/A4YcnMMna1bds5IgBDleyQ95O1YPj
         t1issqojWJ+8inPOSP6ZeCZ7pmRiWkL0tHWlDDs3juvs0Qh9holoIX6Ay2Y7bk85Dbdl
         YmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VrXfTEeUlFP0PUrFGS8cwzoeuUgOtg/+z2YuSleGZOM=;
        b=eBofzlq2OBchosON6ggRfvXmF78EM32ZslbWo+aWdEo5Q50gxLeM7oVS9E9CgUxbi0
         GJj0NFivHua+9C17IF3DqiiRHEdyRiT656pHN0qmvkiF9cWQQARv5g8UlMsg0E6oUuy/
         5hDm1NpRffUIaqqd7NoIJw4co3sDdXbGQCyZZRKB/pwSeEr/eGSSFNNP6Ofb1bAQuPxo
         vZWyf0gVWionzIAY6Wig7J1ybWK4oakay8v/x+0BEk9dz85RLrkeZzo2SqTiB3/4FdGw
         y337l4tqqEMFL6YSFgDnLUhTTpo2RLZBHdyXrxHhjKZnDu/X/8vKcuRpWIcYqVyQ4iQK
         bCtQ==
X-Gm-Message-State: AOAM532unzoi5p/eY/CVj0nG+FB6hbMCP8kiXHszQWoyPWXEJcpFTdgX
        GApPDiG8FRT1yRnc4dnkzzauZGEfWva0bHIEsW/6J0UOpkI=
X-Google-Smtp-Source: ABdhPJzGw/NDDljALiTECgnODLf0UbeJLT3GuK59xoeyWwYqexRkDmBpBemGN4u0K722QUCwXj8vMxcBR5XucDqVsIo=
X-Received: by 2002:a05:651c:1192:b0:246:1d6b:d323 with SMTP id
 w18-20020a05651c119200b002461d6bd323mr1777166ljo.360.1648073680782; Wed, 23
 Mar 2022 15:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHGBnuPavzr_gq0ake6bOQETmHBnU2XOWdDz-UtkBP_+rRdYfA@mail.gmail.com>
 <220323.86o81wonlf.gmgdl@evledraar.gmail.com> <CAHGBnuMRKhsF-xCL944KD5GFPWYe-9cSp6FBZfaZ7bdVTkgjng@mail.gmail.com>
 <220323.86bkxwogxs.gmgdl@evledraar.gmail.com>
In-Reply-To: <220323.86bkxwogxs.gmgdl@evledraar.gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Wed, 23 Mar 2022 23:14:23 +0100
Message-ID: <CAHGBnuMjRNiHr+V7Vc6N72CFbtVDmTapf3w1vn=1TOPB89W0ag@mail.gmail.com>
Subject: Re: How to determine the number of unique recent committers on a branch?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 3:57 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> But you *can* do by grabbing the epoch from the tip commit and doing
> some basic shell-math on it:
>
>     git log --since=3D$(($(git log --oneline -1 --date=3Dunix --pretty=3D=
format:%ad origin/master) - $((60*60*24*7*2)) )) origin/master

Thanks, that works!

However, as --since works on the commit date, shouldn't it also be %cd
instead of %ad in the format string for consistency?

--=20
Sebastian Schuberth
