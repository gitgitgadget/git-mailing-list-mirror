Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36121FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 10:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbcLEKgj (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 05:36:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:63985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbcLEKgi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 05:36:38 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaXIV-1cxOyw0AhT-00mJni; Mon, 05
 Dec 2016 11:36:21 +0100
Date:   Mon, 5 Dec 2016 11:36:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612051126320.117539@virtualbox>
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net> <alpine.DEB.2.20.1611242211450.117539@virtualbox> <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net> <alpine.DEB.2.20.1611251201580.117539@virtualbox> <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251841030.117539@virtualbox> <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net> <alpine.DEB.2.20.1611261320050.117539@virtualbox> <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net> <alpine.DEB.2.20.1611261400300.117539@virtualbox>
 <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net> <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611281830040.117539@virtualbox> <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611292128340.117539@virtualbox>
 <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611301325210.117539@virtualbox> <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qw4D1brutw9fhIsqW6fGAYlovg6M1riSOmJubTWuFf6/xy8mp56
 XmIelhi18lIXZ8cF/CPWhLh5QzMQNHmVMCKTMJEM/pwLfmjifdnaOI00jqfpp8wbCCC00Jw
 LmPmDuj8Xj1560PcGtAI6OiS5QrVyQFeJczvwfeYH9WME2fSCHKK32i/4dRnWHlct3S2sIC
 j/g1N7Wi9va+7JaHEICQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K5+kFHmONzg=:/EUySKz3YSyR1kXtjr5QMx
 JJsEvA01GjNImtHIXSIn2A49P+ftMO4sG2Hl/IsxIsS4kl1I9afkpELATUQQGRvI8nNQLZADz
 CrUTfHyFQiN/qCS7e/VudcPKgKgvmZQYBJt7XIhkotpwU5Bwh8RfK2VzsqEkdEuypgUgH0RFU
 s2p9C51An+zM6ECrTa3Wm+9UDaCHF6VeeED+mMFgqvAKwqya9VY7EE3CwUdKHPb3jPzVdkS9q
 tqwFjYfzGVbO4LpsncU7y2leIcg3p3M8mSbt66dQvI6M+18/LDJ9/np6dLoNX1gYY8C4iruHA
 1AJGLeOX53SMMhNcebUlI9+RpLRcbgqaMmsWzZojI5vYcmPCunWSPhVvFy7aLAMT/qm3Yly5h
 /9zTgh+jksLDtmVCjnwDraGYX/vzmbTaLz76ookah9xXDvPNdpgif5MdmJKwfXyR2cZ/21oC6
 +YFZami2Dk1nSp5hrXuYw/0TIgv0YvSxX08f0NwDsz5ZQ/Y2VBoX05aaUYBnL8ESNt1o/Lkdp
 YhvIaa8OKihI1RXMII6ezombSwR0FTigfnHL2Z342vY97OfQfh4S3km1yrOsz+/0zt2uppO20
 QRb4/v4R1/WFssq/W2QMZN+W2JINeLjyiCyJLuyqhejWg39x2fku2WD8X36FsktJbjvgamDkx
 P1teGh6GDpJdtqZjxTYI0FBoG4MY1TaQi/Uot1QhX3BHmIpGQaUl9GhAwD71FTZCmQJ2oE790
 FxUfrvNfJ+MzIzfX0pMM83PHDeSCWCLBuoMn3QxA1jyvZ79sVm0WfG1CHaWPQcbkW2Fr60W06
 DVG0Z3O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 1 Dec 2016, Junio C Hamano wrote:

> As to "I have to spawn config", I think it is sensible to start the
> cmd_difftool() wrapper without adding RUN_SETUP to the command table,
> then call git_config_get_bool() to check the configuration only from
> system and per-user files, and then finally either call into
> builtin_difftool() where setup_git_directory() is called, or spawn the
> scripted difftool, as Peff already said.

I just spent a considerable amount of time to figure out that I overlooked
your comment about "only from system and per-user files".

> Your "users opt-in while installing" is not about setting per-repository
> option.

Wow. That would make things really inconsistent.

I know that *I* would want to be able to switch that opt-in feature off
for repositories where I absolutely rely on some rock-solid difftool. And
as a user I would not only be shocked when it would not work as expected,
but I would be *positively* shocked to learn that this is intended, by
design.

Seriously, do you really think it is a good idea to have
git_config_get_value() *ignore* any value in .git/config?

Really?

It caught *me* by surprise, and it definitely makes for a very, very bad
user experience.

And this is much more fundamental than just difftool.useBuiltin.

I see for example that our pager.<cmd> setting is ignoring per-repository
settings. That is, if the user sets pager.<cmd> in ~/.gitconfig and then
tries to override this in a specific repository (which any user would only
do for very good reasons, I am sure), Git would happily ignore that
careful setup and create an angry user.

The only reason this did not blow up in our face yet is that users
apparently do not make use of this feature yet. Which does not make this
behavior (that "git_config_get_value()" happily ignores .git/config) less
broken.

We need to fix this.

Ciao,
Dscho
