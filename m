Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10200202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbdCOOJd (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 10:09:33 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:36099 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdCOOIM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 10:08:12 -0400
Received: by mail-ua0-f177.google.com with SMTP id 72so9749225uaf.3
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=2WcZIZu7WXAhImfi55tZd1J7dyYg8F8vboVxdP9N344=;
        b=IBThvTS2ItWBf5p5kM8o1fzJ/BEtEwp4W/A48LuKOY51IsoyrcsO7OzwQ/fDcomApP
         m2Ts3waqFBa38Q9GWaU5zQiQfWQ8d8uwzLtj4HB67wHqeLWPBSC+47d3e2i3N7Rzm4hW
         V+a4fVbACoDVsIpc1ykKcfVIULwVGf/2XHqwnvMgq6FeghsOO4CovUFgU5TdoPkjqFSi
         wu8mhk5JuH4FxIxsksnLk/vQbUV2S1sBzmU7ZEQz235To0dXgFe+ENKw+flT6Tmdx0IS
         LYOn0ywFmYuz1CL0qs7mtKDz/GJjfB6ihyVQmyLi1wi1OSzjyYgT5yztXWVbfV55RaYY
         gyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=2WcZIZu7WXAhImfi55tZd1J7dyYg8F8vboVxdP9N344=;
        b=BLCOASY8kDHd3cNWetwypYixWIFDrNCFeY5XHchpatQ4UznXZ+XrATrEUaydbF48HQ
         tNfDJ30KKaYGP1AvQlXI8WQLDyfjphRolB7fEcmBPQQknT8h8zRNtEx/QM3cupvhFpfq
         rcHFb9owLype6TOPe+1r27vFSFimB4ld/LRi2/tVv+Ucq0TN90+ZB9EaEoWchHDiMabA
         2peLDiAb4MYZbS8neodivObwJ2lO2R5/pai2Q60fhTHTZ+S/yxN5l+lA2VC/V7DdX+Tl
         irIqQ9B4DN0vkIVtlS1GG72hK5jeD4jPo8gVwzqG4QrDrkbs4WK2eCoNIVBo3b6jl2pd
         oOaw==
X-Gm-Message-State: AFeK/H3iQ3JohUq+tlo2PKN3zRsQBGEvqDBWF5Sx/DoEzEpDQ/sEtHOnOBd5/QFdFntCs6J82uZ04MK+nzAlyA==
X-Received: by 10.176.69.103 with SMTP id r94mr1353723uar.161.1489586890642;
 Wed, 15 Mar 2017 07:08:10 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.82.136 with HTTP; Wed, 15 Mar 2017 07:08:10 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 15 Mar 2017 09:08:10 -0500
X-Google-Sender-Auth: sOVC78KfpYss3bW9z3pQg966J0M
Message-ID: <CAHd499BP-iaXJDNg+4RWB9GaQ1xW8ZnH0oysWSa7u_DCSWFFDg@mail.gmail.com>
Subject: git pretty format: "%+b" not working with "%w" in front of it?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have the following log:

$ git log

commit 7ffb909bb8f38607e3d6d9f3504a66ca978f0ac2
Author: Robert Dailey <robert@ziosk.com>
Date:   Mon Dec 12 11:01:00 2016 -0600

    Add initial skeleton files & a few interfaces for new kizi/sc16 stuff

    This is still FAR from complete....


I want to generate changelogs, using github markdown list format. I
tried doing that using this command:

$ git log --pretty=format:"* %s%n%w(100,2,2)%+b"

However, the 2nd newline is not inserted:

* Add initial skeleton files & a few interfaces for new kizi/sc16 stuff
   This is still FAR from complete....

The format I'm expecting is:

* Add initial skeleton files & a few interfaces for new kizi/sc16 stuff

  This is still FAR from complete....

This seems to work, but I do not get the 2-space indentation required
to continue text on the current list item:

$ git log --pretty=format:"* %s%n%+b"

* Add initial skeleton files & a few interfaces for new kizi/sc16 stuff

This is still FAR from complete....

So why isn't it working when I use %w before the %+b? Am I doing
something wrong? Note I'm using git version 2.10 on Windows through
Git Bash.
