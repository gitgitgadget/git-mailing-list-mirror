Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05A0201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbdB1Uw5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:52:57 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35628 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdB1Uwn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:52:43 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so2922565pgz.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 12:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AflsgMVB33Rg1P5/w0IWlZmNaYC9mVP3inVrzvCBtLM=;
        b=PeEmZ1ynYicHTvN7u6czlvcGhSCZPzkNeFMXNLNJ522ozWcF4+QEgpfdEP+AJm/zWl
         FIMb2Perfh5JHRupWHSPiZGXnhKVMp8ziwfPIHwk6AGLaWpud9RVnD2vOH48reIt+aLD
         GMc9E2AD9tESh6kLzsemYIyj2ZMG4Ddgi34LHNvPfWfaCtLXIx/9/amt117LFGTAM7oQ
         r/tBUjyk3fTSs6IOQypu5NJI8u0m+hvt/RBgKJ0dOh4NtmCqWczo+qKXnQDZ7sfOt6AO
         oTn6LFReceoabluKAWq5Gy7SwGdlf9o21MtW98gMTmQO00h1yyCqvdHrsihg47iyMssb
         doGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=AflsgMVB33Rg1P5/w0IWlZmNaYC9mVP3inVrzvCBtLM=;
        b=jGg5YUd1lz84nTIJgQ+BpVMdoYbxkn1iQ7+MhjrUCn3thxr/+ySqn885moA6O4IvSK
         r1fZ/u0Cz8VV1aaMwZu2XAkGgpRaJ8SiV5I3Sm5W4C0PYRWCLjQRUsW3KkSWWpKpGrxr
         uMFJSgIf3Sp1+PomvLJ2GoK8H6s7TvfBDVmiQm0DzSoeJoQtT813Oy/CMT3wUI1mDmru
         fwBrTM4O4SVOfTsqEPmB8eqh8EWI/muOnjjnpZco8FfA8GMjI2pcQlU3c9VJiOydzNnD
         zP8Tq17ruoYussT9ZQJSugslzekxsQdJQ4cXt6D8fh9TA909BGwcr2lICiOF+vVIMFE1
         ycyg==
X-Gm-Message-State: AMke39lBrLTT0TsXRvxkztGSUAcFK5AFoYW5Ft6ZkgVT7u9t9Yz5gjJj8Z8wvUpmjj/UJQ==
X-Received: by 10.84.231.134 with SMTP id g6mr5515118plk.110.1488315162722;
        Tue, 28 Feb 2017 12:52:42 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id z74sm5927967pfd.70.2017.02.28.12.52.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 12:52:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v5 00/24] Remove submodule from files-backend.c
References: <20170218133303.3682-1-pclouds@gmail.com>
        <20170222140450.30886-1-pclouds@gmail.com>
        <c525b1cf-3bb0-452c-8a8d-b07c58f00c84@alum.mit.edu>
Date:   Tue, 28 Feb 2017 12:52:41 -0800
In-Reply-To: <c525b1cf-3bb0-452c-8a8d-b07c58f00c84@alum.mit.edu> (Michael
        Haggerty's message of "Tue, 28 Feb 2017 19:20:18 +0100")
Message-ID: <xmqqinnujaw6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/22/2017 03:04 PM, Nguyễn Thái Ngọc Duy wrote:
>> v5 goes a bit longer than v4, basically:
>
> I've read through patch 14/24 so far, and they all look good except for
> the mostly superficial comments that I have sent so far. I like the way
> this is heading!
>
> I'll try to continue tomorrow.
>
> Michael

Thanks.
