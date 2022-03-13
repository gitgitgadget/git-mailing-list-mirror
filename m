Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F49C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 14:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiCMOJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 10:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiCMOJi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 10:09:38 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13B87650
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 07:08:31 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r2so4304629ilh.0
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=TxN4zlcfyznFR8WivvZLUNeRO7Fy9hiNEfYUZzkEEPg=;
        b=cS1Cc/Xi1zFT8s1+Fy7Nfy0l4cWry0XOL0TRT8uLIsBEl3R9CPy69WEO5YdUEoONli
         Nl5pMT/K4Tvm++mW0k/epmmTAL1f6O57rPhqc1EQtGDyKAWxqpKX3AMzsK88wslbF/yu
         4LnCJmjjunBcwOTWjBwJdH0Xlv4uVsd7cX/Af8//tvJexyCIKshs/eAAE6Ki0xixEf35
         xTkEFW4RyRC1sqdDYvYW2KS1oc0y/O+A8+DpyrJ8trsPxnSCLVaw0C2K4KmBXvxjQEqr
         9lJFgAXDzJA/YON4Ua8YIke50Shx0o1d0Wi07Fp2IUypCbiDmwzlwBfJEWoO0UwaNkPt
         YIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=TxN4zlcfyznFR8WivvZLUNeRO7Fy9hiNEfYUZzkEEPg=;
        b=uTGfXaTDBhknmgrnAGlTMbbGGZLa75vlTzRgwP0ptFo7EWV5GdOzDs2I6q7jz34Yqv
         k+P1w3EVdaSdkr2iV3EGTCK6nWBIma0iAF49pcbGvU3zWzDqcV/FlqGDbKTodRWCWccP
         s5LcjgSHIqEOoLN/ECjM3TCn4ZbY8sjLI+Rj54LZVqPhZNJGzKRDcs3jesSNxcBWY3ae
         W3o7Ka8Wdqjaxd0B1DDX62TeqZMYP7mW+t+zFMV/o5KoboilMs1TYq6w98v7kbEVDHka
         21xVK272sa8x6lmQi53DXKITF0JqMZaQV5qDy1MHyQn0NXZwvTxbd9GRxgIVyMJSRkSa
         obMw==
X-Gm-Message-State: AOAM530sYc/nhs8KS91eBmYNLK2oCKmgFGAN8KvoUwNC1iOeAcmjvK22
        xqnG2i51yk+mDI8cRgigDck=
X-Google-Smtp-Source: ABdhPJwAZY+zW0sXYyWhyYLcix9jcdTO8hEh3pYnBS0cvJtrJBkvlpqcUw5aVM6gMMmSTknxeJnwkA==
X-Received: by 2002:a05:6e02:1a4f:b0:2c6:6499:9d1b with SMTP id u15-20020a056e021a4f00b002c664999d1bmr15500442ilv.119.1647180511010;
        Sun, 13 Mar 2022 07:08:31 -0700 (PDT)
Received: from EPIC51148 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id j15-20020a056e02154f00b002c7828da4desm3602911ilu.0.2022.03.13.07.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 07:08:30 -0700 (PDT)
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
 <01cc01d83671$0acd4a20$2067de60$@nexbridge.com>
User-agent: mu4e 1.7.9; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        sallred@epic.com, grmason@epic.com, sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 09:01:04 -0500
In-reply-to: <01cc01d83671$0acd4a20$2067de60$@nexbridge.com>
Message-ID: <87zglu9c82.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


<rsbecker@nexbridge.com> writes:
> Is there anything we could do around the new signature infrastructure
> relating to this? I am NOT a fan of SSH keys without passphrases, but what
> if we could use the coaxing above and map to SSH expiring keys then stitch
> in signatures (a.k.a. sign the commits) to correspond to the users in the
> given timeframe - then destroy the private keys to prevent further signing.
> After that the Name/email becomes somewhat irrelevant from an integrity
> standpoint.

Is this really possible?  Is it really as straightforward as splicing in
some text into the commit message to the effect of 'this commit is
signed' along with some signature artifact calculated pre-signing?

Though I'll note I *think* this would only solve the problem for the
committer field -- it's my current understanding that a commit can only
be signed by one signature.  (I have heard of systems that generate a
new key that is then signed by multiple signatures, then signing with
that new key -- but even if this is possible, it seems pretty involved
for such a common workflow.  This level of coordination might not be
possible for us -- especially given the merge workflows we've needed to
create to accommodate our current release process.)

--
Sean Allred
