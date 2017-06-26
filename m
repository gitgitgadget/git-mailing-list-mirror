Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C6420834
	for <e@80x24.org>; Mon, 26 Jun 2017 09:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdFZJCK (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 05:02:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33863 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdFZJCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 05:02:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id f134so338310wme.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=laG3u5FMrmTh1aE/6M56bp3CKOZl+Q9raoEpQaY9zf4=;
        b=Z3Rr1SPujGF1USRGlj9yjXAmXzMjHapmaIogdnvkXFQov31gge2yMEhykMiJTHbvmW
         4NT1r46h9qRFs4yPte39551Yia0PjAhxq0B4EEUm5ArC74bpQMX/pMhAc7aJ/IRxxnU+
         mjpM51GO/fRMo2UTeuaN7y6SKR/1n3GCjm0GeeJEko+dWzgWA5+obd4QhJe5lDAc84AZ
         wmkmjOB4gEfQxW+cCnIUvn720FnVa85uuU/3fhJd7pzzUAyltYXzHxpqjvWadKxJvRm0
         L7q2lrMCMQ63e5yhZSjVF7tnEGBnnn5M+P7slBXSD79aLxF/t1BlFQVJS+BypfKdyxYZ
         W7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=laG3u5FMrmTh1aE/6M56bp3CKOZl+Q9raoEpQaY9zf4=;
        b=t6p8K1nS5kv9thc+nFgfyJfle2q6kBDegoV3PUvt1g99YF2u+6eI8goOKiejH7I+CQ
         4ibVF+CJ2L7L9E/LeyTgEmo1YrB8mKcBJbhn++qZyJ0h1wS5KW8YBSXO8sUaT8eb7cuO
         CAYnjFZur3Q2hGVrlbNTIFwiqdCgOM40t/IxxcECHO783MIhyIhCYVbtPGgDFQUholOF
         MHxODMtXhTZuSDTqdtwe8wIVrXVpTDLZSUJr+8CzxHB121VYGtaHPJCJogN5DQT5pK4o
         vfCCd99a9kmA6XDd+ntU6IanZE1HIKXzB+PCSRZrn6rz14WZL/19MFgT8yTeFjz8Ko7X
         v1QQ==
X-Gm-Message-State: AKS2vOwZInX2Un1YrOLTBHeLD7jVgtTyuf8bQm228mNQjON/Ww+2XJOE
        rsI9EGw1bL0EZw==
X-Received: by 10.28.156.208 with SMTP id f199mr11286054wme.22.1498467727941;
        Mon, 26 Jun 2017 02:02:07 -0700 (PDT)
Received: from [10.32.249.40] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 74sm11456161wmu.5.2017.06.26.02.02.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 02:02:07 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 1/6] t0021: keep filter log files on comparison
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqtw337m4b.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Jun 2017 11:02:06 +0200
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Wong <e@80x24.org>, Taylor Blau <ttaylorr@github.com>,
        peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <79C07E47-251D-4869-8EEA-11A9E336ABF3@gmail.com>
References: <20170625182125.6741-1-larsxschneider@gmail.com> <20170625182125.6741-2-larsxschneider@gmail.com> <xmqqtw337m4b.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 26 Jun 2017, at 00:12, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> The filter log files are modified on comparison. Write the modified =
log files
>> to temp files for comparison to fix this.
>=20
> The phrase "to fix this" implies that it is _wrong_ to modify after
> comparing it, but it is unclear _why_ you think is wrong.  After
> all, the purpose of this comparison helper is to see if these two
> are the same with cruft removed, and once the helper finds the
> answer to that question, the current users of the comparison helper
> do not reuse these files, so from _their_ point of view, there is
> nothing to "fix", is there?
>=20
> It would become a problem _if_ we want future users of this helper
> to reuse the same expect (or actual) multiple times and start from
> an unmodified one.  There may be some other reason why you do not
> want the comparison to smudge these files.  Please state what that
> reason is before saying "fix this".

Understood. How about this?

    The filter log files are modified on comparison. That might be=20
    unexpected by the caller. It would be even undesirable if the caller=20=

    wants to reuse the original log files.

    Address these issues by using temp files for modifications. This is=20=

    useful for the subsequent patch 'convert: add "status=3Ddelayed" to=20=

    filter process protocol'.

If this is OK, then do you want me to resend the series or can you fix =
it
in place?

Thanks,
Lars=
