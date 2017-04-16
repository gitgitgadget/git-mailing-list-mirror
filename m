Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FB320D09
	for <e@80x24.org>; Sun, 16 Apr 2017 18:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756599AbdDPSpj (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 14:45:39 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38134 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbdDPSpi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 14:45:38 -0400
Received: by mail-wm0-f45.google.com with SMTP id t189so21686883wmt.1
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qMWshQBxxUZUEDiyw83QgTrSnqnqYZCEwTzWmhr6IVs=;
        b=qpon7yOBh7L42NUiM8H5wXwYgzffo+sVk0OtdwpwuZ34udzFjkGV8on+oKE/SKK2+f
         pJ3N2+idKs1lr2ncJg7zeDJdbEvPb++I0Kj3K73AArwjRvS81QbBItdrJr+7M+y6xebX
         xL8gwJUsw6Jiy83bvRFPDugcxo1mfdBsXxLNddwFe+eSElXtO4fBmlAOO2ujyuHjVRiX
         +UYaPc2nNyxbMT6M2jFpU5CoGzw7bX+4v+ArgnvQ8nqSHO2EvRFVpToaJzOEig1epjm3
         6bZnUTYCeLl2TR9c3Oi6EJWlVQeJuXzFApcxLZ+3RpavUKSWSPQpX8ITf35pz+8c+IDW
         xP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qMWshQBxxUZUEDiyw83QgTrSnqnqYZCEwTzWmhr6IVs=;
        b=VbrWCqXtkVdX9+RvolM0TiCBBhxiLtQDRV9F9AbByyHkg7BN0KQgd6TAR+LW+Qx2Pt
         hzLGDRfJa4JHF94Pn7g2m+JXG66173OW5K4gGJEbAnINdoscuGYTRc5HEgiB6Fxgru/H
         hHGDh3uRUjs3+wz4NHP8uBMzHtPYBhUOvyBdgT1KJyZMvZd7X72xb68aTi96tDxTgDzI
         tEYChdcmTWj8sOXRhgPOcz5pnMj6wojoxdKPR6Z3GW5hn8zObvvlVhz5GluM/vJwSX1u
         fg+K+rwxmqRwFxdPGEF+iRJn36CD0dhBBF75iMJsQiyMplJxO9sD/Nl/HUaUNQytZ4IF
         ktYA==
X-Gm-Message-State: AN3rC/5IlUqrvowTyOsR+F2rbXQSiC8jeZE+p0sqNaf0cNAXYCbErHov
        gepI41qfI5/vLbTGHNaHALZQDYJq6w==
X-Received: by 10.28.167.3 with SMTP id q3mr3316697wme.134.1492368337073; Sun,
 16 Apr 2017 11:45:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.173.78 with HTTP; Sun, 16 Apr 2017 11:45:36 -0700 (PDT)
In-Reply-To: <CAO-Op+Fd9x7O66skWWy5TkTfMst7ohUiw3U9MMujyvYsjWnFSg@mail.gmail.com>
References: <CAO-Op+GujOUuueqwOKbb1NosZ-VYY5KVWm1+HNMC8xhd0ApEDw@mail.gmail.com>
 <CACsJy8DQWrLZF3wUQ5WF2FfriM6ko8Zwm_x5ErEEWTE6n5rayw@mail.gmail.com> <CAO-Op+Fd9x7O66skWWy5TkTfMst7ohUiw3U9MMujyvYsjWnFSg@mail.gmail.com>
From:   Alistair Buxton <a.j.buxton@gmail.com>
Date:   Sun, 16 Apr 2017 19:45:36 +0100
Message-ID: <CAO-Op+HTNdn6gE_V-4dBjjYTfSjq71sXhBVV6vutFzm2fsctQQ@mail.gmail.com>
Subject: Re: [BUG] ls-files '**' globstar matches one or more directories
 instead of zero or more directories
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On IRC someone pointed me to the glossary section for pathspec, and I
find that even more confusing.

In the section about ":(glob)" it says:

> For example, "**/foo" matches file or directory "foo" anywhere, the same as pattern "foo".

This is not true for ls-files: ":(glob)**/.gitignore" is completely
different to ":(glob).gitignore".

The only place where it is true is inside .gitignore files, and there
the ":(glob)" syntax does not work.


-- 
Alistair Buxton
a.j.buxton@gmail.com
