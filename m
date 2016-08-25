Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6F51F859
	for <e@80x24.org>; Thu, 25 Aug 2016 20:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756501AbcHYUkQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 16:40:16 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34111 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754595AbcHYUkP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 16:40:15 -0400
Received: by mail-yw0-f171.google.com with SMTP id z8so37004906ywa.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OQQCNc7ZO4nBV8B9EWwM9TrpPT7SSRhT0ra3Ffs2HhY=;
        b=xUttFhZdPQTQtb240GNaWYRUxlrD4D+WxaitoP5ARAy+SrrCtBVt+mY4JvnJOX8ibe
         Tlmrp7mtxMZduTVA3XWpsJ7EkY799i8T9xJrYw4fWYIJuTdrh8VSkt6EcJq1wCdHaM5v
         YWhcffpjXbnNIXVa+qFyghxIBOwiiYfG9ORLiRypqRXJyYLJF3EstllKjjALOfuVpatL
         Z/c5m7JX3hN9qjIIAopzIVzW1/VutDzqXEkcEQViMSpr708SGm38yJcyPyNrMbTZhpa6
         lN4rcdJdkBA7SyM8RPegde7YRizT2+Y5RZAeshjKan3wLrMh8STNBU3nWGchmtaG7+hW
         7smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OQQCNc7ZO4nBV8B9EWwM9TrpPT7SSRhT0ra3Ffs2HhY=;
        b=Cg6dmsRkWjQrp9mBY7gvE5OZnnG4sCzPbRnv4BY1cCMT5myd3YB2bgwIJhyrM7bFjd
         7o6dzw0vVEVF+/Fr4rLkzIojnRtOm97yHnTeNVOTRawI5DCFm3qzXs8WMrSVZjH0XYHc
         kRotZzTWoX8NPKVbrdG9sjdN7iZ2tZD64DV8PYEKzXU0OhMxxr+giMqvCy7Ou/OHyb9+
         l41SNhLndT7sFbaPKQY/PH9z4zEfPEFgHCe2vgJffacMi/HZKGmLHi3q11lJ2deMksjC
         b7py5C1tuAzUSj+ivbFUZG+5fFUxx9C4Hbb7Cnn59TnSiW/Z2sVXROaPxJCo5/p3tecX
         P1jg==
X-Gm-Message-State: AEkooutbquPVl9JwOXRLoS+KL3+Ilhmje0MLYWkMHrj8EDHYdmXXdplIONjhdAV6J1wfUVhNMFiFygjtH2eG8w==
X-Received: by 10.13.249.135 with SMTP id j129mr9132688ywf.267.1472157579414;
 Thu, 25 Aug 2016 13:39:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Thu, 25 Aug 2016 13:39:18 -0700 (PDT)
In-Reply-To: <CAGZ79kbsq52Qh0Jtn5hpPPfHu_9r2CUHvAHOTh6Cgz8ODkzreg@mail.gmail.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
 <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
 <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com> <CAGZ79kbsq52Qh0Jtn5hpPPfHu_9r2CUHvAHOTh6Cgz8ODkzreg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 25 Aug 2016 13:39:18 -0700
Message-ID: <CA+P7+xrQy33gt8bnsagLVPAHhZPZx-3s0E_Aj7tOwXnHjOoCBg@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 10:47 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Aug 23, 2016 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I am not so sure about that.  If there is an existing place that is
>> buggy, shouldn't we fix that, instead of spreading the same bug
>> (assuming that it is a bug in the first place, which I do not have a
>> strong opinion on, at least not yet)?
>>
>> Can there be .git/modules/<foo>/ repository that is pointed at an
>> in-tree .git file when there is no "name" defined?
>
> If you're holding it wrong we can come into that state.
> * Checkout the submodule,
> * then remove .gitmodules as well as relevant config in .git/config.
> Result: Then we have a only a gitlink recorded as well as connected
> working tree to a gitdir inside a superprojects .git/modules/.
>

Yea, but I think you're right that we shouldn't support that state.
What I'm worried about is the case where we can get this state doing
something sane/acceptable but I don't think we can.

So we should support the gitlink to a repository stored at <path>
without stuff inside the .git/modules, and we should support submodule
gitlinks with a proper .gitmodules setup. I don't think we should
die() but we should error properly so I will introduce a _gently()
variant of these functions, and die properly in the regular flow.

>> I thought we
>> errored out in module_name helper function in git-submodule.sh when
>> we need a name and only have path (I just checked in the maint-2.6
>> track); did we break it recently? submodule--helper.c::module_name()
>> seems to error out when submodule_from_path() fails to find one and
>> will segfault if it does not have name, so it is not likely.
>
> The name is literally the only thing that is not optional in a struct submodule
> (see submodule-config.c:182 In lookup_or_create_by_name, these structs are
> added to the internal cache.
>
> Stepping back a bit, I think we'd want to document this expectation more
> in the man pages
>     The name unlike the path of a submodule must not be changed (as the
>     name is used internally to point at the submodules git dir)

Agreed, this should be documented. Do you mind doing the documentation
patch for this?

Thanks,
Jake
