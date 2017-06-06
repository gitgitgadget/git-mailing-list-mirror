Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D963220D09
	for <e@80x24.org>; Tue,  6 Jun 2017 10:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbdFFKzC (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 06:55:02 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:35513 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbdFFKzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 06:55:00 -0400
Received: by mail-ot0-f171.google.com with SMTP id a2so13514459oth.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 03:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qiK/nKg0PiXSn0JE6q65cF0GHLZu68ugo6aG+Gp+yOI=;
        b=VRbO/b2W5XSIChib0zf0bRAK4WtjUD3AddpXyQcpKzBVsgsWO3fLKU0/dnPADastwA
         UfDIZUNz4ZcioW6i7RM3QcFFBpVR80qPIXHVHHxWIz6/pk4rjVS4NBb330ajugFHHW1s
         5g0rPOUFeS8zbvtdIBr+fme/L24uiuYBOeKcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qiK/nKg0PiXSn0JE6q65cF0GHLZu68ugo6aG+Gp+yOI=;
        b=P2Q6tNBflVZnZw4bwrLSKrSCTCTFsGDOqHFbl/5WSFU/V0VPIHtX54sA/g/OvbxgRl
         EOYQfR5PtxnvxqgyCSNg1nKcA/H5IWp9GT+6PPxbapxbCz5VUJQzeAfmU/nySTe7vZKg
         KkF+INEtFdnSnJdqEdrgccyJqbjEWkhnabtvMJ4lTsgBU6bARAGhyUSjxwqg9Y7OwlZ9
         PI+FCo2Ugb6TWYv3cm936/ikSWUjF12QuuKqDicYX3UyKkNX2cmj1TNgsiwHSijvdJ6X
         hw9lz+Y9Ft2Lljec0tArnQKeIJO1vqULOKc8GlitQXif852/DMb+WzbybFbuoe+pvt/o
         zikw==
X-Gm-Message-State: AKS2vOxXEqv5g9EyNCN++bZzyMDjxx19GN17i/ioGXL4m7WdIxUAfGSZ
        MlwfGtPMazfwgI6zLB+RE0dzKDcQZ1aa
X-Received: by 10.157.53.88 with SMTP id l24mr12950823ote.155.1496746499597;
 Tue, 06 Jun 2017 03:54:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.62.71 with HTTP; Tue, 6 Jun 2017 03:54:59 -0700 (PDT)
In-Reply-To: <CAKOu8-2mB=fcFUd86vdK+z==0bX3rUvY-VuNjQ-C6t++uik8YQ@mail.gmail.com>
References: <CAPRL90JeQ3i1m7ydYzTCFgtZ4cC+gYEXFeAKvCuAVwPLXpsgXg@mail.gmail.com>
 <CAE5ih7-Nmy2J6zO9mx7g=L7Ey9PnVUcD3wnXBN4_0znwOHaUeQ@mail.gmail.com>
 <CAKOu8-2iBV=sAP0WeRMQFT+0y5cJ1g6A3bQ5x=D=8q9ocxnBVg@mail.gmail.com>
 <CAKOu8-0DG_wQf4ch_MH=rjAncg1iP=uA1U7XHgXe7JNrEJSkGg@mail.gmail.com>
 <CAE5ih79VCpmMmaq0AEW=5HeOmVdpjpSmh=1CheUZbqvbNfBFbA@mail.gmail.com>
 <CAE5ih7_yt4zjju3F34gUTKLPip9T98ow=shZY7EPe3yE8gk32Q@mail.gmail.com>
 <CAE5ih7-+EzUhjXCCOu_oELof_2X_qf5snoqUZyuRNqEu+p=ewg@mail.gmail.com> <CAKOu8-2mB=fcFUd86vdK+z==0bX3rUvY-VuNjQ-C6t++uik8YQ@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 6 Jun 2017 11:54:59 +0100
Message-ID: <CAE5ih79_0XhT6Nb5WMki0kCZ_FaWSCYc5H=fZmp3esQSN-tF1w@mail.gmail.com>
Subject: Re: Git p4 sync changelist interval
To:     =?UTF-8?B?0JDQvdC00YDQtdC5INCV0YTQsNC90L7Qsg==?= 
        <1134togo@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 June 2017 at 08:56, =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=95=D1=84=
=D0=B0=D0=BD=D0=BE=D0=B2 <1134togo@gmail.com> wrote:
>>
>> It seems to be something to do with the code around line 3395 that says:
>>
>>     if self.changeRange =3D=3D "@all":
>>         self.changeRange =3D ""
>>     elif ',' not in self.changeRange:
>>
>> It's finding a lower revision number with which to later call
>> importHeadRevision(), but that only seems to be called if the revision
>> range does *not* have a "," in it. As a result, we never actually call
>> importHeadRevision() and so files end up missing.
>>
>> The obvious fix of fishing out the "@3" from the "@3,5" revision range
>> works in this instance, but breaks some of the regression tests.
>>
>> Luke
>
> I did the same change before and it worked for me. I'd like to find
> out if it is a bug (I think it is), a normal behavior or am I doing
> something wrong.
>
> So according to what you say, it is a bug.

It's a bug!

I think you can workaround it by doing:

$ git p4 clone //depot@3
$ git p4 sync

I'll see if I can workout why my obvious fix caused the tests to fail.
