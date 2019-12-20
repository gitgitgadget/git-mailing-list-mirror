Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAA2C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 01:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F4C227BF
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 01:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3Hkm4Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLTBwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:52:18 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33966 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfLTBwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 20:52:18 -0500
Received: by mail-ed1-f47.google.com with SMTP id l8so6790409edw.1
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 17:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AMsthP7N/WGHx19Eaa2Yy9+fE3CtXFxsq2gpcjArUyo=;
        b=B3Hkm4FnUPtCW2KxDWaI5mKUnD/o7MGevMzFn5kjT/mrCmf21uvefwTphT8SXBgVtF
         YEuJNPks6Lq55sQxAJE3kQIaw2rZphi4RWbpxM9DRk/JJvMSc80KC6NhgZEpcHsoi4kH
         Xc0faZfFyYT8ZqRQAUd9EUscQlHBHV4aNlOBh0np7dTeUQ8pdPfLOKqtSnk++Kglrc7m
         mH2nlCFZglmkRngBKVssRPFxtDcJv/ZkVqHlh5xYbfaQpl4uXQaZO0di3Sdifvf//w7R
         iEDsfpQjEvIdyPMs4pBhHh26zod1Ak+kDJBHFQkuw/FgBtMW/oo/MBTBQ5RlMQ1EyFby
         w1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AMsthP7N/WGHx19Eaa2Yy9+fE3CtXFxsq2gpcjArUyo=;
        b=jq+C8FJAbrFOSitxRPfNISTsu3pL8TkMz2X5rUU3kqKtVvQc/97cL4/I5ivH0lVtH4
         RUmpemlu4oobdETsc5I8sM0wlouOJ976+KQ+mOPdvK+jgrd1fE4/46Jk/Opbeoa/Pgci
         kBrN+MgD2ayUqe3e7Z9rC/fCuIVyz04QW3rK01m/7EJz6z4TzSlxwABQKUJF1hEaEv4d
         x++008e5OSpG8p23W8bCU+CwTjVpfSdcGd7aS8Bzke/f/2KJNizSJobaQhl3gq/G33dc
         u0ltXifQWtXUlRIrxvGBhZR9ws+8WP4m2gZZz5wpMZLGr6FQ4AauOayuF+0t9fRMAz2t
         EE6w==
X-Gm-Message-State: APjAAAXhHm6WrYShQa6iw+4jW8PfMvDTitDt8E7lnnktu0BUtgjmITJ0
        YMFs8T183FbsjQh29FJKLywDraVa4yxKyiq+tBgMD0K9M7E=
X-Google-Smtp-Source: APXvYqxMjYVvIHWHLcoo6bh08cVHXs8RfqEgi0Cx324CcRIuTQ4fp6EX8IT1s1eBZDiZheJ9UaWm4/K4Vl+7WRjIk44=
X-Received: by 2002:a17:906:31c3:: with SMTP id f3mr12948992ejf.239.1576806735793;
 Thu, 19 Dec 2019 17:52:15 -0800 (PST)
MIME-Version: 1.0
From:   Keith Thompson <Keith.S.Thompson@gmail.com>
Date:   Thu, 19 Dec 2019 17:52:04 -0800
Message-ID: <CAAHpriOh=9Mh7_moxWCzXBHYTtNi9TOQQPBxa4CX=uLgOnpNtw@mail.gmail.com>
Subject: Cygwin git with schannel ("native Windows Secure Channel library")
To:     git@vger.kernel.org
Cc:     Keith Thompson <Keith.S.Thompson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've posted this on Stack Overflow
https://stackoverflow.com/q/59381061/827263
but I haven't gotten any responses yet.

When I install "Git for Windows" on Windows 10, the installation
wizard offers the choice of using either the OpenSSL library or the
"native Windows Secure Channel library".  (Whether that's offered
seems to depend on what's available on the Windows 10 system.)
I believe this is referred to in the git sources as "schannel".

Is there a way to configure git under Cygwin to use the native
Windows Secure Channel library?  An ideal solution would be a
modification to my .gitconfig, but something that lets me build git
(and possibly curl) from source would also be good.  See my Stack
Overflow question for more details, including some things that I
tried that didn't work.

The problem I'm trying to solve: In my work environment, I can
use Cygwin git for local operations, but I have to use Windows git
for anything that talks to a remote (push, pull).I'd prefer to use
Cygwin git exclusively.
