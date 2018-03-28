Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC731F404
	for <e@80x24.org>; Wed, 28 Mar 2018 04:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750703AbeC1EdD (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 00:33:03 -0400
Received: from mail.javad.com ([54.86.164.124]:35397 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeC1EdC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 00:33:02 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 14DC73E863;
        Wed, 28 Mar 2018 04:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522211581;
        bh=phd9sor8mAcUgIuaDXVnMspUAqmG47bFm4xW0ChFtss=; l=3423;
        h=Received:From:To:Subject;
        b=eHhAMu/5YtZKuiOm75VNx7neRXAmxE8xnPpRsZdlZ0kABiGLmSSpSPns6ccGwSI13
         ihW6Xm66CsmMhvtiTeQ7XlG10wpU1G8rwDXavGtFW7MoEOxO58RPRfn+iqh6dicKit
         CNbL8YkddWnUBNvUv0cRNlh7BCk5HC9PPq5QyN5U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522211581;
        bh=phd9sor8mAcUgIuaDXVnMspUAqmG47bFm4xW0ChFtss=; l=3423;
        h=Received:From:To:Subject;
        b=eHhAMu/5YtZKuiOm75VNx7neRXAmxE8xnPpRsZdlZ0kABiGLmSSpSPns6ccGwSI13
         ihW6Xm66CsmMhvtiTeQ7XlG10wpU1G8rwDXavGtFW7MoEOxO58RPRfn+iqh6dicKit
         CNbL8YkddWnUBNvUv0cRNlh7BCk5HC9PPq5QyN5U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522211581;
        bh=phd9sor8mAcUgIuaDXVnMspUAqmG47bFm4xW0ChFtss=; l=3423;
        h=Received:From:To:Subject;
        b=eHhAMu/5YtZKuiOm75VNx7neRXAmxE8xnPpRsZdlZ0kABiGLmSSpSPns6ccGwSI13
         ihW6Xm66CsmMhvtiTeQ7XlG10wpU1G8rwDXavGtFW7MoEOxO58RPRfn+iqh6dicKit
         CNbL8YkddWnUBNvUv0cRNlh7BCk5HC9PPq5QyN5U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522211581;
        bh=phd9sor8mAcUgIuaDXVnMspUAqmG47bFm4xW0ChFtss=; l=3423;
        h=Received:From:To:Subject;
        b=eHhAMu/5YtZKuiOm75VNx7neRXAmxE8xnPpRsZdlZ0kABiGLmSSpSPns6ccGwSI13
         ihW6Xm66CsmMhvtiTeQ7XlG10wpU1G8rwDXavGtFW7MoEOxO58RPRfn+iqh6dicKit
         CNbL8YkddWnUBNvUv0cRNlh7BCk5HC9PPq5QyN5U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522211581;
        bh=phd9sor8mAcUgIuaDXVnMspUAqmG47bFm4xW0ChFtss=; l=3423;
        h=Received:From:To:Subject;
        b=eHhAMu/5YtZKuiOm75VNx7neRXAmxE8xnPpRsZdlZ0kABiGLmSSpSPns6ccGwSI13
         ihW6Xm66CsmMhvtiTeQ7XlG10wpU1G8rwDXavGtFW7MoEOxO58RPRfn+iqh6dicKit
         CNbL8YkddWnUBNvUv0cRNlh7BCk5HC9PPq5QyN5U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522211581;
        bh=phd9sor8mAcUgIuaDXVnMspUAqmG47bFm4xW0ChFtss=; l=3423;
        h=Received:From:To:Subject;
        b=eHhAMu/5YtZKuiOm75VNx7neRXAmxE8xnPpRsZdlZ0kABiGLmSSpSPns6ccGwSI13
         ihW6Xm66CsmMhvtiTeQ7XlG10wpU1G8rwDXavGtFW7MoEOxO58RPRfn+iqh6dicKit
         CNbL8YkddWnUBNvUv0cRNlh7BCk5HC9PPq5QyN5U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522211581;
        bh=phd9sor8mAcUgIuaDXVnMspUAqmG47bFm4xW0ChFtss=; l=3423;
        h=Received:From:To:Subject;
        b=eHhAMu/5YtZKuiOm75VNx7neRXAmxE8xnPpRsZdlZ0kABiGLmSSpSPns6ccGwSI13
         ihW6Xm66CsmMhvtiTeQ7XlG10wpU1G8rwDXavGtFW7MoEOxO58RPRfn+iqh6dicKit
         CNbL8YkddWnUBNvUv0cRNlh7BCk5HC9PPq5QyN5U=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f12le-0002ND-HG; Wed, 28 Mar 2018 07:32:58 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
        <872944c4-ca97-9f55-a424-86d1e3299a22@gmail.com>
        <1c912980-8ce8-6281-fa99-040a5e3e1103@talktalk.net>
        <nycvar.QRO.7.76.6.1803061829460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87h8pscw0r.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803070756550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87ina8ymxs.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803080741160.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87vae1h3uo.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803261333500.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87in9igl0s.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803271454010.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 28 Mar 2018 07:32:58 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803271454010.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 27 Mar 2018 14:55:43 +0200
        (DST)")
Message-ID: <87po3oddl1.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi Sergey,
>
> On Tue, 27 Mar 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On Mon, 12 Mar 2018, Sergey Organov wrote:
>> >
>> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >> >
>> >> > On Wed, 7 Mar 2018, Sergey Organov wrote:
>> >> >
>> >> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >> >> 
>> >> >> > How can your approach -- which relies *very much* on having the
>> >> >> > original parent commits -- not *require* that consistency check?
>> >> >> 
>> >> >> I don't understand what you mean, sorry. Could you please point me
>> >> >> to the *require* you talk about in the original proposal?
>> >> >
>> >> > Imagine a todo list that contains this line
>> >> >
>> >> > 	merge -C abcdef 123456
>> >> >
>> >> > and now the user edits it (this is an interactive rebase, after
>> >> > all), adding another merge head:
>> >> >
>> >> > 	merge -C abcdef 987654 123456
>> >> >
>> >> > Now your strategy would have a serious problem: to find the
>> >> > original version of 987654. If there was one.
>> >> 
>> >> We are talking about different checks then. My method has a built-in
>> >> check that Pillip's one doesn't.
>> >
>> > Since you did not bother to elaborate, I have to assume that your
>> > "built-in check" is that thing where intermediate merges can give you
>> > conflicts?
>> >
>> > If so, there is a possibility in Phillip's method for such conflicts,
>> > too: we have to perform as many 3-way merges as there are parent
>> > commits.
>> >
>> > It does make me uncomfortable to have to speculate what you meant,
>> > though.
>> 
>> It doesn't matter anymore as this check could easily be added to
>> Phillip's algorithm as well, see [1].
>> 
>> [1] https://public-inbox.org/git/87efkn6s1h.fsf@javad.com
>
> Ah, and there I was, thinking that finally you would answer my questions
> directly, instead you keep directing me elsewhere ("read that! Somewhere
> in there you will find the answer you are looking for").

Except I've copy-pasted it for /you/ from that reference in another
answer to /you/, and /you/ denied it there as being unexplained. As it
actually happens to be discussed and explained in the referenced
material, should I rather copy-paste the entire reference to fulfill
your requirements?

Here I repeat, directly again, that essential quote from that reference,
in case you forgot it:

<QUOTE>
git-rebase-first-parent --onto A' M
tree_U1'=$(git write-tree)
git merge-recursive B -- $tree_U1' B'
tree=$(git write-tree)
M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')
[ $conflicted_last_merge = "yes" ] ||
  trees-match $tree_U1' $tree || 
  stop-for-user-amendment
  
where 'git-rebase-first-parent' denotes whatever machinery is currently
being used to rebase simple non-merge commit.
</QUOTE>

> My time is a bit too valuable, and I will not continue a discussion where
> my questions are constantly deflected that way.

No deflection on my side was ever intended. The referenced discussion
actually has explanations. Maybe one whole page of reading, and it is to
be read in context, and then a few follow-ups in that discussion could
also be of interest, provided you are interested. I'm sorry should you
have no time for that.

-- Sergey
