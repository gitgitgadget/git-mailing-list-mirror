Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1468020970
	for <e@80x24.org>; Mon, 10 Apr 2017 10:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbdDJKYg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:24:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33156 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbdDJKYf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:24:35 -0400
Received: by mail-pf0-f196.google.com with SMTP id c198so5876826pfc.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pHVpPfujqrjisGdBLgbwaHqLuw1+xdofpYnexWrhdXc=;
        b=OOfLODdnQ9zh+2QOHNHD2F6Ex5Op64+NmI2edsIogXeVMrClzscb20FtZNlo/1CHsc
         G+bhc7dSHTungcsg1d66faKaGmYfVvZWOG4AVKSYC4/+rocVT1havw1zH5YxqYuknRZN
         D+wnqCtTNek3pxhi+NPGsGWcQ7HRqzv0bh2XfUz8/1xLOZ3O8chDAOkVzWCsB/hXKeLS
         xTajsHW3MwhTmatReUwpvXfsh6Y/3YoxbN/XioCCdq3UOWBfuZdUjv8JNIxP2GIcFUg1
         K/+ODjsocT1THR/W5bMiFaoY8eFPLp78exNgRGBD8ORXYO2kcWDRJ3m6uqi4PbcuflYt
         D1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pHVpPfujqrjisGdBLgbwaHqLuw1+xdofpYnexWrhdXc=;
        b=dy7C/NQHxJqZLUS8QoVQLMumlElC2RQlyPxw8lhIhaqHNep/S0mb9G1ZDw8WUZrdNk
         tXIRxCgKByWBRvgd6tL652xJNe4aO9oRDsGGjMd4oiX5qcNThn68IdZKxbCS77AoOrTe
         zXaBpGHzmnsLiIP/RH0w5NS9m3wH8ketuJL1H+8qEJS9+cU0gXim/oi++FvPNYxCmLGW
         VncIso0bDJGco76R5YteLNaDhmnwUWsVPfcIDYSQHDWZsIzjIinQfH7rrZAg9+RLJxo6
         xoYq52Scs0zckTwMtBi25Qth1S3d/pPG7F6SfesGL9DzfiayyLQyajHeIxKDRoLTxPfN
         WtrQ==
X-Gm-Message-State: AFeK/H1m5m92SmmptDg9ueH0Vx+hR79hw+J0pBEQ4CXDeFowFnd8PshLI/B+GWh/fU6xug==
X-Received: by 10.99.0.85 with SMTP id 82mr51315612pga.39.1491819874841;
        Mon, 10 Apr 2017 03:24:34 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id k26sm18082082pfk.59.2017.04.10.03.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2017 03:24:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 10 Apr 2017 17:24:29 +0700
Date:   Mon, 10 Apr 2017 17:24:29 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 3/3] reset.c: update files when using sparse to avoid
 data loss.
Message-ID: <20170410102429.GB19325@ash>
References: <20170407192357.948-1-kewillf@microsoft.com>
 <20170407192357.948-4-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170407192357.948-4-kewillf@microsoft.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 12:23:57PM -0700, Kevin Willford wrote:
> When using the sparse checkout feature the git reset command will add

"git reset" has three different modes. It would be good if you mention
what mode is affected here. The tests are for --mixed only. I wonder
if we need to do anything for --hard and --soft?

--soft touches branch SHA-1 index only, not worktree, so probably not.

--hard should be handled by unpack_trees(), I think.

But it would be good to cover these in the commit message as well to
stop readers from wondering.

> entries to the index that will have the skip-worktree bit off but will
> leave the working directory empty.  File data is lost because the index
> version of the files has been changed but there is nothing that is in the
> working directory.  This will cause the next status call to show either
> deleted for files modified or deleting or nothing for files added.
> The added files should be shown as untracked and modified files should
> be shown as modified.

Hmm.. reading --mixed documentation again ("Resets the index but not
working tree"), I think the current behavior is expected regardless of
skip-worktree bits.

Perhaps the problem is the loss of skip-worktree bits on entries added
by update_index_from_diff()? If the bits are at the right place, then
it should not matter if the same version exists on worktree or not and
"status" or "commit" should work as expected, I think.

--
Duy
