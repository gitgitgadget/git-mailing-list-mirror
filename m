Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D2C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 11:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiGMLLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 07:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiGMLLB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 07:11:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC9D100CC6
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657710642;
        bh=rXbnOhxQElgjQ0gOhOYkSvgg8PYZ2NFpP47jI7Z9CFM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iOTy2sH5/4wUZ3J/LDJFvgGehB1W/y0swKIIIgtQfYDvmt6WJbJMJQZQsKLj9+dKx
         sKFCizE15fZfdQfpnsgi10waQPIbKHG4+OoPS3mCIFC5MvJd1c4elLTYbbdkRhuw+z
         NtlT2WyuDjqsqVFQ96qgO6MwbEWQrjC8MoKb90gQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.180.6] ([213.196.212.225]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSc1B-1o0t203cev-00SzLr; Wed, 13
 Jul 2022 13:10:41 +0200
Date:   Wed, 13 Jul 2022 13:10:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/bisect-in-c, was Re: What's cooking in git.git (Jul 2022, #03;
 Mon, 11)
In-Reply-To: <xmqqo7xufee7.fsf@gitster.g>
Message-ID: <s3726r9p-r96o-7793-0qrq-o54rs4npr972@tzk.qr>
References: <xmqqo7xufee7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iNX7JLXzVlg+jL0jeyT8lG+LHVWXLYDHIW89i3AEXsfYyFyJOXv
 +tgzNcqc8rM4PpEv7N8tlptoTnfEbuuLvUAZ3urvEJrkXqv8HGHXvl6Y2G183h7Iije0Au0
 oILWOYqknpDg2LRgQyG7ly/0/La5Ql3Chl1HJWIguHYFoJqgLCPxouQVy3sCvXvhW5fih+K
 krWwa6MxS6FGIwGrYNpjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bY2iovgi1Pg=:g1iSkdLBWHVA/2F70TTJWW
 vLfgPkg0xS5xMKx7OVmz2xrYFO5S6dIL86ZJcShTTHoAhrdHC73gDIhg6KWv3xqQtw5bGzybB
 SQ3ZuLi3GZHfrwiX0ZHmDtA549GQ+QGGzmZpdv/RAK6s4VommoGc3n656cQfZwsMCMZ/Sc4vG
 lwvjQk7mSiE6kZepeHYTzbg83c8gEhy99kDci1cEcH4azyt6Yt4JbJZAf35MH2Qjnn0bSBN3G
 RXeZuQ+lajQzZewEhEcTfOiRM1GpbHsgMIqMIXR4Glg9aBWtGxEb0ltBreQ9sP072EghSu0gq
 qvrYIbpcLTQ6bIMbJ3plfgtshPvyBnai5/ZjvN4Bm0bNKAwLqlMITUy2urz2KEPsPZ79c9X0i
 8IzvdFV40ja9/cXZCSF/iMvlUtjvcKcpJtAeah9tWqKAHKkgTwNWPWX/W0/hu6AN7lfVi7CTn
 6Uk/Ari8jcFrZuRfM78y/pSvSlqmNX29VueeE+kx7Jzl01ijnqtfIBDHoZvBQ0LtJ4X25pMj5
 XXYW0h1CDAEf7imeYxpzLIMQDamD3V4oh7a5/SR19DXNX0fCGiBGOfEN3DDmDR1D9NCs7++Ly
 7ggo8eE9LVAdX561ACAAmndOd/mHDI+5kiRal7XyUVVlJmWijWwl2xbYP340cdmRYitKPRrTI
 DjkT41lvHXcBdT8VoW6F38lWlZ4FuKC7lOk1b9JKe9lBHm6YDu53V8vB7dnFGT/tkBCDOGZRz
 vjQtRRH2RdHAiGACOBuOX8PrXHQnGKSKSacKgDRqxzlY2WeVEUdWuEq/tKHAe00cvHgOncDdy
 j8171B/E3ST95Q67mg82eDIutiBWvQR0F5L3IxnH6w0xAVjd0ISMJCbO+N2SEHTcVI6rKetUZ
 4PX9LUgMonlkyqnsaUf1NQQCDN9hVc1nuHnAuiOmMpna+oTe/FJ+Zeie5d1oUayxCE9AT6bJZ
 /vSW6JE/Xgo5kaSA5b7tpsrm55Y45UzSZMYdfWT/xlVpDI/jsXolU2a2wf5/mN20gSiAwt59O
 7v0iKIbu7+yrkflmoP3WFmaRyW1hBr3SY9jrS/970BHVasmBWWfQ/TMkPhzkhAK23VCXNGHrB
 LumX3sS7ZTz9c26VsgpVNV9PyZz9QdTpX7GP47I0scihetVVuakSZVAsA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 12 Jul 2022, Junio C Hamano wrote:

> * js/bisect-in-c (2022-06-27) 16 commits
>  - bisect: no longer try to clean up left-over `.git/head-name` files
>  - bisect: remove Cogito-related code
>  - Turn `git bisect` into a full built-in
>  - bisect: move even the command-line parsing to `bisect--helper`
>  - bisect: teach the `bisect--helper` command to show the correct usage =
strings
>  - bisect--helper: return only correct exit codes in `cmd_*()`
>  - bisect--helper: move the `BISECT_STATE` case to the end
>  - bisect--helper: make `--bisect-state` optional
>  - bisect--helper: align the sub-command order with git-bisect.sh
>  - bisect--helper: using `--bisect-state` without an argument is a bug
>  - bisect--helper: really retire `--bisect-autostart`
>  - bisect--helper: really retire --bisect-next-check
>  - bisect--helper: retire the --no-log option
>  - bisect: avoid double-quoting when printing the failed command
>  - bisect run: fix the error message
>  - bisect: verify that a bogus option won't try to start a bisection
>
>  Final bits of "git bisect.sh" have been rewritten in C.
>
>  Expecting a (hopefully final) reroll.
>  cf. <20627.86ilolhnnn.gmgdl@evledraar.gmail.com>

I did not find that one, but I found
https://lore.kernel.org/git/220627.86ilolhnnn.gmgdl@evledraar.gmail.com/

And that claims that Git has a convention to universally exit with code
129 when options are passed with incorrect values.

That claim does not survive even minimal contact with Git's source
code, though.

If I find some time, I will respond to that mail, but a reroll is actually
unnecessary.

>  source: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>

Thanks,
Dscho
