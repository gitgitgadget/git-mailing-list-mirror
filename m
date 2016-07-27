Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C6C6203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 17:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757485AbcG0RnG (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:43:06 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36545 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756658AbcG0RnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:43:04 -0400
Received: by mail-it0-f46.google.com with SMTP id f6so148436092ith.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 10:43:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=bKgm1UEtK7jFCr96YehykhkeISiLTQioRDEcpSUSHyU=;
        b=tsYVdyKkkmdbpypHFatI17JvNOQxAbJ2axQoslKsglvR0H4rfGaVrhwmHcyxy4Go1y
         9PLCMYTsaDPJ2FHLc3mP0aiY71P30w6825IC0XwOlkjegK5UUa9mNsRArcdBsPKf8eQe
         dE4+ikgn1Ab++akkHndWnTb+3ePITVg/AEJsziKK+zHRzzSVrxhqX/mcpwULretCBGMy
         VbOub+DzcVCFZw7hMK4WPXO9BqTdhyknpFCrtfu5IcF5TQoyRpHstuFHB37yI+XZfzxb
         boxMh70hempUZUMzD70lCrDhh6DAmTGLt0KuOIUwnBVhfCTNGYumQS+VEa//gyeRcWHN
         zHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bKgm1UEtK7jFCr96YehykhkeISiLTQioRDEcpSUSHyU=;
        b=hP4+s/E4d9w8PIV7zPuMCT8I8UuDDw+EIhKz2JqnqBQ6NSiqHBperifvsnJT9GJ/wQ
         zuFDP0USu08gDSKujstqnMbcEy+db2JVsx1Hz8qbCPO4xKcIwNTQB7nU8j1uL6LVkT4c
         7uZllOcajgVrEO7R50WZ9sYsfHST7EUWHjm9tIA6+4OVbS3KiVQtAa8gUmwXfvwRubeO
         C7ML0EXYPXsY79u9/E0jwxpVWShm4dcXO7VgppSD5CSEwkI5Vviu1be9GrFGBIjdQp1I
         CP/ztiJmzzS0/0xBYY+6nr+UWZDLd4sAKlWCdwE+li17lKquVS0Ws1P0+luyo+aLv+ah
         Anwg==
X-Gm-Message-State: AEkoout+OpJ7+wPxlOc2w6mX03DWSJUqMBQb6SCCagHypi3jvpnRO7wWpmu2VWqWl5MbU2FXlG0PE33OGxQzzA==
X-Received: by 10.36.91.134 with SMTP id g128mr35203499itb.42.1469641382895;
 Wed, 27 Jul 2016 10:43:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 27 Jul 2016 10:42:33 -0700 (PDT)
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 27 Jul 2016 19:42:33 +0200
Message-ID: <CACsJy8CMnywB8AdmLxB8LnsznHrMTieoezhaQS=2r1pnM8ONZA@mail.gmail.com>
Subject: Find a topic branch containing a commit
To:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Before I start doing anything silly because I don't know it can
already be done without waving my C wand like a mad man...

I often do this: find a commit of interest, the commit itself is not
enough so I need a full patch series to figure out what's going, so I
fire up "git log --graph --oneline" and manually search that commit
and trace back to the merge point, then I can "git log --patch". Is
there an automatic way to accomplish that? Something like "git branch
--contains" (or "git merge --contains")?

PS. Sometimes I wish we could optionally save cover letter in the
merge commit. Sometimes the "big plan" is hard to see by reading
individual commit messages.
-- 
Duy
