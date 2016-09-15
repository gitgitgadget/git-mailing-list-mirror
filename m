Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D7792070F
	for <e@80x24.org>; Thu, 15 Sep 2016 16:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbcIOQFN (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 12:05:13 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36052 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbcIOQFM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 12:05:12 -0400
Received: by mail-it0-f54.google.com with SMTP id o3so102996186ita.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ADg6XjRa1GX06o11eg3CiYY0wpsgcrMR7y2Ihf0LJXc=;
        b=KlIW0D1wN5zMMNsXIE9wVbxdi9Ak7e2Vf3DL3CW0AabG308Zz7sc3ohGWKeqGHSogj
         rLaGExvppPT9/DljQKnxxzDzrNB27TcmS4Wd7UbJjAWP7hP+xCa1XtM0nVY4jhY7kevM
         il74RrdscAyWI/s6PJimf/EduXcjhktO+b3StQ8OVnV9ytNtK58GQHwIo+LXHbwCgyQM
         /9WuDwjO7XxqLN961OjqlANNwb20tkIKkC19nMh9lYJLCxZ7UDosDpjYVAzzHirrFD95
         zkW0oVpTk2kdUuezjhO/HV2auRCfty/Dt4OJorvorR3Sn+EXDIFPvLNEoN5wPLU2G0sz
         V6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ADg6XjRa1GX06o11eg3CiYY0wpsgcrMR7y2Ihf0LJXc=;
        b=Vo6NWcnZG2xGYECPdWraJM1cjS9KfIceJ04gKyBTI9QV89Dx2c4Id+dL4gUYQOs4BZ
         M2MR/Tfv1VTD/UFruiPKasR64JghWESaXD0KF8teh4K+gvPfNZAxk/ZgxqRMNZjjKlle
         /1Sdv+cK2dD5L7I2G9SVqC4rvaWO57mVzXRhxcuaSj3PNksWxWGmLSHrjbKKyCglEAYY
         LquSfIaEPEdECe1AXwGH+zOuZeqn+95tcTi47V6BCex9Y4yDkbOjL6nT5IIuTKTAbVIo
         c30Im1OeihOWv1QRGMLuU44Akv4wZg9vbyUMOSG2SckLw9BX4VB8r19ftg3zqPwS5ohc
         4qMg==
X-Gm-Message-State: AE9vXwMarNmQGR9Hv+5fz3GsDhLbvnXD5HVz/z+OnaouXAgHcK6AgIJdUFz8S/bFFvDOgmKtshkcETpHaminLxad
X-Received: by 10.107.201.78 with SMTP id z75mr1436693iof.202.1473955511093;
 Thu, 15 Sep 2016 09:05:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 15 Sep 2016 09:05:10 -0700 (PDT)
In-Reply-To: <20160915130233.GC9833@onerussian.com>
References: <20160915130233.GC9833@onerussian.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Sep 2016 09:05:10 -0700
Message-ID: <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
Subject: Re: [wishlist?] make submodule commands robust to having
 non-submodule Subprojects
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 6:02 AM, Yaroslav Halchenko <yoh@onerussian.com> wrote:
> NB echos some questions of mine a few days back on IRC about Subprojects
> and submodules
>
> If e.g. you just 'git add' a subdirectory which is a git repository, git
> adds it as a subproject but doesn't initiate any entry in .gitmodules
> since it is the job done by submodule and git core itself is
> agnostic of those beasts.
>
> But having then this "Subproject"s which aren't registered as submodules
> (and I haven't found any other use for them besides being a submodule)
> brakes "git submodule" commands, e.g.
>
> $> git submodule
>  cc6a09ac06c13cf06b4f4c8b54cda9a535e4e385 ds000001 (2.0.0+4)
>  0a9f3b66e06a2137311a537b7377c336f1fb30ad ds000002 (1.0.0-3-g0a9f3b6)
>  9da7e4f4221699915645ac2003298c6aba2db109 ds000003 (1.1.0+4)
>  fe16cacb5cb9b4d53c50e498298fab182500e147 ds000005 (2.0.0+3)
>  6898d99ff3ba26880183ed3672a458a7fcde1737 ds000006 (2.0.0+2)
>  bbd10f634fe87e9d5853df3a891edbdb18cda7f9 ds000007 (2.0.0+3)
>  138e6730193c0585a69b8baf5b9d7a4439e83ecc ds000008 (2.0.0+2)
>  ddf3a4cf7ce51a01a664e6faff4b8334b8414b1f ds000009 (2.0.1+1)
>  7fa73b4df8166dba950c7dc07c3f8cdd50fca313 ds000011 (1.0.0-5-g7fa73b4)
> fatal: no submodule mapping found in .gitmodules for path 'ds000017
>
> which then stops without even looking at other submodules.
>
> I think it would be more logical to make it a 'warning:' not a 'fatal:' and
> proceed.

So maybe we would want to introduce a switch
  `--existing-but-unconfigure-gitlinks=(warn|ignore)`
as well as
`git config submodule.existing-but-unconfigured (warn|ignore)`
for a more permanent solution?



>
> Thank you for consideration
> --
> Yaroslav O. Halchenko
> Center for Open Neuroscience     http://centerforopenneuroscience.org
> Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
> Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
> WWW:   http://www.linkedin.com/in/yarik
