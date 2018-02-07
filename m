Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E161F576
	for <e@80x24.org>; Wed,  7 Feb 2018 09:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeBGJr1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 04:47:27 -0500
Received: from mail.javad.com ([54.86.164.124]:60976 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753409AbeBGJrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 04:47:25 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id B08B13E935;
        Wed,  7 Feb 2018 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517996845;
        bh=SJAJELhKx/hv8Hetbi9QvpHc5Ok0+Q2BYAJTfxoq67M=; l=1866;
        h=Received:From:To:Subject;
        b=XuA8VU9B4ZzQyXS8bTQSoyljUHuJDQ1GHK50I/xi0aE3/bzB80qgj5YemOpSOUdpR
         bLVuZoPWEf/O8dYxzWMb7aWpxN5wJDrpnvcXrytkXLcvDDwFA8yIrEh0TkypHdYy3V
         OOWgT64U/YIQHzkdMFSOQ4s5m8emeQaaeiN1sMdI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517996845;
        bh=SJAJELhKx/hv8Hetbi9QvpHc5Ok0+Q2BYAJTfxoq67M=; l=1866;
        h=Received:From:To:Subject;
        b=XuA8VU9B4ZzQyXS8bTQSoyljUHuJDQ1GHK50I/xi0aE3/bzB80qgj5YemOpSOUdpR
         bLVuZoPWEf/O8dYxzWMb7aWpxN5wJDrpnvcXrytkXLcvDDwFA8yIrEh0TkypHdYy3V
         OOWgT64U/YIQHzkdMFSOQ4s5m8emeQaaeiN1sMdI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517996845;
        bh=SJAJELhKx/hv8Hetbi9QvpHc5Ok0+Q2BYAJTfxoq67M=; l=1866;
        h=Received:From:To:Subject;
        b=XuA8VU9B4ZzQyXS8bTQSoyljUHuJDQ1GHK50I/xi0aE3/bzB80qgj5YemOpSOUdpR
         bLVuZoPWEf/O8dYxzWMb7aWpxN5wJDrpnvcXrytkXLcvDDwFA8yIrEh0TkypHdYy3V
         OOWgT64U/YIQHzkdMFSOQ4s5m8emeQaaeiN1sMdI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517996845;
        bh=SJAJELhKx/hv8Hetbi9QvpHc5Ok0+Q2BYAJTfxoq67M=; l=1866;
        h=Received:From:To:Subject;
        b=XuA8VU9B4ZzQyXS8bTQSoyljUHuJDQ1GHK50I/xi0aE3/bzB80qgj5YemOpSOUdpR
         bLVuZoPWEf/O8dYxzWMb7aWpxN5wJDrpnvcXrytkXLcvDDwFA8yIrEh0TkypHdYy3V
         OOWgT64U/YIQHzkdMFSOQ4s5m8emeQaaeiN1sMdI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517996845;
        bh=SJAJELhKx/hv8Hetbi9QvpHc5Ok0+Q2BYAJTfxoq67M=; l=1866;
        h=Received:From:To:Subject;
        b=XuA8VU9B4ZzQyXS8bTQSoyljUHuJDQ1GHK50I/xi0aE3/bzB80qgj5YemOpSOUdpR
         bLVuZoPWEf/O8dYxzWMb7aWpxN5wJDrpnvcXrytkXLcvDDwFA8yIrEh0TkypHdYy3V
         OOWgT64U/YIQHzkdMFSOQ4s5m8emeQaaeiN1sMdI=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ejMK2-0001Ox-Tc; Wed, 07 Feb 2018 12:47:22 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <87k1vpqq85.fsf@javad.com>
        <CA+P7+xqs=cEC+9LJ9VB4XZU-oS7CX6eQSNSGfPeg-whRCwU1Lg@mail.gmail.com>
Date:   Wed, 07 Feb 2018 12:47:22 +0300
In-Reply-To: <CA+P7+xqs=cEC+9LJ9VB4XZU-oS7CX6eQSNSGfPeg-whRCwU1Lg@mail.gmail.com>
        (Jacob Keller's message of "Tue, 6 Feb 2018 23:26:11 -0800")
Message-ID: <876079qggl.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Feb 6, 2018 at 10:16 PM, Sergey Organov <sorganov@gmail.com> wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>> [...]
>>
>>> +--recreate-merges::
>>> +     Recreate merge commits instead of flattening the history by replaying
>>> +     merges. Merge conflict resolutions or manual amendments to merge
>>> +     commits are not preserved.
>>
>> I wonder why you guys still hold on replaying "merge-the-operation"
>> instead of replaying "merge-the-result"? The latter, the merge commit
>> itself, no matter how exactly it was created in the first place, is the
>> most valuable thing git keeps about the merge, and you silently drop it
>> entirely! OTOH, git keeps almost no information about
>> "merge-the-operation", so it's virtually impossible to reliably replay
>> the operation automatically, and yet you try to.
>>
>
> I'm not sure I follow what you mean here?
>
> You mean that you'd want this to actually attempt to re-create the
> original merge including conflict resolutions by taking the contents
> of the result?

I mean just cherry-pick the merge the same way all other commits are
essentially cherry-picked during rebase. That's what Johannes Sixt did
in his patch I was reffering to.

> How do you handle if that result has conflicts? What UX do you present
> to the user to handle such conflicts? I don't think the normal 3-way
> conflicts would even be possible in this case?

No problem here. It goes exactly the same way as for non-merge commits
that are being rebased. You can try it right now using

$ git cherry-pick -m1 <merge_commit>

that will induce conflicts.

The (somewhat tricky) functional difference is only in recording correct
additional parents to the final commit, but that part is hidden from the
user.

-- Sergey
