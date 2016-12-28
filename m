Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535E620441
	for <e@80x24.org>; Wed, 28 Dec 2016 17:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbcL1Rpz (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 12:45:55 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34587 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcL1Rpy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 12:45:54 -0500
Received: by mail-qk0-f172.google.com with SMTP id h201so111852623qke.1
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QebwkQ1xGFZnN8liaBCm+cIq+m1z3KKozWptMWAjohg=;
        b=CDuhOECUnhaYfMWSONaf50rSJCSR5xShBcW4Rwt0MlPBYaf4lmzToEAVlu8IriTeVR
         aNbaEgAmvFey1t26IWcaf5uUP1//x1c7pFSbMgLUCxlnjTPQNyxJ7P9lGUtxzmtOiS2/
         +Nk54p8dlFkeQGEay2QcQR0XCtVR/EAEjQfY5dhHjDVg7rIKpJ7rzbI4TfeaAf4d6C7P
         QHAPo4rRvz00peaW40oJy62boVy+Xwl6G2P0h9+eV1mdsQyWWfC8N/dulaucf8vNFSL0
         G/QOSKFa2tbytYM3HQBiQz28RDh47PLHLBiB16Sul03k2Uvs3ySMa99ZT8KFHPr5U1Nj
         /lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QebwkQ1xGFZnN8liaBCm+cIq+m1z3KKozWptMWAjohg=;
        b=irvhaUK/UbNWz17o2IbKG2yUAl4vzLa8n+SXkCjYo765w1Qc4HhSqjR/Xzawrqn8XJ
         jqTnoA1PcqiIn0RJltw3dECuNBOCvRQTTE6c6/3eTeKrqQuFdUbFdRED3lxP+9YWQDbL
         H/ebshhWJ0zf5Ff0hpRLbTAJWN0H60T7G8fpFyXYGeV/Q4BIqlQcPXmuzrARAdoEW/jJ
         7hxjiUI1ay3PdnZeeKmcIVzR1tNEBcvusX152ODE+qymVsUEjKkeYMAJztOORrgAUtpA
         gyumTiRzo88ofysqje62F3X7uHmGwoTVeq45e8kqOB8NVTt68xHCY+7wKngtoyaFlJaZ
         2x6A==
X-Gm-Message-State: AIkVDXIOwawo+EkPBSo1r44lefgNfC590DW+vTtgKB+SyRz6hhfZqJfH3jXCsdXjUdAl0+hJYL9o8+Z47LO67Pm+
X-Received: by 10.233.216.7 with SMTP id u7mr35659094qkf.220.1482947124734;
 Wed, 28 Dec 2016 09:45:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Wed, 28 Dec 2016 09:45:24 -0800 (PST)
In-Reply-To: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
References: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Dec 2016 09:45:24 -0800
Message-ID: <CAGZ79kbRMYyaOmuqymx9dsLGdvX+iM9OMMQtQGS=uA+dO6_MVQ@mail.gmail.com>
Subject: Re: [PATCH] am: add am.signoff add config variable
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 9:40 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> git-am has options to enable --message-id and --3way by default,
> but no option to enable --signoff by default. Add a "am.signoff"
> config option.

I think this is a good idea (from a design standpoint and what the user needs).

Just like e97a5e765d (git-am: add am.threeWay config variable), we'd
prefer if you'd
also update Documentation/config.txt as well as a new test. :)

Thanks,
Stefan
