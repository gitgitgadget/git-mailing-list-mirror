Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00F61FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 18:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932733AbdCGSa6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 13:30:58 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34921 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755647AbdCGSa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 13:30:56 -0500
Received: by mail-pg0-f48.google.com with SMTP id b129so3363972pgc.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 10:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+XxGZMTatuOSzaBfrRZQdSdOCoDSX1h6ZKPdQZDYae8=;
        b=KiHYlrpXjqBFOP0ATlMN5EkznBrixlzEC9nxYRHESGVpxH1rnOaf1wyv+E4C/dj0e6
         YbTjxlN4yzelEHWn+XPMYhxbf53Ug6X/2YZJe01tJICYd7dnXRnl3xBY08KDhZEIfA+y
         FgbMLgxYhKsszJojrynQgmOyxo1PS4d9SmOTzYAzkpHFEg+7KDoWcucColbn6zznrkrj
         j+FGBnnJWAJ6OZ/2yPg3/Dw0gQKqlYDWl4owzOGxbyRYpSUrJL9V1t+WCBkzRvjNoh2R
         0cq7y2L/Tw/rOkXVBXg3YSdlHk+RZntwy+5rxGfCc6NcRTZTm6UJXdm/JtCzuRnAlUM9
         VC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+XxGZMTatuOSzaBfrRZQdSdOCoDSX1h6ZKPdQZDYae8=;
        b=Usi+hW0ZgHpRJyGhnBH4Ov74gTBoRFionbSRCMwk5aqjKVqdhDtUjTz1/rsRZZ6HB5
         w7n226O5V5+DjKjo2XHETkMXkcffIMHiznxGYJCLMOmRbDo0ippyRgRS2dCxUG4VpZPc
         ZVn2qYxgZLLJtGiZw4/c8iLlJtlRvVNyYT95Rsgercb+XPpBQw0SKoLGfr583wNvV9hJ
         gNQpUpCb62+LOTt7eLOADb5OuXWYMx0SvV/IbcOUulKOO7iYxOrAmze+uy0wKKQUD4pV
         k5LlzE49Wg0BSJJqgl6U7AFbTOuCkLmAtIdEMGnseGbLDUhSn5/TUv/NkoEldSA+yQSd
         LBag==
X-Gm-Message-State: AMke39mK01k6ZSXJdmR/oNCyPQXGJG1Z8b7WWEv5ML1Kva3h4pz5TWo5lShvtkiPMySJNj0IP2rwfZ546oAbUaLe
X-Received: by 10.98.198.78 with SMTP id m75mr1936505pfg.160.1488911454865;
 Tue, 07 Mar 2017 10:30:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 7 Mar 2017 10:30:54 -0800 (PST)
In-Reply-To: <0102015aa974d7a6-46afa73b-4378-4b01-9db4-723fb9e41d65-000000@eu-west-1.amazonses.com>
References: <000001529cbe5436-285f0113-5761-49d8-8961-5a9df0180ed7-000000@eu-west-1.amazonses.com>
 <0102015aa974d7a6-46afa73b-4378-4b01-9db4-723fb9e41d65-000000@eu-west-1.amazonses.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Mar 2017 10:30:54 -0800
Message-ID: <CAGZ79ka_5QogUEwF6SPCwyqSrCNSrtAsqzqJQdXsJkZEAyzDNA@mail.gmail.com>
Subject: Re: [RESEND PATCH] git-gui--askpass: generalize the window title
To:     Sebastian Schuberth <sschuberth@gmail.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://public-inbox.org/git/xmqq60jz2xry.fsf@gitster.mtv.corp.google.com/

Although the following are included in git.git repository, they have their
own authoritative repository and maintainers:

 - git-gui/ comes from git-gui project, maintained by Pat Thoyts:

        git://repo.or.cz/git-gui.git


I cc'd Pat.

Thanks,
Stefan
