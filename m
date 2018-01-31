Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABCD1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 18:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbeAaSCY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 13:02:24 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:30821 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932158AbeAaSCY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 13:02:24 -0500
Received: from [192.168.2.201] ([92.28.135.202])
        by smtp.talktalk.net with SMTP
        id gwiDew4mRAp17gwiEeJgdv; Wed, 31 Jan 2018 18:02:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1517421742;
        bh=j5bD0zpPZfbAgIlhldN4+63KTqiiBOfFutnemfVGX6A=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=POAkKD+hh1Ei56N+P5Cd91F0WT2eXFvVOXGhb5yC2kz0k8yA+XH3ZzzKgwjSVE59b
         B6LxB9cYEnZwmXewcuXpvgFxOfj62btXxcQbqDUT5z/jHJFXGs+ALRFs/dEFXwOXnW
         ojkwl8TFw9Yu47dLfvfx/MZViQuX3BvLMulFNLr4=
X-Originating-IP: [92.28.135.202]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=+9ZQAP2FB+pNrrgMTYJMPA==:117
 a=+9ZQAP2FB+pNrrgMTYJMPA==:17 a=IkcTkHD0fZMA:10 a=w_pdHa2Rh4iZzVReR6cA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 02/10] sequencer: introduce new commands to reset
 therevision
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <cover.1517266437.git.johannes.schindelin@gmx.de>
 <36281a14bc9f9a53e6c1bead561e3c93744047a8.1517266437.git.johannes.schindelin@gmx.de>
 <CAGZ79kYK9H88HRLKBFs+OatYMVVqmc1WOsTbaUbaK9yW0Sqqrg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801311411040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <cba8d5dc-f42d-8412-c471-edb5a860b3ae@talktalk.net>
Date:   Wed, 31 Jan 2018 18:02:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1801311411040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO2Q5e0ssqwBhTvlzFZj7oKZ9JjtptGLCip8QhVFlPCi1DaAKgfRvXho3YzR2s78gZL7YjAFbJQnSUUa87M3O8tqHamjEVRW6bfB43NpEHixC86tcEmR
 piqqmBSdcDRO4q5ctjRWsDUox+5xZpfGzWglj1MAfhXxY+ENvggAxi8WPQoGLRt5SQUBrb4rxXMIzUhqE7vW1lsgJfvzwvPfahzh0zc7tX0aINcDL2c2tAyf
 HucuGU9sUMmDBF7btJ31O22O20z7fXhKrPhGgMf9NePK2QB3c+CeWVBKQevpec96dALD1h3eM5mSk/uSGap9aOyqVyMBeh0iIyymdrc017h+b+VfN8XPvY4K
 p5yR/DQk/ppGMvLKpFARhqjgrJJ4btUgZucqTUMWskmMq/+tceKQnmwWXgJ2YOLjFtkyK5cN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/01/18 13:21, Johannes Schindelin wrote:
> 
> Hi Stefan,
> 
> On Tue, 30 Jan 2018, Stefan Beller wrote:
> 
>> On Mon, Jan 29, 2018 at 2:54 PM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>>> @@ -116,6 +118,13 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
>>>  static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
>>>  static GIT_PATH_FUNC(rebase_path_rewritten_pending,
>>>         "rebase-merge/rewritten-pending")
>>> +
>>> +/*
>>> + * The path of the file listing refs that need to be deleted after the rebase
>>> + * finishes. This is used by the `merge` command.
>>> + */
> 
> Whoops. The comment "This is used by the `merge` command`" is completely
> wrong. Will fix.
> 
>> So this file contains (label -> commit),
> 
> Only `label`. No `commit`.
> 
>> which is appended in do_label, it uses refs to store the commits in
>> refs/rewritten.  We do not have to worry about the contents of that file
>> getting too long, or label re-use, because the directory containing all
>> these helper files will be deleted upon successful rebase in
>> `sequencer_remove_state()`.
> 
> Yes.
>
It might be a good idea to have 'git rebase --abort' delete the refs as
well as the file though

Best Wishes

Phillip
