Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378BB1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbcHOMhZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:37:25 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36446 "EHLO
	mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbcHOMhY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:37:24 -0400
Received: by mail-ua0-f175.google.com with SMTP id 97so70938920uav.3
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 05:37:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZfmxUFEOQPWD2ZkE64nG7XGxeewGTPwb9MlcNfzyjII=;
        b=qgKyyKy1PWRKlixnKgI7pLS5fnLb/vLNiUh+jIpAq5RPTXWg+sjgXcmBd1JSdsZlSm
         tJ0nm/beRhSFOWEDe/+ap1HxkPmPl1hhYvxeLJT7zkim7WjOS1BVJ0U6ZjJbfH4P33OL
         sao4nHlQpI3jRDMVvI+yC/y5vTe9SfFmtiz1nYq1qvxn1MHwk0rmWedibRWLiJzmuRq/
         mVb1BXbHjZm/ExLAttK0XVfAN9uouB2WSxWQ89rw7FLM9YAhA6antT/PS0EV7c15YG0W
         tCnQO53vAMvEzLnD62pTThTxbjYrkHiPWqzbpeBX/M4rzBztUMzg9s5S6awicwlJasxm
         7dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZfmxUFEOQPWD2ZkE64nG7XGxeewGTPwb9MlcNfzyjII=;
        b=gxNmRxmDrjucs/J5ZvfgwEqy6ndnrcm6BUtUisb3NnsFjyad3weOng6K0IjH0Kd5gS
         2FA+UWhxQAeRMuoin8l60brSBOSZHDY1zGd3JlqtKApDlkfbFAysk4WrFybLowox2M0E
         lt1AmIvm5goVR/b427kA1sTvoCWmZ2AwEnmtrK2Ux5Ipk7VdJhuh0vWQno/qe5Q5c1j7
         akNEML/btBF/cPPazXw9KSCy+k+Xskg/GmTn0JV77GfMo/n4A6VHQbRo11zCyiJZGs0U
         jtBzq16UhnbunfmaLryNHkgCx/2+Odh3rF8z1c0nzkhbbWAotJL6JaecFtWG2ospb1w9
         SeOA==
X-Gm-Message-State: AEkoousDTZ//9A6fzH/pPHpLcNK0FNSGdtg7js47Bzp78wKSTz2KndwhhRRDsnb1/whjJq64y/LhVbo/oG9YUw==
X-Received: by 10.31.68.196 with SMTP id r187mr9004468vka.41.1471264154772;
 Mon, 15 Aug 2016 05:29:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.69.172 with HTTP; Mon, 15 Aug 2016 05:29:14 -0700 (PDT)
In-Reply-To: <20160815120441.nwtdqfgcv3ljt4vl@sigill.intra.peff.net>
References: <CAB-zwL28qUBO5PrRznH9KmLJZUHO65_J-DxvPP+NHZEuofKh9Q@mail.gmail.com>
 <20160815120441.nwtdqfgcv3ljt4vl@sigill.intra.peff.net>
From:	Arkady Shapkin <arkady.shapkin@gmail.com>
Date:	Mon, 15 Aug 2016 15:29:14 +0300
X-Google-Sender-Auth: O4IJ8COLskEheJ90vN-vrT_us1E
Message-ID: <CAB-zwL2oFMBFjkkoh1EhSD7FCK_1wVV+whu8uxTKTHQKJgNzrQ@mail.gmail.com>
Subject: Re: Git shallow clone branch doesn't work with recursive submodules cloning
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thank you, after updating to "2.9.3.windows.1" options "--recursive
--depth 1" now works.

But "--recursive --shallow-submodules" and "--recursive
--shallow-submodules --depth 1" still doesn't work.

2016-08-15 15:04 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Aug 15, 2016 at 02:20:27PM +0300, Arkady Shapkin wrote:
>
>> I am trying clone repository by tag with recursive submodules init,
>> but for one submodule it doesn't work.
>> What I'm doing wrong?
>
> Nothing. See 18a74a0 (clone: do not let --depth imply
> --shallow-submodules, 2016-06-19).
>
>> >git --version
>> git version 2.9.0.windows.1
>
> The fix is in v2.9.1.
>
> -Peff



-- 
WBR,
Arkady Shapkin aka Dragon
