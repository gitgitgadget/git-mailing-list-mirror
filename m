Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566E61FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756493AbcH2VJy (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:09:54 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33032 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756128AbcH2VJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:09:53 -0400
Received: by mail-qk0-f171.google.com with SMTP id z190so50471qkc.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Ztb+LbvqIY0fIcaMYU5vfy0wu4Zjc/FUNj8Z7x4qvTw=;
        b=06/Ec9YkvmfJm0x1K2fpmNdV4H/8s5yWu+h8bhY/uvwSoHC/JUS4UFPDZISCjfoFXn
         cDg4zQCu4Vlp573/jvZmPGzaTUrqef00x18Xw4FcCtLQ8lM7Tp3vy5ZLOqJVlQiwwnMe
         3Ay4vBdVeVILCufBw8398/JV0ML+T3iYXs8M/JwVUOhb/W/e1QZIvKW35Z4l1Rd+M4tP
         Hf74AWtL598z9K+Hiv0nEVTgMZ/dOhD5W6pjsn6PXaH84kpNYnHp7w2EaFq6maRsgCVt
         dWETDfndqleLg3eMZIpwmjxwf3olug/5gINNg26HOkkryitPD33VwtFlBkTVktzWGAlu
         tmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Ztb+LbvqIY0fIcaMYU5vfy0wu4Zjc/FUNj8Z7x4qvTw=;
        b=RHUO3f3/ej+t0XaENJ5FvjvKnVAsdaPXBfYCo2ugEzLEW5uUkjyqNRan4VWkU/auid
         w4MCDCmfs8nZeUdkAvUXWc52SOgwM4sLnf7cLBsEbiYosJPQHK1F3+KKobEtqg9wsJvc
         TETzIQNrhQXj8XPO8IqUEwXYk7irUa+pOH1FeF/3fHVhUeOz79UE4fnib7HjyC50+7Yj
         0zPag5Fx5eL5AHTkUp6KnMpi9RtpETrURTy1wAOlC5ZP1JsORROmfOmsW3ECc0IaxdHD
         2EonBG4OYk20GB9eOEra8oB4RFD29TXx7qx2YhkiPHDRnK8V5A/XOmDOolJGWWiMtFeK
         ohIQ==
X-Gm-Message-State: AE9vXwPo5o6qt1WB+1WnnMop+ao7UtYJ1sSUTwytzP6EUE285evjLttMQqK9YEgXXjK6PzZWgnMEOPA8TBXQ7Q==
X-Received: by 10.55.101.10 with SMTP id z10mr88871qkb.186.1472504991103; Mon,
 29 Aug 2016 14:09:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.19.79 with HTTP; Mon, 29 Aug 2016 14:09:30 -0700 (PDT)
In-Reply-To: <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 29 Aug 2016 14:09:30 -0700
X-Google-Sender-Auth: s9oROazObPM2_3OSyS8eLpcYu4w
Message-ID: <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Uma Srinivasan <usrinivasan@twitter.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 2:03 PM, Uma Srinivasan <usrinivasan@twitter.com> wrote:
> On Mon, Aug 29, 2016 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> A top-level superproject can have a submodule bound at its "dir/"
>> directory, and "dir/.git" can either be a gitfile which you can read
>> with read_gitfile() and point into somewhere in ".git/modules/" of
>> the top-level superproject.  "dir/.git" can _ALSO_ be a fully valid
>> Git directory.  So at the top of a superproject, you could do
>>
>>         git clone $URL ./dir2
>>         git add dir2
>>
>> to clone an independent project into dir2 directory, and add it as a
>> new submodule.  The fallback is to support such a layout.
>>
> Thanks for the reply. However, in this case....
>
>       git clone $URL ./dir2
>       git add dir2
>
> how will "dir2" get ever get registered as a submodule?

With a separate invocation of "git config -f .gitmodules", of course.
The layout to use gitfile to point into .git/modules/ is a more recent
invention than the submodule support itself that "git add" knows about.
The code needs to support both layout as well as it can, and that
is what the "can we read it as gitfile?  If not, that directory itself may
be a git repository" codepath you asked about is doing.
