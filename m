Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EC7C2BB1D
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97243206E9
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jngxfctI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCMRbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:31:48 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:33677 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCMRbs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:31:48 -0400
Received: by mail-lf1-f53.google.com with SMTP id c20so8578531lfb.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JQxWu4UYv9Gr1LNzkiOp+LyJCJRoobUH0l8I/bq8yrQ=;
        b=jngxfctIYOQ3yYDKCmV0kgYX9yvIUqbr56VeGyp/cGdurljJ0x9gIp7XAV7a1T6rD3
         +ZMwdJPzru6hrEWwvq+sXh8BXkd4fMjWLXIYzZtbgxn4L0UDxoH6LnieclhrMZhi5yc9
         efhC/+seK2aU6ATzuGw/2mCn/T4kk1bptSWUPCgX/GyU6KO1XJU+UKuFcVl+Pqy1yfBe
         8+xDacW6yGiTp6TIgArp9ZZxLRC2h1Jt8OUbvlLXXNrpycbpIvBDLTlAFrI/e0VYD6gV
         LRDVvIIf5pO0lzny5370fb1CGUdxq8uR5rpoUlWya+1xV/vJsbHDsxjbLYNlZzG9q7QG
         Wb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JQxWu4UYv9Gr1LNzkiOp+LyJCJRoobUH0l8I/bq8yrQ=;
        b=W1N2rEm3xarUV1/EpDFuQ8BRsJLWB0XXhN7nHhQvndkdOH4B4h8v0iGBalYWOfX2fJ
         ti25V9qALCUEV3LbVFLT28Y9fSNLH+4ucVcH3U6cUeEpt4m1iQvZm26Ed8mohJbGG8PA
         ly8hddYhf2zAZmmg2vWaFpRLbxYcRg/BaNhGakQwl+mR1tkt3jzHcmoxpSPogqYckNgj
         J1l9mgymad1nAXbpdcKDMZryl5RgkSvgW4ICuStateF9QLUPoxqBGf8XNpJLoeWtMDTe
         4F0S8ieSCEyEfeEpX2KPMmr8Lbddt7fThdqTxhbjnxTgSHw4fEZ7fMjbOqEkuRpxcE3m
         coNw==
X-Gm-Message-State: ANhLgQ3bp0Vr2Mdrrif7dq6d/MTgmcuz+RYgQwC2kQly7jEqw052OVL9
        gMoiANMyOPHT+zz5C1ejAazBIWWSEe+i6VZBpmw=
X-Google-Smtp-Source: ADFU+vsjvCI5RXE7cnKSSi8ty8cQrgEoUCDEE6UxUaMUrPqHmyveRVU5pd5l1P0Ncox+RTrSa1xeiSthf0vwkmxru1k=
X-Received: by 2002:ac2:4565:: with SMTP id k5mr9062480lfm.8.1584120706027;
 Fri, 13 Mar 2020 10:31:46 -0700 (PDT)
MIME-Version: 1.0
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
Date:   Fri, 13 Mar 2020 23:00:00 +0530
Message-ID: <CAHk66fvQw+6oQ3dnxJ8Ud8wrZrsm5hdnsekon7OK+y8-AM84zQ@mail.gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     jnareb@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> I have prepared slides for "Graph operations in Git version control
> system" (PDF), mainly describing what was already done to improve their
> performance, but they also include a few thoughts about the future (like
> additional graph reachability labelings)... unfortunately the slides are
> in Polish, not in English.

> If there is interest, I could translate them, and put the result
> somewhere accessible.

I was going through resources and drafting up a proposal. The slides would be
a great help.

Could you please translate them, if it's not too much trouble?

> Or I could try to make this information into blog post -- this topic
> would really gain from using images (like Derrick Stolee series of
> articles on commit-graph).

Yes, thank you very much. Derrick's articles have been very useful so far.
I would be glad to help you out in any way that I can.

Regards
Abhishek
