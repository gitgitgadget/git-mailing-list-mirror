Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6531F728
	for <e@80x24.org>; Thu, 23 Jun 2016 05:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbcFWFoa (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 01:44:30 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34959 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbcFWFo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 01:44:28 -0400
Received: by mail-qk0-f169.google.com with SMTP id c73so94554449qkg.2
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 22:44:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xp/tm6fhP+8BkXYtZin9EjQwO7R18YHmkfJ/+GvQqBU=;
        b=GwPxwqtnis9OSXCUAKeXLv6p4qirynQg4Dnp7SOa83cx4ombsoSG5RTewYvlVWJyI5
         NNZQXfiP/qb0EbdfQEiaOpVBeAjK/bDORt0ibXU8h/K5DAZDhHV4QTLXALHxT43j5ykL
         oOj7148HxJT3aESqIR2ZFw/f2mhUsiVGXN2FQxH0/k0h8Vx7D3Sxk/ewxAQIeF+2QFCG
         xP9gpUafnVgcG61yxDpnz1JvJozaqdQVhsfnO/1O7mq052FbW90oNgJsYCI8YkX/A25J
         y98RcCS7GxKHAnxxcRWCfZRB8uZATNR24RAdF/VIpMSlIHQR8TzOZpKFbBBUKE/Vc9VT
         AKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xp/tm6fhP+8BkXYtZin9EjQwO7R18YHmkfJ/+GvQqBU=;
        b=jUGA3QNlocE3Sot+HlD3zfaXFPPYNJ0tu78J3f9DIMVId9VKpvD1VVg2MgRcpDrjzh
         ziuae0gCCyWLAbRzh7Qu8evFjXhyDaoIFFzbV4LsyWMatDRNrbsuQSaq2/1Sy+YEExzc
         KS3VAL5vLtssFDp/YMePovpPwrC6wN+Z/XFH/ufiH6rVsgVD/DHeMMiULWDa/w5w4no1
         YWLJDhBsgk5MLuNaip68hXf8n21JSFw+u8wtp+Rb6KOtdm9fwab5BZFEIR2a/wFZYqPl
         5ddECW2nKdQMbmrRgoo4sQiYohirSCqvo60mXzfQIH+E0kUNOgucGTgU9KqelxbB6VIn
         kORg==
X-Gm-Message-State: ALyK8tKVJaIJdDe/hOcAQ/TNULg5HmJGM/4SKWjC9ik9+0HtU21MICYHpm4nkTh/1M3CtkwDUceVgVWirRRv5Q==
X-Received: by 10.55.47.6 with SMTP id v6mr40952383qkh.11.1466660667877; Wed,
 22 Jun 2016 22:44:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.123.6 with HTTP; Wed, 22 Jun 2016 22:44:27 -0700 (PDT)
In-Reply-To: <xmqqr3bpklsd.fsf@gitster.mtv.corp.google.com>
References: <20160622165126.12786-1-mehul.jain2029@gmail.com> <xmqqr3bpklsd.fsf@gitster.mtv.corp.google.com>
From:	Mehul Jain <mehul.jain2029@gmail.com>
Date:	Thu, 23 Jun 2016 11:14:27 +0530
Message-ID: <CA+DCAeQUJ4D4kjR6FtTibwPO8o+wv-hQNDDj2ysJaBHGTPkHgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Introduce log.showSignature config variable
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 2:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>
>> Add a new configuratation variable "log.showSignature" for git-log
>> and related commands. "log.showSignature=true" will enable user to
>> see GPG signature by default for git-log and related commands.
>>
>> Changes compared to v2:
>>       * A preparatory patch 1/3 has been introduced so that tests
>>         in patches 2/3 and 3/3 can take advantage of it.
>
> It is unclear how this change allows the remainder to "take
> advanrage" to me.  Earlier, "signed" branch was created only when
> the GPG prerequisite is met and with this change the branch is
> always created, which is the only change as far as I can see.  But
> the tests that are added in 2 and 3 are all protected with the GPG
> prerequiste.
>
> Besides, the invocation of "git commit -S" after this change is no
> longer protected by the GPG prerequisite and it may even cause the
> 'setup' step to fail on a host without GPG.

I overlooked the GPG prerequisite when I created the "setup signed
branch" test in patch 1/3. I will send a patch to  rectify it ones
everyone agree with the idea behind this patch.

In patch 2/3 and 3/3, there are many tests which requires a branch
similar to that of "signed" branch, i.e. a branch with a commit having
GPG signature. So previously in v2, I created two new branches,
"test_sign" and "no_sign", which are identical to that of "signed"
branch. And with these branches, I wrote the tests in patch 2/3
and 3/3.

As suggested by Eric [1], rather than creating new branches, I
can take advantage of "signed" branch which already exists.
So, I created a new test to separate the creation of "signed" branch
from existing test "log --graph --show-signature". This was done
because I do not want new tests to depend on this test. If in future
someone changes this test then it will affect new tests introduced
in 2/3 and 3/3.

Now the new tests and existing one ("log --graph ... ") are using a
single branch "signed" to do there work.

If changing an existing test is not well justified here, then I can create
setup test for new tests only, without affecting the existing test.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/297648

Thanks,
Mehul
