Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41228C4167B
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 22:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiLTW7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 17:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiLTW7k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 17:59:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3181F2C6
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 14:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671577173; bh=Pn+CsgATYWAgo8Hxrv2p7WUCLnPHPHAC5N8LJ5kuAlA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GhUWU3ZN9+8D1AH1PaTDWQalaH1TEzbW5FvqS8x/GTWG74D5QUPlrxSeMzbLVgUUf
         Gu0+FzkpqVHS/TS6QpYT6EKjn48RLvDyT5kwZTSMhYAPOGJxoyjcJpu11jJ3QF1N5L
         /92IfjXp2pc89J3Wwjnt2Ea1K/fs5YROOGc8d2Sm4EBggw2xAeF0emi0XwU8IsnVOe
         5aTmdg2jxxXF8HOL+vJy2uNBaLIFsoWbkGcg2+pq7+DhXm5IFeP09FeA0ubczjmiv5
         1dQ2qTRxdydEkJfZxe//yEDU6sN+cdbxzhr2qrqZKkwRFoSkwTgrdzYg+wm8JDy3fp
         d0seE3QjKk24g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.64.45] ([89.1.213.120]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1p9PDD3DvW-002rx9; Tue, 20
 Dec 2022 23:59:33 +0100
Date:   Tue, 20 Dec 2022 23:59:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/drop-mingw-test-cmp, was Re: What's cooking in git.git (Dec
 2022, #03; Sun, 11)
In-Reply-To: <xmqqa63ss3fl.fsf@gitster.g>
Message-ID: <c57ecd23-7ca7-2501-983f-6661c7872a01@gmx.de>
References: <xmqqpmcqv7qh.fsf@gitster.g> <o428pr88-sn2p-o715-52ns-1r6750762572@tzk.qr> <xmqqa63ss3fl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FngoL29HaFX9ZFCOcmAyYEGoT7+q4MGx44aflF9rEFsputYcxrF
 BSk4FKULmOOEHnqB317XaNZ/XA7A/H9NWIr4rKW6rDXTDQ8zIiI/x9Jkd6thB2ua3e/mqEG
 4taZMYJtDF7Sd1Z+xy7ef80mNGW6gGPADXTBq4/SIjM2EFCODxQE2NeNnfa1aR7PuEHyQKx
 poinEz1y+049bg0iItgJQ==
UI-OutboundReport: notjunk:1;M01:P0:a+ANBBzVwxg=;veu0hn6R/Jv9xoJQO8UAoGmKA0F
 87jAgIAVyxBMLe2eeL7L68fP4pt56aWDVC5hH47wyIMQHynRba7GlPOd/wg5zYeqbXkvqerEj
 0fiGen/HrdZRYvKwLwOryB7V2uzuk8sY7Z5fGDLAMdtc1WP/ZR5W+6QzJS/hWzb4ifLbrJyv5
 I28LVaHT1rl2DIpT4wEKjGdF1S0ZMvLway58MCS9PK6+mX6UdXUw0EZ4I60oWS9NQ1F3XBZ96
 Tj0CYR76bFgZMNaz/a6u37lLPnmcd+au/48JxB35UD0TUbwMwt46YxIdlNc710PIQyXKTxtu3
 wQkKkqX4Yv27kH3twQE741bCkcQ4fsfpKhCC7Vb3j66Nq18sETQiiBHVoLu5hYfVzRFABCXNQ
 FFl6SC4dRe+zX+9PgnvhqypSlEaR0UWX8KcdGFUumsWyqkwusiTBMewQSj3yonZEnZHNrr4uR
 Iz4TAWsi2XgmhiVzjsZMp1VXs71Gl31G4wFnfDlvPLYkZuL2caAs+c/0yfkKseLKHo/R1rVoU
 Pvf8ubCpjDVCeXOZlH3vd0pWNwXqebVkNIiLX+Owj8+XVxuiEjKrcz3xXorx5Qn1zyAKfmL07
 rPis2TZEMPSvwOwrObHFSpmP6VSVWA0nWe+1lW8ixRvwfefqkEmrQtWuR/yqa3l4r12Lvtm9p
 rfXmhbOpTbZIMiaIiQF7r09Ib6oGAK09mLxzbA77gMLknnTR6BAuX/YTGu4mkXnEGj5BrikyG
 uUr9/OEwjl1qcJ+bEK6qw1WjYh2mQ938vRgjuK/J+R9q6xD7zxsOkRmJei5HgAt5b+lAuL2KG
 dTibEaGwvQpMLp6HnU2EGrzWnF2lkuOFR5SdDBpctQjoa6Wr4gQLByW+s3fMvbHAidAKCQ+Kj
 +r91QYlWTLQ666Q7s9H9OmAvbMFE3zqhfwqC/xUYoVpaviIoa0LJdHj54QfEMrJb+M7xjxYOW
 FvyxeTf/PhuyhRyxsnQ1kqhxqII=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Dec 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > There is a new iteration available here:
> > https://lore.kernel.org/git/pull.1309.v5.git.1670339267.gitgitgadget@g=
mail.com/
>
> Thanks.
>
> IIRC the review comments hinted that MinGW specific test_cmp that
> equates CRLF and LF are no longer needed,

That does not match my understanding. The MSYS2 tools we use in Git for
Windows' SDK (and therefore, in the `win` jobs of our CI runs) are outside
of our control, and have been known to change behavior with regards to
line endings.

If we want to have a robust experience, we will need to continue that
`test_cmp` practice that ignores line endings-only differences.

Ciao,
Johannes
