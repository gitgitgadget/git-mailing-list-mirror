Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E2A1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 16:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbcF3Qn5 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 12:43:57 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36507 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbcF3Qn4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2016 12:43:56 -0400
Received: by mail-io0-f179.google.com with SMTP id s63so76974675ioi.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 09:43:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E70zkMlqJnU7B1PVgqUVf3myr6ZZ6/ijSxfKlToKOrE=;
        b=enPxnpkH6abJITLUoIN1Gvxxx3YaUff0IXSaJO4dVi+am1reveV04EIFN8N+FOHXVM
         tAH2biUzk3cblrS8jF6Qbvi7k3XSvexz64a1c0/v2zB3oyW1MQKFHKiv6IM8AREC9QS6
         i1KluPOlSkdXIzRU/X/3ejaX8lZ7Eyy8TS8FF+2ig40okuc2iN3vOTXSIibR+WNBukMF
         +SlGxIPqKNqL3Z9xiRho96f7FAbprOwU2+LA5jlYoWsjZCCCl3RYzSu7Rq4gSB1GbUoG
         PjQhHz+SpO4wkffwi3rMsD50DXrz94PZHw1lBgG6yeoDD/Og+TR753uez1A1OHLX396p
         wSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E70zkMlqJnU7B1PVgqUVf3myr6ZZ6/ijSxfKlToKOrE=;
        b=f6VkLmwZLnHBXOXfKHLjbrsnkVGXZmSmL8280T5rHCi2xSpGy3ZvshtXP+QcuIr9lS
         MMoTMscPKSL8v44AN+LQw6J24hoXuZ8R0gFNAJbyHLxxNOg5N80x4BkdJ/wvXnqNoFTr
         BAryUxnDA+GIIMt+HIsj1vFP++ddhj7O2QAqjh4AfNd10nkL6L86nT7tDG0PK0bgrjyL
         G3SIsjKtaUIHKXp4Ujgz7RyBNPooyBKzPap0aw1QnqL2gyfIWEvq7y9ODA6amPvQSm17
         FNtqbD/zmlDqNOfgDQNzFXkQ/IUEEOsCiljGvyQ/g8Umi3f1eZ1x3f+vsldjFv/Bd+Nz
         fO2A==
X-Gm-Message-State: ALyK8tKxTL9+9uUTmKCaDe6waRY3TaSBiLFaQUC1tCKwZgGh24Ybqc5aMqC2mdE0s12nAusAQoUplMlo7zqqdQ==
X-Received: by 10.107.159.16 with SMTP id i16mr14995169ioe.29.1467305035614;
 Thu, 30 Jun 2016 09:43:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Thu, 30 Jun 2016 09:43:26 -0700 (PDT)
In-Reply-To: <20160630163942.8353-1-pclouds@gmail.com>
References: <20160630163942.8353-1-pclouds@gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 30 Jun 2016 18:43:26 +0200
Message-ID: <CACsJy8A6DvSC=X_YU=NhLWR+O5GgfKPqduWbS_ZbjMBi10tQVg@mail.gmail.com>
Subject: Re: [PATCH] log: decorate HEAD -> branch with the same color for
 branch and HEAD
To:	Git Mailing List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	j.cretel@umail.ucc.ie,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 6:39 PM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Commit 76c61fb (log: decorate HEAD with branch name under
> --decorate=full, too - 2015-05-13)

.. and I got the commit wrong. It should be 51ff0f2 (log: decorate
HEAD with branch name - 2015-03-10)

adds "HEAD -> branch" decoration to
> show current branch vs detached HEAD. The sign of whether HEAD is
> detached or not is "->" (vs ", "). It's too subtle for my poor
> eyes. If color is used, we can make the branch name's color the same
> as HEAD to visually emphasize that it's the current branch.
-- 
Duy
