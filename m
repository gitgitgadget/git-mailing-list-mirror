Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0501F803
	for <e@80x24.org>; Tue,  8 Jan 2019 09:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfAHJot (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 04:44:49 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:38953 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfAHJot (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 04:44:49 -0500
Received: by mail-io1-f48.google.com with SMTP id k7so2641487iob.6
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 01:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/E+pqNAY7BiNuDgdRETiCiZVj/ZAx+4BN0RYaoVJ4fs=;
        b=nKSYv7kDaeD1FpUtEpkghvg54wrjvxog4cXiQTsKrkALjhhiBO5DelY6VipYzOWCX1
         LbSwtR7BI140tsSYLiCY2KwWftvFOd1e+M4A1ynzYBoO6B1zpChuKQ/0BvpfibOuP35+
         n8F7oLSk6XPUIk/zzORs/dvoB2A4URz58LzRQu/KuLv3giEDYUSATJrpGSmJj48ZYVDf
         UCW1T7r7O0Ti0tbgnop4VzwYyWAm3Lb1npO4zlxG3sTfQXHpgVFZPBU9VXD52+k/3Ctw
         q6oEKHaEwEvlRZjaEWE8E9Khrps7gNFntoAI4xCesnaGI4V2LVawaBAKUopux9+7aZ3S
         VHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/E+pqNAY7BiNuDgdRETiCiZVj/ZAx+4BN0RYaoVJ4fs=;
        b=asAUZjR70KmItkm9bPbennQuKy8DJbG6IbttlkBWOMFI9T/MS6V3PL7oiCDDECkkLL
         /STdG+LAPO0VbsYPnITF0AR5jmH6DjjtcSXc7bJYqKEsqk1cU+2Kfbyb4r+6+kJmhmQK
         WGA48Ya2rfzWZIDBAvX2Bgv2mKGdKB7Df++aBkgys5piPiMloXoA9ypNXM6sAZIORHYC
         MpugDXlsR9AyLuJ7gf3nORcdTXBLYmPYBQQMissbkWpwrrfrmpnrCtA0AoezH9tLf14m
         qawSSfhe7nmR2AfYrAD8JS+sTmiz26ubAuqh1mE2lgeqllwl2fEAVgNzA4bDMYRuhPKr
         646A==
X-Gm-Message-State: AJcUukdJ0FOAoh4nj2Iy2OVzRdOWZgIVl6U3nndXkJPhN7ynzSkiIg2W
        J+gdCvyibWyA6VzbZ0JbFvGzppGD/8IfMtpetaY=
X-Google-Smtp-Source: ALg8bN7HlLuRWS5CDjqLH4Sef6T39RfK6zSuGc3SXRl4MhJM3FW68kjJx1mc6kK9/j3xgD11Y4F5yGpHzGwSN/3LO24=
X-Received: by 2002:a6b:ef0b:: with SMTP id k11mr479017ioh.236.1546940688325;
 Tue, 08 Jan 2019 01:44:48 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEBmVQ8H78uHSPSBy+HqLXZ3xE5=jVdYDfPOVZ_53U8YA-A@mail.gmail.com>
In-Reply-To: <CA+dzEBmVQ8H78uHSPSBy+HqLXZ3xE5=jVdYDfPOVZ_53U8YA-A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 8 Jan 2019 16:44:22 +0700
Message-ID: <CACsJy8Atwp1nQbDaxYSNiDFmVmMG2h88w=dAZWU1SF6JQ18EEw@mail.gmail.com>
Subject: Re: `git reset` for delete + intent-to-add doesn't reset
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 8, 2019 at 2:28 PM Anthony Sottile <asottile@umich.edu> wrote:
>
> ```
> git --version
> rm -rf t
> git init t
> cd t
> touch a
> git add a
> git commit -m "add a"
> git rm a
> touch a
> git add --intent-to-add a
> git status --short
> git reset -- a

"git reset" without "-- a" does remove intent-to-add status. I'll look
into whether "reset -- a" should do the same.

> git status --short
> ```
>
> (the git version below is compiled from
> ecbdaf0899161c067986e9d9d564586d4b045d62)
>
> ```
> $ bash -x t.sh
> + git --version
> git version 2.20.GIT
> + rm -rf t
> + git init t
> Initialized empty Git repository in /tmp/t/t/.git/
> + cd t
> + touch a
> + git add a
> + git commit -m 'add a'
> [master (root-commit) 95a1815] add a
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 a
> + git rm a
> rm 'a'
> + touch a
> + git add --intent-to-add a
> + git status --short
> DA a
> + git reset -- a
> Unstaged changes after reset:
> A    a
> + git status --short
> DA a
> ```
>
> Even `git reset --intent-to-add -- a` or `git checkout -- a` don't
> seem to clear the `intent-to-add` state
>
> How do I reset the intent-to-add status in this case?
>
> Anthony



-- 
Duy
