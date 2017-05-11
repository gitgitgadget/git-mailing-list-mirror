Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10ED1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbdEKJzo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:55:44 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34651 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbdEKJzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:55:43 -0400
Received: by mail-pg0-f51.google.com with SMTP id u28so12187364pgn.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=s6sxNP5Q21cNCvR5Ujnxj981i/PMSI2LkN7lMeZFnbk=;
        b=lqVCfK3esfDPYEeivT9esuYgL8FdOgcuRZKRgEunU0q9esiQSsSe2qM2TqHUfYAqHX
         2Gaor44eb8uErLsRbF9hZVYrn1PomVN4Gxts7Ron0vtFCRZ6HKPdDbIdsr0kYY9UPwZP
         s3WHB9vXI2CuUtladF+W5ZqMivEyIpRddXDVdV5b6b3BrJtUlnaVaRNZfOfSCPCAC8O+
         v439FnM8wZgj5Q5RdMAsnsLHIu/Z8OQYHfiE1JCeXQjKoednuTCGeFMMnjLz9DP2tjoP
         FHS3MBlbzJ9sWaoLVmaIcUPw5zLMhTkmY13mBwi/z56uhRwj3g7Tq8ZalKS52G3Wnl+q
         iB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=s6sxNP5Q21cNCvR5Ujnxj981i/PMSI2LkN7lMeZFnbk=;
        b=lvHFqyrIzBXPjjTygzoLEaFCfy6YrcuGl9iy+HcfBWtoQ+yk5uXE5xbXOFywATIxC1
         bpjk6jDEyJFzk1CBrTu6zUdoqr2pKs7S6Y6n7DHLQPHTvPt4r4yQF7LuRAVCC4t47Ypv
         eD4LpYWj9oDZGHwBZ2fzUWkgQtKQkXnxWuTi99J+R5pOl5LhbSrYzuC1183jfVgOVPVN
         LsVE/MkfgfMtX2T5yROjQ/BtYf9chlp/aFcJuSXctCWsAYvDQ6KKaTGNME+38WziynuP
         fyMLGj94LDv33w70IgcZqzh6ZY/3vidya3lkxyNAF5oDGNrCfesF7PV10aaVDHdTi6Nm
         hAPQ==
X-Gm-Message-State: AODbwcD2UnjYljbjpYeo9S02sCdqdrS4nyrMNxDE/Pujebj4KIEJ1sxQ
        TSM51ECc0tpe1roLL8k=
X-Received: by 10.98.215.72 with SMTP id v8mr11281711pfl.121.1494496543047;
        Thu, 11 May 2017 02:55:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id f193sm2585833pgc.54.2017.05.11.02.55.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 02:55:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] perf: add function to setup a fresh test repo
References: <20170510225316.31680-1-avarab@gmail.com>
        <20170510225316.31680-2-avarab@gmail.com>
        <20170510233032.GD28740@aiede.svl.corp.google.com>
        <CACBZZX50-0uzMyYJo5Z92nRH0m-Q70=P4Wr-LwBqH71nXdsmcA@mail.gmail.com>
Date:   Thu, 11 May 2017 18:55:41 +0900
In-Reply-To: <CACBZZX50-0uzMyYJo5Z92nRH0m-Q70=P4Wr-LwBqH71nXdsmcA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 11 May
 2017 02:00:12
        +0200")
Message-ID: <xmqq8tm3afaa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, May 11, 2017 at 1:30 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hi,
>>
>> Ęvar Arnfjörš Bjarmason wrote:
>>
>> [...]
>>>  # call at least one of these to establish an appropriately-sized repository
>>> +test_perf_fresh_repo () {
>>> +     repo="${1:-$TRASH_DIRECTORY}"
>>> +     "$MODERN_GIT" init -q "$repo" &&
>>> +     cd "$repo" &&
>>> +     test_perf_do_repo_symlink_config_
>>> +}
>>
>> Unlike the other two variants, wouldn't this leave the cwd inside the
>> new repo?
>>
>> In other words, I wonder if the commands starting with the 'cd' should
>> be in a subshell.
>>
>> Thanks and hope that helps,
>
> Yup, I'll fix that. Thanks for the review & also on the other patch.
> Will send a v3 with these issues fixed.

Hmph, does v3 actually have this change?
