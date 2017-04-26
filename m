Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8029207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 07:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1956579AbdDZH4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 03:56:40 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38032 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1956571AbdDZH4i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 03:56:38 -0400
Received: by mail-it0-f44.google.com with SMTP id f187so28703457ite.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=33QRFtroCgw+kuz2ssxZgtVzdb8KQx4UofYAXUHtcjo=;
        b=mYjjCa+iPCr0QaZPNFWBUQt+nA2FaiUXkQmNipSMr61soLboBQFX1NaOidlK017aG8
         529ktVDu1FN2OuMGEhGJ3TQz1CULDdjKiZk5nwzDB3hZL45LCk+XmOhksTcB3JM0NHM5
         /FiPrcHE6g7ezBze7Ml/WTxRogSF1eex1WAgPQxBNDFdQ9wMznkE2uRC07kyCIptvkBP
         +q4Ru+Q0K8B3fIW+hMgbAD422jk3Q00/y1eRh63Nf/JRXsuBuQ7/b7P/6tGo4SakvYpY
         xMUdGMc4a0Ly/VpwCyKaDVhL2lBUqISSihNbcrS5YH/ybZ6mnM3EOdprgkAFAJf1sQl/
         0I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=33QRFtroCgw+kuz2ssxZgtVzdb8KQx4UofYAXUHtcjo=;
        b=tBL0qlHgzAm+nDvFSGmWTTOa17mXq+Zm18uSn9epBpKBdZbnlW1VcSWKzPzL1ELddA
         K5oSnjAmdjqkF5fGFVmuBLUHXYxIK57Y4dE9eTc//P9AtyLFyfGTG9D/lKNDlhM4Sv3P
         QcqiqMrxkLl8zOUh0q+cUjls+8AxSTeHcWrJ2M9FCEb4GbdFfAR23UENyHCT6+G5QkXN
         5d5XlJ4czRjWezyGvvlx9pLJjCleYqv/n8Wffd6FIKFV4gwadQkTUPCZYF+z0NpC7EiJ
         3iUl/+VCYdiY3n47ICjLonfdWHDLa0rrp9YKGFkMHcABkADOAOH4/NsxHHemNjpoxbsY
         1BAg==
X-Gm-Message-State: AN3rC/5CCov/Y9gUfBbIWLGzj//dr5Rw1jq/J/xVLI2xpme3oyBt7fZ1
        zbUjcRVRGYXd/VxF4ORUvyfBk1Ai4Psq/2c=
X-Received: by 10.36.131.65 with SMTP id d62mr9597628ite.66.1493193396776;
 Wed, 26 Apr 2017 00:56:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 26 Apr 2017 00:56:15 -0700 (PDT)
In-Reply-To: <xmqqmvb4szef.fsf@gitster.mtv.corp.google.com>
References: <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
 <20170421185757.28978-1-avarab@gmail.com> <xmqq1ssi4nci.fsf@gitster.mtv.corp.google.com>
 <CACBZZX63VQK4fLSB2T8onXJ_hQE8dkOCAyFFM-C_yOfoMwxLMA@mail.gmail.com>
 <xmqqmvb5w2hj.fsf@gitster.mtv.corp.google.com> <CACBZZX494g8CKoN0V1N4xRuDsErPtJcMjaZcLFAqJgDQ+Mz+yA@mail.gmail.com>
 <xmqqmvb4szef.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 26 Apr 2017 09:56:15 +0200
Message-ID: <CACBZZX5PgC3CjCrhhFb5d0z6-uMw2oR36-6H=78Q5eN20pKthg@mail.gmail.com>
Subject: Re: [PATCH] tests: fix tests broken under GETTEXT_POISON=YesPlease
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 3:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Indeed, I've tried to be careful not to introduce bugs like that, but
>> in this skipped case the tests look completely stand-alone to me.
>
> Yes, the ones I commented on in the upthread looked like their side
> effect were not felt in the later tests.
>
>> In any case, I like my other patch to just remove this whole thing bette=
r.
>
> Hmph, did I miss a patch message?

I sent it to you & CC'd the list, but it looks like it didn't make it
on-list. It's "[PATCH] tests: remove the GETTEXT_POISON compile-time
option to test i18n marking"
(<20170424110434.27689-1-avarab@gmail.com>). It's 240K & 6k lines, so
perhaps the list is rejecting it, here's the patch:

https://raw.githubusercontent.com/avar/git-patches/master/remove-gettext-po=
ison/0001-tests-remove-the-GETTEXT_POISON-compile-time-option-.patch
