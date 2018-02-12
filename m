Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 224171F404
	for <e@80x24.org>; Mon, 12 Feb 2018 13:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935145AbeBLNFY (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 08:05:24 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:55098 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934075AbeBLNFX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 08:05:23 -0500
Received: by mail-wm0-f44.google.com with SMTP id i186so9449576wmi.4
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 05:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqryNSqPCaZjiJAQ+8zYCFfsWeOrhzEGJjJO5kZhVFQ=;
        b=mk/8SLOjBY73+GHQYPFNd/donAtf2n2Rda2HSyNMS47WHAtBBDfwlT4IlEP/jkfPcS
         m4FPQxEzeBVDwAa+kTSKCyp0Nj8tuLOPKS2Bc8Ll0YnP9kiztVReJe6SxQGAdiKbfM4y
         20BY65CEKysu7aCgZKp1iZvB8pTzpxqlbUb176bHePGyY0We2JqsomzUXjYWQYLxjcTZ
         mwJbhl/fW2z6XS1sl/WenZWIec5Jo0+A/zUELMv96KxmTp8pavlYE/koXfuZXsw4KyRz
         STvAOn8k8KougMVbu5XsKf8zZgdJyKjwg26jzQD+u7cQ5toP9Iv3hrm/EvGNSfcQ8cnH
         /+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqryNSqPCaZjiJAQ+8zYCFfsWeOrhzEGJjJO5kZhVFQ=;
        b=BiLIy8nZFhOenaldFaW6V81P/XF03Qhm8Ue2W6oZa2bVq4YHT7fFQw9v12LI363hFm
         RgbSqKQdpkG8S0pA8UQO0BUEar+1dZr/JkMfdQqwRi9Qa1pFcWaY2kUpxDnE1zi8lJL8
         j694RpWohSAjyALfknLGXIBVYQ8OcecrMZ3YZfh7WKN8utyL8Dv8y/BEWGeeLqLEhIR4
         vo6b2QO8S/r5707UzbLuLsRZqLuSSITTth5uU0FYE6ux6WAPg/PNq0XXkfSqHKaLhz8N
         5c55C/yDRC3SxRFwB4KCkFOvakjPJXhanIaKBgkQk3c/Io5YBQ9c1f5IH5OtjGUjwrAR
         fYtg==
X-Gm-Message-State: APf1xPARib/10axsLAxmrOJZQApPYmsrP5xe/36bJ/OS/dgTymUTxYYX
        G9fMWwkB6+iXcF3F5f291cs=
X-Google-Smtp-Source: AH8x226jQcy7+6+WBCH6ERnZsFv7dxrgf6HzMrF5D3HdPWwbg18ecInBuuaKmbjG/mQa4Tk3Skk8sg==
X-Received: by 10.28.71.198 with SMTP id m67mr3864542wmi.40.1518440722543;
        Mon, 12 Feb 2018 05:05:22 -0800 (PST)
Received: from localhost.localdomain (x4db19afd.dyn.telefonica.de. [77.177.154.253])
        by smtp.gmail.com with ESMTPSA id j132sm9034738wmd.38.2018.02.12.05.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Feb 2018 05:05:21 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git bisect run make" adequate to locate first unbuildable commit?
Date:   Mon, 12 Feb 2018 14:05:11 +0100
Message-Id: <20180212130511.32620-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.181.g4b60b0bfb6
In-Reply-To: <alpine.LFD.2.21.1802120512380.17034@localhost.localdomain>
References: <alpine.LFD.2.21.1802090817550.6248@android-a172fe96dd584b41> <9803DEA99A6545F7A3F9A3CE08FE2263@PhilipOakley> <alpine.LFD.2.21.1802091553290.17104@localhost.localdomain> <7135CFE5288C49EEA02785C1F407B46D@PhilipOakley> <alpine.LFD.2.21.1802120512380.17034@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> > 1. there may be feature branches that bypass the known good starting
> >    commit, which can cause understanding issues as those side
> >    branches that predate the start point are also considered
> >    potential bu commits.
> 
>   ok, but let's make sure i understand what defines a possible commit
> that "introduces" the bug. if i define two bisection commits <good>
> and <bad>, then i've always assumed that what i'm after is a commit
> <X> for which:
> 
>   1) <X> is reachable from <bad>
>   2) <good> is reachable from <X>
> 
> this seems fairly obvious.

Well, maybe _you_ are after such a commit, but bisect is after a
commit <X> for which

  1) <X> is reachable from <bad> (i.e. the same as your first point)

  2) <X> is not reachable from <good> (which is not the same as your
     second point, notably when it comes to commits on side branches
     that branched off before <good> and got merged later).

> now, as you suggest, it's possible that the
> "bug" was introduced on a feature branch that bypasses my choice of
> <good> but, at *some* point, that feature branch would have to be
> merged to the point where it was now reachable from <bad> and, in the
> context of bisection, *that* merge commit would represent where the
> bug was introduced, no?

No.  Consider this piece of history:

           <good>               <bad>
              v                   v
    --a---b---C---d---e---M---k---L--
       \                 /
        f---g---H---i---j
                ^
              first
               bad

Then the command 'git bisect start L C' will first consider the
following as "possible commit that introduces the bug":

  d e f g H i j M k L

(IOW all commits listed by 'git log ^C L') and will then
systematically narrow down until it will find commit H as the
transition from good to bad.

