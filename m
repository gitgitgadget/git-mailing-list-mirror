Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94DD91F576
	for <e@80x24.org>; Thu,  1 Feb 2018 10:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeBAKkm (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 05:40:42 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:34168 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeBAKkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 05:40:41 -0500
Received: by mail-ot0-f177.google.com with SMTP id x15so16430648ote.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 02:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l9Ei87So8Vtt5LWPfSyHGPAvcRtFXevISKRvFbzBnvs=;
        b=n4T7kwARjSvpUm5JUzBdwQeZHbllgiYmaHHrrBB5Lc/0K4o+b0x39syIl0Wjr3gWJZ
         s8jZO9Ln2K8duDwg6BgFIb2Uh3HJxOc1ugDVQ/bv1qK6Xn8MlgD79SVfOQ3/IvSHSAa9
         HR5K+ZIKrT1LP5yBavwKn/F/cVrc2fe6aNZdCY/Bz0mtlQh91lS/EdE3fgqLD2xPJr0O
         2kq/oiazy9fmS898VbqLIbhskfj9EXoBAvt6p3X7y7xfLp0dP4U9yg36sd0lqeyHGjKm
         1Y6rZ9nSdAgLlZGBnrbVo3g8Cx+ZSixW9z/dOHGsm6/2zjzcWdo+V12R7NU2Acc4LUTf
         yVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l9Ei87So8Vtt5LWPfSyHGPAvcRtFXevISKRvFbzBnvs=;
        b=aL+W0eTpmfJvXEjnm5lY0f2x8KwU59QVWTCB76D6vE4GpAtU8x+U4faFpyWam0PX90
         oCB5/lIYngqqYNMaccMq9zXhxRy2xeWLkTKEHx2oxmAA94kUkUQ61J1L8zBhgiY40ywa
         Vp932sPN9Mo2n7L9MNwqz/sH2DPWKa+IGvBe3P/+Qjm5l18rPIaOHbXveiTCX4o8aB0t
         AwN1hpnEhwbxrsDHCHR0dHlkfI9BmIQNIMf6xPULOEklxZopyzAXpgA7DzTHZyjmC3hA
         ta5avZbuPzZEgPxpbvcncOpKK6/ftp1zcq8nLBByYEWo6vRO1DPUdy1iUPRCgZJBRoDi
         bB6g==
X-Gm-Message-State: AKwxytcYZn9lN3RDDqR1qQVA9yq9Tv/nfNOcCpU4GSqUuG2u+XAnl6Lj
        xJHHUE5xWhwb3MjKLJ/O8QIwrrFgURU1ms+8ApE=
X-Google-Smtp-Source: AH8x226Ff9GC5n+DoC+1FUE4eXzXSvcfSnv9l3B5uj/IMRtwCG4J8wt+FBg4YPiF3/m/WAYfQvfJIVAknZAnoFdhJfA=
X-Received: by 10.157.53.5 with SMTP id o5mr6173481otc.181.1517481640981; Thu,
 01 Feb 2018 02:40:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Thu, 1 Feb 2018 02:40:10 -0800 (PST)
In-Reply-To: <bb8a433f-bd61-1f3c-2034-1acc96539882@gmail.com>
References: <87efmcw3fa.fsf@evledraar.gmail.com> <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
 <87bmhfwmqa.fsf@evledraar.gmail.com> <20180129094033.GA8670@ash> <bb8a433f-bd61-1f3c-2034-1acc96539882@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 1 Feb 2018 17:40:10 +0700
Message-ID: <CACsJy8CShVSQAZ6ZaGT9i0JDEn19cTMaEmLRDV3ULjaj9DqZUg@mail.gmail.com>
Subject: Re: Some rough edges of core.fsmonitor
To:     Ben Peart <peartben@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        jamill@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 6:16 AM, Ben Peart <peartben@gmail.com> wrote:
>
>
> On 1/29/2018 4:40 AM, Duy Nguyen wrote:
>>
>> On Sat, Jan 27, 2018 at 12:43:41PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>>
>>> b) with fsmonitor
>>>
>>>      $ time GIT_TRACE_PERFORMANCE=3D1 ~/g/git/git-status
>>>      12:34:23.833625 read-cache.c:1890       performance: 0.049485685 s=
:
>>> read cache .git/index
>>
>>
>> This is sort of off topic but may be interesting for big repo guys. It
>> looks like read cache's time is partially dominated by malloc().
>>
>
> That is correct.  We have tried a few different ways to address this. Fir=
st
> was my patch series [1] that would parallelize all of the read cache code=
.
>
> We quickly found that malloc() was the biggest culprit and by speeding th=
at
> up, we got most of the wins.  At Peff's recommendation [2], we looked int=
o
> using tcmalloc but found that 1) it has bugs on Windows and 2) it isn't
> being actively maintained so it didn't seem those bugs would ever get fix=
ed.
>
> We are currently working on a patch that will use a refactored version of
> the mem_pool in fast-import.c to do block allocations of the cache entrie=
s
> which is giving us about a 22% improvement in "git status" times.  One

My apologies if this has been discussed in the second half of 2017
which I have no idea what happened.

I just wonder if it's possible to design a "file format" that is
basically a memory dump of lots of struct cache_entry? This "file"
will stay in a shared memory somewhere and never get written down to
disk. Since it's very close to the data structure we have in core, the
most we need to do after mmap'ing it (and keeping it mmap'd until the
end) is adjust some pointers. These entries are of course read-only.
When you modify/create new entries, they are created new, using the
old malloc(). We just need to make sure not free the read-only
cache_entry entries and munmap() the whole thing when we
discard_index().

This opens up another option to deal with the large UNTR and TREE
extensions in a similar way. These will be your next headache after
you have reduced parse time for main entries.

> challenge has been ensuring that cache entries are not passed from one
> index/mem_pool to another which could cause access after free bugs.

We kind of have something close to that, but not entirely the same.
When split index is used, the same cache_entry can appear in two
index_state structs. Of course you can free only one of them (and you
can only do so when you know both index_state are gone). I see some
code cleanup opportunity :)

>
> [1]
> https://public-inbox.org/git/20171109141737.47976-1-benpeart@microsoft.co=
m/
> [2]
> https://public-inbox.org/git/20171120153846.v5b7ho42yzrznqoh@sigill.intra=
.peff.net/
--=20
Duy
