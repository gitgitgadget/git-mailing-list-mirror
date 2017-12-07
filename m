Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6A420954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbdLGVUq (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:20:46 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38805 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbdLGVUp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:20:45 -0500
Received: by mail-wm0-f41.google.com with SMTP id 64so214164wme.3
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hQnjTHFcpcPbPVXk5l+PE5bnMxZ+7R11ivaNx13XnAU=;
        b=OeDn1N71a+QEPwq1ulBIBDHCzoOjMo/xcbPig6ktFYdUi0lV3rvzO8Z4PrIjBd6Iqw
         GbrHP4lOyrszRZw4A96c2rZo7UXkskxj/tEGb7vQYAJwj7/NM41O+WbuiMcR2g4KSNNa
         xXnPCkZ/k/7U/TyPtqtHeCOMaIkMadU75gNvqi3qrnW838XbRxAjqj+h5Y5yntN2PjRn
         hIvLlbkwJz9DM7XvxpvcsKPNJG/exfRxX8H6tE1GAJsdgrfNxrBQewKOZ31kf8XKbdze
         vxYsFR3Md2JVnYv50O6Te+j9paKyN+60Rj/YdwbmnI5OYYirzgrytGR8p2VSO7ExyeJI
         DdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hQnjTHFcpcPbPVXk5l+PE5bnMxZ+7R11ivaNx13XnAU=;
        b=bLA46FdO/TJVvQlV6pNg1voxeAEio+hf+HqNMmv7yCTsjFql2KzM0aL5JRVanLDeJB
         MyVAJpu38t3ZZQ+3oV9QZwokIW5VxSlmYdC7ue+2q5A/FEFV8X6BMpdtjWsqCK8yqtkB
         jOpXV5R5YVa1/xjsJdDBM1/mCBzch7uICnRfTtbavjLyYPtgTA2FkIt8aENSwCiWF6o7
         DWgRNsl56iHTdeFqS+wGTCCXVIVfDw0XCJBDLpKEecUxDR9VnrtByzFp8wJ/3o3f3yC4
         f4jeE9yQyA2ruOIhl6rP1N3P4joSRMiKfaGg1wJrNUYDXGFTp1dw9kBxlIDduwvq2VPz
         Cnzg==
X-Gm-Message-State: AJaThX6iMCZnReriXJrehdRnHbLHYCrnpB68+iGo4FjF00cCmnUHuoV1
        8u/yR4IcY5ysAC8P8GMC/7ORDq8vIb8FrAEL59U=
X-Google-Smtp-Source: AGs4zMawPOlMzHQjmm8GliZKXvUKOwGjOXCq28qBIjeCP2gtEWy349eLtAruM5nRccymS8QWBuJHuao7WzVF2EiccEA=
X-Received: by 10.80.149.152 with SMTP id w24mr47677191eda.76.1512681644067;
 Thu, 07 Dec 2017 13:20:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Thu, 7 Dec 2017 13:20:23 -0800 (PST)
In-Reply-To: <20171207211258.GB12850@sigill.intra.peff.net>
References: <20171207190135.28660-1-jacob.e.keller@intel.com> <20171207211258.GB12850@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 7 Dec 2017 13:20:23 -0800
Message-ID: <CA+P7+xr-aUm_=50gsrJ3TXpDzvi7LYzWPeamAC+TqzLyh_mY8w@mail.gmail.com>
Subject: Re: [PATCH] diff: add tests for --relative without optional prefix value
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 1:12 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 07, 2017 at 11:01:35AM -0800, Jacob Keller wrote:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> We already have tests for --relative, but they currently only test when
>> a prefix has been provided. This fails to test the case where --relative
>> by itself should use the current directory as the prefix.
>>
>> Teach the check_$type functions to take a directory argument to indicate
>> which subdirectory to run the git commands in. Add a new test which uses
>> this to test --relative without a prefix value.
>
> This looks good to me (and I slightly prefer it over Junio's for the
> simplicity).
>
> I agree on the ordering suggestion Junio made.
>
> -Peff

As do I. Junio, if we go with my version, feel free to squash in the
re-order. Or if you prefer, I can send a v2 (though for such a small
change I don't see the benefit).

Thanks,
Jake
