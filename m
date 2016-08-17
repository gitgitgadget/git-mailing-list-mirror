Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9340A1F6C1
	for <e@80x24.org>; Wed, 17 Aug 2016 09:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbcHQJ6U (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 05:58:20 -0400
Received: from lang.hm ([66.167.227.134]:55499 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbcHQJ6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 05:58:19 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id u7H9w9bg005993;
	Wed, 17 Aug 2016 02:58:14 -0700
Date:	Wed, 17 Aug 2016 02:58:09 -0700 (PDT)
From:	David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:	Nikolaus Rath <Nikolaus@rath.org>
cc:	git@vger.kernel.org
Subject: Re: Working with zip files
In-Reply-To: <87pop8wh5w.fsf@thinkpad.rath.org>
Message-ID: <alpine.DEB.2.02.1608170256450.11774@nftneq.ynat.uz>
References: <87y43wwujd.fsf@thinkpad.rath.org> <alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz> <87pop8wh5w.fsf@thinkpad.rath.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 16 Aug 2016, Nikolaus Rath wrote:

> On Aug 16 2016, David Lang <david@lang.hm> wrote:
>> On Tue, 16 Aug 2016, Nikolaus Rath wrote:
>>
>>> I would like to store Simulink models in a Git
>>> repository. Unfortunately, the file format is binary. But luckily, the
>>> binary format happens to be a zipfile containing nicely formatted XML
>>> files.
>>>
>>> Is there a way to teach Git to take advantage of this when storing,
>>> diff-ing and merging these files?
>>
>> you should be able to use clean/smudge to have git store the files
>> uncompressed, which will help a lot.
>
> Having looked at that, I'm not sure if this really helps:
>
> As I understand, the smudge command is run on checkout to convert the
> blob in the repository to the format that is desired in the working
> tree. But this is the opposite of what I need: on checkout, I need to
> convert the text data in the repository to a blob in the working tree.
>
> Furthermore, I need to convert multiple text files into one blob, will
> smudge/clean seem to do just 1:1 conversions.
>
> Am I missing something? Are there any other options?

so the smudge command would zip the file and the clean command would unzip the 
file (assuming it's a single file, if the zip is multiple files, you will have 
to add something to combine them)

you want the working tree to have a zip file and the repository to have text.

David Lang
