From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working directory
Date: Mon, 8 Sep 2014 17:52:47 +0700
Message-ID: <CACsJy8DxUguPohjYGTgnHjBc=0mqn20c67pTBN34VRz7oCjyGA@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1409387642-24492-23-git-send-email-pclouds@gmail.com> <70985AC885404243A2B95F534083A0E9@PhilipOakley>
 <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com>
 <CACsJy8ASW0xO3WzU7f+T4iDhjL=Y=C6K+Cvi-OWOnS16r=m+9Q@mail.gmail.com>
 <64D6AA311E524C27A8B6EDE7A63489D7@PhilipOakley> <CACsJy8CTLRpjmh+0K6ypLKUgi52gsFEqnNsha2yfOvRVCdhdMQ@mail.gmail.com>
 <5405D983.3050707@xiplink.com> <xmqqfvga2ai9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 12:53:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQwZW-0006vB-Rm
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 12:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbaIHKxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 06:53:19 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:40547 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbaIHKxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 06:53:18 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn18so2481817igb.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 03:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tc6m6S73zA2Tu2E7vuqbxyD+JiZDITQWfQiVry2VkjY=;
        b=t8teKtzKVFKFJph26dH7eH8J5kg5VSlElgtsjAbQx00ZWbHZes8P1NnAAOeVJmgpyU
         Oj7ptZcFDY/n6tUmdiKvyUGwfPty9XaIWR4R/4zaZ0Gcqq4yzWhx9ICFErU+BPQpwKHS
         VzWSx7IKEMhq23KFjyEOsTSFVO7nCDEEVNxV08v4rZMHi09yoYvCKF1J7HNy30h/6cLE
         Q4CLx+kkhg151/Hs3fU95h8fD5IFF0pjamk0JwFeF1veD7Sn9NqhmXxIMgom0Mt6LGsL
         GidCd88mWm/EtUI81/r2Pa8FF3GARAhTxD+zWSTmZo4ji8LLfPKqorMhsbOmoRJiaggM
         WbxA==
X-Received: by 10.50.103.106 with SMTP id fv10mr23041959igb.40.1410173597584;
 Mon, 08 Sep 2014 03:53:17 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Mon, 8 Sep 2014 03:52:47 -0700 (PDT)
In-Reply-To: <xmqqfvga2ai9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256638>

On Wed, Sep 3, 2014 at 12:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> On 14-09-02 08:27 AM, Duy Nguyen wrote:
>>> After reading this "multiple checkout mode" in git-checkout.txt, I'm
>>> tempted to rewrite it like this. I think the example makes it clearer
>>> what I mean. If nobody has any comments, I'm going to send v2 with
>>> this (and other comments collected so far)
>>
>> Overall I think focusing on the word "checkout" for this feature makes the
>> documentation confusing.  It's also not a "mode" but just another git
>> feature.  Since this is all about multiple working directories (the phrase is
>> actually "working tree" in the existing docs) we should just stick to that
>> rather than introduce new terminology.
>>
>> Finally, a bit of bikeshedding, but I think "$GIT_DIR/repos" is also an
>> unfortunate choice and that "$GIT_DIR/worktrees" would be better.
>
> I tried to stay away from bikeshedding, but a good phrasing is
> important.  I think $GIT_DIR/worktrees captures what they are trying
> to represent better in that they are not storing repository
> information, but they are about storing per-worktree state.

While we're changing the terms, I wonder if "primary working
directory" and "secondary working directories" are better than "main
checkout" and "linked checkout".
-- 
Duy
