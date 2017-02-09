Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F0B1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 19:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932450AbdBIT6S (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 14:58:18 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35911 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753499AbdBIT6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 14:58:16 -0500
Received: by mail-pf0-f194.google.com with SMTP id 19so825215pfo.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FJrMVgGxpb+2gpP5qO9u8x4FU1+3RGs7Mu/vj/K25lk=;
        b=nhgPnSF5z3MIRP/oX8tIndWlCqim5qfn2KcvU6PXfhmObp37uda6+W0tBOtmVIzzHx
         ZUmbXPV0g0eiifNfWnP3pp3kMBRgQTXZHv/fkHdQSctTIbEjzLXaueIIGADpZflB7Ec2
         GzxfJ0NAnJeJUKHD2j6Qcu+xZPskVOsqGo+g/+LHzSG4KojzX1YK3ANP8eavrEH5Etsi
         ivIh851wMVKepg02b87lH9WvJElAHX4my93CAIFT5Nkj0VGEAj5xaNECdFjNpMKWfZ4l
         bm1H+d4k3OXGepxbOtaiK/UuT2tAwgjhr+8DUcHanNAh3j4hb1H1lgmZG9uHGmd412C8
         m2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FJrMVgGxpb+2gpP5qO9u8x4FU1+3RGs7Mu/vj/K25lk=;
        b=D9R/eQJrMQ09o9rCUjXqV88tPiwjDur0yMP3dRrdJ19Jfta224btQzOzvcQhUyu4Ig
         11iZALMI92B2irhw6zx6/w19MiRCt9vrwlLabeHHWzVli2aSFQOfsF2vG+U6U7MwUFSv
         hBjcZyy2cDKtAJwuhWyjvQ84kHuGvj2q6WqiT6evXeRQ7j91bSsNX7mpkhz2ehE8mCht
         gREkrtkY47AxfzzButRM6dlcm+bTpYjc+28pLbzdKXO251TIMJsddfSlf60WGlUWrumq
         3GwrgtuUHCyXpbDzBn5BPGzET0+rpEwzIuAckCe3hegNyCgSyZ4/rnaV+yCGr40EMqMm
         Eutw==
X-Gm-Message-State: AMke39nJgI0pKChWkvvGL/eS/qkYsyFcgpTbeCAflbvUl3cypVbkuQwLLZm9Pc1PM2yOIQ==
X-Received: by 10.99.237.17 with SMTP id d17mr5841753pgi.82.1486668281443;
        Thu, 09 Feb 2017 11:24:41 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id p66sm30812826pfb.88.2017.02.09.11.24.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 11:24:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
        <2f67fc21-92f9-a03e-1b09-a237af6dbc46@alum.mit.edu>
Date:   Thu, 09 Feb 2017 11:24:39 -0800
In-Reply-To: <2f67fc21-92f9-a03e-1b09-a237af6dbc46@alum.mit.edu> (Michael
        Haggerty's message of "Thu, 9 Feb 2017 17:08:13 +0100")
Message-ID: <xmqqy3xfp3pk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/06/2017 11:34 PM, Junio C Hamano wrote:
>> [...]
>> --------------------------------------------------
>> [Stalled]
>> [...]
>> * mh/ref-remove-empty-directory (2017-01-07) 23 commits
>>  - files_transaction_commit(): clean up empty directories
>>  - try_remove_empty_parents(): teach to remove parents of reflogs, too
>>  - try_remove_empty_parents(): don't trash argument contents
>>  - try_remove_empty_parents(): rename parameter "name" -> "refname"
>>  - delete_ref_loose(): inline function
>>  - delete_ref_loose(): derive loose reference path from lock
>>  - log_ref_write_1(): inline function
>>  - log_ref_setup(): manage the name of the reflog file internally
>>  - log_ref_write_1(): don't depend on logfile argument
>>  - log_ref_setup(): pass the open file descriptor back to the caller
>>  - log_ref_setup(): improve robustness against races
>>  - log_ref_setup(): separate code for create vs non-create
>>  - log_ref_write(): inline function
>>  - rename_tmp_log(): improve error reporting
>>  - rename_tmp_log(): use raceproof_create_file()
>>  - lock_ref_sha1_basic(): use raceproof_create_file()
>>  - lock_ref_sha1_basic(): inline constant
>>  - raceproof_create_file(): new function
>>  - safe_create_leading_directories(): set errno on SCLD_EXISTS
>>  - safe_create_leading_directories_const(): preserve errno
>>  - t5505: use "for-each-ref" to test for the non-existence of references
>>  - refname_is_safe(): correct docstring
>>  - files_rename_ref(): tidy up whitespace
>> 
>>  Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
>>  once there no longer is any other branch whose name begins with
>>  "foo/", but we didn't do so so far.  Now we do.
>> 
>>  Expecting a reroll.
>>  cf. <5051c78e-51f9-becd-e1a6-9c0b781d6912@alum.mit.edu>
>
> I think you missed v4 of this patch series [1], which is the re-roll
> that you were waiting for. And I missed that you missed it...
>
> Michael
>
> [1] http://public-inbox.org/git/cover.1483719289.git.mhagger@alum.mit.edu/

Actually it was worse than that.  What the above lists *is* v4; I
just failed to update "Expecting a reroll" note when I updated the
topic with your rerolled patches, and left it there trusting the
now-stale note of mine.

Sorry, and a HUGE thanks for noticing the mistake.
