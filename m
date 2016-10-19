Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6F0720988
	for <e@80x24.org>; Wed, 19 Oct 2016 01:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933917AbcJSBEN (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 21:04:13 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34291 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932945AbcJSBEL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 21:04:11 -0400
Received: by mail-qt0-f172.google.com with SMTP id q7so6911890qtq.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 18:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E1Izu+HHQ7AuG8dIIHB/LmjqPurA3k6WgBAcDJ6oUCk=;
        b=YN4UipGRm0tcYaXD04Z+p0jPXUSEssugofA/VnChcQdxSb8R2D9//M+m6Dwht2pAI8
         mghXuGFnH++u3XzKRR41MktHRYKjgC316N5ESS7g/rfh8tQ82jGu+CAEDKY+rUgjFVad
         UiKW1AvZC/SB79LRkd1X11myakw4iipKnyvV2iZTmVsphQ/PTzuoA+uhVKT+CWIv2oDv
         WYqsNn5jYhmJp9TN9o9Il9sZQ44sxQkoBQJS+1m28fT+H6O91miRN4c1YVLFiipY/h+Q
         MNEzL0V4ACgKZ+b8qWblLx0LVl3Gbhyueufvg8b7T6g4/QL3jgoC9nPjokxp0MH7sz4D
         VXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E1Izu+HHQ7AuG8dIIHB/LmjqPurA3k6WgBAcDJ6oUCk=;
        b=WWmT+nm5SMDTeXfpsfG6vQ1+CMqkO/4IPxtu2LE5HxJfzZMteIype9jHkIh+80Rzay
         OwW/FpVZCvfvjmLAsJxGkaIe4pP/gmjVR5yUqCCt1RVlF0OX48e7uav6N2H65qkTWppN
         kK0zX8OB5vL4Pqn713zhcT1UshwpJ5SOjTcmAXXH5hR4f0Y5+I8GTbiNpJNaEwchCYDO
         R3HvejALr+i6Pip3SzdJpxCEfnOXhYPHbw7dNSztajE0Pv/AyxOCNT0bzCilEH9ckEQo
         DMw2YMWKCH1DRvEb/zPUlQgjC0Baz2+74jx2qMpMxJfTOKi7oxGMBdWSbZnVQRmZP3v8
         pgWw==
X-Gm-Message-State: AA6/9RngKS+CWgrTX532yBYsNz3T8R1yV/Q0PwPQYeGCHJX7wo0odGeAM75m0DjUuTAIimUT4fY7+GzAElfRwRGJ
X-Received: by 10.237.33.225 with SMTP id m30mr3630974qtc.61.1476839049819;
 Tue, 18 Oct 2016 18:04:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 18 Oct 2016 18:04:09 -0700 (PDT)
In-Reply-To: <xmqq60opnolz.fsf@gitster.mtv.corp.google.com>
References: <20161018210623.32696-1-sbeller@google.com> <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
 <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com> <CAGZ79kZHLVpxbJ_C-dM2LDA64-_TJNyY+52fTWkOvLvvAq2XDg@mail.gmail.com>
 <xmqq60opnolz.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Oct 2016 18:04:09 -0700
Message-ID: <CAGZ79kYrKGLEOO72aWuX5OOM-AecdFZFXRqBkRzhdAM-VbPFxA@mail.gmail.com>
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 5:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The underlying issue is two fold:
>>
>> * in t3600 we'd need
>> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
>> index d046d98..545d32f 100755
>> --- a/t/t3600-rm.sh
>> +++ b/t/t3600-rm.sh
>> @@ -616,7 +616,7 @@ test_expect_success 'setup subsubmodule' '
>>         git submodule update &&
>>         (cd submod &&
>>                 git update-index --add --cacheinfo 160000 $(git
>> rev-parse HEAD) subsubmod &&
>> -               git config -f .gitmodules submodule.sub.url ../. &&
>> +               git config -f .gitmodules submodule.sub.url ./. &&
>>                 git config -f .gitmodules submodule.sub.path subsubmod &&
>>                 git submodule init &&
>>                 git add .gitmodules &&
>>
>> because the sub-submodule URL is actually the same as the submodule
>> (because we'd test lazily)
>
> This fix sounds entirely sane.  The "../." you touched was depending
> on the buggy behaviour; it is exactly the case of "there were two
> wrongs that were covering each other; after one of them gets fixed,
> the other one's brokenness is exposed", right?
>
>> However in t7403, we have a construct like:
>>
>>     git clone . super
>>
>> which then results in
>>
>>     git -C super remote -v
>> ...../git/t/trash directory.t7403-submodule-sync/. (fetch)
>
> That sounds expected.  We do not have to add trailing "/.", but the
> system ought to work with or without it correctly and the same way.
>
>> However instead of fixing the levels of nesting, the fix is as easy as:
>> diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
>> index 0726799..525d32b 100755
>> --- a/t/t7403-submodule-sync.sh
>> +++ b/t/t7403-submodule-sync.sh
>> @@ -15,7 +15,9 @@ test_expect_success setup '
>>         git add file &&
>>         test_tick &&
>>         git commit -m upstream &&
>> -       git clone . super &&
>> +       # avoid cloning a repository with a url ending in /.
>> +       git clone . root &&
>> +       git clone root super &&
>>         git clone super submodule &&
>>         (
>>                 cd submodule &&
>>
>> Same goes for t740{6,7} as well as t7506.
>
> Isn't the issue the same as that "3600-rm" one?  I know you said
> twofold upfront, but I am not sure I agree.

I took a couple of hours trying to get the same fix applied to the t7* tests,
but that doesn't seem to be as easy. I'll try again.

>
> The "super" repository refers to its submodules with "../submodule"
> in the test code we have, even though the submodule referred to
> lives inside $TRASH, and by fixing the "trailing /. and trailing
> /root are treated the same way" bug, its reference created in the
> test ends up referring to one level above, perhaps in t/submodule,
> instead of the intended place t/trash/submodule.  By using "root",
> you are making their wrong references point at the right place.

Correct.

>
> Admittedly, the updated test above tests something different from
> what it originally wanted to test, which feels somewhat distasteful
> but I do not think it is wrong.

I think it is. I was just showing how to quick fix the issue, and how wide the
impact was. More like assessing the situation of what is broken with
that patch, rather than proposing a way to go for fixing.

>
>> I think this change to the test suite is not warranted, because
>> we want to have the current behavior as-is ...
>
> I am not sure.  Certainly we would want to make sure that the normal
> case (i.e. no funny trailing junk) to work correctly, but we do want
> to protect the fix from future breakage as well, no?

Exactly. So not intermediate "root" that we clone from, but adapting the
relative URLs. Maybe half the broken tests can switch to 'root' and the others
go with the current behavior of cloning . to super.

>
> Perhaps we can do a preliminary step to update tests to primarily
> check the cases that do not involve URL with trailing "/." by either
> doing that double clone, or more preferrably, clone from "$(pwd)"
> and adjust the incorrect submodule reference that have been relying
> on the buggy behaviour.  With that "root" trick, the test would pass
> with or without the fix under discussion, right?

I assume so, (not tested).

>
> Then do the fix under discussion and introduce a test that clones
> from "." refers to submodules with relative path and makes sure that
> trailing "/." is interpreted correctly.
