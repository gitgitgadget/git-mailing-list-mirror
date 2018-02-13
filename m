Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF201F576
	for <e@80x24.org>; Tue, 13 Feb 2018 07:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933480AbeBMHQD (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 02:16:03 -0500
Received: from mail.javad.com ([54.86.164.124]:35881 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933366AbeBMHQC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 02:16:02 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 3E4593E8B8;
        Tue, 13 Feb 2018 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518506161;
        bh=Y1YZSE+LWcfbP4B18ABWrJboqoCStOM1dpVSj/0K4fU=; l=3008;
        h=Received:From:To:Subject;
        b=ke3Z2mFWKaHinNdOqL09w+/cCa5MGJ8jke7fnh22g/UmqI6ymixRe7sp2PVSYE9C/
         GIZfgmNQWMblf6JMfVRMa2u5UgdPQdEp8pWlv6kTbwrr1XfdcA1a6K1suBfV/ROvSI
         rIFgXSpSfhgXI6z6ayhBy+NcEsNuZ0InQkvG3Nu0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518506161;
        bh=Y1YZSE+LWcfbP4B18ABWrJboqoCStOM1dpVSj/0K4fU=; l=3008;
        h=Received:From:To:Subject;
        b=ke3Z2mFWKaHinNdOqL09w+/cCa5MGJ8jke7fnh22g/UmqI6ymixRe7sp2PVSYE9C/
         GIZfgmNQWMblf6JMfVRMa2u5UgdPQdEp8pWlv6kTbwrr1XfdcA1a6K1suBfV/ROvSI
         rIFgXSpSfhgXI6z6ayhBy+NcEsNuZ0InQkvG3Nu0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518506161;
        bh=Y1YZSE+LWcfbP4B18ABWrJboqoCStOM1dpVSj/0K4fU=; l=3008;
        h=Received:From:To:Subject;
        b=ke3Z2mFWKaHinNdOqL09w+/cCa5MGJ8jke7fnh22g/UmqI6ymixRe7sp2PVSYE9C/
         GIZfgmNQWMblf6JMfVRMa2u5UgdPQdEp8pWlv6kTbwrr1XfdcA1a6K1suBfV/ROvSI
         rIFgXSpSfhgXI6z6ayhBy+NcEsNuZ0InQkvG3Nu0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518506161;
        bh=Y1YZSE+LWcfbP4B18ABWrJboqoCStOM1dpVSj/0K4fU=; l=3008;
        h=Received:From:To:Subject;
        b=ke3Z2mFWKaHinNdOqL09w+/cCa5MGJ8jke7fnh22g/UmqI6ymixRe7sp2PVSYE9C/
         GIZfgmNQWMblf6JMfVRMa2u5UgdPQdEp8pWlv6kTbwrr1XfdcA1a6K1suBfV/ROvSI
         rIFgXSpSfhgXI6z6ayhBy+NcEsNuZ0InQkvG3Nu0=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1elUop-0001zO-0Y; Tue, 13 Feb 2018 10:15:59 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <874lmqirma.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87zi4edbp3.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xqKPbwt-KeYTKadM3bHDkU3m0WiezKeVu75TyftBSEYDA@mail.gmail.com>
Date:   Tue, 13 Feb 2018 10:15:59 +0300
In-Reply-To: <CA+P7+xqKPbwt-KeYTKadM3bHDkU3m0WiezKeVu75TyftBSEYDA@mail.gmail.com>
        (Jacob Keller's message of "Mon, 12 Feb 2018 20:39:00 -0800")
Message-ID: <8760718imo.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

Jacob Keller <jacob.keller@gmail.com> writes:

> On Mon, Feb 12, 2018 at 12:39 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Sergey,
>>
>> On Mon, 12 Feb 2018, Sergey Organov wrote:
>>> > Have a look at https://github.com/git/git/pull/447, especially the
>>> > latest commit in there which is an early version of the deprecation I
>>> > intend to bring about.
>>>
>>> You shouldn't want a deprecation at all should you have re-used
>>> --preserve-merges in the first place, and I still don't see why you
>>> haven't.
>>
>> Keep repeating it, and it won't become truer.
>>
>> If you break formats, you break scripts. Git has *so* many users, there
>> are very likely some who script *every* part of it.
>>
>> We simply cannot do that.
>>
>> What we can is deprecate designs which we learned on the way were not only
>> incomplete from the get-go, but bad overall and hard (or impossible) to
>> fix. Like --preserve-merges.
>>
>> Or for that matter like the design you proposed, to use --first-parent for
>> --recreate-merges. Or to use --first-parent for some --recreate-merges,
>> surprising users in very bad ways when it is not used (or when it is
>> used). I get the impression that you still think it would be a good idea,
>> even if it should be obvious that it is not.
>
> If we consider the addition of new todo list elements as "user
> breaking", then yes this change would be user-script breaking.

It _is_ user script breaking, provided such script exists. Has anybody
actually seen one? Not that it's wrong to be extra-cautious about it,
just curios. Note that to be actually affected, such a script must
invoke "git rebase -p" _command_ and then tweak its todo output to
produce outcome.

> Since we did not originally spell out that todo-list items are subject
> to enhancement by addition of operations in the future, scripts are
> likely not designed to allow addition of new elements.

Out of curiosity, are you going to spell it now, for the new todo
format?

> Thus, adding recreate-merges, and deprecating preserve-merges, seems
> to me to be the correct action to take here.

Yes, sure, provided there is actual breakage, or at least informed
suspicion there is one.

> One could argue that users should have expected new todo list elements
> to be added in the future and thus design their scripts to cope with
> such a thing. If you can convincingly argue this, then I don't
> necessarily see it as a complete user breaking change to fix
> preserve-merges in order to allow it to handle re-ordering properly..

I'd not argue this way myself. If there are out-of-git-tree non-human
users that accept and tweak todo _generated_ by current "git rebase -p"
_command_, I also vote for a new option.

> I think I lean towards agreeing with Johannes, and that adding
> recreate-merges and removing preserve-merges is the better solution.

On these grounds it is, no objections.

-- Sergey
