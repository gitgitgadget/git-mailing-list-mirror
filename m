Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7851F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeHNXuu (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:50:50 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35726 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeHNXuu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:50:50 -0400
Received: by mail-wr1-f44.google.com with SMTP id g1-v6so18367097wru.2
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 14:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f0A42fOyXWOI4Of2we6988Ycp1e1ukXfFbJGjfjlhn8=;
        b=OTWTCcI6uvcQFaAynZHGO7CyylIxIuPVqNiJlGTCD0QMfz9xK4imY6lO7sZH+b6McU
         fUOpBSGf4EnH+p+Oce8Y9xITjECJYRsbFzlzZ+IErW7X3KQ06sdtw2ixzfBpzGazitpL
         2xtawPi9Ex4Tx2rtYHFa55oKht3VOd1MtHcu9sO71BfgA1qt07isabIrAkDujQjuDQSg
         sro7JHNpCrk1oaZvAUS2XUYpIyJXjgmW5H/VHsr1iY4ZHonq2EcSl6BWkJyR+Q1GujON
         XxklAJXwUOrfX6PNryLS5ukrcsfbGo9ComJ8XTV90BQJAcaRMQv+YlUTeI+PAU+H9G4e
         pcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f0A42fOyXWOI4Of2we6988Ycp1e1ukXfFbJGjfjlhn8=;
        b=etZz6b9KKFYqGrJYwTVw1u4g4g4ktttX1eAqmWbVZdO74/bf2O4BChceiR2HFgmDrQ
         Ept4Z1UOWNdM/qBlOaTQy3Dbr63uB20XiW7SvBbtHzZbCwY2fBb6gIN8iBoMGrimE7HO
         6FnRDsu1KaDomro8+LOV4aZbigfiuAJrbI4Qno4pQ0HcE2BQpQ64gVPJD9gprXgC+9cT
         m5G77COUJfGL5DkA6ghEllAPZ1mGV4+AJvq5knm740M9iOz8KHFPOzIs2ec25CcIp/K0
         D3SZeLO+s+R/UzgRyqTYEW4jS2ANubKTbAqKKedH/KiPGkUS0sLRfQxSCaK/T3qf6gEl
         X0Pg==
X-Gm-Message-State: AOUpUlHubeygVVkyi5/olskBkkcIyK1IGtSiQevXhxOK1rIg/kfT6j5r
        OVN9oifcmqAMhiq2puALieI=
X-Google-Smtp-Source: AA+uWPz7//yX7454X4+ZAnsfoN+BdYyE6DIkJ7j92f9xWSx/opMwSOYHyI3w0FP2VW8Hk/DKuOWIxQ==
X-Received: by 2002:adf:c5c5:: with SMTP id v5-v6mr14414968wrg.30.1534280509178;
        Tue, 14 Aug 2018 14:01:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2-v6sm19596454wrn.83.2018.08.14.14.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 14:01:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org
Subject: Re: [PATCH 0/7] Resend of sb/submodule-update-in-c
References: <20180803222322.261813-1-sbeller@google.com>
        <20180813224235.154580-1-sbeller@google.com>
Date:   Tue, 14 Aug 2018 14:01:48 -0700
In-Reply-To: <20180813224235.154580-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 13 Aug 2018 15:42:28 -0700")
Message-ID: <xmqqva8cy85f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Thanks Brandon for pointing out to use repo_git_path instead of
> manually constructing the path.
>
> That is the only change in this resend.

Rcpt.  Hopefully this is now ready for 'next'?
