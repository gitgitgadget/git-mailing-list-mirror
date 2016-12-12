Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1025F203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 20:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbcLLUhP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 15:37:15 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34598 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbcLLUhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 15:37:14 -0500
Received: by mail-qk0-f171.google.com with SMTP id q130so95756316qke.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 12:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O9NbUrnVrpUtADs0XJQtyU7WWZT+QHAw8DSFSJbm+bQ=;
        b=ZBn6n42XAm4I/ZvcDJAwwjhNIv0U9gbSNMFpqkFsYU4n65sro3ikdXNbuYNuwTxksu
         rV2ljKsBjimOzrlmTkQOqSBI0X6kboaUioZmVflgBxUuASLSRp6qAJ9O7N4tQeMroIAh
         gNJUPlYgWNXIHBlPq+H6RjvulJwB8G1EkaaC+Pn1CFWT7qa+ovfnWCKrvGuCrP8oy5gq
         eqvL7jYQntZ+cPWxpQI/7syOM6tG2aAsjUlfG/fenlx8+X97yriOtBk/PdDc+x4rYIfB
         rrRZosLm3EruDnNfWpUy+Wtg4m7bV4smqMffoLeGWhfTqHA+K39YZv8hS+8LEcqMybSk
         NtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O9NbUrnVrpUtADs0XJQtyU7WWZT+QHAw8DSFSJbm+bQ=;
        b=i3yIj9rlhie3ef9QLsNqCsIFRG7shsGUj1P/JCviEv3A3T9N5N1h3cV/VZhcDKk+I5
         HHIIkISp/EPRxIgEJvMjfadiKScWCL2jJUWPBtrY+/M//EjADk2tTp6CcSMa+kzO/c4c
         gomwaw0RqgLAVLSPX5qZ5YIHWe7ybsODqFKPjo0WOvocLMSgWHc5eA8rdEdjt5FE/MZU
         S69C/m3iQOID0YnNv6MhjNnNaegLXVpbTq5CGUKE/uEz1d2bqrN1MWiwSYz2gFxL7H2R
         x3D5uvqjiyr4/wU8yoZuJrbdvtdWtR6CZH88AuA3CuaS1eAGVuwGG1xZa60m+8E5TD8D
         HZwg==
X-Gm-Message-State: AKaTC03ldM227kPs0MhxRAcUtjZBWFhz4takP+ztPGBgVRmmqKI2rX+qc90NOXJ5R9PSFQSPfGrR/vocUKm5AWoI
X-Received: by 10.233.216.7 with SMTP id u7mr25655403qkf.220.1481575033280;
 Mon, 12 Dec 2016 12:37:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 12 Dec 2016 12:37:12 -0800 (PST)
In-Reply-To: <20161212203528.GA193413@google.com>
References: <20161212190435.10358-1-sbeller@google.com> <20161212203528.GA193413@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Dec 2016 12:37:12 -0800
Message-ID: <CAGZ79kYviLE9XF3RCpqzSyp7NuSBXtaGpoExQ4ePXJYO+cNFrA@mail.gmail.com>
Subject: Re: [PATCHv7 0/6] submodule absorbgitdirs
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 12:35 PM, Brandon Williams <bmwill@google.com> wrote:
> On 12/12, Stefan Beller wrote:
>> v8:
>> * Change the worktree implementation: do not have an internal
>>   submodule_get_worktrees, and count the number of worktrees, instead
>>   directly look if there is a worktrees dir and check if there are any files
>>   in there.
>> * reworded one test title slightly.
>> * interdiff to v7 (that is queued as origin/sb/submodule-embed-gitdir) below.
>>
>
> not important but your cover letter's subject is v7 instead of v8 :)
>

I realized that, after sending out.

When working on just one series on the mailing list,
I tend to reuse the coverletter and just adapt it, so I
would presume the diff stat is also broken.
