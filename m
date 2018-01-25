Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1961F576
	for <e@80x24.org>; Thu, 25 Jan 2018 09:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeAYJyL (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 04:54:11 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:41273 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeAYJyI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 04:54:08 -0500
Received: by mail-oi0-f47.google.com with SMTP id m83so4839313oik.8
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 01:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OQqJowKpMbRobIJ2nEEmUOzc1UaEYwZW74AdvQKGnaM=;
        b=ujoq9aN8qae4udtXoVTjMqNKDpttUWePIwFu+pOrNLyRXd/sc6bO5P9a2r0w0Xk+Cr
         FfPi/u7qbiYIGpRTp3wYRyn64211IuxSEJ5G6JjRgu8938/jXiZ2vGOlqTem4SwSDW3d
         8yFp2zKgKx3fFcBhMSCcUIfHJogp15xqtz91K7fmdma6QuPOXazKxQHq9KJfibCFpce5
         g6/Urz9C2Q5kNQ1rfm/0aZbf9ri+CP6yClYQuZ3l8iYyaiwvlgVr/Lp73lBLctVuzQLO
         tYRVIZ5b1GTEWUqRDTaTqp8/0DSUy5np5zq3Wgv1CAy7bIaUt+6SPu4PSwbl0GqB1i1u
         RJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OQqJowKpMbRobIJ2nEEmUOzc1UaEYwZW74AdvQKGnaM=;
        b=Ac6YsCWcBbq9rdagGcJrgJ9Bp2H8I8FuHAoGH64z9zQgtVk83U42pJ4Rs75lenBFPz
         eUWx+KLXQyDEkfnt18YVCb/6Bu+JUv+aSWsIYTMJZBzVnBStxnjCJq1TqKXkUuF2piPw
         hFmRYp9g8tj9mxXFdgs2jAq/gs5ULN4binkvuqW1vrmTROvFvoW8ZayzzYK7wY4TTvST
         V0SbtFPQtubFFRk2Esd5FsQSt7nLMkWr6SBTd4KAeQQXsyJgO0Sy2HX415Bt6HkZ7Wa2
         94Owdq0SDr2Dfl1AzALt/smITjfCddmYFKJ79pthhd9s0v0YH6UBD6GGbcePZdQlzF5c
         wWFw==
X-Gm-Message-State: AKwxytfk2YAG9Ar/7Uakqe7ifj15IplVa/cOuyEFYBW6/RuzIITmPtR+
        +mHDBZtlBhdRuY2G23gKtGP8fuhLJqZhREUC89E=
X-Google-Smtp-Source: AH8x226dJGloRaPDfroX3UifNgSUOwjQz5EiKWr636LLIowJdH91z4+p/3KYDCL3xsZ3J52kj/IMVpPFEmSYN5AxMm0=
X-Received: by 10.202.177.136 with SMTP id a130mr8567689oif.252.1516874047992;
 Thu, 25 Jan 2018 01:54:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.144.218 with HTTP; Thu, 25 Jan 2018 01:53:37 -0800 (PST)
In-Reply-To: <xmqqinbraqa4.fsf@gitster.mtv.corp.google.com>
References: <cover.1516617960.git.patryk.obara@gmail.com> <cover.1516790478.git.patryk.obara@gmail.com>
 <xmqqinbraqa4.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 25 Jan 2018 16:53:37 +0700
Message-ID: <CACsJy8De7P4dXDX2QU=1-HWXtRqjz9o+sXH0zsKQ3mU0XgWkjQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Some fixes and bunch of object_id conversions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 4:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Patryk Obara <patryk.obara@gmail.com> writes:
>
>> Patryk Obara (14):
>>   http-push: improve error log
>>   clang-format: adjust penalty for return type line break
>>   sha1_file: convert pretend_sha1_file to object_id
>>   dir: convert struct sha1_stat to use object_id
>>   sha1_file: convert hash_sha1_file to object_id
>>   cache: clear whole hash buffer with oidclr
>>   match-trees: convert splice_tree to object_id
>>   commit: convert commit_tree* to object_id
>>   notes: convert combine_notes_* to object_id
>>   notes: convert write_notes_tree to object_id
>>   sha1_file: convert write_sha1_file to object_id
>>   sha1_file: convert force_object_loose to object_id
>>   sha1_file: convert write_loose_object to object_id
>>   sha1_file: rename hash_sha1_file_literally
>
> These were mostly pleasant read.  I'll queue these on two topic
> branches and wait to see what others say.

Looks good to me too.
-- 
Duy
