Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71105C433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 09:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiACJ0Z convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 3 Jan 2022 04:26:25 -0500
Received: from mx1.uni-regensburg.de ([194.94.157.146]:44664 "EHLO
        mx1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiACJ0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 04:26:24 -0500
Received: from mx1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id CBB12600004E
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 10:26:18 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx1.uni-regensburg.de (Postfix) with ESMTP id A363B600004D
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 10:26:18 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 03 Jan 2022 10:26:19 +0100
Message-Id: <61D2C138020000A100046A21@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Mon, 03 Jan 2022 10:26:16 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Elijah Newren" <newren@gmail.com>, <sluongng@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: [EXT] Re: Filtering commits after filtering the tree
References: <61CC2DD2020000A10004691F@gwsmtp.uni-regensburg.de>
 <CAL3xRKet7KXTx+6ALVZCxeFRkU3guwNc6GtAT1iofB=UKqj2fg@mail.gmail.com>
 <CABPp-BHnpKZ8LJzd_NL_6TGe7U3A2xPDPuvBkDQ68iTH_un6=A@mail.gmail.com>
In-Reply-To: <CABPp-BHnpKZ8LJzd_NL_6TGe7U3A2xPDPuvBkDQ68iTH_un6=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Elijah Newren <newren@gmail.com> schrieb am 01.01.2022 um 00:48 in Nachricht
<CABPp-BHnpKZ8LJzd_NL_6TGe7U3A2xPDPuvBkDQ68iTH_un6=A@mail.gmail.com>:
> On Fri, Dec 31, 2021 at 2:27 AM Son Luong Ngoc <sluongng@gmail.com> wrote:
>>
>> Hi Ulrich,
>>
>> On Thu, Dec 30, 2021 at 12:28 PM Ulrich Windl
>> <Ulrich.Windl@rz.uni-regensburg.de> wrote:
>> >
>> > Hi guys!
>> >
>> >
>> > As  I know there are really smart ones around, please don't laugh how I 
> helped myself with this problem:
>> > https://stackoverflow.com/q/70505903/6607497 
>> > I'm sure you wouldn't have wasted hours with rebasing interactively...
>> >
>> >
>> > Feel free to comment either on the list or at SO (comment or improved 
> answer).
>>
>> You probably want to try git-filter-repo (1)
>> while using `--message-callback` as documented in (2)
> 
> In particular, you'd get most of the way there with a simple
> 
>    git filter-repo --path my-module/
> 
> That will remove all files not under my-module/ from the repository,
> AND remove all commits that become empty due to removing all the other
> files.
> 
> 
> If you had commits which both touched my-module/ and also made
> reference to other files outside of my-module/, then you may also want
> to clean those up.  If that's something you can write code to do
> (perhaps because the commit messages were regular, or you are an
> expert at parsing and rewriting natural language programatically),
> then the --message-callback suggested by Son could help you out.  That
> sounds difficult to me, because I don't know how to even identify such
> commits without having a human being read every single one.
> 
> But it sounded to me like most of the commit messages you didn't want
> were ones that just touched paths outside of your selected module, in
> which case the simple path filtering I suggested above would clear
> those all out for you.

Yes, as I had a changelog type of file I had many commits describing changes in changelog that refer to files that are no longer part of the repository (commits for the files themselves had vanished already).
(I know changelogs are a bad idea)

I'll try your proposal next time. Writing custom Python filters is too much for me at the moment...

Thanks and kind Regards (and a happy new year),
Ulrich




