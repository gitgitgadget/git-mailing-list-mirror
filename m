Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145D220899
	for <e@80x24.org>; Mon, 14 Aug 2017 19:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdHNTVo (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 15:21:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56590 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750753AbdHNTVn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 15:21:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45F0AAD34B;
        Mon, 14 Aug 2017 15:21:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GRRXGmbTwHbKVF6Isb9zemGsPrc=; b=cEtsEL
        Rrj3fMXEG+ySkZyzoqlu47wwc/oQQsGB6KVPoSEkfsZv/6Y4OttDmFjaHUWC23Qu
        vFlekVJ7f6dFe2srqCyTohdQp0+WEcHUUcoqIAOB71Wk41mgnStG8LM/qQOQrAKs
        mVwXTaIdIROaXiX69MTNKjK8IcPn2KlYqv584=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sDdJGwtzcVi7P5mGoSsY2mQyAsg31Sk3
        Zk6X0P4+OMwxwzIdx6QYud+XlWuVB232lIJ9XoL60xvdzLqqGz5Zjd9JG2Sheshi
        CBTCFLHutD7JN6xC+2kfyXgIBOpy9OXB08YHrZmKC7gj27H9rT3PYYqWD8mAf2/O
        zcqwGr5gZz4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3922AAD34A;
        Mon, 14 Aug 2017 15:21:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 939D1AD348;
        Mon, 14 Aug 2017 15:21:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Harry Putnam <reader@newsguy.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Not understanding with git wants to copy one file to another
References: <87mv7773tp.fsf@local.lan>
        <CAGZ79kbgb2P7KT_b9xuMj1pN1+jsPfH7YSJNDyDB5dY3cwXCQg@mail.gmail.com>
        <87efsj70d7.fsf@local.lan>
        <CAGZ79kZN1-DuiaS=bFgNUXBonAR3BHqtAFSqoJ+MJ4esMdmz-g@mail.gmail.com>
        <87shgx3khv.fsf@local.lan>
        <CAGZ79kaCuaxgGwuw7AHKTjsmwsTBuv=gWzeGDJv3TJv+b25Uvw@mail.gmail.com>
Date:   Mon, 14 Aug 2017 12:21:33 -0700
In-Reply-To: <CAGZ79kaCuaxgGwuw7AHKTjsmwsTBuv=gWzeGDJv3TJv+b25Uvw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 14 Aug 2017 11:07:29 -0700")
Message-ID: <xmqqfucuuf9e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C920944C-8125-11E7-9427-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Aug 11, 2017 at 1:41 PM, Harry Putnam <reader@newsguy.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>
>> [...]
>>
>>> Ah. Sorry for confusing even more.
>>> By pointing out the options for git-diff, I just wanted to point out that
>>> such a mechanism ("rename/copy detection") exists.
>>
>>
>> [...]
>>
>>>> What am I missing?
>>>>
>>>
>>> https://www.reddit.com/r/git/comments/3ogkk1/beginner_disable_rename_detection/
>>>
>>> "Rename detection is just GUI sugar".
>>
>> Thanks there is a nice full explanation at the cited url.
>>
>> What is still a bit puzzling is that in that same commit, there are
>> files that are true copies of each other, just in different locations,
>> But nothing pops up about them in a git commit.
>>
>
> The heuristic to find the renames/copies only looks at modified files
> to be fast(, the assumption is that each commit only touches few
> files, but the project consists of a lot of files).
>
> For that git-diff knows about '--find-copies-harder' that looks at
> all files even those not modified. This would point out the true
> copies, I would assume.
>
> I don't think we'd want to include the '--find-copies-harder' flag
> to status or commit, as it may take some time in large projects.

Yeah, thanks for helping in this discussion.

