Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77969C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 08:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbiFIIeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 04:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241815AbiFIIeA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 04:34:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278619FB07
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 01:33:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gl15so32145038ejb.4
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fvL8BeeOZFepT8M6wo0zkZ843UAUiUtH0N7Vpvq4qWI=;
        b=mKEA3mZ/5yRYsgxgtVDypV++Q6915NZgJP2QaPOAGCKxRr2QRCoKNkrau6XT1aL+sx
         2JJFK8tubEB9wXvX9KnwOak7WmXG7aUnEJGaOcS6K0A44S5Zn4WOQwI0eQ+dcRujv32H
         RDSDzfyILnqCf1/9nfPWJMjBPkRSCA+CjFoWTzHMaHz5GAwfMc28wxSE9BVgdjZNcwRv
         XVDuHF/7MO9JsiBlmr07b1opGfjT+9VRjEMIlt3AZXonNOYXU9O4gfUsyvINmLeyuM8r
         LnRyHomaykkpBIJlx9MUBkwzMP37VXntOTTow2+ZFpNe7P+B07wItAHIkpbYd4kTZudY
         QbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fvL8BeeOZFepT8M6wo0zkZ843UAUiUtH0N7Vpvq4qWI=;
        b=nyViFnTv8vts3Su0utbiPh4tT22RcFy1cpUmvygSO+prsuM3xnKGDSupQbmSipgKN2
         Rh699DmkGHSMWrqnd1ePrOYBWS4bc2n5KzysSB4FoRZQ++RDa0EPMWcxpNq1OEjmbAGp
         1zG2p4DBIt9dEbj3gK9XN+UlH3nwYcEpHllMr80UJ5BdNe6PmnhtOdJqMb7A+2jV6dcS
         /qSEGbiMKSAfvD5+5qy2yfgHBRJiXU8cKpcrq6iWnlhKGC9GWPP6rWpw5CsjeSPYBBOy
         HpAslS/Gd+qyII8gSAQQT50VdXEJty50q0M96mR3vxzkNivYS+LV7LgpX/sezF1aZFCC
         VIgg==
X-Gm-Message-State: AOAM531SiTFMtkIYDXjCQVFYpc/e42qczxkKJlVBBqC8r6inTBXxmyZG
        terr4E/pcKgcV77OG1QNU6CVVG1vsWM=
X-Google-Smtp-Source: ABdhPJx/Ld1V8ehEoMwWRJcDi74Q0XR516bHHCEXTK4dFahWE/p1ebEsOr0rZd0+50Js35/gSJlOjQ==
X-Received: by 2002:a17:906:a06:b0:711:4f17:4391 with SMTP id w6-20020a1709060a0600b007114f174391mr23088757ejf.288.1654763601599;
        Thu, 09 Jun 2022 01:33:21 -0700 (PDT)
Received: from smtpclient.apple (12-96-132-5.ftth.glasoperator.nl. [5.132.96.12])
        by smtp.gmail.com with ESMTPSA id zc10-20020a170906988a00b006fef0c7072esm10507694ejb.144.2022.06.09.01.33.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2022 01:33:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: How to watch files in a Git repository
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <68627d29-8ffd-2e22-46ca-c28c9e980177@gmail.com>
Date:   Thu, 9 Jun 2022 10:33:20 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E6C6D02-8C56-48B5-B178-2F6B66542DBC@gmail.com>
References: <68627d29-8ffd-2e22-46ca-c28c9e980177@gmail.com>
To:     "R. Diez" <rdiez1999@gmail.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Diez,

> On Jun 6, 2022, at 6:04 PM, R. Diez <rdiez1999@gmail.com> wrote:
>=20
> Hi all:
>=20
> I would like to get a notification e-mail when certain files or =
directories change in a Git repository.
>=20
> In the good old CVS days, you could just 'watch' a file with your =
favourite CVS GUI.
>=20
> Some online services like GitHub offer their own notification =
mechanism, but I would like something generic. I am not looking for a =
hook solution, because the Git repositories may not be mine, so I may =
only have read access.
>=20
> The idea is that I can set up a cron job to periodically pull a =
repository, and run a script to generate the e-mails from the commit =
history. Any new commits which match the desired branch and modify the =
desired files and/or directories would trigger the notifications.
>=20
> I've searched the Web, but couldn't find anything straightforward.

I would encourage you to try SourceGraph=E2=80=99s CodeMonitoring =
feature (1).
You can configure a search query which target a file path inside
a repository, then it will send email to you when there are new
commits/diffs touching those files.

I have no affiliation with them except for being a happy end user.
In fact, I used SourceGraph extensively while studying git/git codebase.

>=20
> If there is nothing of the sort, I could write my own script in Bash =
or Perl. I can handle cron and sending e-mails, but I do not know much =
about Git's internals. Could someone provide a few pointers about how to =
code this? I would expect there is some command to list commits, and all =
files touched by a particular commit. And there would be some way to =
interface with Bash or Perl, which does not need parsing complicated =
text output from Git.
>=20
> Thanks in advance,
>  rdiez

Cheers,
Son Luong

(1): https://docs.sourcegraph.com/code_monitoring=
