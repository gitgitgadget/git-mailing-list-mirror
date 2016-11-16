Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7963F2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932361AbcKPShP (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 13:37:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52930 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752805AbcKPShP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 13:37:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 798384E970;
        Wed, 16 Nov 2016 13:37:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ID9bHHVISbvOsU7AoCQ5S/efgSA=; b=aa7kAR
        MsRtZj7vk85Y9AJFwAtg8rPbdTDA6lHWWOBniY8Qg2FMCFlg96Xlmhk4FoglPV75
        iW2uWBm4SKtadItjRkGqu9/YbqVORtEoVd03XDYES6oMxa/hX9Bcl5g3IfN6f4/T
        D92yw9WWKDI22EIvRG2+1IDsPw/pwikZswXB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FTqkcsOexR2ZEhEawzNCosvd+xy8o7bH
        zaxhEnD/9741SR6EBZjL1AcpcyGkTd0tiOgRMiLYMch21dm3GZDQxLoJaY6GDyjZ
        NSQLwZ291JjcXr+cD6Kp0UWDA6pWE79s51mflvpqHWQOQg/KTNmC86s9W/zbhQ+w
        z9Aeb7seA7s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 716744E96F;
        Wed, 16 Nov 2016 13:37:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8F144E96E;
        Wed, 16 Nov 2016 13:37:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
        <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com>
        <alpine.DEB.2.20.1611121106110.3746@virtualbox>
        <0c39be16-76f8-0800-41a2-b7b1dccdd652@drmicha.warpmail.net>
        <xmqqoa1ix7nq.fsf@gitster.mtv.corp.google.com>
        <a3db4c55-550c-f2e8-83b8-46c2be86f7da@drmicha.warpmail.net>
        <xmqqtwb9wywp.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611161039590.3746@virtualbox>
        <xmqqh977qnvk.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 16 Nov 2016 10:37:11 -0800
In-Reply-To: <xmqqh977qnvk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 16 Nov 2016 10:29:51 -0800")
Message-ID: <xmqqd1hvqnjc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0BFD9FA-AC2B-11E6-91DF-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Mon, 14 Nov 2016, Junio C Hamano wrote:
>>
>>> I _think_ the no-index mode was primarily for those who want to use
>>> our diff as a replacement for GNU and other diffs, and from that
>>> point of view, I'd favour not doing the "comparing symbolic link?
>>> We'll show the difference between the link contents, not target"
>>> under no-index mode myself.
>>
>> If I read this correctly,...
>
> Now I re-read it and I can see it can be read either way.
>
> By "link contents" in "comparing symbolic link? We'll show the
> difference between the link contents, not target", I meant the
> result you get from readlink(2), which will result in
>
>     diff --git a/RelNotes b/RelNotes
>     index c02235fe8c..b54330f7cd 120000
>     --- a/RelNotes
>     +++ b/RelNotes
>     @@ -1 +1 @@
>     -Documentation/RelNotes/2.10.2.txt
>     \ No newline at end of file
>     +Documentation/RelNotes/2.11.0.txt
>     \ No newline at end of file
>
> not the comparison between the files that are link targets,
> i.e. hypothetical
>
>     diff --git a/RelNotes b/RelNotes
>     index c4d4397023..7a1fce7720 100644
>     --- a/Documentation/RelNotes/2.10.2.txt
>     +++ b/Documentation/RelNotes/2.11.0.txt
>     @@ -1,41 +1,402 @@
>     -Git v2.10.2 Release Notes
>     -=========================
>     +Git 2.11 Release Notes
>     ...
>
> And I'd favour *NOT* doing that if we are using our diff as a

Again, this can be read both ways.  By "that" on the above line I
meant "the former".

> replacement for GNU and other diffs in "no-index" mode.  Which leads
> to ...
>
>>> That is a lot closer to the diff other people implemented, not ours.
>>> Hence the knee-jerk reaction I gave in
>>> 
>>> http://public-inbox.org/git/xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com
>
> ... this conclusion, which is consistent with ...
>
>>
>> Let me quote the knee-jerk reaction:
>>
>>> My knee-jerk reaction is:
>>>
>>>  * The --no-index mode should default to your --follow-symlinks
>>>    behaviour, without any option to turn it on or off.
>
> ... this one.
>
> But notice "I _think_" in the first sentence you quoted.  That is a
> basic assumption that leads to the conclusion, and that assumption
> is not a fact.  Maybe users do *not* want the "no-index" mode as a
> replacement for GNU and other diffs, in which case comparing the
> result of readlink(2) even in no-index mode might have merit.  I
> just didn't think it was the case.

And "I just didn't think it was the case", when fully spelt out, is
"I just didn't think that the assumption was incorrect."
