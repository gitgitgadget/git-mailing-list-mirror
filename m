Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB6E20756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbdAQXcg (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:32:36 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36013 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbdAQXbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:31:39 -0500
Received: by mail-lf0-f50.google.com with SMTP id z134so117092842lff.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AkXj1SOgCVq2YvNx8uxSsXdNJt6LovnOvB9dyCGxv6o=;
        b=MNRU9gz0jNnNF8GJrGbWH9WFp/vlEBPGv+oBD3Jr1hltdEin33vuLqgMmOWH6A3e3e
         rr/kLe+xtOFN3RPjJAGr86OBew/ol2RkWU1MTb5RKDHWKeSv+b7zAQNOjzl4h2M4G4zi
         Mv8/T2clBjXE2WH6+8YsbpxbSwOjAek3R7Dtb2mHUpdJWr1ZQQyEP7jlPV6nE9GxmpNp
         RgphuuAiKFCRC5D+B4MdqkP4iI9lFZ7gBobJIV9GbUXEFoEjN5l6aHpqNm2/SGMtHffW
         /Be/JzfwzqugjYd+GvsadkuL8vHN/Lt8APSejivXB+Lw9RG0ZH8p/fatKpNOokCe/zgY
         NUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AkXj1SOgCVq2YvNx8uxSsXdNJt6LovnOvB9dyCGxv6o=;
        b=QKzY9D6LBJjfobwxFFL/2wLdTb7zwVpz6u9jz1SclXJm+wGmQv5NktKZ2jhTBHMf0j
         D8weCnOhe5xOUMf/07zrpfp4wgN598FZYMd12WpiERGqz/p0oo25555y7J5Um0ILLHPt
         qdvMTPYtYsSKJoJ2Qi/B+zugNIwBJ+Gm61koJeB25oGbYjJgc07LUfxHq1KbB7r0lzv9
         jzxjLOTWFemgaL0uhR2K4AiYwxFiRLMlcz0Z8++lekxaIgB1NC6Faes48MLufHpvp4L4
         0ZslnZGpas/zQgYbmOnULypKEM1JmAsPZvvUGHxlTpzd9XVqHK6o6vdnlf3EjbeuZSDa
         ApcQ==
X-Gm-Message-State: AIkVDXIM8AoRzd1vHtKloavir7sPRlJbJPzE5fyOA2DZw/GD6ICL/23EW0TZ3ebIYKZUvEzwYKPv6j5U9xYSXA==
X-Received: by 10.46.69.215 with SMTP id s206mr85583lja.26.1484695897235; Tue,
 17 Jan 2017 15:31:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Tue, 17 Jan 2017 15:31:16 -0800 (PST)
In-Reply-To: <97d4105c-0fa6-41c5-e456-30cebd93dc36@kdbg.org>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
 <20170112001721.2534-6-jacob.e.keller@intel.com> <5f723a0d-623f-bf97-00de-29d430484fed@kdbg.org>
 <CA+P7+xrmAmCPOzuaKcm+WxceXnowkM4gKz05tSpdC=CDwpCEug@mail.gmail.com>
 <5c8401ef-9609-f235-9228-be980a13edf1@kdbg.org> <CA+P7+xq1LMkRG_aSyamrsPUQE+rDv4A9Qd19tDMgx-_a5OHsqQ@mail.gmail.com>
 <97d4105c-0fa6-41c5-e456-30cebd93dc36@kdbg.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 17 Jan 2017 15:31:16 -0800
Message-ID: <CA+P7+xqFHG52Xo8ncUwa3owDn3OOz+rr3ZaGwfcUDCiXJmh80Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] describe: teach describe negative pattern matches
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 1:31 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 13.01.2017 um 07:57 schrieb Jacob Keller:
>>
>> On Thu, Jan 12, 2017 at 10:43 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>>
>>>  When you write
>>>
>>>   git log --branches --exclude=origin/* --remotes
>>>
>>> --exclude=origin/* applies only to --remotes, but not to --branches.
>>
>>
>> Well for describe I don't think the order matters.
>
>
> That is certainly true today. But I would value consistency more. We would
> lose it if some time in the future 'describe' accepts --branches and
> --remotes in addition to --tags and --all.
>
> -- Hannes
>

I am not sure that the interface for git-log and git-describe are
similar enough to make this distinction work. --match already seems to
imply that it only works on refs in refs/tags, as it says it considers
globs matching excluding the "refs/tags" prefix.

In git-describe, we already have "--tags" and "--all" but they are
mutually exclusive. We don't support using more than one at once, and
I'm not really convinced that describe will ever support more than one
at a time. Additionally, match already doesn't respect order.

Thanks,
Jake
