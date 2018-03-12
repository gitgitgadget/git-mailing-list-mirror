Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8D81F404
	for <e@80x24.org>; Mon, 12 Mar 2018 12:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeCLMcD (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 08:32:03 -0400
Received: from mail.javad.com ([54.86.164.124]:49874 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeCLMcC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 08:32:02 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 82E8F3E896;
        Mon, 12 Mar 2018 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520857921;
        bh=8Slemw4EB3INR/6PBvwtkoz+jg14+x5qYDnxz0ibPDQ=; l=2696;
        h=Received:From:To:Subject;
        b=CxZ2bOYl8ojv5PHgfxKV+a3FgMJ+cG2YJa3kp4tlV1ZyhiWXETBRfzUDmvGDAluLu
         okew2jj4evr7WlgsHDNLaOMENdr+Vbg7gHuFV+on4PG9dqdCcajlKGswEyfMnouViW
         IOKpfKF927XLbnDCbyUQDoLLF9YxnWFIbgEkW6rQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520857921;
        bh=8Slemw4EB3INR/6PBvwtkoz+jg14+x5qYDnxz0ibPDQ=; l=2696;
        h=Received:From:To:Subject;
        b=CxZ2bOYl8ojv5PHgfxKV+a3FgMJ+cG2YJa3kp4tlV1ZyhiWXETBRfzUDmvGDAluLu
         okew2jj4evr7WlgsHDNLaOMENdr+Vbg7gHuFV+on4PG9dqdCcajlKGswEyfMnouViW
         IOKpfKF927XLbnDCbyUQDoLLF9YxnWFIbgEkW6rQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520857921;
        bh=8Slemw4EB3INR/6PBvwtkoz+jg14+x5qYDnxz0ibPDQ=; l=2696;
        h=Received:From:To:Subject;
        b=CxZ2bOYl8ojv5PHgfxKV+a3FgMJ+cG2YJa3kp4tlV1ZyhiWXETBRfzUDmvGDAluLu
         okew2jj4evr7WlgsHDNLaOMENdr+Vbg7gHuFV+on4PG9dqdCcajlKGswEyfMnouViW
         IOKpfKF927XLbnDCbyUQDoLLF9YxnWFIbgEkW6rQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520857921;
        bh=8Slemw4EB3INR/6PBvwtkoz+jg14+x5qYDnxz0ibPDQ=; l=2696;
        h=Received:From:To:Subject;
        b=CxZ2bOYl8ojv5PHgfxKV+a3FgMJ+cG2YJa3kp4tlV1ZyhiWXETBRfzUDmvGDAluLu
         okew2jj4evr7WlgsHDNLaOMENdr+Vbg7gHuFV+on4PG9dqdCcajlKGswEyfMnouViW
         IOKpfKF927XLbnDCbyUQDoLLF9YxnWFIbgEkW6rQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520857921;
        bh=8Slemw4EB3INR/6PBvwtkoz+jg14+x5qYDnxz0ibPDQ=; l=2696;
        h=Received:From:To:Subject;
        b=CxZ2bOYl8ojv5PHgfxKV+a3FgMJ+cG2YJa3kp4tlV1ZyhiWXETBRfzUDmvGDAluLu
         okew2jj4evr7WlgsHDNLaOMENdr+Vbg7gHuFV+on4PG9dqdCcajlKGswEyfMnouViW
         IOKpfKF927XLbnDCbyUQDoLLF9YxnWFIbgEkW6rQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520857921;
        bh=8Slemw4EB3INR/6PBvwtkoz+jg14+x5qYDnxz0ibPDQ=; l=2696;
        h=Received:From:To:Subject;
        b=CxZ2bOYl8ojv5PHgfxKV+a3FgMJ+cG2YJa3kp4tlV1ZyhiWXETBRfzUDmvGDAluLu
         okew2jj4evr7WlgsHDNLaOMENdr+Vbg7gHuFV+on4PG9dqdCcajlKGswEyfMnouViW
         IOKpfKF927XLbnDCbyUQDoLLF9YxnWFIbgEkW6rQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520857921;
        bh=8Slemw4EB3INR/6PBvwtkoz+jg14+x5qYDnxz0ibPDQ=; l=2696;
        h=Received:From:To:Subject;
        b=CxZ2bOYl8ojv5PHgfxKV+a3FgMJ+cG2YJa3kp4tlV1ZyhiWXETBRfzUDmvGDAluLu
         okew2jj4evr7WlgsHDNLaOMENdr+Vbg7gHuFV+on4PG9dqdCcajlKGswEyfMnouViW
         IOKpfKF927XLbnDCbyUQDoLLF9YxnWFIbgEkW6rQ=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1evMcR-0001J9-OI; Mon, 12 Mar 2018 15:31:59 +0300
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
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
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
Date:   Mon, 12 Mar 2018 15:31:59 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803080741160.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Thu, 8 Mar 2018 07:45:51 +0100
        (STD)")
Message-ID: <87vae1h3uo.fsf@javad.com>
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
> On Wed, 7 Mar 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > How can your approach -- which relies *very much* on having the
>> > original parent commits -- not *require* that consistency check?
>> 
>> I don't understand what you mean, sorry. Could you please point me to
>> the *require* you talk about in the original proposal?
>
> Imagine a todo list that contains this line
>
> 	merge -C abcdef 123456
>
> and now the user edits it (this is an interactive rebase, after all),
> adding another merge head:
>
> 	merge -C abcdef 987654 123456
>
> Now your strategy would have a serious problem: to find the original
> version of 987654. If there was one.

We are talking about different checks then. My method has a built-in
check that Pillip's one doesn't. All the external checks, if any, will
have to be the same.

>
>> > What would your approach (that still has no satisfyingly trivial
>> > explanation, in my mind)
>> 
>> Here is one-liner: rebase sides of the merge commit and then 3-way
>> merge them, using original merge commit as merge base.
>
> But I already pointed out how that would undo a commit having been
> dropped.

No. Not for this version. You did it for originally flawed version of
the method, that has been already fixed by addition of "using original
merge commit as merge base" in the above sentence, and that was the
exact reason for [RFC v2], that in turn is explicitly stated at the
beginning of [RFC v2].

>
>> > do if somebody edited a `merge` command and let it merge a completely
>> > unrelated commit?
>> 
>> Don't see a problem, sorry. The method should still work, provided you have
>> original merge commit and two new parents for the new merge.
>
> That is assuming a lot. That is exactly what this consistency check is
> for, that I mentioned earlier, and which you listed as a downside of
> Phillip's strategy (forgetting that your strategy has the same downside,
> so...).

Again, we are talking about different checks. My method has a built-in
check that Pillip's doesn't. All the external checks, if any, will have
to be the same.

> But I guess that you are still talking about the non-interactive version
> of the rebase, and missed that our conversation proceeded to the point
> where we want that same strategy to work *also* in the interactive version
> (and not have a completely different functionality depending whether you
> use --interactive or not)?

For me, non-interactive is an interactive one with unmodified todo list.

-- Sergey
