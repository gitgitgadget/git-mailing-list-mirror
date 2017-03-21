Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D46C2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 17:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933286AbdCURqw (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 13:46:52 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34806 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932990AbdCURqp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 13:46:45 -0400
Received: by mail-pg0-f54.google.com with SMTP id 21so63874386pgg.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xB13KTunbeWiH/3xLKichYygohNUc/cDmSbUJwStYYY=;
        b=UvotaLb95F05bbM14Yq9zKo2y7l8YIfNd+Lr2uXcBKtxI1R1Ae72PTnv8O4g5gah2r
         5vmCLxzdWpSoikgBT4ViZyGzQSI8+i1psB0qERvXFtG6IPYCbU4MG4xXUmDKHQxE1lNM
         ZdHGnWs8Wqe1IHcFV/qDGhthRhYWjU9axYGeiUkvqngU8WjCGmC0TdLAUsK331XG2baC
         VsiPGaNRMqSRRTkOldqZ6blLURnTyUxVW/enxpk8LhECnXmlc85t5tJSUwoeKGVFCTBG
         8q+UdY6zHvpP1h0+aKJFGPrRaEpui/hkWO9GWKyZmweyN9w/tJY02f5yjY7vLjoG0M5x
         mz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xB13KTunbeWiH/3xLKichYygohNUc/cDmSbUJwStYYY=;
        b=ZbgpSR5KqMnFzWhsyp5Lbw9hU9i7fXw7tlc9zrEfp031CcfBp9JnItcvQtsVeD4aD7
         TIFcDshUdu0C3gwaF2rtB1aRi2pcbcsY1mOmrnncdOJFoedoHUjSuZQbXHTDFIvR2KPk
         4irp7ZftGvT7aYrTWajwRDTYFuL6cD6DLAIaUk0VzZj4h+1szwsggA5GChEByNQo/7B/
         RhrAu+nU8E9tPbZBVRMXx/yvvf6a1mCGFmDj2x2BcjRYG48i0K/xTZsTQr0OSFFkXlRQ
         skGjxKgibYFSthwlohejpPrkC/BBadqGtwjIAmiyuwhMJ7ha7D4JIiX6Fi0Cj7wpVXw1
         RZGg==
X-Gm-Message-State: AFeK/H3K+oAKdyBhDQnsqpO2IKc9gGEudAMTMSEYObHVeSP3fDlyquM+iBzkHgSIcTuUGEDF+Fmq8sM9HOnIVB3c
X-Received: by 10.84.195.129 with SMTP id j1mr48434875pld.88.1490118403553;
 Tue, 21 Mar 2017 10:46:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Tue, 21 Mar 2017 10:46:42 -0700 (PDT)
In-Reply-To: <xmqq7f3jta7o.fsf@gitster.mtv.corp.google.com>
References: <20170321001156.21915-1-sbeller@google.com> <xmqq7f3jta7o.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Mar 2017 10:46:42 -0700
Message-ID: <CAGZ79kYRgG2CBpTv9qtH0_XZcziqF5rGLyDTXV8=pLLaSGukTA@mail.gmail.com>
Subject: Re: [PATCH 0/3] git-describe deals gracefully with broken submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Our own version generation in GIT-VERSION-GEN is somewhat sane by testing
>> if we have a .git dir, and use that as a signal whether the obtained
>> copy of git was obtained using git (clone/fetch) or if it is just a
>> downloaded tar ball.
>>
>> Other scripts to generate a version are not as cautious and just run
>> "git describe". An error from git-describe is treated as a sufficient
>> signal to assume it is not a git repository.
>>
>> When submodules come into play, this is not true, as a submodule
>> may be damaged instead, such that we're still in a git repository
>> but error out for the sake of reporting a severly broken submodule.
>>
>> Add a flag to git-describe that instructs it to treat severe submodule
>> errors as "dirty" instead of erroring out.
>
> I do not have a strong preference for or against the "treat a broken
> repository as if nothing is wrong with the revision, but just mark
> it as dirty" idea.  I would be more receptive if it substituted the
> "-dirty" marker with something else, e.g. "-broken", though.

ok. That was my initial plan. I plan on also incorporating this into
git-status.

>
> My knee-jerk reaction to the code change is that treating submodule
> as something very special is probably not a good idea.  Even if you
> do not use submodules, if some of the objects referenced from your
> index and/or HEAD are damaged or otherwise causes some error while
> accessing, the diff machinery would die, wouldn't it?

Yes; ideally we would want to have a generic "error with working tree"
for all these kinds of errors. Note that the probability of submodule errors
is way higher. (This has a couple of reasons: (1) a submodule has more
complexity than a file, (2) that opens up new areas in which errors can occur
and (3) submodules are less popular so we have fewer
bug reports and people working on it, hence less mature code.

As an example for (2), we had relative/absolute path issues in Git 2.7
for submodules, which is what Martin was complaining about.

> I saw that some new symbolic constants in the code to tell the
> machinery to "gracefully die" (or "hide the breakage under the rug")
> are named with SUBMODULE in them, which is probably a bad sign that
> the design is being too centric to submodules.  The implementation
> that covers only breakages in submodule as its first step may be OK
> (you have to start somewhere, after all), but I think the aspiration
> should be to cover all kinds of breakages in the end and turn them
> to be "graceful", and if you had that goal in mind, you wouldn't be
> naming these constants with SUBMODULE in them.

ok

>
> If "treat a broken repository as just being 'dirty'" were a good
> idea, I'd suspect that we would want to see all breakages, not just
> ones related to submodules, to be treated the same way.
>
> But it is possible there may be a reason why submodules are special.
> I do not think the third paragraph quoted above is a good
> justification.  A repository with broken submodule is just as broken
> and untrustworthy as a broken repository without a submodule, and if
> you want to allow such a checkout with broken submodule to call
> itself v2.0-dirty, you would also want to allow a broken checkout
> without any submodule to do so, too.

agreed.

> I probably would
>
> - introduce a new "git describe --possibly-broken" option;
>
> - instead of running "diff-index" internally to decide the "-dirty"
>   state, spawn "diff-index" as a separate process;
>
> - observe the exit status from "diff-index" and add "-dirty" suffix
>   when it is _known_ to be dirty, add "-broken" suffix when it
>   died, and leave out the suffix when we know that the checkout is
>   clean.
>
> That way, we wouldn't have to contaminate the generic codepath with
> a "treat broken and modified states as if they are the same" logic,
> only to support such a niche feature that we wouldn't want to use
> anywhere else.

I planned on a follow-up that adds similar behavior to git-status,
such that git-status can be used to get the big picture before
diagnosing the individual breakages of a submodule.

That is the reason why I started with the first patch porting
'is_submodule_modified' to porcelain2 of git-status, as that
allows way better reporting on submodules. Sorry for intermixing
these two things.

Thanks,
Stefan
