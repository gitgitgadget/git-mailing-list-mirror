Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C4E215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756097AbeEASUi (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:20:38 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35890 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755539AbeEASUh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:20:37 -0400
Received: by mail-yb0-f175.google.com with SMTP id o14-v6so4424926ybq.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=06498ebMy+SgH2RCDbz5BhPZsYwbVjZ49LQgFOeVN/M=;
        b=pGIVgJj4X6hNrYdZqn9DPLCKrk7Ikihje+e2ftakXi4LViopi7qKd13Od2Za4VanAW
         FJePOpKEJmSd/gSWJiROBAxghABRGiN2j9QKatICzlu13mGuKsz19elSB2lUNCF0FzEn
         2tu3qBrO6BDpGDrU4N4mudNTTbgLfpSJu3WF4GLBfzwPnU2E56lfKEbnf28nmIUX1NiL
         ILI+nyJPVKxdNUXuRIoWHaZjd7chdRqJShBJtoEDg29kQ8/D4yStAZySvrANNdUuRRFd
         cyZM8u7Ag1DxTcCNcCBPKxYzJJ8/xwiFL56hz5gy76H24fQM89AnnwQA407zNbeot1Ef
         RACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=06498ebMy+SgH2RCDbz5BhPZsYwbVjZ49LQgFOeVN/M=;
        b=Y8oJF3DJmyDYs6OcFl/4BrcJll+wL4hCN7O4wuzl6URUAHEERaJBvknCrw818oAMzw
         SetmEbVz8h0g63uZ+0rWg8OZ50FYDNZMMaHvXbzZ2sSbmOZ2mNAkh73d/3CFopO49QlR
         rPV9HsFX9Aph/7ysePMWOW34n1js8YajzZVBkwetlJE5FLa+K53tfPrSaD8MXzUEV70G
         KImyj6R0y5ItNVUCw2jEbDB57dx+OVdkdjm1BbtiZLC/5bHuAYycwnlbDrVCLftUz6vH
         mKE6ojSUqOXUfy2sS/TpPyLi4ts0WIIaEFHjTve2zGS8r3QprSwCsJiGVytclBgxNIvb
         5JTg==
X-Gm-Message-State: ALQs6tAdg7G1g3FYXbFebzDUzfU3rG7idFFqbp14wLLdEx9DW+/PC84G
        kaS/DXHB9U4Ne5EnLQaSYVz3axruE/mugCVWjWUGrICS
X-Google-Smtp-Source: AB8JxZpy7z/vr7/FUM51uFYLzmZhfS9s96+rgidAxhjvPBcLetMEHpI8hQve9I/nKtrLETUMHi0Kx1HLqICeh0Mf/cQ=
X-Received: by 2002:a25:3bc5:: with SMTP id i188-v6mr8056417yba.352.1525198836335;
 Tue, 01 May 2018 11:20:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 1 May 2018 11:20:35 -0700 (PDT)
In-Reply-To: <20180501180908.17443-1-kcghost@gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180501180908.17443-1-kcghost@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 May 2018 11:20:35 -0700
Message-ID: <CAGZ79kaMOxuqC5nF=Tq+cQtj03fxzoKKnYi_BM23n_hmrTFkfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add --progress and --dissociate to git submodule
To:     Casey Fitzpatrick <kcghost@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Casey,

thanks for sending those patches and improving submodules!

On Tue, May 1, 2018 at 11:09 AM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
> These patches add --progress and --dissociate options to git submodule.
>
> The --progress option existed beforehand, but only for the update command and
> it was left undocumented.
>
> Both add and update submodule commands supported --reference, but not its pair
> option --dissociate which allows for independent clones rather than depending
> on the reference.

This makes sense.

>
> I apologize for any errors I may have made in creation of these patches or the
> formatting of these emails. This is the first time I have submitted patches to
> a mailing list.

The formatting seems to be alright, git-format-patch/git-send-email
just works. ;)

Stefan
