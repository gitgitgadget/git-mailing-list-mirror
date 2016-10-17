Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD121F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 23:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754742AbcJQXCC (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 19:02:02 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34119 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935334AbcJQXBv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 19:01:51 -0400
Received: by mail-qk0-f175.google.com with SMTP id f128so251598094qkb.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 16:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2uoSdwgdmkZMe/pyy4C0KAlao42bUY9gzuDFpM2zhZI=;
        b=SNZym7J/4NlJTC0sqFLISP3bDuJJTPGX7IJDxt29s3ypJ7yVwl9YGEika4/a73sR8Y
         mEhVe41ijjCI+1rz3F7tJdEZ4yYi5wdekKuq4s164L+7GIhFBzV1xLWX0M8W8D3oVFBy
         VEEY2UysQwXxcyDDyqmVL5H9j0NsJKgUZJU2XMwea1DUmrSpfp9gfw5tDgV4nU3/0CAh
         KvnApXlJIKnkf7P4RrKr5TQdLzpvV6Kc9yVa8ouzu6lPFwT2DnZQR6uQDQ6Q6GITrvI8
         SNeMe4LW4rE1Lm0ObERu+t07E98dyxTdkdTIodRCJcwgrbQoSApbPar3/sp27Rky/PKd
         orJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2uoSdwgdmkZMe/pyy4C0KAlao42bUY9gzuDFpM2zhZI=;
        b=m328y8+zzaC7K/O70FlXEeDjS+eCeQ63ZP2s9vdNMLFMr9WJ67rkCPDMpm0dhkmGyo
         9TVoSRXrovsRMB9sSx/z1iGCHdCzUERztHjXZELyKc5IM9bFUDecy7R3Jm0J0iU4K6Wm
         w16rkU/cER3yu/vukKkb82LBO/Tu/kvJHIx8OwczJVruvr5Zx4emEtSsOt1QTWCTWhz5
         MixGdv4MTSIfIp29TVqVghzbFu0wgCW9FOMzIofPmSLVBJoF955z1j84kL8lPdSnGjkS
         NcqiRRV9AMEejV6uB6Oor4MvThyEMFwHAk7+SYH2exCY30jGh53rDWJgH3rfqyMGE1J3
         vJqA==
X-Gm-Message-State: AA6/9RkjiwawaZKcWlNHDEsqxfr8j37uHRAVOOuaZ18MeU13jIRE+CCdr0JJDu5XVs25cRJ1Ma4+l4gb40FWCUgN
X-Received: by 10.55.56.11 with SMTP id f11mr25108131qka.255.1476745303518;
 Mon, 17 Oct 2016 16:01:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 17 Oct 2016 16:01:43 -0700 (PDT)
In-Reply-To: <b09fb7693069a14d2ed9ec47545e49294ac3015e.1476466609.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476466609.git.jonathantanmy@google.com> <b09fb7693069a14d2ed9ec47545e49294ac3015e.1476466609.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Oct 2016 16:01:43 -0700
Message-ID: <CAGZ79kZWQ7tBck1V_feYiAa-sTW0UC9j51AKzO3QrJBw-jdzvw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] trailer: streamline trailer item create and add
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 10:38 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Currently, creation and addition (to a list) of trailer items are spread
> across multiple functions. Streamline this by only having 2 functions:
> one to parse the user-supplied string, and one to add the parsed
> information to a list.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
