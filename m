Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA961207BD
	for <e@80x24.org>; Thu, 27 Apr 2017 00:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033282AbdD0A3F (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 20:29:05 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35151 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033284AbdD0A3E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 20:29:04 -0400
Received: by mail-pf0-f195.google.com with SMTP id a188so3975795pfa.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 17:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OS6giYr1NsK5W4mxQss5pf6qeNtAyQjNyKeBNvN9eP4=;
        b=lGCnY+HiKCFzla3D1AMcNf/vZpiAooAJu+F1Fs0qMvGh2a4qneOQ8z5msQ544jU4I4
         q2145Q2LxbUO/yHkSppN/LHMjXh2sKtAnUQvbHDMc5RcR2mB8imdkuzO+efRx4PYvvBu
         ZoKKF0x0hzF86uyvIeUQmTf8t5e8CPLoSro0HG1mPFkdBfVuf17HHG1nIHiX+RsIcNbx
         DJaOVMPAAvkumaufAU5wsjRvyFKxIqJcoEJOoJ7fWbqFJAPKke4E2vb3SxJpptB8V0VP
         hcDuZubtlodh6QQetVoU/ABoT44Po3AAqfpvjYMIbCLjfe0I0uDl0Xd9RXhvP6gl7VWf
         HysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OS6giYr1NsK5W4mxQss5pf6qeNtAyQjNyKeBNvN9eP4=;
        b=QgplkPvE+bsAg60LC4KfT8/GNF2IJVg3MDVfp2Sg+0/ppFkFzbkCXWtu74u/KurW3p
         QzgRmfKuqnwPobey5cVd1iqjvmoiHXSIwxMkaZEc2qI6HwWbzpD74mxRMFqnVRFS7enU
         kGPJ6Jjat7sb1lo5EHk9QuaEcrI9K4jGUqfdAB9Du4MYhpXglkBCyupKzLX8mWfbMW7k
         tfX2cw177t0KFcRueYSzw1ayUVAPFslSbgHjE+4yHEIGLZYMY5HCVwcvwU6gALn6JK6l
         qhxn/JZ8p0xnGln3NEaFYFbfvjB3aVjEbF6xUc1M53VeWd6dqPPwFHX0NC5BsoWmfCly
         VN8w==
X-Gm-Message-State: AN3rC/4ZrSmdrFpFvwgXsnmgrpWjTM5Eh+7g/rTjBjGp6bGkgxXUC1B5
        JOIKjhXu89cHLcIMpqQp4A==
X-Received: by 10.98.56.216 with SMTP id f207mr2760702pfa.71.1493252943358;
        Wed, 26 Apr 2017 17:29:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id e207sm670790pfh.121.2017.04.26.17.29.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 17:29:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>,
        Orgad Shaneh <orgads@gmail.com>,
        Dakota Hawkins <dakotahawkins@gmail.com>,
        git <git@vger.kernel.org>,
        Christoph Michelbach <michelbach94@gmail.com>
Subject: Re: Submodule/contents conflict
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>
        <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
        <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>
        <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>
        <C3A8A88B8DDD468095B7FD256330EEF7@PhilipOakley>
        <xmqqa873ubiw.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZEveo8jQodvd0n6fEXc1OXDVa26BCumM0etjst74F_Hw@mail.gmail.com>
Date:   Wed, 26 Apr 2017 17:29:01 -0700
In-Reply-To: <CAGZ79kZEveo8jQodvd0n6fEXc1OXDVa26BCumM0etjst74F_Hw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 26 Apr 2017 10:41:11 -0700")
Message-ID: <xmqqinlqr8vm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> +'git checkout' --working-tree-only <tree-ish> [--] <pathspec>...::
>> +       Similar to `git checkout <tree-ish> [--] <pathspec>`, but
>> +       the index file is left in the same state as it was before
>> +       running this command.
>
> Adding this as a new mode seems like a "patch after the fact",
> whereas the wording hints that this may be included in the prior
> part, but I find it hard to come up with a good description there.

Yes, having three distinct modes of operation covered in a single
entry makes the description unnecessarily messy, as you have to say
"generally these things happen, but if you use X then additionally
this happens before that, and if you do not use Y then this happens
instead".  We _might_ want to separate the [-p|--patch] mode out of
the main one, making these into three entries, for this reason.
