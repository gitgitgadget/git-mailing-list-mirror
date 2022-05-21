Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB65C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 22:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346929AbiEUWDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 18:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiEUWC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 18:02:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74F52AE36
        for <git@vger.kernel.org>; Sat, 21 May 2022 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653170562;
        bh=IZq/1DFJS6tJI+RhBQy1ECLOKwo0yvixqZeMW9buw1o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Hs4dgboSYaKnsDpYuP5BqHo++f0Hx0iRi0MsyJfSoMqxynYhVAvNFXTrkyKSBIhb3
         VpvJCRFbxrtntdMUQV/N6xqpRNfHmRPdyPBXPPHPSTTsadJQ/DXhrrxAcRIx7g0Qga
         CPsBOJpj/JrdFpjJMPoh/akHp5dacJ11fB1v+lHI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1nSn5M08Mk-00ioGv; Sun, 22
 May 2022 00:02:42 +0200
Date:   Sun, 22 May 2022 00:02:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: js/use-builtin-add-i, was Re: What's cooking in git.git (May 2022,
 #06; Fri, 20)
In-Reply-To: <xmqqmtfbcoaa.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205212352540.352@tvgsbejvaqbjf.bet>
References: <xmqqmtfbcoaa.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:66ELKooHfDn9tDS4wnfDqOeOxxu0MqU5lKI9m7acTLn3rNcjn4V
 OxDywYyE9Y6sAF4DEc2FC8TS8qXLGwPkwl3qvzKoNZizHoSRgoS6klQrVRCX/BpLu6IWzqe
 nUj06c8XyaGp3M0q+oL4qmWbNRTh3Oy/7pHRifi9Ni18E+kKfw+q7S1I35fgPDa6xqhKx/a
 S1o5SESYNcNcOtgIvWs8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j0yJjFAnAZ4=:TkuZPMh8w/9xosaEPBS99C
 5iFYa95hdvolqFXZ3cZClK9aAsNRYxXQp3y7r47sb1RdY2KaMwH1RhTSsk+s4nuIl4RMV/dQZ
 w8W6HApxYegOCNak67VHUBeW4UG34mQM4wlhYtePVcGtKTNM+10JIdWqEIDO/I1RYInnd8y+7
 rAY7KKsqpIsbBc9rLMpzVFtBD1Vo4/weJN8ApzoBdecMPHE6QqmajoyXTbqEBdN0jtmgRVgLg
 3I7ryuwtca3dxdfbWNDZrW2cpXhIYoUv1uuaqb3FV7oeYysoHsi/sNXu9qZ+8ylAE+j9+TtAg
 McOtNeg436rvSKUYMdLj9BpwI/f5/d1fht9jGoDDbRrb46c6iVROdGv5rUuvw6M+ZHAz9wLis
 IGufvWT+YQJKSVKw40rZImX+gspHH5zvZJZ0DnYuDqbl6soXv0ybAoCllZ9+8t0U5rWaY4+Xj
 HDSLJkPqq2IYti6xuBDAvtw95Ayf9PHGXoA+GjHQr4RZgMIcV7SA2hykWmzTGi07zwsjm1/iu
 597hQsArm+QXpjznP6OCgjcTnjTBDdcjdWzSocAadAZpf/N2h28/mQiCC+npcaioraBve3N46
 28v6sL1CUOuyN7qaByLyXVs0Z+Y7rC/0WZG9fwQ48F62rf3VOS6aWr192wX9qZV10BUkRn/cs
 v8Mzxk96BHfX9q5UOXTAckSdRxkpsZQPx/k1sVcc/HxyyZhQt0L2y7XCcedvlP//R/1sbkVKr
 p7iGO2qf4NJldr2Ow92pwnb6H9HyZUP5rFM5BcYhEDHmHjbQ87+3SUqqKuTUOhJYF7Ul59w6n
 w/tcy5mGVHgS+D+MtZ0afpUxljYv/bWA+XVmRREfIr1MOW10k7zPZge2gSclm74i7TgBfCa+8
 RXba1jq5x+TjcZr4gmAxgiBpR6uVcQCT9+FeYwS6OCB3wWSAFuST7amO712hQ5sJ1ZS0rvVOP
 aP3waxdmdTekyIQqUkayB5u3dQRKI6BgFRdwXogd9BxZQfvT2vNV9I/HB8/LLLasu96a1YwDg
 6hXuXLH8ebEA1xBVp+syLwwdKf8inwyP1n7DxAFTn+FCNydlY0pZEpZLRpb1bgR3C0+mvd6gJ
 lKmhyYTcE9H1L+NQih8dRYbKtp8Gh1M+vGwyLuILouE9Rh+UdjnCwrqZQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 21 May 2022, Junio C Hamano wrote:

> * js/use-builtin-add-i (2021-12-01) 2 commits
>  - add -i: default to the built-in implementation
>  - t2016: require the PERL prereq only when necessary
>
>  "git add -i" was rewritten in C some time ago and has been in
>  testing; the reimplementation is now exposed to general public by
>  default.
>
>  On hold.
>
>  What's the status of the "known breakage"?
>  Are we ready to switch if we wanted to?
>  There are known breakages on macOS.
>  cf. <nycvar.QRO.7.76.6.2112021832060.63@tvgsbejvaqbjf.bet>
>  source: <pull.1087.git.1638281655.gitgitgadget@gmail.com>

As per
https://lore.kernel.org/git/CAPUEspg1cJC_UwjJFx-jnzWsascY++S3UgM1UCLRcnK_M=
v2wOg@mail.gmail.com/,
I believe that the macOS breakages have been confirmed to be addressed by
`pw/single-key-interactive` (which was merged in 32f3ac26e03, i.e. it was
included in v2.36.0).

Therefore, right now might be a good time to advance the
`js/use-builtin-add-i` series.

Thanks,
Dscho
