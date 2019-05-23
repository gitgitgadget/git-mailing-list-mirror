Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B33691F462
	for <e@80x24.org>; Thu, 23 May 2019 09:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfEWJuH (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 05:50:07 -0400
Received: from smtp47.i.mail.ru ([94.100.177.107]:41144 "EHLO smtp47.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfEWJuG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 05:50:06 -0400
X-Greylist: delayed 35482 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 May 2019 05:50:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version; bh=l9KXaQz1GzULqUIc8FoXekrXpVuighQeTyvE6S0Hspg=;
        b=qs36L2gtM9j522U22XxhaSO6WtOy+9W4bhrPd2zyNHXPu4K8/wUn4uNE4zvR9XJffcGm03hjguaqioatIyDpmej8C8+9sER0SJJssmMMeT3VQG2LgR0RWjH7+841Y0dFrzTWzTEoVT54VyGka3uZx0reZmW1Z536FP744scgMFY=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <odnoletkov@mail.ru>)
        id 1hTkMN-0000nb-En
        for git@vger.kernel.org; Thu, 23 May 2019 12:50:04 +0300
Received: by mail-io1-f49.google.com with SMTP id v7so4317527iob.10
        for <git@vger.kernel.org>; Thu, 23 May 2019 02:50:03 -0700 (PDT)
X-Gm-Message-State: APjAAAUDkPcUZVYrz9ImBSBH9qUN7xR5UduU8ZOQkraGNnx91UaOqNRZ
        p1attwEYJslBOTKx0eccYIL0Rll7do9ejgnSUDQ=
X-Google-Smtp-Source: APXvYqwRImnOSywJPLLq7PM/dQx40lDEVXCAzd8GPc7HWNUqesAHXvuG08S801FWIbSnp0MMQnZ26pipbHKyN18PpB8=
X-Received: by 2002:a6b:5116:: with SMTP id f22mr30311617iob.185.1558605002364;
 Thu, 23 May 2019 02:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh8bsphny.fsf@gitster-ct.c.googlers.com> <20190522235705.68452-1-odnoletkov@mail.ru>
 <30d1e067-4184-30e8-bfd2-6ba8da0fc1f5@kdbg.org>
In-Reply-To: <30d1e067-4184-30e8-bfd2-6ba8da0fc1f5@kdbg.org>
From:   Maksim Odnoletkov <odnoletkov@mail.ru>
Date:   Thu, 23 May 2019 10:49:51 +0100
X-Gmail-Original-Message-ID: <CAEYVt4pv1JCZf_tXC4S3-D940MfrohEo0+qst73GScm9+5Rbvg@mail.gmail.com>
Message-ID: <CAEYVt4pv1JCZf_tXC4S3-D940MfrohEo0+qst73GScm9+5Rbvg@mail.gmail.com>
Subject: Re: [PATCH] Make stashing nothing exit 1
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     gitster@pobox.com, git@vger.kernel.org, keithbsmiley@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp47.i.mail.ru; auth=pass smtp.auth=odnoletkov@mail.ru smtp.mailfrom=odnoletkov@mail.ru
X-77F55803: 0014004E1F3277295A78504BD2AC29418E23A805F02667946C5FFC93732DA433450DA77368CFE40BDF80C731D9F61FF4
X-7FA49CB5: 0D63561A33F958A5534A7CA17DD01848DC10D6B1C2241BC69BBABCCD6EDD99DC8941B15DA834481FA18204E546F3947C1D471462564A2E19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B2EE5AD8F952D28FBA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224906B0952B3C02BDD73AA81AA40904B5D9CF19DD082D7633A093541453170D46FCD81D268191BDAD3D78DA827A17800CE7AB8EEA909F5DE8F7CD04E86FAF290E2DBBC930A3941E20C675ECD9A6C639B01B78DA827A17800CE7E87EAEC642D14D3B4D0697F13E8DDE4A75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC852301B74F4230CB9127F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-Mailru-Sender: 4C235FE2E5D2D890D35D2197AF433329404A5EFBB888B1B432E54423F65A384D35B354B808D7FFF0A42620DD4D382ACDC77752E0C033A69E5B5A690398F5F5FE1B1963E874B928233453F38A29522196
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 23 May 2019, at 07:14, Johannes Sixt <j6t@kdbg.org> wrote:
>
>> Am 23.05.19 um 01:57 schrieb Maksim Odnoletkov:
>> The problem with current behaviour is it makes it hard to use stash in
>> scripts. A natural stash use case is: wrap some operation requiring a
>> clean working tree with a stash push-pop pair. But that doesn't work
>> properly when working tree is already clean - push silently does nothing
>> and following pop becomes unbalanced. You have to keep that in mind and
>> work around with something like:
>>
>> if ! git diff-index --exit-code --quiet HEAD
>> then
>>    git stash push
>>    trap 'git stash pop' EXIT
>> fi
>>
>> With this change this can be simplified to:
>>
>> git stash push && trap 'git stash pop' EXIT
>
> In a script, shouldn't you better use 'create' + 'store' instead of 'push=
'?
>
> -- Hannes

Just like 'push' 'create' doesn't error on no-op and
doesn't create a stash commit =E2=80=93 so you still need to handle this
edge case manually.

I was thinking of using create-apply pair for this use case but push-pop
has added benefit of preserving a user-accessible stash entry for manual
recovery in case stash can't be cleanly applied after the operation.
