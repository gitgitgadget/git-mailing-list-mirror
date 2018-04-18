Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8BC1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDRVAL (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:00:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43549 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRVAK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:00:10 -0400
Received: by mail-wr0-f193.google.com with SMTP id u4-v6so8350319wrg.10
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MDFU0K3ACElCamGkMVpoDcak0zr6Bo15zyXiYvXA2XE=;
        b=WZn2p5nY47Ob/jkdmXmCin3s72jbAtaa+i9yMxEc2gi5EDaQRlbeWvBYV0dXJn+4lQ
         HRK69v4nPyACP9OrgcwTU9Te/RvhRTVasSD4NqHZCpqufLCjPgXpLbcIys74HmBCGZMh
         lDfAixp4uJe2BfepBbX1FRgyKDti2OL3ofR0RrIYM1pBW82i5CIiUCmCMz1gux7ooT/o
         6wql5CcPkiYT6IJ+PBhNWKcOmhPIPRKFMuTHuhtvm20w/jhuVHGcKI6uiyhquW/4Bdn9
         2uNODBkfrjGRc6nCjhB37KlCnpx41RkSb54OgPKUsVyCUr+k8d1cIS7VlNIuuA+JmoAo
         MP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MDFU0K3ACElCamGkMVpoDcak0zr6Bo15zyXiYvXA2XE=;
        b=ulJosU+njppELkUFJBmhdFSHHUUoNcLZWIHqrGwej4wVFaA2rJTM35EZf+2/W4QqCx
         83438N4nLVIqOy3YLQEnhYNS2NiZPOazI7NNQxx3WoUXHQ7241y7Fr5eZo5WcRqMfRda
         QYEWYcOqN661BSsMyE2+jsQ+nrmOVYBAA8MUUZOGsqdaEyQ1Qt55dcksyykAnMb3tfqS
         t2KEAgycUsglJVz3Q/IC8zi6u9W6GXxbfpkF6HZy3CDRFo61SZcu56KSUwZIOcV6ZZ3j
         9zWA7KjVCpB/V0LlHexPXt8MFTVdjtd1ARZn2b+WmX7iLXXLAlTkLAHMknNJg0fNV9Zw
         ODmQ==
X-Gm-Message-State: ALQs6tCf5OnITEVkKAbz3JlkPy1ZvBjpYtDDrHyuYvdYn1dvMdtrhSkT
        4lo4ifZ4FAaZg/6ht79aXM8=
X-Google-Smtp-Source: AIpwx4/i87ARNgn3I+mXAi6n3kp0Wt8DupoSkK/RHHWceAu+KPYHCXY83cKyjVHA6eSbupksBUqr7A==
X-Received: by 2002:adf:9205:: with SMTP id 5-v6mr2778119wrj.282.1524085208907;
        Wed, 18 Apr 2018 14:00:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 80sm3273723wmk.46.2018.04.18.14.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 14:00:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <mail@eworm.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
        <20180418171612.5647cf12@leda>
Date:   Thu, 19 Apr 2018 06:00:08 +0900
In-Reply-To: <20180418171612.5647cf12@leda> (Christian Hesse's message of
        "Wed, 18 Apr 2018 17:17:33 +0200")
Message-ID: <xmqq4lk8i61z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <mail@eworm.de> writes:

> Junio C Hamano <gitster@pobox.com> on Tue, 2018/04/17 15:07:
>> * ab/simplify-perl-makefile (2018-04-11) 1 commit
>>   (merged to 'next' on 2018-04-17 at 4448756934)
>>  + perl: fix installing modules from contrib
>> 
>>  Recent simplification of build procedure forgot a bit of tweak to
>>  the build procedure of contrib/mw-to-git/
>> 
>>  Will merge to 'master'.
>
> Looks like cooking is v2 of the patch, while we were at v3, no?

If that is the case, unless v3 was obviously crappy and was
discarded, which sounds unlikely, it is more plausible that
I must have missed v3 altogether, isn't it?

I'll stop merging this down while I hunt for that v3 version.  As
the above is already in 'next', we may have to ask the v3 patch to
be rewritten to be an incremental update to it, though.

Thanks for reminding me.  Very much appreciated.
