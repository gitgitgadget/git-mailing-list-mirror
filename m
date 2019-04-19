Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01E220248
	for <e@80x24.org>; Fri, 19 Apr 2019 19:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfDSThS (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 15:37:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37964 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfDSThR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 15:37:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id f14so7435085wrj.5
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4qkbQ/lya0kqByMbg8FokNiNWMnM/p2Go5H8Q15AqwY=;
        b=ZJgTpFt5/LMDXHy4oHLLfH1CAdqoBEP4PEptaEaG9oWnxRiZmkY7CLAFOLM6APcyQk
         fNb6BSKM50em/KXAeLITPsX5iCEYmPDxuiTSIjCYYaEH7eHMMPu+pFimJeJoQ4wb2oxU
         lLvM+v7/RL0VLXRst2D4Q84VawMKJY8IXl3ogsx2HARH/FzaqN9I0GVoixdgpQ9x23B4
         vhdaWRDqPqUgYKnOJNg2f5VPNYXw49Bx4dd4Ngy3JCLm+bCXhqhcWkdJ3F/sBkeoDdRg
         ZM6SVDV1CmT9xtv4zvpJ5DWCuGOFWES2fR41SKqHz6rdzfjOPfYRo9jLRPD0QB5NUsc6
         d/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4qkbQ/lya0kqByMbg8FokNiNWMnM/p2Go5H8Q15AqwY=;
        b=DlbvTkmk3P4aDpaiEGd5BfPSMBCZ7vc1/BHDHDloUDX4DLuvDZhqpa7B7gdsQRTqcZ
         3SZketDBtsDR08aJpmzDXzSxVQDEUWofY/OtZRgrmvSB12shX+dBO1JywijwtyXdkuIM
         rkpKsvDhmSwMAbJlYKk24f1pfYZePZXNCaVIhbcQ6rr5k2+KiE3y90opZegYX/ZTWLXs
         kfGhiByU8EnXjkulFZ9k/qw/OxIDKTlt8o7YzPhoFF7Lh8vA8PD+AJQX6iJ8aBF7hGko
         kLzSW47SwJ0bi5oTLjiBf8tu0qkJJIEFgqWtrCD0S5JgaK0ctFe18uVJh5uvFJfO6b5S
         mdaw==
X-Gm-Message-State: APjAAAV0nJ02FBzR0oMPNpQvpKqf7eTJPqW7Nh+nUno0at3RIQj+G/rP
        44Fg1BS+dXYdF0HhbdDFwazhVBOCtlU=
X-Google-Smtp-Source: APXvYqwNsMqjOwoqu3YGBOCuE79mN7PpbPwrHqd1lg04ZYv2mvrRbmmqFYH9vIKRUR18wGQHqEkSYg==
X-Received: by 2002:a5d:6687:: with SMTP id l7mr1560953wru.307.1555655826792;
        Thu, 18 Apr 2019 23:37:06 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d6sm4267307wrp.9.2019.04.18.23.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 23:37:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vadim Kochan <vadim4j@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] configure.ac: Properly check for libintl
References: <20190418050419.21114-1-vadim4j@gmail.com>
        <xmqqftqfhnmz.fsf@gitster-ct.c.googlers.com>
        <20190418082844.GA10068@lwo1-lhp-f71841>
        <xmqqmukmegof.fsf@gitster-ct.c.googlers.com>
        <20190419051249.oiypxcs6hexjdf2d@vkochan-ThinkPad-T470p>
Date:   Fri, 19 Apr 2019 15:37:05 +0900
In-Reply-To: <20190419051249.oiypxcs6hexjdf2d@vkochan-ThinkPad-T470p> (Vadim
        Kochan's message of "Fri, 19 Apr 2019 08:12:49 +0300")
Message-ID: <xmqqtveucxgu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vadim Kochan <vadim4j@gmail.com> writes:

>> I think
>> 
>> 	autoconf: #include <libintl.h> when checking for gettext()
>> 
>> is probably a better title.  
>> 
>> Together with your originally proposed log message, which we now
>> know explains why this inclusion makes a difference sufficiently to
>> be understandable by an average Git developer, the resulting commit
>> will communicate to our future developers the reason why we thought
>> this was a good change clearly.
>> 
>> Thanks.
>
> Thanks! Should I re-submit patch with title updated v2 ?

You could if you feel like it, but in a case like this, responding
with "Yeah, I agree with your suggestion" and telling me to retitle
is sufficient, if you have nothing else to change in the v2.

I've already did the retitling while queuing it, so no need to
resend.

Thanks.
