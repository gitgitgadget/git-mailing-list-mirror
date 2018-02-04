Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C131F576
	for <e@80x24.org>; Sun,  4 Feb 2018 09:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbeBDJpq (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 04:45:46 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:40913 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeBDJpo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 04:45:44 -0500
Received: by mail-ot0-f176.google.com with SMTP id s4so156174oth.7
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 01:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B/RDxaerazONJsalJbsORp0IjKyfahb+DYKnanXRaoQ=;
        b=cJCBj+EHGtT/l2kL/j0Pmn2DFgdXerTYaqqZyEPO91ZIKOBvYC2esA7NjAjniTy2Ie
         GYYEhCi1x1i0oRuC6Ho019b1qmLTtWDW4QSViN3hX2ftyiNxQNAoxJzpMdnVv2aIdQwk
         CO0lL7io2DQR6FeE19r8wzmki43M4vWqXpzCy+/UrUxfal8xksTumObXwXb+NEHm09KW
         W0rLJw1uJeHoR2uQj106oBdIEK1SS7pVmlxQiBTz9zYCsI2TPSrlhutRdGl2oP1jANcI
         i2cNgS7AxhTuOn20QYWwf1nHquJBdYiKOEof4fIPVMGXRqf+Wj1LOuB/433gRAZiI32w
         YegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B/RDxaerazONJsalJbsORp0IjKyfahb+DYKnanXRaoQ=;
        b=JrUboyRZeTmK83Q1CYf9venVmmfTEXIxu3ac6lM+8PwqEK4EC+eFnoBjfVn+F4ief/
         3MkfO2VUPkvy4/qSp5GaPP71hIKcprrb157zDPTQvZOa2ToPz2huRy0KrqiEz638jTgp
         LhHbnWGM/ecUMgptcvprbOZ3hgtb8JdMq3VBq8GL9nhTN9kQ+YoVGYrV6LnjYoSRHcBo
         6vx8fRo+g4RK/BeF6kJMxZucFaoZcycyluZtka8SEwHpUYdnlE30Acn7weISGYco9F7Y
         cmGllikLZ/ALd7KmxDzgW2Ik6/wcJ8/0kyUJ/18jXC1sPi4o9fM0xLx3lJfADndMERA8
         FKow==
X-Gm-Message-State: AKwxytdMR+N08y0Xyl1EaQBE0qG1b5OaG5ZysjNsUe8a11yc0v1v2Wxc
        uUjx43rH1fL9VDZGpmygao9QcAOwhf6RaWWSeLw=
X-Google-Smtp-Source: AH8x226OG5iNIXlJErJpElwlhONvFj2qjIIYvF33Yd8C1Z5gmG/h6WYF4ThfQJWlVnGJQ2Oti/Xl6B0AgV49sPgVACA=
X-Received: by 10.157.2.8 with SMTP id 8mr12090583otb.106.1517737544319; Sun,
 04 Feb 2018 01:45:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Sun, 4 Feb 2018 01:45:13 -0800 (PST)
In-Reply-To: <1e618c0c-81ba-fa7e-8039-748bdfa5a6d9@web.de>
References: <1e618c0c-81ba-fa7e-8039-748bdfa5a6d9@web.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 4 Feb 2018 16:45:13 +0700
Message-ID: <CACsJy8BKpniRxzDa8tOzEu=UVB0kMgv-n0tqZgp0Jreruqq-mg@mail.gmail.com>
Subject: Re: contrib/completion/git-completion.bash: declare -g is not portable
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 4, 2018 at 12:20 AM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> Hej Duy,
> After running t9902-completion.sh on Mac OS I got a failure
> in this style:

Sorry I was new with this bash thingy. Jeff already answered this (and
I will fix it in the re-roll) but just for my own information, what
bash version is shipped with Mac OS?
--=20
Duy
