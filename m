Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79501C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 23:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356013AbiDZXPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 19:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356016AbiDZXPh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 19:15:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37BD14A500
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 16:12:25 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b12so121534plg.4
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 16:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mLqh4SrCjyYZWi4AZQS7r67r/YbEQBwVQM32K6dfDng=;
        b=PjTPEX/2RyXvqhob3GJtR5T6V2Lp9yDgegnmBHGiyp5cCippjPvpt5Fd7JKTFIHdMT
         VlEFDDIXByxIjTQQPeT5sQYdV3zNcT5bNaWDQJYJYGl9acUZgCS1YoO2vyHFAZIOhJnG
         nQMDUT6H+2udTK7CoQTZCxuzZDo056oado5pnRF27coub1uTWnyPNBQV7WE42MgaAUf3
         qpHdAanJ8qDnHKZbZgtHmEjvpHv0W3Vf5Rcv76wAwk3gZU3QFH17ByFb1h/+5oynRamJ
         aGNq3mtPCSIyqZsCTBnsc0XugiXXe1K1gKuW7w+55/dSLTxbRcW6/fPC4fqDRLNqeZSd
         +RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mLqh4SrCjyYZWi4AZQS7r67r/YbEQBwVQM32K6dfDng=;
        b=7+kpDN4oOQI8sYs6s4I6MPgZKx1skkfbH+LD0PaLae82s+STcsr+eUJdjJbE9liOXf
         F2Mu8lZncv0UThkZPtq/IwV0HJC7PcMo4EFTjSUOcLar5jxb/6S4CvpqBprdMbu4I5vH
         nSL+XHgIFtQH10JQJYrjeUpUEpnP8la4GqYn0rREDlItMtIsy2Hvr/GDmAcbeAW9jCce
         okqnj2ci1RBxmLIJOZPqaEAAQuz9zaWY1Rh62jHYTpfVn/Rbp+SLENZdPMJToZqzVWrN
         bq0PuqCFYm1US9qIADcpKz52NfVIQNEvPxHLduiyHd4HwXDO4EnD+xn8hPf6ycjtJ1O4
         TKiw==
X-Gm-Message-State: AOAM533PYzRm12GFTdeSsB3MS6LtKqhNMXJgwQLfwkSYjE9pqazuqcQT
        DvyELproNz/FgM6JxU7Mc6tF84CTQok=
X-Google-Smtp-Source: ABdhPJzSkb+WEwpcl80j1rtbKqu8N8IZ0KYujZBnnNEM6tbuu2zC/9xlqewkaYPnkG63CKN0MczWVw==
X-Received: by 2002:a17:902:d510:b0:15c:ecd2:e7fc with SMTP id b16-20020a170902d51000b0015cecd2e7fcmr18512240plg.132.1651014745053;
        Tue, 26 Apr 2022 16:12:25 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:38b:d8c2:e101:e089])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm16785276pfx.34.2022.04.26.16.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 16:12:24 -0700 (PDT)
Date:   Tue, 26 Apr 2022 16:12:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Jorawar Singh <jorawarsingh12@gmail.com>, git@vger.kernel.org,
        Alice Merrick <amerrick@google.com>
Subject: Re: Git user experience workshop
Message-ID: <Ymh8VlCTK3m4flWj@google.com>
References: <CAK-fT4Ge88sp_zcTiWuvg5pe7qpGhqWbq3Jt4W0DRVVpy54pwg@mail.gmail.com>
 <b94dbce7-d2d5-d260-27c7-b98e009b41a3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b94dbce7-d2d5-d260-27c7-b98e009b41a3@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Phillip Wood wrote:
> On 11/04/2022 11:18, Jorawar Singh wrote:

>> There's been some conversation about holding a workshop focused on
>> user experience [1].
[...]
>> The purpose of this workshop is to help incorporate UX practices into
>> the Git development cycle.
[...]
>> Once a reasonable consensus has been reached, we’ll set the date and
>> time, and ask for RSVPs via email.
>
> Is there any news on a date yet? I filled out the spreadsheet but haven't
> heard anything.

Thanks, Phillip!  Let's do 2 May (that's this coming Monday) at
- 8-10am pacific time
- 10am-noon central time
- 11am-1pm eastern time
- 4-6pm BST
- 5-7pm CEST

(Thanks to Jorawar for finding the date.)

Jorawar will reach out with more details about how to RSVP, day-of
logistics, and so on.

Sincerely,
Jonathan

>> [1] https://lore.kernel.org/git/CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com/
