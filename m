Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB2A1FF40
	for <e@80x24.org>; Fri, 17 Jun 2016 06:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbcFQGFp (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 02:05:45 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33850 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbcFQGFo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 02:05:44 -0400
Received: by mail-it0-f67.google.com with SMTP id f6so894625ith.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 23:05:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Vxdq+EITT55dXHwRMRkm/DQVpwv2foQcsot+TvvLxHg=;
        b=j5d9I3JQ0gxmdMmTKnEi5XNTTsjACUGM89+yxY/RJNLJv3atVpvCzDSPUJzQu/nlkP
         FJhh2HmzeE9bJCBYKHGR8Kf5H/te/SuWx0U35TQ/TZ3dazdePjit607SyTAPm08/USbZ
         Jq/QYXll47ZisfwDuKTygCjvI9lcFmRs6QeoSZfZorhYTXRgrRFsCsg5CLF7DkTVwlVT
         Y09qSe2eNyY6hmKfYLQm3G9AN+W7dVGR7AEfqSuCUjgU4YUw5rv0Ca3JREeAHLiWPw9G
         YNEsDyYFo9/rWsjoXQ3aErKJWt5X8h4rtYSD2e/REo/MqE0/kmpkTme38x3tj6wNWFyn
         eQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Vxdq+EITT55dXHwRMRkm/DQVpwv2foQcsot+TvvLxHg=;
        b=Fohm/bNmUD7FX4URROXp0re53JN4eX9dzIrnLTEp4pOsNnUyIA2G8J2sR9ZW4fNOD0
         5aL5VkUWNOUJ0nY5hRUKuKs4mL9zJUbMuvKMv6blT1IsaCcvxIgHsaCSyfj2r4XU4qRs
         I2G/FblidMRkE0BFLLqEQOoht77nV700tEvXtxyCNXxd9TMJPV6UZ2Dq/leYgSFGOiy/
         SWGMD6SqHbEvKHpP2evSrEPW3upwENS3noK+w5hzKzq3yx8Av3KDi3qIiUGoesh7xYY3
         fwd/3AdisukqjHfF8iMl5vjsdJmrtVSGFwzohwVGvTuvMTLa5DbKSMezrv/XmOuoaa6p
         0znA==
X-Gm-Message-State: ALyK8tKsYdRt7d8V5rhSEUjPJEq1VrTBcsaQr7jPT6irCLx3VjeY/sVFwyfvYxiQGAmgQ8qJwVpyxOBmO+a38A==
X-Received: by 10.36.210.198 with SMTP id z189mr601403itf.32.1466143543718;
 Thu, 16 Jun 2016 23:05:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Thu, 16 Jun 2016 23:05:43 -0700 (PDT)
In-Reply-To: <20160616203259.5886-3-joeyh@joeyh.name>
References: <20160616203259.5886-1-joeyh@joeyh.name> <20160616203259.5886-3-joeyh@joeyh.name>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Fri, 17 Jun 2016 02:05:43 -0400
X-Google-Sender-Auth: 9mHvnwcoBpL9MifbCXM2hCPvmCM
Message-ID: <CAPig+cTk8NkNKRcDCWpOhh_g4kXUhHHfFdfPeeq1-zJTzxXt6w@mail.gmail.com>
Subject: Re: [PATCH 2/4] add smudge-to-file and clean-from-file filter configuration
To:	Joey Hess <joeyh@joeyh.name>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 4:32 PM, Joey Hess <joeyh@joeyh.name> wrote:
> This adds new smudge-to-file and clean-from-file filter commands,
> which are similar to smudge and clean but allow direct access to files on
> disk.
> [...]
> Signed-off-by: Joey Hess <joeyh@joeyh.name>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1299,14 +1299,29 @@ format.useAutoBase::
> +filter.<driver>.clean-from-file::
> +       Optional command which is used on checkin to convert the content
> +       of a worktree file, which can be read from disk, to a blob
> +       (written to stdout).
> +       Only used when filter.<driver>.clean is also configured.
> +       See linkgit:gitattributes[5] for details.
> +
> +filter.<driver>.smudge-to-file::
> +       Optional command which is used to convert the content of a blob
> +       object (provided on stdin) to a worktree file, writing directly
> +       to the file.
> +       Only used when filter.<driver>.clean is also configured.

s/clean/smudge/

> +       See linkgit:gitattributes[5] for details.
