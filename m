Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6C3202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 16:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbdGKQEF (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 12:04:05 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34487 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbdGKQEF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 12:04:05 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so425450pge.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3UHkL+dZVTUs2hDGCUgtXpfTHwd9w8AgF1lr3lqzRBs=;
        b=Jw/qXR1jZ043nQiPtN901hy6H0ou/h6iCXUo9BPjZqMeB1ayYD35KTh1bbBphLkM/D
         mMxV+Iq72JjD9EWc2b6h5m43oq6jOnyft1qwXgsiXQEkYlJpfEcEU0qJK6LTgxdzmhfW
         DJcy2vEwYkeo5IvIE6l38M3ib6doEbZirSshbnY7y34oNwYOhtrHWSY7fB47vuybXZXA
         4h/O/mEd5bHUKmvaJdar62VabdkG9dNx0+3VZh7asRy24kWKawsCB7pvrbsUqm6XYCoN
         5txXzpB/WGCsYSQhmYHCMRv8LSOeFqYs8A6i6I5jjySI9gYkxOnst9NL+HsArE5vkGFb
         YTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3UHkL+dZVTUs2hDGCUgtXpfTHwd9w8AgF1lr3lqzRBs=;
        b=Pg43nkWGXFJfmc7OAXm9BJB6yPNgBEQR2fRz17LiJapgIdIzY1d0HKKkmmEDvYgXyI
         356J3cil4uIG8HQRAd7ME7TFfXIexrjTnORifttwo0ovIGmru3fDg5Ds6ytdVovLOFWQ
         +/HpayKP3ARjKRacaWussoG8OiOM7NBfCryX+FXlwu988jWw1J+i7MSeiMEm8B2ZFUKN
         I8R7xr1d/B940G+ckfvZmxG0nVUuuRPQ43s71ucwnyUi2obftmuR3lvLmjWNQluXAj9t
         +PkjjWnpeIciEbRj2dSdhHInjqlUAkL3FB9gUuwqLdM+FfL2Cb6cfJQoGGWHJz55eeQt
         BGNA==
X-Gm-Message-State: AIVw111N7pWs7hnk6S5cyUAw83k9gS4wJ1kFnb4a2YwVhBzTvEz6NV+j
        EyxjwdS7whGd1A==
X-Received: by 10.99.112.13 with SMTP id l13mr605330pgc.199.1499789044241;
        Tue, 11 Jul 2017 09:04:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id q124sm584188pga.8.2017.07.11.09.04.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 09:04:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Eckersley <peter.eckersley@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Weirdness with git change detection
References: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
        <xmqqy3rv2cfv.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 11 Jul 2017 09:04:02 -0700
In-Reply-To: <xmqqy3rv2cfv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 11 Jul 2017 08:57:56 -0700")
Message-ID: <xmqqpod72c5p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Peter Eckersley <peter.eckersley@gmail.com> writes:
>
>> I have a local git repo that's in some weird state where changes
>> appear to be detected by "git diff" and prevent operations like "git
>> checkout" from switching branches, but those changes are not removed
>> by a "git reset --hard" or "git stash".
>>
>> Here's an example of the behaviour, with "git reset --hard" failing to
>> clear a diff in the index:
>>
>> https://paste.debian.net/975811/
>>
>> Happy to collect additional debugging information if it's useful.
>
> Do you have any funny clean-smudge pair that do not round-trip?

Ah, nevermind.  Peff's analysis looks correct.  Thanks for a report
to provoke a good discussion.
