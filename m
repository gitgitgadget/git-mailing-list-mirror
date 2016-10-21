Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2D7820229
	for <e@80x24.org>; Fri, 21 Oct 2016 16:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935067AbcJUQPv (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 12:15:51 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33505 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934928AbcJUQPu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 12:15:50 -0400
Received: by mail-yw0-f169.google.com with SMTP id t192so102352250ywf.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gkKu9UPeo/sNUDHplVju/tT/SZAGarSCX08r7C5w6Nc=;
        b=fJ+hbBm/MjZLRuIO9xQU2Q6zhLix+B/0P6006bSSnX17QWFGHUtsUqYv+mnAnV5VBM
         GJaGDORq56Dt20qf2XJT0hYENSldXcB5PXW2JIhvwYX7K2/E+bZ2xSlwto2/L8uosKZq
         bp9cWqQlpc3NIIlHK/F8zxQcbmJU5EaOCEGspC95hqIh4o8bIFU6umnDnkYuF3l5X93v
         by98zb+kCow98RsKmnBkrAYvoo+Lg5CUVv5GGYrJ7aeVrVdPyuW6WOnQmwJEmdwfwJl2
         YGaijwrGShJ9b/XbIeYxWfaV64PDdsO9YT1/aViycAIp8lBRLdbPlyd+EJ6jOTV+cKNw
         daPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gkKu9UPeo/sNUDHplVju/tT/SZAGarSCX08r7C5w6Nc=;
        b=dO2XK6CTXxeYTqvyLWxIG/WDa8dmWhxlXZJIsKd5FH1QhEvG1N2D/VrUtKVad7EKGz
         BVhiYXHYtPD6egM8Bme4HnTbO+GOAbzOstcNaIE1YO6AVcLhDa4F2KmDmX9Cshx2tzKr
         VDdTV1oE0oLunWq29NlneGtmA6LzQqteP0syDpq0bY8fwO3aoRTOtjI1Bzpop2s9rIP5
         6ULX3s7d8Ndoaar7Smr6tumHWfXorrhMqT/0NK8UXuBAxLrd0Q/bt+M2tAUnDABpfku/
         cdk3rp6p8HeULv0ELG07HCYBxwBP8I7YqPLZcH4eIVypowKqF/GlVEgIrd+ZBZvqLPkK
         /XYQ==
X-Gm-Message-State: ABUngvc8uZwdnuUflDN7t+slw8wAdHKgZ2HOAB8EWOdAMuL2dmxrMVcx0fXv5mRya+JSdYpSbhuA/oNDL2DWqw==
X-Received: by 10.129.76.194 with SMTP id z185mr2115155ywa.257.1477066549354;
 Fri, 21 Oct 2016 09:15:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Fri, 21 Oct 2016 09:15:28 -0700 (PDT)
In-Reply-To: <20161021154840.pdmb5c3gjharsrxe@sigill.intra.peff.net>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
 <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
 <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net> <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net>
 <CA+P7+xozpk2-WZUYtaKmCazG3Owzpa3bsDejyUuGj0YEQnJWJg@mail.gmail.com>
 <20161021153534.mjed3sqhxjelxzwx@sigill.intra.peff.net> <CA+P7+xrix3UZDEE1swG_=jBLwWHA04KoYikWBBMNx7aa=Hevmw@mail.gmail.com>
 <20161021154840.pdmb5c3gjharsrxe@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Oct 2016 09:15:28 -0700
Message-ID: <CA+P7+xp8TDL59tQgCpmMDJ-BspA1CF6YsnuGMXas1bx_X0qJoA@mail.gmail.com>
Subject: Re: Prove "Tests out of sequence" Error
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 8:48 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 21, 2016 at 08:42:58AM -0700, Jacob Keller wrote:
>
>> > For $HARNESS_ACTIVE with _just_ "--verbose", I don't think it would be a
>> > good idea to activate it. We should either silently ignore --verbose
>> > then, or complain and die.
>>
>> We should probably do that to make sure people realize what might
>> happen. I read your series and it has a good explanation of the
>> possible alternatives. I like the approach you chose.
>
> Thanks. Do you want to make a patch on top of my series?
>
> -Peff

I am not sure I will find time to do it today, so it wouldn't be for a
few more days.

Thanks,
Jake
