Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1B81F404
	for <e@80x24.org>; Wed, 18 Apr 2018 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeDRSAc (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 14:00:32 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:16078 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752530AbeDRSA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 14:00:29 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 8rNZfhssYLjjA8rNafWYlN; Wed, 18 Apr 2018 19:00:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524074427;
        bh=gpVb9KdUpxBkXp8pGbKXzJchmVceiUIQEKcYuQ7fcUg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hlXAFGptoH67siw0w3gYYwuXG+zCF+Hp/IrimkBZtKOI1S5BSVZgLkgLNozuIEnqp
         Cmk3qawhY7ofAETiDGsuuGYi0be8LFzalBKvbcbmjqqyxGI1sPVndSOM0qULdv3+lu
         R32OGfyVEdk/upH2V3LymqG5iw0Y18KtN2gV7RRk=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=cIBk9nwiCTQbJB3qrrYA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 04/15] sequencer: introduce new commands to reset the
 revision
To:     Philip Oakley <philipoakley@iee.org>, phillip.wood@dunelm.org.uk,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
 <cover.1523362469.git.johannes.schindelin@gmx.de>
 <fb797f32b7385317b9dc18524e3863ba627f6c98.1523362469.git.johannes.schindelin@gmx.de>
 <2bec489c-521e-0277-3a15-00b39126e652@talktalk.net>
 <BA40DE939AF14BC18B496FDA27281CA2@PhilipOakley>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b4ea06e6-462e-061e-2d66-0b2c7ee346ef@talktalk.net>
Date:   Wed, 18 Apr 2018 19:00:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <BA40DE939AF14BC18B496FDA27281CA2@PhilipOakley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNtkcAnTI/unvPDJVt7PujN65EIfU22sNzNeJxp33KSlA6FnDfMbBEHYb9sfNDUxf+80UMpIHeRjQ1BhLVLGBBQKY2Rw72aig3T2e7YDa4FxrEsooQAZ
 QPZyPPYdnfR2xoIBbhzidNf9XyMcz2cYOLb1RJOVqlszmVFKnCH6m1PvCc7/0eZvpgYlhE/iGD8RLUh3PjotgfdX+HTOaogABMpwJJcp7rkcsScjis0eSxyb
 6mIR9Rj7n9RNrWTuy4oQ1midQusMMntMPZaI8wiuojx0/X1qVhG/ANQBlb3rX04kPr33EoFMxoeHGwGm0hcwc82Eyo12+GbS8Nr6hbDrmPWfOjD+/sF+J1PQ
 5E0w9bU2h1CsJL/zgr+cFp6nvOmzzUZ0VmmVylI7FRyN0T6ov35as7u35O7+sL5BI3ECKEEQs679EwK1lmGvN0kObmuaec8wtI6X9eKEBiS32pGupeWU6VOi
 RkeDkaEyyOr9dsfZ/SD5rEYgk2hgvifH39FStQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/04/18 18:17, Philip Oakley wrote:
> From: "Phillip Wood" <phillip.wood@talktalk.net>
> : Friday, April 13, 2018 11:03 AM
>> If a label or reset command fails it is likely to be due to a
>> typo. Rescheduling the command would make it easier for the user to fix
>> the problem as they can just run 'git rebase --edit-todo'. 
> 
> Is this worth noting in the command documentation? "If the label or
> reset command fails then fix
> the problem by runnning 'git rebase --edit-todo'." ?
> 
> Just a thought.

Yes that's a good idea, thanks

>> It also
>> ensures that the problem has actually been fixed when the rebase
>> continues. I think you could do it like this
>>
> <snip>
> -- 
> Philip
> (also @dunelm, 73-79..)
That's a bit before me (94-00) were you there when they were building
the hill colleges and some of the science site?

Best Wishes

Phillip
