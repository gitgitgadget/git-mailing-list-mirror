Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E4C1FC19
	for <e@80x24.org>; Sun, 26 Mar 2017 08:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbdCZI0x (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 04:26:53 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:33506 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZI0v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 04:26:51 -0400
Received: by mail-ot0-f182.google.com with SMTP id 102so4599147otv.0
        for <git@vger.kernel.org>; Sun, 26 Mar 2017 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h0D+yq1NnrBoGq4gmKpBSx3NIZyqEYuADCD4F+mkMXE=;
        b=kXQat1gZe6Xzc1IunPeev5Xme2BjYgHQ9IOSX/zKa+v2Bfv4zx/Sl5hweqF4LcidrW
         2MeOOz1PvQ/LxVXAsUD7mr2wL0Zl+P9Dr/92g95qsQZuCmHxMCjOZ5M/Vv4Z7XTE4UHI
         qK5QPgV6vMjryEE416HX+9CPpZofw52a6MG6xg9oVDffNQQ2u9eki1JAeP/DKiZ6T5+b
         dxnWRm2TcOMuoGrEYvVJBucV/G1n7qoDPHArpRanB8jOXiGK9qQwYTpTWosrTkIc7R2s
         C5NL9yuTu53iAL5EPSKkI73pEmOe8RpI0CTSJzpfoJp+tYyxA9auxRxZdG3UuKLrERet
         xQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h0D+yq1NnrBoGq4gmKpBSx3NIZyqEYuADCD4F+mkMXE=;
        b=E4Zr94Lu+wm+RsfuMDGlHBXz2Lv6qx21msyZGlBqD0BAjwHBhkC4GvlnkBx3mvSWs5
         cJ5euwx8FAlQhXHrjOi+URdU6zZg/LqhJ7lM98pAWXJFe2wdFtEsdOLZNORHDF/Vc79k
         bWVqNSqB7ptIadhYMUaOmlW/3/aQAlUjw3dE0Bv6BXZQRlWPsJyTXOIHF5bkJLvPMOH6
         rjtWoxG53q5JHWZgmntOCQZND11lKtsKIuzOtnz03t28xiaLAs3TJePmAq5GIHAQI5PC
         i5uzVkIjYF/Omr5cDO8PWNuIA6a6FKXExGECswyLPWTWbLLj949jDCf54f3EHWYN5pys
         Bwlg==
X-Gm-Message-State: AFeK/H1QelqTGS1QINOH8bSD81rE+HqM+eIlSUiXmuVWmlVMTcUAgGe0O3LLfG3NaiUtLWqeisKA4QLNopEvgQ==
X-Received: by 10.157.20.151 with SMTP id d23mr8258033ote.37.1490516809784;
 Sun, 26 Mar 2017 01:26:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sun, 26 Mar 2017 01:26:19 -0700 (PDT)
In-Reply-To: <0d437f43-30d6-3920-5298-0c426b098c1a@alum.mit.edu>
References: <20170216120302.5302-1-pclouds@gmail.com> <20170318100206.5980-1-pclouds@gmail.com>
 <20170318100206.5980-3-pclouds@gmail.com> <b841a674-7b2b-420d-7faa-e5b836fb534e@alum.mit.edu>
 <CACsJy8B85TH0DOViEmfh8mOz_u7rVotKJa-HYk6TJ81kvV4xPg@mail.gmail.com> <0d437f43-30d6-3920-5298-0c426b098c1a@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 26 Mar 2017 15:26:19 +0700
Message-ID: <CACsJy8BRUXx7WcCTrgDEv++Lj+d=fWbLyysMCW3Rw_Z+QRcS_w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] refs: introduce get_worktree_ref_store()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 9:25 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Instead of moving all of the `for_each_*_submodule()` functions over, I
> encourage you to consider getting rid of them entirely and let the
> end-users call the `refs_for_each_*()` versions of the functions. Again,
> I'm not sure that there won't be friction in doing so, but it seems like
> it's worth a try.

They are getting rid of. If you look at pu (or nd/prune-in-worktree
actually) there's only head_ref_submodule() and
for_each_remote_ref_submodule() left. head_ref_submodule() has no
caller but is still there, I'll need to kill it. Killing the latter
can be done separately since the callers in submodule.c need some
update.
-- 
Duy
