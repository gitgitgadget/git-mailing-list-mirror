Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469911F404
	for <e@80x24.org>; Wed, 11 Apr 2018 04:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbeDKEye (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 00:54:34 -0400
Received: from mail.javad.com ([54.86.164.124]:36131 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbeDKEyc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 00:54:32 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A56A93FEBC;
        Wed, 11 Apr 2018 04:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523422472;
        bh=GYvJrw7JX5woQhmdYlCa2Svm4qg4mmi8pCG4zBqxTDs=; l=1699;
        h=Received:From:To:Subject;
        b=EFxMw6OjxJ1UBzwc/jcfJZC6ZOc81BQyZFEdbNL5CYfopC7wrqvBPIJNV4QflMwao
         ptUwo2h+8tN6dimMIGRFfZ5jq/8UFC2M6UwZcESZ/sTWChedt8ZfvOWPba4/4a0Tvt
         b2YyYyk0ve6TbqyIvYgFHV3m6AGKR3FMLMFfguPw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523422472;
        bh=GYvJrw7JX5woQhmdYlCa2Svm4qg4mmi8pCG4zBqxTDs=; l=1699;
        h=Received:From:To:Subject;
        b=EFxMw6OjxJ1UBzwc/jcfJZC6ZOc81BQyZFEdbNL5CYfopC7wrqvBPIJNV4QflMwao
         ptUwo2h+8tN6dimMIGRFfZ5jq/8UFC2M6UwZcESZ/sTWChedt8ZfvOWPba4/4a0Tvt
         b2YyYyk0ve6TbqyIvYgFHV3m6AGKR3FMLMFfguPw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523422471;
        bh=GYvJrw7JX5woQhmdYlCa2Svm4qg4mmi8pCG4zBqxTDs=; l=1699;
        h=Received:From:To:Subject;
        b=qTIyAjHlgE2nvXtVv9GsTKUmtV/FvDUGiB7T+WVTVVVpwQB0llQlrJh7bHadzX7n+
         q/l+F4f+PfNccJMyIjfAxijET8i9rRvARTpH4hXW+5/x1D5nj1/ow13ZwSnVFo7Uz4
         D1obO4tECwyn5WrBfSdWTz6+NoXH/nlaNsSd9v6I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523422471;
        bh=GYvJrw7JX5woQhmdYlCa2Svm4qg4mmi8pCG4zBqxTDs=; l=1699;
        h=Received:From:To:Subject;
        b=qTIyAjHlgE2nvXtVv9GsTKUmtV/FvDUGiB7T+WVTVVVpwQB0llQlrJh7bHadzX7n+
         q/l+F4f+PfNccJMyIjfAxijET8i9rRvARTpH4hXW+5/x1D5nj1/ow13ZwSnVFo7Uz4
         D1obO4tECwyn5WrBfSdWTz6+NoXH/nlaNsSd9v6I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523422471;
        bh=GYvJrw7JX5woQhmdYlCa2Svm4qg4mmi8pCG4zBqxTDs=; l=1699;
        h=Received:From:To:Subject;
        b=qTIyAjHlgE2nvXtVv9GsTKUmtV/FvDUGiB7T+WVTVVVpwQB0llQlrJh7bHadzX7n+
         q/l+F4f+PfNccJMyIjfAxijET8i9rRvARTpH4hXW+5/x1D5nj1/ow13ZwSnVFo7Uz4
         D1obO4tECwyn5WrBfSdWTz6+NoXH/nlaNsSd9v6I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523422471;
        bh=GYvJrw7JX5woQhmdYlCa2Svm4qg4mmi8pCG4zBqxTDs=; l=1699;
        h=Received:From:To:Subject;
        b=qTIyAjHlgE2nvXtVv9GsTKUmtV/FvDUGiB7T+WVTVVVpwQB0llQlrJh7bHadzX7n+
         q/l+F4f+PfNccJMyIjfAxijET8i9rRvARTpH4hXW+5/x1D5nj1/ow13ZwSnVFo7Uz4
         D1obO4tECwyn5WrBfSdWTz6+NoXH/nlaNsSd9v6I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523422471;
        bh=GYvJrw7JX5woQhmdYlCa2Svm4qg4mmi8pCG4zBqxTDs=; l=1699;
        h=Received:From:To:Subject;
        b=qTIyAjHlgE2nvXtVv9GsTKUmtV/FvDUGiB7T+WVTVVVpwQB0llQlrJh7bHadzX7n+
         q/l+F4f+PfNccJMyIjfAxijET8i9rRvARTpH4hXW+5/x1D5nj1/ow13ZwSnVFo7Uz4
         D1obO4tECwyn5WrBfSdWTz6+NoXH/nlaNsSd9v6I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523422471;
        bh=GYvJrw7JX5woQhmdYlCa2Svm4qg4mmi8pCG4zBqxTDs=; l=1699;
        h=Received:From:To:Subject;
        b=qTIyAjHlgE2nvXtVv9GsTKUmtV/FvDUGiB7T+WVTVVVpwQB0llQlrJh7bHadzX7n+
         q/l+F4f+PfNccJMyIjfAxijET8i9rRvARTpH4hXW+5/x1D5nj1/ow13ZwSnVFo7Uz4
         D1obO4tECwyn5WrBfSdWTz6+NoXH/nlaNsSd9v6I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523422471;
        bh=GYvJrw7JX5woQhmdYlCa2Svm4qg4mmi8pCG4zBqxTDs=; l=1699;
        h=Received:From:To:Subject;
        b=qTIyAjHlgE2nvXtVv9GsTKUmtV/FvDUGiB7T+WVTVVVpwQB0llQlrJh7bHadzX7n+
         q/l+F4f+PfNccJMyIjfAxijET8i9rRvARTpH4hXW+5/x1D5nj1/ow13ZwSnVFo7Uz4
         D1obO4tECwyn5WrBfSdWTz6+NoXH/nlaNsSd9v6I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523422471;
        bh=GYvJrw7JX5woQhmdYlCa2Svm4qg4mmi8pCG4zBqxTDs=; l=1699;
        h=Received:From:To:Subject;
        b=qTIyAjHlgE2nvXtVv9GsTKUmtV/FvDUGiB7T+WVTVVVpwQB0llQlrJh7bHadzX7n+
         q/l+F4f+PfNccJMyIjfAxijET8i9rRvARTpH4hXW+5/x1D5nj1/ow13ZwSnVFo7Uz4
         D1obO4tECwyn5WrBfSdWTz6+NoXH/nlaNsSd9v6I=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f67m9-0007f3-Ju; Wed, 11 Apr 2018 07:54:29 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
        <87tvsj6rn2.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 11 Apr 2018 07:54:29 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 11 Apr 2018 00:11:39 +0200
        (DST)")
Message-ID: <871sfm737e.fsf@javad.com>
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
> On Tue, 10 Apr 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > Once upon a time, I dreamt of an interactive rebase that would not
>> > flatten branch structure, but instead recreate the commit topology
>> > faithfully.
>> 
>> [...]
>> 
>> > Think of --rebase-merges as "--preserve-merges done right".
>> 
>> Both option names seem to miss the primary point of the mode of
>> operation that you've formulated in the first sentence. I suggest to
>> rather call the new option in accordance to your description, say,
>> --no-flatten, --keep-topology, or --preserve-shape.
>
> A very quick A/B test shows that neither --no-flatten nor --keep-topology
> and certainly not --preserve-shape conveys to Git users what those options
> are supposed to do.

In fact, my preference would be --[no-]flatten, exactly because the
default mode of rebase operation flattens the history, and thus what I'm
talking about is:

git rebase --no-flatten

vs 

git rebase --rebase-merges

I honestly fail to see how the latter conveys the purpose of the option
better than the former, sorry. To tell the truth, the latter also looks
plain ugly to me.

> But --rebase-merges did convey the purpose of my patch series. So
> there.

- Except that your primary description of the series (that I find pretty
solid) doesn't mention _merges_ at all and still conveys the purpose?

- Except that this patch series _don't_ actually _rebase_ merges?
Yeah, I remember a follow-up is to be expected, but anyway.

I'm still unconvinced.

-- Sergey
