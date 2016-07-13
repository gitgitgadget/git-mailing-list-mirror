Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0BB2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 15:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbcGMPFr (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:05:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34969 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcGMPFp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 11:05:45 -0400
Received: by mail-it0-f67.google.com with SMTP id f6so3062446ith.2
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:05:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rNuTuh815xFtUVihOOAP+TDB9hK2sE9UbtwffRcWyF0=;
        b=yB++eQ4MbxqQ0NUbKm0n2N/jXl9XZihsm3L5W4+02p/Uk+UAjsJgK5XmaBgDe9EVjA
         BUyOre3mmKZ8zESjWPfh7H4DSg/kk6YklqsZ7YXKf0aXisqh2EaVDSpEBAcCdnYG7aWa
         AHqrJyohiavYt1IEvoUtJEmszDWsR4R7Lfk6P2/W//0WVoTf379a67dg0J1WiWEnX8sN
         kwcyVZcbN0qJ2Mv2bIl+BaCVlKuC0xhAll/d2XCtfdPkkUUL3cKqfkexWtmAVOYWt84N
         y5mni7F7Efo0DHidGAMP/mDzzXp8qHakG5cxYMVV8fxeqD/qWvdmKgNE/BU2dmfWsqVf
         IVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rNuTuh815xFtUVihOOAP+TDB9hK2sE9UbtwffRcWyF0=;
        b=hMwOvh3M2v12OQdR0g3bbJGgc3Iujuvyqq/cybGv7H5V/8Kj5sETYzOLyS7NKq0XGx
         vVHyAHaKhx22WbOifCYpBf90fTnZDHEiQklbkQLrl3WJlDQjS4+JlnsWGAFsqfiKi2PM
         x/nuf4C7CJZ1lsEHmLjaZb+KW/ik8BW7UBl9JeCJEYuGnu6TeJ4U3tuxSAsABkoo55ig
         hwJ/Od206Mau+Eg0+8m5Xb0JvLwlAnTmHaoLJy6rCynSdLRJne4dj3AY5p+WtrPDt94H
         hmxKoch1vv4Q5jG27O2T5iq7Na4n8CMivbxTXQUxc1IG2mnfokUbuXf47h2Yeb2MAqna
         N5XQ==
X-Gm-Message-State: ALyK8tIjFtXCOmEXiZy3S6ZRx+nTJOxW7EU73COW9BXOhdgaFIVSrdE3VWx0BSCYW4xWwAWEqk1Q2/8OFWntAA==
X-Received: by 10.36.123.199 with SMTP id q190mr9733762itc.42.1468422292211;
 Wed, 13 Jul 2016 08:04:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 13 Jul 2016 08:04:22 -0700 (PDT)
In-Reply-To: <xmqq1t2y4mjy.fsf@gitster.mtv.corp.google.com>
References: <20160706184829.31825-1-pclouds@gmail.com> <20160709052356.30570-1-pclouds@gmail.com>
 <20160709052356.30570-2-pclouds@gmail.com> <xmqq1t2y4mjy.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 13 Jul 2016 17:04:22 +0200
Message-ID: <CACsJy8B6faU6kaqSpNRZRxkrvM=W29acXkqVBdGq4gaqaDJRRA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] test-lib.sh: introduce and use $_EMPTY_TREE
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 10:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> This is a special SHA1. Let's keep it at one place, easier to replace
>> later when the hash change comes, easier to recognize. Start with an
>> underscore to reduce the chances somebody may override it without
>> realizing it's predefined.
>>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>>  t/t0000-basic.sh                |  2 +-
>>  t/t1100-commit-tree-options.sh  |  2 +-
>>  t/t4010-diff-pathspec.sh        |  6 ++----
>>  t/t4054-diff-bogus-tree.sh      | 10 ++++------
>>  t/t5504-fetch-receive-strict.sh |  4 ++--
>>  t/test-lib.sh                   |  4 +++-
>>  6 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> index 60811a3..48214e9 100755
>> --- a/t/t0000-basic.sh
>> +++ b/t/t0000-basic.sh
>> @@ -834,7 +834,7 @@ test_expect_success 'git write-tree should be able to write an empty tree' '
>>  '
>>
>>  test_expect_success 'validate object ID of a known tree' '
>> -     test "$tree" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>> +     test "$tree" = $_EMPTY_TREE
>>  '
>
> I doubt the point of, and I'd rather not to see, the leading
> underscore.  Are there existing uses of the name that want it to
> mean something different?

No. There is EMPTY_TREE in use, but it's exactly what we expect. It's
probably still a good idea to separate "global" variables from
per-file ones. But I don't feel strongly about this, so if a re-roll
is required (or somebody votes for underscore removal, including you),
I'll remove the underscore.
-- 
Duy
