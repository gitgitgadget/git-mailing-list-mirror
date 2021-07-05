Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A209AC07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C40161396
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhGEHpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhGEHpc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 03:45:32 -0400
Received: from mx1.uni-regensburg.de (mx1.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:3:bdf7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B53C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 00:42:55 -0700 (PDT)
Received: from mx1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 3363B600004F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 09:42:53 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx1.uni-regensburg.de (Postfix) with ESMTP id 16FC2600004D
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 09:42:53 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 05 Jul 2021 09:42:53 +0200
Message-Id: <60E2B7FB020000A1000422A0@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Mon, 05 Jul 2021 09:42:51 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <l.s.r@web.de>
Cc:     <git@vger.kernel.org>
Subject: Antw: [EXT] Re: bug in "git fsck"?
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
 <xmqqczs0popg.fsf@gitster.g> <52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de>
In-Reply-To: <52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> René Scharfe <l.s.r@web.de> schrieb am 03.07.2021 um 22:03 in Nachricht
<52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de>:
> Am 02.07.21 um 20:15 schrieb Junio C Hamano:
>> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
>>
>>> I was wondering whether git fsck should be able to cleanup
>>> orphaned branches ("HEAD points to an unborn branch") as described
>>> in https://stackoverflow.com/q/68226081/6607497 It seems I can fix
>>> it be editing files in the repository, but I feed that's not the
>>> way it should be.
>>
>> HEAD pointing at an unborn branch is not even a corruption, isn't
>> it?
>>
>>    $ rm -rf trash && git init trash
>>
>> would point HEAD at an unborn one, ready to be used.
> 
> True, but the scenario described on StackOverflow is a bit different.
> Commits were filtered out, and branches still pointing to them cannot
> be deleted with "git branch -d" or "git branch -D".  Git fsck only
> reports them.
> 
> You *can* overwrite them using "git branch --force foo" and then
> "git branch -d foo" works.

Would it be OK to force the branch to any commit (e.g.: "master"), relying on
the fact that any reference (read: "master") to that commit will prevent actual
removal of the commit?

