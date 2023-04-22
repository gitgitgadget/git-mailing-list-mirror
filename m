Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CAC6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 19:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDVTrc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 22 Apr 2023 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDVTrb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 15:47:31 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F1210D9
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 12:47:30 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 33MJkRMZ978001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Apr 2023 19:46:28 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeremy Morton'" <admin@game-point.net>, <git@vger.kernel.org>
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net> <01cd01d9754b$f12326b0$d3697410$@nexbridge.com> <fbe77ad2-ce65-e6a6-254e-01bf6446d582@game-point.net>
In-Reply-To: <fbe77ad2-ce65-e6a6-254e-01bf6446d582@game-point.net>
Subject: RE: Proposal: tell git a file has been renamed
Date:   Sat, 22 Apr 2023 15:47:19 -0400
Organization: Nexbridge Inc.
Message-ID: <01ce01d97553$4361f990$ca25ecb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLKSEVgGV7VqNVq5ZPBoEDYjfkU8wGiEiwXAbdj3K2tO0owAA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No, history is preserved in the rename.

>-----Original Message-----
>From: Jeremy Morton <admin@game-point.net>
>Sent: Saturday, April 22, 2023 3:45 PM
>To: rsbecker@nexbridge.com; git@vger.kernel.org
>Subject: Re: Proposal: tell git a file has been renamed
>
>I read that git mv is basically the equivalent to deleting the old file, creating the new
>file, and adding the changes.  Isn't it?  If so it's gonna have the same problem as I
>have now.
>
>--
>Best regards,
>Jeremy Morton (Jez)
>
>On 22/04/2023 19:54, rsbecker@nexbridge.com wrote:
>> On Saturday, April 22, 2023 2:02 PM, Jeremy Morton wrote:
>>> Yes, I know Linus specifically doesn't store file rename info in Git.
>>> The trouble is, every now and then, I'll come across a situation
>>> where Git doesn't successfully detect that I've renamed a file
>>> because I'm doing something like renaming a class at the same time.
>>> So I'll have a file OldClassNameTests.cs and a NewClassNameTests.cs
>>> but a bunch of lines in that file have also changed from
>>> OldClassName.DoThing() to NewClassName.DoThing().  I can clearly see
>>> that this is a rename, but Git sees enough changed content that it
>>> doesn't realize it, and puts it in as a delete/add, losing the content history.
>>>
>>> The standard answer for this is to rename the file in one commit,
>>> then make the changes.  That's fine if you know ahead of time you'll
>>> want to do this.  However it's a total PITA if you have a bunch of
>>> changes and you realize that a rename has caused this problem.  You
>>> now have to back out your changes to the renamed file, add the rename, commit
>it, then re-apply the changes.
>>>
>>> Could a command be added to git that means you tell Git that counts
>>> as a file rename?  Git would add a marker to the staging area that
>>> the file has been renamed, and upon commit, would first generate an
>>> additional commit for each rename before generating the main commit,
>>> ensuring the rename operation counts as an actual rename, and the content's
>history is maintained.
>>
>> Would git mv work in your situation? You can stage changes to the original file,
>then use git mv. Or use git mv first. The rename shows as staged in any event.
>> --Randall
>>
>>

