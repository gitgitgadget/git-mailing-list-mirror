Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62111FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750843AbdAMA5E (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:57:04 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36272 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdAMA5E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:57:04 -0500
Received: by mail-lf0-f47.google.com with SMTP id z134so22274048lff.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MKgHCtTvZPk5vS61CAkpuLaJsO09SWORbbBvkh6XT10=;
        b=WwT9cStdRYPm602rJeH/pfMaptlih9S/RWJZwWSRSGATZJIrkHaTO14BSP/JRWDxwI
         efP/xq82bO3QoUiMT2QtKpFnw604abSTwGNLLUVdznK9qxd14+q9gEn1zO7bRAOwU8zl
         NueJOyLacofWnWdvbNExJVot4RhTjwYyjmvw7p+CPzSZaAJw+F+ct73YvBxEGhCNfauW
         3hQdbfbdfcIL1BSFqgNOGmAPrkH5DlktaXWjv9CEmSK+x3hZdggcx9fALcQv5HtMUz3C
         Upmp+ppIJqTlIa2W1pnUjxjJ9I4GfHqRXunbPurqsbsy97htUWjGDARSF9+h0bPAP0v/
         hDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MKgHCtTvZPk5vS61CAkpuLaJsO09SWORbbBvkh6XT10=;
        b=XniAPtSNOEFH7FQSyNaRABp05AI376ma7sUdBibkxfonRPOxqmbqQUZWLAsJthJxPN
         aJxv1ctoIPEidrj8j4FOCzafRPo01QQw2c5Zd/5E+rOmbp8jCvTCfnif7Gp0HDU+G0j5
         Rofp3typaOLHDC1pSiTGIEmAgtXaRno56ebZ3Qf3Y16W07z1hu5QDIndoLJX7NSNNoeo
         +qU5MYBTwPM4g5mb6Es0+P0mONLZ67VvTFnONAz/KY+zYsga6a+ieGIpa52z4EGNTu78
         pk8Q+ShbtynIjCOs/yGolzrg06AoxZUPTbF3yA/kX7uOetOOEx1yjuUOaHLBelD1ZC1/
         //Xg==
X-Gm-Message-State: AIkVDXKOU7MF38toEuDpQRWfNNaTsYVdbPbf10EpSS0EWXyLktu0T50ofQQsf9gbYX53k1uil8Xw8vnK3rYHZQ==
X-Received: by 10.25.10.6 with SMTP id 6mr4967087lfk.88.1484269022496; Thu, 12
 Jan 2017 16:57:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 12 Jan 2017 16:56:41 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1701121056470.3469@virtualbox>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
 <20170112001721.2534-4-jacob.e.keller@intel.com> <alpine.DEB.2.20.1701121056470.3469@virtualbox>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 12 Jan 2017 16:56:41 -0800
Message-ID: <CA+P7+xp_23dfGUmuT3fTMOrBOaMjvZpu0ax7A3L8RfQDK4hLbg@mail.gmail.com>
Subject: Re: [PATCH 3/5] name-rev: add support to discard refs by pattern match
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2017 at 1:57 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake,
>
> On Wed, 11 Jan 2017, Jacob Keller wrote:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Extend name-rev further to support matching refs by adding `--discard`
>> patterns.
>
> Same comment applies as for 5/5: `--exclude-refs` may be a better name
> than `--discard`.
>

I agree, will change.

Thanks,
Jake

> Ciao,
> Dscho
