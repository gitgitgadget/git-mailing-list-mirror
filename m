Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1EA20248
	for <e@80x24.org>; Wed, 10 Apr 2019 03:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDJDBj (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 23:01:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36634 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfDJDBj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 23:01:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so849385wml.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 20:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aKenXnke4Jc3aWpKpyqOPbiNPGqgMWV4m+49sQz/pUk=;
        b=IfZ3KC70wkGb55130lenLhLCmR5OvpbypFmYcGN5Md+utFNIWC+ln5fAjcWt0JXHTw
         26wMKan7CPAzbfQa4v6T7e29GWhiLW3x8xtw9+LCwKWRYVWMGqddiMzr0kk093zTZDs2
         0FCEO1zsXGMUnBgjllcj5WJX7NhBg04vom5ibN1cc0jsaCmJNem59STROu3tpodDgQpk
         sT/lQCtM+xy8cFdPqtlQAotgEjKbFq7tZc72FnEJqTsIoh7v8xpQowyVDIor+JuPhdry
         d79GO8i4d1EDcMdnlIdbbyHuXnmRGSPpKvYBdP5dVkoKG5hOVOwChC7j6n9/H9WUxfr8
         ysgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aKenXnke4Jc3aWpKpyqOPbiNPGqgMWV4m+49sQz/pUk=;
        b=eZlmcFsjrbWgmCYWG/6Eglsg5ZkVAfaNhoH0TfFA7DtP0Zu7oU+T5p7sZ/QrlVzxkM
         HemIMmZ13IsquMurwMcxwTaZhl+P+mrOPvta2UWgaeXxZYY7YH/KYQZxA0PocwF4EQ4R
         rJVgGX4QxMPtl+j3A1BT+4VVE2VTVGqlSqSuI4tcgp10vGuz30ERxgIbDFkAONYfnTsj
         RDlL8BnW/1xG3tuMpONkMj0e7FwqMiVQteWcub8k/Tol9MCQnsS7ywEQRUGJ8yg39z+S
         mQE8OQWzG+w4SSVT2Rb9msXOrCIwoZsKON/RvOmTOjNxwdzqLRtYN+/d5GVBPQ4el+6V
         AJog==
X-Gm-Message-State: APjAAAXq0QtgyZq8W/8pBYIasOXJ7+DuDilCLcf3qMr33HjvIDQxBN1b
        CNZp0UMUBywWv1qLJrSIv3M=
X-Google-Smtp-Source: APXvYqyVbe3uC1++qnUX75Jufy4CjpsUoTtKwpL4P/2P5Nz3WvPHbnGV8gvpUiCwUZw2H217zVRQlA==
X-Received: by 2002:a1c:6502:: with SMTP id z2mr873360wmb.119.1554865297333;
        Tue, 09 Apr 2019 20:01:37 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 13sm1283124wmf.23.2019.04.09.20.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 20:01:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
        <20190409191831.GC32487@hank.intra.tgummerer.com>
Date:   Wed, 10 Apr 2019 12:01:36 +0900
In-Reply-To: <20190409191831.GC32487@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Tue, 9 Apr 2019 20:18:31 +0100")
Message-ID: <xmqqmuky36nj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 04/10, Junio C Hamano wrote:
>
>> * tg/stash-in-c-show-default-to-p-fix (2019-03-21) 1 commit
>>   (merged to 'next' on 2019-04-10 at 9489a31a36)
>>  + stash: setup default diff output format if necessary
>>  (this branch uses ps/stash-in-c; is tangled with js/stash-in-c-pathspec-fix and tb/stash-in-c-unused-param-fix.)
>> 
>>  A regression fix.
>> 
>>  Will merge to 'master'.
>
> ps/stash-in-c is still marked as "Will cook in 'next'", so I assume
> since this is fixing a regression in that topic, "Will merge to
> 'master'" is a mistake here?

Thanks.  I actually intend to unfreeze ps/stash-in-c and topics that
fix it, now this topic is also ready to go.  So I'd rather mark them
all for 'master', and give all of them exposure so that we can smoke
out remaining issues, if any.



