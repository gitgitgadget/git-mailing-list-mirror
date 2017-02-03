Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42091F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 20:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbdBCUQP (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 15:16:15 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33430 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdBCUQO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 15:16:14 -0500
Received: by mail-lf0-f66.google.com with SMTP id x1so2367801lff.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 12:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YWfhJ7162sFqzRxEHTjigPHCRwDDnDob6lmja3wm+6w=;
        b=CiIGpv8rGdT6wOc3DNAHC7LUw1v+vLRp0ipq9U9tB8ANXS7H+27ef1YWA7Umhzanxy
         2+ks5rCYMUEoyMj1vpqDP6hYV2GaXpms+kq8XPhTjd+Je2Z7mhHWUaUQo5xXc+kFg/zl
         iPhrmLqLCY9pQDiTRD/xLfFcAIp8fhARGP4SnfnRNrtg4wGaoZTsd6OEV1vRiz+YfoHc
         ZT/rUzUS1CoWZ7HaeuaXUsYcOm2D7WjClPfZMysgbj2waTsacO/YEMVYYttvmr9jUed+
         cc6hQKmeHlVZ2wCu97wuLpg2BS5TYH13GsnEsMDdWkmZj+wTKOGF2UAxU/YYqBPHmHlq
         GXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YWfhJ7162sFqzRxEHTjigPHCRwDDnDob6lmja3wm+6w=;
        b=Zk6iQeV/j3jjrGAQbBLJIjFM/66zB/Op0XvtIGOQfdAgLC7JBhQGglGDYKXdx2oMzH
         zAomrzOBu1H4+BTVgF8bnqNHX0gPvoZm29siy6XX7oUFbkYn3R8F3NoVliOmMUCOgGEY
         N89QTGnRxGb/qJAtXbY+eo9cBvjar4sn8auOyTv9LZgZLrN/rMLNXvircaDCkV2Dm9Aa
         2kIHQ9/zGaszmOoW3B27oXptE+NG75J1tCDUnHkZQciZtR0w8UdgHywy+MudkfI1tSrc
         TtxMl+EtQJI+a2fBQfai8F3UsMmjrUsRoG/TSFe+Kw9P+YEXRtlHs71Hyn+MK+yQpQoi
         2ggw==
X-Gm-Message-State: AIkVDXL4rX345sb9dgBHoq6m7JPQew5zHbxGwIVINh+OSU12ZTUn8jLCSAbQ2o9gqFGTjMCJk4Hdn2xsWbDidA==
X-Received: by 10.25.24.152 with SMTP id 24mr5856524lfy.12.1486152972486; Fri,
 03 Feb 2017 12:16:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Fri, 3 Feb 2017 12:15:51 -0800 (PST)
In-Reply-To: <xmqqlgtnf6ce.fsf@gitster.mtv.corp.google.com>
References: <20170203003038.22278-1-jacob.e.keller@intel.com>
 <CACsJy8B=OEdUbc3_Svci_whtk=-Bz-4BP4y-Xr_u3CU81dxvCA@mail.gmail.com> <xmqqlgtnf6ce.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 3 Feb 2017 12:15:51 -0800
Message-ID: <CA+P7+xqGnS+aYSQGp4kfnhY6eGdV6Y2=RfzFsxCX+cFzHYpvHQ@mail.gmail.com>
Subject: Re: [PATCH] reset: add an example of how to split a commit into two
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 3, 2017 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> +$ git reset -p HEAD^                        <1>
>>
>> For good practice, perhaps put "git diff --cached HEAD^" before "git commit".
>>
>> I tend to avoid "reset -p" and "checkout -p" though because sometimes
>> it does not work. Not sure if it's just me, I think it may have
>> something to do with splitting hunks. So I usually go with "reset
>> HEAD^" then "add -p" and "commit -c HEAD@{1}" instead.
>
> Perhaps I am superstitious, but I do that, too.
>
> Doing this that way, the users do not need to learn "reset -p" or
> "checkout -p" and only need to know "add -p", and not having to
> learn two extra things is a big plus.  On the other hand, it
> requires the users to learn the reflog, but that knowledge extends
> to the use outside of the -c option of "commit" command, so overall
> I think it is a win.
>
>

I didn't know about the "-c" option to git commit, that makes the add
-p path a bit more straight forward. I'll re-word the example to use
this new suggested flow.

Thanks,
Jake
