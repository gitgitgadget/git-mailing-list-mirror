Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 886021FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 19:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbcGSTVg (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:21:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36784 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbcGSTVf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:21:35 -0400
Received: by mail-io0-f193.google.com with SMTP id y34so2043284ioi.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 12:21:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=EYqKbvSZJRUKUscCrQZkgo+8FRPYXi2Gax8x27QWZjE=;
        b=qrr/6uq4S2CZTeZust2VRYwvojhZ8DjvGanDmf+w0ft99StdC9irKEQTsJsoYtxlMB
         +fUftj3GiyhGPFPeuqKxcXt4eTfGhA/6G17IC/0Xk123JCGxGxFhCh1FqeQXtofW0cJv
         Yg1NCaTG9hEU/oSsZ6167rZauTy53MEIeGHb97u01Fe4VYdpEMD0v6FYlceeQ0OjJnPu
         VdMRqi5xNXwd5EZcgNt+W/KkPIPnss6+4iomVfOz4ZDrO0jpTLlEm7cjkcOs1JzbPYwA
         IgkwUecDC71EvNLQLAmF890i0oL6gL19i0ii1V8DZ3Ju4OgWEfhHhily3D6nHYDTBm+2
         YQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=EYqKbvSZJRUKUscCrQZkgo+8FRPYXi2Gax8x27QWZjE=;
        b=FYsBZ/pjUOtfdMggyyrZX8LLoPRt4I9fKePcFG8/usXyWL04ESl/zUBbWBAAhTEbm5
         6tCg/XZ+8OCiUYHu3Il2bAJG370IeH1eM1c50eC0d/fEowidFGS4KMJ+TBpvhFLUR/1Q
         dWlO0zU/INm9rRBQkDlK6BQFTu1Sy0iRrLVFBKFuyHhTGuTpBFkRA5EERTrAB19yJyKM
         OeeHgQ4XksP9nNFkjo4DFxkuBvHM3+6yDcyKmC0Kx9xBKNSOrslw4JU5rMw3vGOIT9z9
         PGyWiR6uXZHGvd9iVjjDpnSNMZ+jWZBBMB1VutQsSqcjmLnWuQzC7SsDoM6PxDLF1M6z
         +bXQ==
X-Gm-Message-State: ALyK8tK16HkGY7XzszYbcBThi+CmXCpZBEOc+7/fdnqtwpvuzITpEyw7IAwgXPM78AGMRmuRdcOG1Jb5eJvz+w==
X-Received: by 10.107.137.159 with SMTP id t31mr33399414ioi.34.1468956081399;
 Tue, 19 Jul 2016 12:21:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.7 with HTTP; Tue, 19 Jul 2016 12:21:20 -0700 (PDT)
In-Reply-To: <CACsJy8AkpBmNS0nOoKX7PUYhp9kKgvH=K2gpCnq+sR++ZmDAgQ@mail.gmail.com>
References: <20160719144701.571-1-antoine.tenart@ack.tf> <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BDRPK2UKxoMat3i2HL38+KFqw2Qfet2Bev26HXRM-BWA@mail.gmail.com>
 <20160719185452.GB28551@kwain> <CACsJy8AkpBmNS0nOoKX7PUYhp9kKgvH=K2gpCnq+sR++ZmDAgQ@mail.gmail.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Tue, 19 Jul 2016 15:21:20 -0400
X-Google-Sender-Auth: HPbYEn1LVQX4DQ7fjOYqRlNFxAY
Message-ID: <CAPig+cSWQDJzDKN30Ho-ziDH-Wyg5pPx-WMeQ4WCPdy7PZJkVA@mail.gmail.com>
Subject: Re: [PATCH] worktree: add: introduce the --name option
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Antoine Tenart <antoine.tenart@ack.tf>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 3:04 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Jul 19, 2016 at 8:54 PM, Antoine Tenart <antoine.tenart@ack.tf> wrote:
>> Like moving a worktree (or is there a command for this?)
>
> Don't touch it. I've been waiting patiently for that patch series to
> be reviewed :)

For newcomers, "that patch series" refers to [1].

If it's any consolation (probably not), I'm still trying to find an
opportunity to review it, however, my computer time is severely
limited these days. In fact, I'm so far behind, I still haven't
reviewed the worktree-lock re-roll (which probably has already hit
'master').

[1]: http://thread.gmane.org/gmane.comp.version-control.git/298194
