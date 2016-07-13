Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396622018F
	for <e@80x24.org>; Wed, 13 Jul 2016 15:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbcGMPAz (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:00:55 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35222 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbcGMPAx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 11:00:53 -0400
Received: by mail-io0-f193.google.com with SMTP id q83so3101150iod.2
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:00:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Pj5ZGvKusK++I9jo/YnREVYchZ35M4ExbWn7XmKHjQ=;
        b=wjWBS5b0Xe6AZ6jZSDeDvAdexplGCp79jr4iVTTkyjL2wKtRjXK6sqzvvC1cDnfkfU
         Jy4r6R3m9o5X4DkhWbcLxsuHUabueXo1kC0Uy8O9GbDxl4wMcbXfy6+lhtO5dLsaGYWZ
         fizIk3S0uRDkMMxeJ91glByT+xzUPZagFCuHUmj0Ps7P8ez/LugBcraXWtw014UTIYbx
         MvvJm19KvAG715u/zqa8LuKZP+F46jAqlhhRUoNs2cLvRP9wyZx/2VYEqMEwEFT7x1S9
         fJQHGcLSXq1NG6zPZRvJeYyUvrtZcE/HFbqZY7EW7Xdw02rlwP/PPaT8ks46btXavRM9
         kDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Pj5ZGvKusK++I9jo/YnREVYchZ35M4ExbWn7XmKHjQ=;
        b=lYjjiynq64IckHS5dH+KPZBzfyT6NctLwJ499FfLo9EC3OaRXzRoqrwbxQE4XviEuL
         /7dVhb7LlGHKXrVGBNGLTbEe5biMUsQTmg+zD2AXggje7Bt19SHpgHN7zd6lIOHHVhaW
         0IXVyw/MkK6vyJjAgc70uhxNFA9Vji2Emrg8FMLi0CPnOoeWfTinNA+m+HkJFjwFEgl9
         4vx3vtZt2Qal2Yb3OC+YZ1csj2HY7G4IlWRSb4iG9R0jZ1hE8qXA5a4X57LYDDIdZFRM
         AMY5/wGlgcuXLarAgYGnWlQt5stEpCnWfMJzAEp3dj424snv4XozQtRURIhGcyIvVgmE
         z4zQ==
X-Gm-Message-State: ALyK8tLDR0EcgdU3A1nkyzHoUpTr4EIE596OqtwVfMX2yZdJXNAY81c5FRmO1zlmVQyf4KDDCxTO2KpbnSFZgw==
X-Received: by 10.107.22.6 with SMTP id 6mr9250818iow.128.1468422013720; Wed,
 13 Jul 2016 08:00:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 13 Jul 2016 07:59:43 -0700 (PDT)
In-Reply-To: <xmqqtwfu37ld.fsf@gitster.mtv.corp.google.com>
References: <20160706184829.31825-1-pclouds@gmail.com> <20160709052356.30570-1-pclouds@gmail.com>
 <20160709052356.30570-5-pclouds@gmail.com> <xmqqtwfu37ld.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 13 Jul 2016 16:59:43 +0200
Message-ID: <CACsJy8AQLoe=61+iibfsYw-0ibVKF8zruymAFZqr8SwxX=JT2A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] cache-tree: do not generate empty trees as a
 result of all i-t-a subentries
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 10:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> diff --git a/cache-tree.c b/cache-tree.c
>> index c2676e8..2d50640 100644
>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -380,6 +380,13 @@ static int update_one(struct cache_tree *it,
>>                       continue;
>>               }
>>
>> +             /*
>> +              * "sub" can be an empty tree if subentries are i-t-a.
>> +              */
>> +             if (sub && sub->cache_tree->entry_count < 0 &&
>> +                 !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
>> +                     continue;
>> +
>
> Looks sensible, except that it is unclear if it is correct to assume
> that "subentries are ita" always equals to "entry_count < 0" here.
> I _think_ it is OK, as the function itself does use the latter as
> the sign that it hit to_invalidate=1 case when it returns.

I had the same concern and double checked it. If one day we have a new
entry_count < 0 case that's not i-t-a, we'll need to refactor this
code a bit.
-- 
Duy
