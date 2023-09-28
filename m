Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A729E732D0
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 14:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjI1OIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 10:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjI1OH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 10:07:59 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC78F
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 07:07:58 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C3971A4651;
        Thu, 28 Sep 2023 10:07:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=BKoA/MQfGM53wOQLx9hvnZbs7g0pI5HaZRZeU/
        fJWLQ=; b=pEeNCfPkhH1OIszmwfIxPPVKNIAEF6c9XN4Ib8Tf1wPlMnWEHb5t3z
        Mq7OlC1iMIvscB2DjSIO2TRTDBnpR3PC8V2wtoFfjs5dlIaeu5LUJ/s6icADMIMM
        a7b6b6cdWVHHRhyw7AxS5aDCG2wSr7XyA0gmUff/Lx4AKCpU8lJRk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 740AE1A4650;
        Thu, 28 Sep 2023 10:07:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8F751A464F;
        Thu, 28 Sep 2023 10:07:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Saurabh Sonar <saurabh.sonar120@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature Request - Unique commits list
In-Reply-To: <CAJ-L=uAjXB67Zx1BPpdJYF_y1RS+UqwpyTMF1F4o3yO+1o76vg@mail.gmail.com>
        (Saurabh Sonar's message of "Thu, 28 Sep 2023 13:46:37 +0530")
References: <CAJ-L=uAjXB67Zx1BPpdJYF_y1RS+UqwpyTMF1F4o3yO+1o76vg@mail.gmail.com>
Date:   Thu, 28 Sep 2023 07:07:55 -0700
Message-ID: <xmqqbkdml7b8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C7A3E5C-5E08-11EE-8707-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Saurabh Sonar <saurabh.sonar120@gmail.com> writes:

> After merging the master branch into my local it is hard to find my
> own commits in git history.

I suspect the above may be the other way around (i.e., after the
upstream takes some but not all of my changes into their 'master'
branch, I want to find out what remaining topics from me are still
not accepted by them), but anyway, doesn't something along the lines
of

	$ git log --branches --not origin/master

work for you?  It asks

 * Please list commits ("git log")

 * The commits to be listed should be discovered by traversing the
   history starting from my branch tips ("--branches")

 * But I am not interested in those commits that can be reached from
   the 'master' branch of my upstream ("--not origin/master").

