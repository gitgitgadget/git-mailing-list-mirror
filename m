Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77521FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 20:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933023AbdCGUMM (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 15:12:12 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36623 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbdCGUML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 15:12:11 -0500
Received: by mail-pf0-f170.google.com with SMTP id o126so4682195pfb.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yuwbjlT1LVRWUW5JfsRQUNSDXMyB1mtz+PphuMiNSkM=;
        b=DzsoykYegBUGUxnhLRSvRkOxZjlCgCu/+AbaMytYCibgWEVUxA74k4K/a3xtBocGpF
         b5CPTPZFBMRYzJlHChToHGg7+Z137UNO0uR3OfQ9ugeljwpcqRGdqmuvUYZELYIqfDgC
         Dn0JToxrTd9knZBcYbumVe1qDeZ9vhwi1lBRhVUsC5iejiufXY9RNq2g2HJxacZl3eS4
         9KcnrF8SzJfEPFuR4uBcinRHURaCY5DOTSr1qZvatk0MUjzRBW5Ctd88evY6u7DKX1Id
         MpxSbvXyNfOjDapvgB1WUcGF/6nM1zoI4N1u6Xdp0esKahWuQpdazzEnBtFM9PQQU/q8
         ERhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yuwbjlT1LVRWUW5JfsRQUNSDXMyB1mtz+PphuMiNSkM=;
        b=arj0wIKqKD3phjHnfMbNaSEQFsk3n12i1Gm7k4VpXte6cO/uMsc9txIjnxvUK/d3J2
         q9gqEu6nQmEdydoBs3dxZsQxVt+EfMAMFb8SxkWHXPIrLdddtaPlGah1am5ytc/KN54B
         qpTY4iPH1gLaLrTjpX3Sy9TwUn29ZyM5E0yCkcWgnWIRnPcb8qd0g1MDzdm+xsjuENPG
         t2I3JyIbBR75ufn9VtW6j/80XZkgxtvsDQzoXhyeWavr3gdDpQFj0oFBvcr+A7vArhkm
         gyvjL1c5qRyf3XvnnDYvm/oAF7P0H3fhqIBU0b3g9zlE4CnYulUyoHPDMd/HqISfPQTs
         gCiA==
X-Gm-Message-State: AMke39lmu4pQFZIJsAaXhs8ndCo1XXAqIwdes07aNNaBCccpTkW1HnRScAd1OKuVPfN8z8mSzRoSHHK/uzmrWRms
X-Received: by 10.98.149.80 with SMTP id p77mr2427272pfd.56.1488917487460;
 Tue, 07 Mar 2017 12:11:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 7 Mar 2017 12:11:26 -0800 (PST)
In-Reply-To: <1488916365.8812.1@smtp.yandex.ru>
References: <1488916365.8812.1@smtp.yandex.ru>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Mar 2017 12:11:26 -0800
Message-ID: <CAGZ79kaFxN+0W8HDBB4Wnqy64UmdsRCCF2kZ852XsLNP=QNofA@mail.gmail.com>
Subject: Re: git init --separate-git-dir does not update symbolic .git links
 for submodules
To:     CAGZ79kZbc394rmxYDUxCbysKNbEQCB7aLJkf6MGcCeXKAxiKhA@mail.gmail.com
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Valery Tolstov <me@vtolstov.org>, sven@cs-ware.de
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 11:52 AM, Valery Tolstov <me@vtolstov.org> wrote:
> Just noticed that there already is function that gives module list
> module_list_compute. But purpose of it's arguments is not quite clear
> for me at this moment.
>

static int module_list_compute(int argc, const char **argv,
                               const char *prefix,
                               struct pathspec *pathspec,
                               struct module_list *list)


argc, argv and prefix are just passed through from each caller
argc is the number of arguments on the command line,
argv is an array of said arguments on the command line,
prefix is the position inside the repository.

e.g. If in git.git in Documentation/, you run a git command
"git submodule--helper module_list *"
then first "git" and "submodule--helper" are removed,
and then cmd_submodule__helper is called (at the end of
the submodule helper, which then sees
    argc=2, argv=["module_list", "*"],
    prefix="Documentation/"
which then proceeds to into module_list().

That parses these arguments, but there is no
argument it knows about, so it does nothing.

Then it just passes these three (argc, argv, prefix)
to module_list_compute, which then makes up the list,
to be stored in the last parameter 'list'.

The 'pathspec' parameter seems weird.
Internally the arguments mentioned above are converted to a pathspec,
such that we can go through all files and call match_pathspec inside
of module_list_compute.

In all but one cases we do not care about the pathspec, but in one
case (in update_clone) we want to issue a warning if the pathspec
was empty (i.e. the user just said "git submodule--helper update_clone"
with no further path arguments)
