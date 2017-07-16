Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495F020834
	for <e@80x24.org>; Sun, 16 Jul 2017 00:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbdGPA72 (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 20:59:28 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36104 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdGPA71 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 20:59:27 -0400
Received: by mail-lf0-f52.google.com with SMTP id h22so69694119lfk.3
        for <git@vger.kernel.org>; Sat, 15 Jul 2017 17:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gUgDGO1XzWV0LN/UDqZlCwtNRYfVyJWVqNt37CBwCog=;
        b=cnuIUFUhctzTpi9gLZMcXABH+oGYd6ugaieBrOOclwhSaPpDkbK90N15Jc/0B+UJyl
         2f0GC1iBCGTmUduGKFDj5yskb0EUSEt6KCgO5HYg3cYi4U4U+2mLsWt7GiXgwZq0Xkvs
         jUORHmFULBLVuMWHQ2J/uGYO23JAAJqelgGDyIl1puDWOmSrarlfDPc+8+6pGw3hhhPt
         yRAyJuMUaOYhQZnP7MTkNftAG/xW/DvN506M7j9qyNd6OM+bLyKNkhDrtI4OFS3H+Uio
         iyk0MlJoEt+Nt2urOTHFaeK1c3XrAl05SUmfSZRTknEUlxSrFfmZ+t2AUUHZz2RL/Nkt
         ToJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:organization:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=gUgDGO1XzWV0LN/UDqZlCwtNRYfVyJWVqNt37CBwCog=;
        b=EgZPsOfc/CxAGLCET6k+6vHLTAvbdKc2Ic21i87xO4n3pwtBJGdOMGEdCn/AHk/iKT
         rXqK8TF08W+mSyx5JxFxdfn4qjo1TOtngm/IGsqUDScaKF/9KkatYop6krOsiBMEsCoR
         aGmyYZJMEZ+3SsRpioMY/9By64GA+LkuywZi6EHYv69UoFyWV79r0iGLTBdmjXRA0FIJ
         EyuFvIjhvL0bvMH2iPPsshYdpTZGh3+HzDkGkCKIgXlUlJdXwOxXcMFaZrmRtMrne3Cu
         CQnjEDfxIBs2Ti8ehE5rTFJWuX+yEnNk+Q/3g6I5EG1ho6BA1IZ07cyBkJYVw4orFGs2
         CiEQ==
X-Gm-Message-State: AIVw112LpW0a3G400Ly34zGJ5KqrRkf0UgEmpNI5YLZF24kVYJwSGxpm
        OxrdZEiSNLbTAxKsch4=
X-Received: by 10.46.1.209 with SMTP id f78mr2798651lji.55.1500166765514;
        Sat, 15 Jul 2017 17:59:25 -0700 (PDT)
Received: from gauss.local (81-235-138-217-no63.tbcn.telia.com. [81.235.138.217])
        by smtp.gmail.com with ESMTPSA id b126sm2941823lfe.39.2017.07.15.17.59.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jul 2017 17:59:24 -0700 (PDT)
To:     git@vger.kernel.org
From:   Jan Danielsson <jan.m.danielsson@gmail.com>
Subject: Keeping a non-1:1 mirror in sync and keeping private branches
Openpgp: id=C714C43356FB8176822FC591EB087C6291361CDA
Organization: La Cosa Nostra
Message-ID: <699d0274-285f-3d30-654d-d9ca59fe4dce@gmail.com>
Date:   Sun, 16 Jul 2017 02:59:23 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

   Let's say there'a s hosting service hosting a repository which I want
to self-host.  I don't just want to do a mirror, but I want to keep it
in sync (using a cronjob).  In addition, I want to have private branches
on the self-hosted repository.  (In this particular case, the "hosting
service" is github, and "self-hosting" is bitbucket -- but I'm looking
for a solution which is agnostic with regards to hosting service(s)).

   Searching, reading and asking around led me to the following (these
are scripts which are run on a separate system which acts as a git bridge):

   init:

   git clone --mirror $UPSTREAMURL $DSTDIR
   cd $DSTDIR
   git remote rename origin upstream
   git config remotes.default 'upstream'
   git remote add --mirror=push origin $DOWNSTREAMURL

   And then to keep self-hosted repository in sync with upstream:

   cd $DSTDIR
   git remote update --prune
   git push

   This seems to accomplish everything I want except that the the "git
push" deletes any branches I have created on my self-hosted repository.

   Am I doing it completely wrong?  If not, how do I make my branches
survive the push?

-- 
Kind regards,
Jan Danielsson

