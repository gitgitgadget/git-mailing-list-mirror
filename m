Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A8E1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeJ0QKC (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 12:10:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35520 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbeJ0QKC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 12:10:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id q12-v6so583130wmq.0
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rbRTeATlYTyeF7mKMJSm9TCJPSjYo6YU2LlSYawg22I=;
        b=k5xfojELYFs9ilpK107wBAlnoiykXCyVlZlPjxBCP4BkOkYPv6moTV2UyU7g3WAfta
         z4dRmvOPNOtznVWhS7QgbMGnZudEhW16We6taY/RuyUucCl0zl0oulOkag4eNw7xFsf6
         aGekUsnhc1jOf9p8Q1o9HxUZEKeFo2EM7PR785agqguEwxC/lwT+jBUPSZGikRAFv3Rw
         Zhx6p30P/Z/5eJ7vYBe2IZchqUuj1ngBLTDMEIna2u4MOkGm94CDaCcw+UxuXwgPlGuP
         1Ej5WoFI2BZNUHfX+80F2A8wHmKcCqU6PC/A69HGWF7ybZKYv2SxxdzMdTzYfvZOw4uM
         CVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rbRTeATlYTyeF7mKMJSm9TCJPSjYo6YU2LlSYawg22I=;
        b=LORPNGPWKypscpOR67EmAs+NNlUa7U2TObuQ5o5RfAWhw5I3XSbRxAdAY9i4yIm7Pd
         JlfkJ4cHMb35RBwWy1Fdae9rM2GCTbistVyAR51WaIQs9I/4ynv3gbTz1VPcix5Fb2PJ
         ixx05tiEEjVgfCFmIRZ5tiVAjYPHrw0MaUr+XTj1LJjibUfVPJoLc/0QJKsVdsuyuWFT
         MeCNK2lxpmQhcRvxbqwPMW0Y2urkQBRlzCBjHjCxSwsCwqhGp1XVE8lnfzMF9y6Mftut
         SeeHPfbtp4I2g4f+A+yViKKYsSuMTiChKx4t2WnmemyPDb2QevXaHRLZOeRgOUqqD2Cm
         MLQw==
X-Gm-Message-State: AGRZ1gKWeOF0ZOtdkYlea4vH2yVfEsfqFXfOly+bGEHazjrnqb09EGnZ
        VoaVHx2kTqhDH+xMIfZdMok=
X-Google-Smtp-Source: AJdET5chISYBrGI6FQtjyQBkpxgHVVUUTh1dJRpVZlqVYgNEMDfMn6CEoIo7W8xXcSyhgYy2JLbM4g==
X-Received: by 2002:a1c:7a0a:: with SMTP id v10-v6mr7918370wmc.41.1540625398608;
        Sat, 27 Oct 2018 00:29:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s8-v6sm3820wmb.5.2018.10.27.00.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 00:29:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2018, #05; Fri, 26)
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbjKZSHfHbDykkob1w21RTB9tgCCYVrOD=0C8aAFGncTQ@mail.gmail.com>
Date:   Sat, 27 Oct 2018 16:29:56 +0900
In-Reply-To: <CAGZ79kbjKZSHfHbDykkob1w21RTB9tgCCYVrOD=0C8aAFGncTQ@mail.gmail.com>
        (Stefan Beller's message of "Fri, 26 Oct 2018 12:04:55 -0700")
Message-ID: <xmqqwoq3alu3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>
>> * sb/strbuf-h-update (2018-09-29) 1 commit
>>   (merged to 'next' on 2018-10-26 at e4ad935cb0)
>>  + strbuf.h: format according to coding guidelines
>>
>>  Code clean-up to serve as a BCP example.
>>
>>  Will merge to 'master'.
>>  Further clean-up patches may need to follow soon before this
>>  change escapes to 'master'.
>
> We have a contradicting statement here, which can be either an
> issue or an oversight.

"may need to" takes a volunteer to do so; it does not have to take
the patch hostage to the lack of such a volunteer.

