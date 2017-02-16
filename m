Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30EC71FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 12:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbdBPMkD (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 07:40:03 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36398 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753618AbdBPMkC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 07:40:02 -0500
Received: by mail-lf0-f47.google.com with SMTP id z134so7483290lff.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 04:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+c1Fya7DYUWr8gHPArgm3+bf8cSoDjUA/HYNRfy1Dqk=;
        b=WQR9jncOUZOB7koLpP7vW4iLh/u8MBGue7QiD7a+kpAAR45b0zxK7uGIn91upx8RWF
         ZeYm6q2hP6yh+oToQE9kuaOGLvgZifyFWCcinp+Y1Ppp5uP5u8s64yVK7cF7lddSvp6G
         w/d7uC1sAe9L9+xoZ7lfiq9VNJM0rS1vOUuTxGhUHybdrm5AdCYCMh8Uk3bpU64chEmx
         2ga2cy6VrUPyQKGapu4r/+m87Gfv4swI/GL9rvOnb0YYS4ZUdh2L3YK0NMbWgXFKgggI
         Mz1p8LehKtjqX2O+aK5akvYK+5dzWdO64Yk2HIG43khZde+MFxgVhRKTJr1PYiJv42Om
         Dxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+c1Fya7DYUWr8gHPArgm3+bf8cSoDjUA/HYNRfy1Dqk=;
        b=s9yOiMu24Q6HGtK6CQXkwhm49G+kC9RMD46sLHIdVu3SZhdj4falxBSXv7JtGnAvat
         QlVRRTvt/AhPRlJP7MtAmcSXiMEnn4b+NCiumoQQgz3NYtQeqvPDGFCKcZHNvfZpm70U
         PXwCg38cuJ2r1i1LbPLKmRbnU5VTpDrY3DuFYkO6xiKQ/NdaJzUtkOG+DcsEKIqyEnTk
         +ZqsikKPqHQ6gWfrHg6r+0o4uSA4VWmJorfzB5mSq7hwQur6yOuvgZGqTGDkSQljSeA2
         0KyHPVIK8z5+iMdQQ5rNJ8TlGZTblzDqIusMIGH8OlJ6uPPw5IjaHW052zQMRnN3ZJqR
         XFjg==
X-Gm-Message-State: AMke39nZu1oUjsI0AEx+FvouuqlDSRK3mn2VRalbdA52+bPzmKAclKr2bgmILIfE5TpcPmP1/eJxcfCXdJVFFw==
X-Received: by 10.25.225.141 with SMTP id l13mr659272lfk.129.1487248801256;
 Thu, 16 Feb 2017 04:40:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Thu, 16 Feb 2017 04:40:00 -0800 (PST)
In-Reply-To: <20170215214052.5py4pxkcz4g2bmtk@sigill.intra.peff.net>
References: <20170214154816.12625-1-chriscool@tuxfamily.org>
 <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net> <xmqqlgt88t0r.fsf@gitster.mtv.corp.google.com>
 <20170214195513.7zae6x22advkrms6@sigill.intra.peff.net> <CAP8UFD0EfUgfmTB4dj-A+rw79F7SWKxYvatNfR+Nj-8ukWYAQA@mail.gmail.com>
 <20170215214052.5py4pxkcz4g2bmtk@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 16 Feb 2017 13:40:00 +0100
Message-ID: <CAP8UFD20=zVy=1Tr4D1Rxf+a4yR_X2zmexNCTNKV5RSF9ueYrg@mail.gmail.com>
Subject: Re: [PATCH] show-branch: fix crash with long ref name
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 10:40 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 14, 2017 at 10:29:46PM +0100, Christian Couder wrote:
>
>> > I notice Christian's patch added a few tests. I don't know if we'd want
>> > to squash them in (I didn't mean to override his patch at all; I was
>> > about to send mine out when I noticed his, and I wondered if we wanted
>> > to combine the two efforts).
>>
>> I think it would be nice to have at least one test. Feel free to
>> squash mine if you want.
>
> I started to add some tests, but I had second thoughts. It _is_ nice
> to show off the fix, but as far as regressions go, this specific case is
> unlikely to come up again. What would be more valuable, I think, is a
> test script which set up a very long refname (not just 150 bytes or
> whatever) and ran it through a series of git commands.

I agree that a test script running through a series of command with
long refnames would be great.

But I think the refname should not necesarily be too long. As I wrote
in the commit message of my patch, if the ref name had been much
longer the crash would not have happened because the ref could not
have been created in the first place.

So the best would be to run through a series of commands with a
refname ranging from let's say 80 chars to 300 chars.

That would have a chance to catch crashes due to legacy code using for
example things like `char stuff[128]` or `char stuff[256]`.

Implementing those tests could have started with something like the
test case I sent, but as it would in the end be about many different
commands, one can see it as part of a different topic.

> But then you run into all sorts of portability annoyances with pathname
> restrictions (you can hack around creation by writing the refname
> directly into packed-refs, but most manipulations will want to take the
> .lock in the filesystem).

Yeah, but if a crash doesn't happen because we die() as the ref is too
long for the file system, we could detect that and make the test
succeed.

> So I dunno. It seems like being thorough is a
> lot of hassle for not much gain. Being not-thorough is easy, but is
> mostly a token that is unlikely to find any real bugs.

Yeah, if we really care, it might be better to start using a fuzzer or
a property based testing tool instead of bothering with these kind of
tests by ourselves, which is also a different topic.

> So I punted, at least for now.

Ok, no problem.
