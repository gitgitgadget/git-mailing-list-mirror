Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7901F453
	for <e@80x24.org>; Wed, 23 Jan 2019 19:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfAWTV4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 14:21:56 -0500
Received: from smtp29.i.mail.ru ([94.100.177.89]:41158 "EHLO smtp29.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfAWTV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 14:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=vGbMWS+XqkpLI6C6kYEMlSWrpb1GRhjb9HBeMR9MREA=;
        b=aJo6Q4b8wfXY73VkAZuUd0rbHc4DXuwsd45p4s5fz7PdEdSkcYVU8ugiGJdJdOrawRkxaEFxB8z08PchnR9RvkrZkzXANl+mq09Zfdz4AzTXvVQDDRs7OHgwgJVxgCljpYZNMfRa9RLvxVYfOZ1wzA15cqAsthJ7mYTZYa2T6Lo=;
Received: by smtp29.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gmO5x-0002RJ-0B
        for git@vger.kernel.org; Wed, 23 Jan 2019 22:21:53 +0300
Date:   Wed, 23 Jan 2019 22:21:51 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     git@vger.kernel.org
Subject: Fwd: Re: [git-users] List of ignore configuration file
Message-ID: <20190123192151.uwwbkkoib7zqhoip@tigra>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170306 (1.8.0)
Authentication-Results: smtp29.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-77F55803: 260C666A7D66B36A5A78504BD2AC2941FB2FADD82D94A0F76AE357E6F0A8C27AC2C27D75854CA720B49494E9A1CE4011
X-7FA49CB5: 0D63561A33F958A586A55DCF77A6446DAF36DEA1B7529061A3C41EEC065DAD478941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249FABAEF6C2F5AA74A3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE7B742A0F936AD8A56CD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE71FFB7292748DFEBEFB46F7CE0A3970D575ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57D4B828FA1BC0F1ACBD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA41D48D195BB9B3D1234882BFA858CFB12525D33B0D3204FECFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A user over there at the git-users ML is having troubles with the
wording of the `git check-ignore` manual page which, in their opinion,
fails to clearly communicate the twist about tracked files being not
eligible for ignored/non-ignored checks:

----- Forwarded message from cl.robitaille@gmail.com -----

Date: Wed, 23 Jan 2019 10:15:59 -0800 (PST)
From: cl.robitaille@gmail.com
To: Git for human beings <git-users@googlegroups.com>
Subject: Re: [git-users] List of ignore configuration file

Well, the first point to mention is that anyone writing help, man page and 
information must not forget that the vast majority of readers are reading 
such information because they do not know..... This is obvious but the main 
point is to not take for granted that they have a deep knowledge, 
particularly when a concept is a bit "strange"...

Now, I understand that git is, normally, for developers, which are 
typically more knowledgeable, but still....

And I agree it helps to have real user inputs, so I will provide many. I do 
not expect all be accepted but this is Ok.

So, here it is

1 - Ideally, the man page should be following "the standard" format. I am 
not sure if one exists but since the vast majority of the man pages are 
using the same layout I presume that there is some form of soft standard. 
Here, obviously, my point is about listing all of the files and their 
location at the end of the page (which does not preclude to mention then 
elsewhere in the text if desire).

2 - For the git-check-ignore. here are my suggestions

DESCRIPTION
       For each pathname given via the command-line or from a file via 
--stdin, check whether the file* / directory*  is excluded by .gitignore 
(or other input files to the
       exclude mechanism) and output the path if it is excluded.

       By default, tracked files * and directories *are not shown at all 
since they are not subject to exclude rules; but see ‘--no-index’. *In the 
case of a directory, any *
*       tracked file or directory below it will cause the directory not to 
be shown.*

3 - Again in git-check-ignore.
     
Actually, here, I think the description of --no-index is wrong. At least in 
my case, which was that a directory WAS ignored by git add because a file 
under it was already tracked. The man page description is only talking 
about the opposite case where git add is not ignoring the pathname. I 
wanted to provide a suggestion here but I fail to understand the use case 
described by the man page. In fact, I am not even sure it is correct. git 
add appears to honor the ignore instructions despite having already tracked 
objects. May be the use case is when the pathname is BELOW something 
already tracked??

4 - git check-ignore should be augmented to have an option of simply 
listing all of the ignore files, may be even allowing to dump their 
content. The latter may be too much....


On Tuesday, January 22, 2019 at 5:37:11 PM UTC-5, Philip Oakley wrote:

> On 22/01/2019 22:35, Philip Oakley wrote: 
>
> Extra points for you will be on order if you can suggest some better 
> wording for manual pages to help others patch that misunderstanding. 
> The same would apply to a contribution for the git-scm 'book'. 
> 
> It is a help to the devs to have some real user input... 

>> On 22/01/2019 21:20, Claude Robitaille wrote: 
>> Thanks this help. 
>> 
>> I did read the man page, but I am used at seeing the files and 
>> locations at the end of the man page the section FILES. My bad to 
>> skiping right to the end of the man page. See dnsmasq as an example. 
>> 
>> Yes TL;DR..... :-( I skip too quickly on --no-index. But now I 
>> understand that it makes check-ignore to "mimic" add.... (even if 
>> mimic was not the intent) 
>> 
>> But, the description is talking about file and tracked files. It is 
>> not obvious for an occasional user to correlate that with "my dir is 
>> not checked because something under it is indeed tracked" . Bomttom 
>> line, what I am saying is that dir and file are slightly different in 
>> the context here and yes my mental model was wrong. 
[...]

----- End forwarded message -----

The whole thread is archived at [1].

1. https://groups.google.com/d/topic/git-users/GPBJxQWeHuA/discussion

