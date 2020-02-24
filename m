Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF48CC38BE0
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B376C21927
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ifP3SMDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgBXUt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:49:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57247 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgBXUt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 15:49:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8774851E9B;
        Mon, 24 Feb 2020 15:49:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NHtmcOlWaNdo
        YLvEU0VF5s7f0Bg=; b=ifP3SMDOFWxxIrMZYB4L6YvvMHNRrsHgHCG/YinV0HDk
        BjyX07fsrO9lftHiAAPcYCqykHra2+Vhojc9AqpXtc22MppYeGDOHIBtQIqVNR0i
        hGWk52UjvNb+WgxhXLZbawngmtsc2uw4HqBVyUAFa2eZZHbRPAbWs6Mxslql9p0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Q8Om/R
        Mft4KfZlgu1lOT+mO8rqQFa5C6Knr1AieLXHHGFcU1dgVOE73uklRx7Wz1N+jVJF
        omW3BoJJ1d7RLGC8azVkNFvIbfXib+jq3kgRBFXjmAGFKcQgGq7dztafxvqboEMM
        auLuTIK2Zifq3kJYkaDKhuFNIfMI7kAHnhfj8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79AC651E9A;
        Mon, 24 Feb 2020 15:49:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0F9D51E99;
        Mon, 24 Feb 2020 15:49:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] t: drop debug `cat` calls
References: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
        <179c67caec0f8123d09455cb78532419166e1b9e.1582447606.git.martin.agren@gmail.com>
        <xmqqlforpyqe.fsf@gitster-ct.c.googlers.com>
        <CAN0heSo8RSyvTqTtDLcnBsvMJ-DLL_B-sKRZDNUZBhZ1yX=bmQ@mail.gmail.com>
Date:   Mon, 24 Feb 2020 12:49:24 -0800
In-Reply-To: <CAN0heSo8RSyvTqTtDLcnBsvMJ-DLL_B-sKRZDNUZBhZ1yX=bmQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 24 Feb 2020 21:24:32
 +0100")
Message-ID: <xmqq8skrpv6z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 24BB4A1E-5747-11EA-A050-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> For the first patch 1/3, if we lose the cat entirely, we risk bugs in
> *git* being hidden.

Yes, as Peff already said, the change to explicitly test if the file
exists makes perfect sense.

> For the hunk in patch 2/3, I first thought it was in the same
> category, before I realized that kwdelfile.c disappearing would be
> a bug in *p4* as opposed to *git p4*.  Since we're not in the
> business of testing/verifying other people's software, we can
> afford to drop that call entirely.

It is ">kwdelfile.c" shell redirection that creates that file.  I
agree with you that preparing for a bug that "p4 add -t ktext
kwdelfile.c" or "p4 submit" removes the file is a little too much.
