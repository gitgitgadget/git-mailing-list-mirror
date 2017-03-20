Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341DE2095B
	for <e@80x24.org>; Mon, 20 Mar 2017 12:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754404AbdCTMH2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 08:07:28 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34827 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753416AbdCTMGk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 08:06:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id q19so3653082oic.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AS994riDJjLJ8H6QUMLxSPcade08kmWGRgXA+i7QCGo=;
        b=X6D3r8+1YWLgLM9C9Zi6cWb1WmN8/aPpb0UnhvQoHxRwAEdUKmr1yV5JxIZWnURSb1
         VbprQiOG2Wb/maQbTnq05Q/fIZAfa82PkpLXPz+9H/X9aCf/tAQHC6CPbAEz/b5ZGCn0
         skxL5DRnu5xCwxUth8L4ioJKT7Lppfhvu8WnkMCJeECTPC4JbYcKTBMjdDcJyltp/UEe
         UnXX5Ld+jqG1pfGWcWX4A7IXed67xPPprWiCBOF89tymLeEeCIIiHCrs3EjDX2Boasc3
         WAkJaH2ObZyf51ownPcO4PXWrAa4yz+qcmWQZWupOa5/3tyzJUIbakxxUVMz0Pabcp9t
         sV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AS994riDJjLJ8H6QUMLxSPcade08kmWGRgXA+i7QCGo=;
        b=V3sWggQFIKmn6CY+lAFO5JBarghMGMd4pIg43832r2/ORMnDCS++6cf7As98YNOaIw
         6BwpgHEblOkLfwR+CX3fLSMhNV3XZmfgBO0Wm2UOv7cyICTaQ11PcCR6vhmkMyCrG3sk
         Oea8iQl9ff4gA9lZoRtB+roRe3gaKJ1M5Qko9UcABFrn6ufsZygcN6Ii8rCfJIAj67AD
         1MG/IHFdCYvnQDNQuuqmebqpXWjeao8Ganjb+5jhcQx8JjxngzsOhm+hUoJSlZWeoQG1
         2HcZ3bG98YKWc6hhc4VPe/xGr6O4F1DblO905EZQCD/RNie5kDp8s9GypHS2QeWKIiuN
         5esw==
X-Gm-Message-State: AFeK/H3IY1mRtRpZD/BKm0W1O3LmipbNIIArsVVkdq/GZOmcCnkYTY36mvsHc5beACSeZM1MiQQWMoIPgEJLKA==
X-Received: by 10.202.183.86 with SMTP id h83mr3167658oif.169.1490011551725;
 Mon, 20 Mar 2017 05:05:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Mar 2017 05:05:21 -0700 (PDT)
In-Reply-To: <37e76a4d-e197-f9b1-2546-d207656149a6@alum.mit.edu>
References: <20170222140450.30886-1-pclouds@gmail.com> <20170318020337.22767-1-pclouds@gmail.com>
 <20170318020337.22767-27-pclouds@gmail.com> <37e76a4d-e197-f9b1-2546-d207656149a6@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Mar 2017 19:05:21 +0700
Message-ID: <CACsJy8A6mZGjNdFbhKgWAR=XSK+2mO-HG7Vayp7VODRJwu1ixA@mail.gmail.com>
Subject: Re: [PATCH v6 26/27] t1406: new tests for submodule ref store
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 12:27 PM, Michael Haggerty <mhagger@alum.mit.edu> w=
rote:
> On 03/18/2017 03:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  t/t1406-submodule-ref-store.sh (new +x) | 95 ++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 95 insertions(+)
>>  create mode 100755 t/t1406-submodule-ref-store.sh
>>
>> diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-stor=
e.sh
>> new file mode 100755
>> index 0000000000..22214ebd32
>> --- /dev/null
>> +++ b/t/t1406-submodule-ref-store.sh
>> @@ -0,0 +1,95 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'test submodule ref store api'
>> +
>> +. ./test-lib.sh
>> +
>> +RUN=3D"test-ref-store submodule:sub"
>> +
>> +test_expect_success 'setup' '
>> +     git init sub &&
>> +     (
>> +             cd sub &&
>> +             test_commit first &&
>> +             git checkout -b new-master
>> +     )
>> +'
>> +
>> +test_expect_success 'pack_refs() not allowed' '
>> +     test_must_fail $RUN pack-refs 3
>> +'
>
> It's a little bit unfortunate but probably OK that this test and its
> analog in t1405 hard-code internal numerical constants. At least in
> t1405 the names of the constants appear in the test name, meaning that
> anybody changing the constants' values in the future will probably find
> the "3" in that file.

I noticed that too, but was not motivated enough to do actual
enum/define <-> string mapping in test-ref-store.

> Would you do the same here, please, or at least
> mention the constant names in a comment here?

Will do (and hopefully will make test-ref-store take names instead of
numbers at a later point, or you'll get annoyed faster and do it ;-)
--=20
Duy
