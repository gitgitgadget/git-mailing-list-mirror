Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4101F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932302AbeDWTjF (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:39:05 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:37406 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932175AbeDWTjE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:39:04 -0400
Received: by mail-yb0-f174.google.com with SMTP id i13-v6so5799370ybl.4
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KVOsHCpQ0fFqSC92WYujpBKsVlKDzdvSVBs/HdejgqY=;
        b=naQcrTbd74iajQzeju1mwAEoH4UHayVTSjLjKVjIuQUMNZxxHyMPRS9oES5VnyXNMV
         Fh5SuDO1Q+Wgc0Kz2JUEyWZ2nyZXJHMeAOrQ6c76bXB37jfVVigwFjb81C69990BbiBe
         i2ydytoqnVCpbAEb2X4QTmlK9H2HXPuHh2AYRHbu1pNsWgk/fpzx764w1JYD/08GapLb
         otYs0qKpcQj6SxJ/SJz8hJxGqlVdRNJSQMDvProxOz+GDLnf22V5K+0D86VHYROz5AV0
         Z86BhL554jUdPdreeX0Eq5x0FsErXmWbtiqaAV7Rl0u4MwYj2VQpul4vJt8cN5mpOc1X
         3IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KVOsHCpQ0fFqSC92WYujpBKsVlKDzdvSVBs/HdejgqY=;
        b=tYdkvrfF3J0i31b9KP0Uofepm+jZ51ke8P7jK5MptixgimHV0inrbOPYJemlTxDz5f
         c3abyq7U7v3mMke5aviLaRz0ur4garRNd3TR5POk/6mT/Ag814DWqIjWiTQQyDPVTAMv
         pdIaqKJ+ck/N9KWaxyp+1HqBJuW1Mq3aBVesO/NnpfvsPM50tmW14NL3OTYO3IVpGeTv
         JufbViOsHAgJI/Hb5aPEeMHTtjWTXA65mEiMnbenhhkIw4oy9hq9Y9OyQL3Cjxw0Zjp9
         SW90whbTDdrdciMd0gg1zKPT1LpQf+y85vzXx9LnRxlcqUl1qtdhc2ZD+290OV5OcjiN
         e0nA==
X-Gm-Message-State: ALQs6tBfrhH89U2PDesdHNQLdKHi8iuTKFBfBbnSxWi1bwIJahEbGPUT
        Mwf9wNeRfIkqFGZLNhg8qe8QJQ6OvljukTqeSNTIAKT8Qs0=
X-Google-Smtp-Source: AIpwx4+1E3dpBwsiMc+ES0NpbmfiVS/6kl9iJqee+PBQdbTlZdI+fNp4JGrSseIvZVzFhNDdhhEIURg/SjBvnLHNEZg=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr12145392ybn.167.1524512343794;
 Mon, 23 Apr 2018 12:39:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 23 Apr 2018 12:39:03
 -0700 (PDT)
In-Reply-To: <HK2PR0601MB184272A36E86014BDD988DB5F9890@HK2PR0601MB1842.apcprd06.prod.outlook.com>
References: <HK2PR0601MB184272A36E86014BDD988DB5F9890@HK2PR0601MB1842.apcprd06.prod.outlook.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Apr 2018 12:39:03 -0700
Message-ID: <CAGZ79ka-2OEYCqrZWEbWsR_QnZP_xr-yxg6jkWN4HYdKA+RJwQ@mail.gmail.com>
Subject: Re: Feature Request: option for git difftool to show changes in
 submodule contents
To:     Oshaben Nicholas <nicholas.oshaben@bwigroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oshaben!

On Mon, Apr 23, 2018 at 7:49 AM, Oshaben Nicholas
<nicholas.oshaben@bwigroup.com> wrote:
> Hello,
>
> A coworker of mine was trying to use git difftool in a repository with su=
bmodules and we found that it only shows the change in the subproject commi=
t hash. The option to show the changes in the contents of the submodules ex=
ists for git diff. Can this be added to difftool as well?

Yes, of course it can be added. Care to write a patch?

See lines 432-443 in builtin/difftool.c:
https://github.com/git/git/blob/master/builtin/difftool.c#L432

I'd think you'd want to compute some output
(Similar to the git-diff output? Then we could just
refactor the submodule diff stuff to be reusable here)
and put it into the strbuf there.

Feel free to ask away or read the docs Documentation/SubmittingPatches

Thanks,
Stefan
