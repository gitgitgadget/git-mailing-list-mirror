Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2511F404
	for <e@80x24.org>; Wed, 12 Sep 2018 22:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbeIMEBM (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 00:01:12 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38650 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeIMEBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 00:01:12 -0400
Received: by mail-wm0-f44.google.com with SMTP id t25-v6so4084354wmi.3
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 15:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C12RajrtH3HdBVKGqZ3jnN/RQJEHGsnEeR6xmkHBDCo=;
        b=kuT1Diypo1ItQLe8CUVFG1Rmzqak0e06GYjObHEm5RUO5jM+8ksY4PQG2EDsnOVwA6
         aJhcG5RWnv0Ml5GwktDcuVAMIkLFkbVRYCQz7TRlkJzf4KVVaSYPd/jQIAIZ9mcU54z6
         YA5t3VS/+JJwpYsFarHrqbAWkL0xq/o5DMk7I68fb95vONNl2Z0OIWlwu/XnZbx1y8D5
         2x8ztrVW0bRj54ckuksJMhycDNKSi0qsjx9Miux9qcwdwBGnhHVT2qZX4m0vnU+EFWEh
         PufzgOV/GdEm9UNeMId//Ev4OPT4JiQ4vN/ReEE2ip9l6lLxjcNY3vhbpdDI6yW+jIak
         Y9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C12RajrtH3HdBVKGqZ3jnN/RQJEHGsnEeR6xmkHBDCo=;
        b=JlufFTlEUQ7Dnu2DsHBybzbqp5OSQIXOVCkCNrWii/md2bItHa3DFaeRHY+spD+I1S
         P8e7o2byvnJuEs3al1SrsEZqM3rO32Ri+AGs4JSEH77BHEN5Xoym7O64REgHwaWFJbSD
         nSYJUKtr0zZQ3KP2fP29aH9xlvODbezHwMxkMlbI+VnxvGAwDYPiW+6iWO7XC2d3SXe/
         +U2VuIr9nfSQmLtsbj7Cubqg7oeQzDJfbNoPxgx5D8FRPyo+NTCcAquadYeI82ZZJ+y4
         6tBF2iAn1X/amyxCsmGK9+QqvACIKviS8cBedGioKvACr42W7SxOS0smXe2dRGaT+UJL
         xwdA==
X-Gm-Message-State: APzg51DLmcH97lJXDMdqb/LA8/0wm+/dgUtDwL1mpUDIQaEc17RnkjRe
        2IL5tA8pN0XVMgEhizSjUV8=
X-Google-Smtp-Source: ANB0VdarMUe3lonTiStQ6wsvnAqpW42I97cebTq9vXZim/I1HnElT0Hncr9qYUhmNprYjG3uvr5JYA==
X-Received: by 2002:a1c:c501:: with SMTP id v1-v6mr3149554wmf.115.1536792871530;
        Wed, 12 Sep 2018 15:54:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m8-v6sm1757113wrn.72.2018.09.12.15.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 15:54:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] contrib: add coverage-diff script
References: <pull.40.git.gitgitgadget@gmail.com>
        <e4124471e5494b737d99eceed25fb03e787d0b96.1536770746.git.gitgitgadget@gmail.com>
        <xmqqa7omjred.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 12 Sep 2018 15:54:30 -0700
In-Reply-To: <xmqqa7omjred.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 12 Sep 2018 15:13:30 -0700")
Message-ID: <xmqq5zzajpi1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  contrib/coverage-diff.sh | 70 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>  create mode 100755 contrib/coverage-diff.sh
>
> I fully appreciate the motivation.  But it is a bit sad that this
> begins with "#!/bin/bash" but it seems that the script is full of
> bash-isms.  I haven't gone through the script to see if these are
> inevitable or gratuitous yet, but I'd assume it made it easier for
> you to write it to step outside the pure POSIX shell?
> ...
>> +	elif [[ $REPLY =~ \+\+\+\ (b/)?([^[:blank:]$esc]+).* ]]; then
>> +	    path=${BASH_REMATCH[2]}
>
> OK, it probably is easier to write in bash than using expr if you
> want to do regexp.

Just to clarify. I am saying that it is OK to give up writing in
pure POSIX and relying on bash-isms after seeing these lines.
