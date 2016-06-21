Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C40F2018B
	for <e@80x24.org>; Tue, 21 Jun 2016 18:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbcFUSEl (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 14:04:41 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40472 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752534AbcFUSEj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 14:04:39 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7F16020BC6
	for <git@vger.kernel.org>; Tue, 21 Jun 2016 14:04:38 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 21 Jun 2016 14:04:38 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=tSiwbC5iGW+rptA
	g3FiRdi1iHRQ=; b=XLWRnIfa0ThaT+C7I6px02eZZFTdcw/UicLx8ouiQDnE+rm
	rd2Y97gFhozVCanIP3pzqVkcAYqruD/wKjer16d/tIvSsPEORFpkwzRf5eP8vjl9
	u91wF2Mn3GTvz9NSAn0H8d/un7JLLyzNpUytAyPm5JtRLBXOzWt+5MjVVMak=
X-Sasl-enc: PNsyg3hjGqGJ8CRrMabiKKuY5FJ/fTViycJXzSzJM3cS 1466532277
Received: from ebox.rath.org (ebox.rath.org [45.79.69.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3FA92CCDA7
	for <git@vger.kernel.org>; Tue, 21 Jun 2016 14:04:37 -0400 (EDT)
Received: from thinkpad.rath.org (thinkpad [192.168.12.2])
	by ebox.rath.org (Postfix) with ESMTPS id D56073024B8
	for <git@vger.kernel.org>; Tue, 21 Jun 2016 18:04:34 +0000 (UTC)
Received: by thinkpad.rath.org (Postfix, from userid 1000)
	id 64870C0257; Tue, 21 Jun 2016 11:04:35 -0700 (PDT)
From:	Nikolaus Rath <Nikolaus@rath.org>
To:	git@vger.kernel.org
Subject: Re: How to find commits unique to a branch
References: <878txz8ubq.fsf@thinkpad.rath.org>
	<xmqqtwgnsdr3.fsf@gitster.mtv.corp.google.com>
	<87lh1z78fr.fsf@thinkpad.rath.org>
Mail-Copies-To:	never
Mail-Followup-To: git@vger.kernel.org
Date:	Tue, 21 Jun 2016 11:04:35 -0700
In-Reply-To: <87lh1z78fr.fsf@thinkpad.rath.org> (Nikolaus Rath's message of
	"Mon, 20 Jun 2016 16:21:44 -0700")
Message-ID: <87oa6ubeq4.fsf@thinkpad.rath.org>
User-Agent: Gnus/5.130014 (Ma Gnus v0.14) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Jun 20 2016, Nikolaus Rath <Nikolaus@rath.org> wrote:
> On Jun 20 2016, Junio C Hamano <gitster@pobox.com> wrote:
>> Nikolaus Rath <Nikolaus@rath.org> writes:
>>
>>> What's the best way to find all commits in a branch A that have not been
>>> cherry-picked from (or to) another branch B?
>>>
>>> I think I could format-patch all commits in every branch into separate
>>> files, hash the Author and Date of each files, and then compare the two
>>> lists. But I'm hoping there's a way to instead have git do the
>>> heavy-lifting?
>>
>> "git cherry" perhaps?
>
> That seems to work only the "wrong way around". I have a tag
> fuse_3_0_start, which is the common ancestor to "master" and
> "fuse_2_9_bugfix". I'd like to find all the commits from fuse_3_0_start
> to master that have not been cherry-picked into fuse_2_9_bugfix.
>
> However:
>
> * "git cherry fuse_3_0_start master release2.9" tells me nothing has
>   been cherry-picked at all (only lines with +)
>
> * "git cherry fuse_3_0_start release2.9 master" also tells me nothing
>   has been cherry picked, but somehow shows a smaller total number of
>   commits.
>
> * "git cherry master release2.9 fuse_3_0_start" gives me the commits
>   from fuse_2_9_bugfix that have not been cherry-picked into master
>   (which seems to be in contradiction to the two earlier commands).
>
>
> Am I missing something obvious?

I meant to add: the repository I'm working with is at
https://github.com/libfuse/libfuse/.

Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             »Time flies like an arrow, fruit flies like a Banana.«
