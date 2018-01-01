Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3CED1F404
	for <e@80x24.org>; Mon,  1 Jan 2018 23:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbeAAXrH (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 18:47:07 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:40029 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeAAXrG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 18:47:06 -0500
Received: by mail-oi0-f53.google.com with SMTP id w125so32466312oie.7
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 15:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o+MxBEdQV+erDepy/EHMD0FIYfPdcAiqjdrtkVS+e0o=;
        b=sMRGAMNq4K649jLmU///GupefaTwuM0Ee20FgH32d+sVcn1dP7Os6muGuJaPDGel3Y
         OisUzVppyUBOQK4ljrj5IUroiX1nhaQxBtNbKx8JL8pZZj0vDBPeVRo70b/jI5j4wvCD
         GVSjCGopeJvSOlisE6crlRZJH9WrQXKdzyhmRGb7xA2e2ie0VYzd0k9oHyfUCHBdGBnp
         NybRHnTjnW+rD0dsxGF2uCIvm911jMr2zLi9ViXdw2n0maAHxb73Qb3mExbwQmFjGrCu
         96PHupwiJicaUy8TLvi5yWwinCn7QKBgmkWPvxE4u9JBmsN9qn3MqGaM7QZ4Ahv4PNRG
         kYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o+MxBEdQV+erDepy/EHMD0FIYfPdcAiqjdrtkVS+e0o=;
        b=slbryWrj5OUY9HDEDZUox1oqSLqNwhOhuzTIGDiZG9/figzjhz+tJL0E3j/YN2s8rM
         ebYrDRw82GBQK2veF5eThekUpKG3mvThKRvxmsLn4yWERgqqXFK8VlyCDFcBFA9EsO8s
         PWXLIzG0iFhVwBMYMu2gzIEk6r9Jvf3Gph4BA0/Qx0PPAvCVHy1qt1v4LVLrnF9fwGYs
         OmrSVXIp7COa8hhdYffSsEgqVe7IADbAs9aHApzADTdTFrgkxErF9alHcQDcLWHszNKp
         AuI/TmN8RGn6DwCzvlfHaI/7ELnU4swAOT+p4+6vbQ33zuPZtJjozd7bb7o0OAdeGGPh
         i8cA==
X-Gm-Message-State: AKGB3mKV2QY8Z6aXNef12LsWL+2jp/J8FARbW4Pk8vRvtysJTqv9fFvx
        t/QwIc2E+9SSg1QBFJTtqYWbL3r1NH1pkVpyfzU=
X-Google-Smtp-Source: ACJfBosu/xWsG+LAdf4LsMozPnWW+mhPYX7Drs+g/Mm81wtE5f+apbqmHKtuSkI/Hj+nMId8AJ4GJlWQbfrN3by/Ht4=
X-Received: by 10.202.46.69 with SMTP id u66mr31171811oiu.253.1514850425740;
 Mon, 01 Jan 2018 15:47:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 1 Jan 2018 15:46:35 -0800 (PST)
In-Reply-To: <20171229041927.GA83931@bryant.local>
References: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>
 <20171229032927.GN3693@zaya.teonanacatl.net> <20171229041927.GA83931@bryant.local>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 2 Jan 2018 06:46:35 +0700
Message-ID: <CACsJy8Bw5RLTRNjvRpuBO4_jbK2dTasapDjHsb-=Y_3op0+L8A@mail.gmail.com>
Subject: Re: [PATCH] Add shell completion for git remote rm
To:     Keith Smiley <k@keith.so>
Cc:     Todd Zullinger <tmz@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 29, 2017 at 11:19 AM, Keith Smiley <k@keith.so> wrote:
> It looks like that was just about preferring remove in documentation and the
> like, I think it would still make sense to have both for completion since rm
> is still supported.

'rm' should be deprecated. But because I did not really push for a
deprecation plan and 'rm' still remains after 5 years, I guess it may
be counted as "supported" too (or we can start the deprecation process
now).

>> Keith Smiley wrote:
>>>
>>> Previously git remote rm did not complete your list of removes as remove
>>> does.
>>
>>
>> Looking through the history, the rm subcomand completion was
>> explicitly removed in e17dba8fe1 ("remote: prefer subcommand
>> name 'remove' to 'rm'", 2012-09-06).
-- 
Duy
