Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF7C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjC1R4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjC1R4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:56:10 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F005EE193
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1680026161; i=l.s.r@web.de;
        bh=OGrsFFHLMLlSs6yJZMRhqMXFtk3sIPhkKCw2c1O4dAA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Zd2vfVSGItgxKiXHpIGjMJw9WVjnG6r8XvkjioQ8S7xCyeGioxAR8SUS0bHSs6u7P
         l27+/3JzMpded8sfL7PKaHMMR9v7v1fWFD3+RztwRjNJVK8+0h1gSaqrAZQIaP0ux+
         gZI2/Y29HR0GQqV4kcMxYuRVWXM0h72zn2abL15fSJxOetthjyf+ZWSVOCDEzoFrr7
         i1K5VuqqrdWaCzv8V/OVEWEm4Uv8MlJelKjIWWi0sOl6/zyfN0A27cydgwRMUtbz/T
         GPdc4+60Or3Gwer0w1G+5fNG2QeFMPhHelFfXy4OXGrijeaD3zba0cXerxsEQWPUAY
         8/aay+kFBe7pw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.43]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MaHSp-1pvIZw3Bcj-00W4L4; Tue, 28
 Mar 2023 19:56:01 +0200
Message-ID: <4e03ea47-b0aa-d69e-6c54-fcbadb3b0641@web.de>
Date:   Tue, 28 Mar 2023 19:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mario Grgic <mario_grgic@hotmail.com>,
        demerphq <demerphq@gmail.com>, git@vger.kernel.org
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <CANgJU+Vn8ZLGcAYbuDeNkv6T5YdX6t20BqGQDPB0VL_TzoGSWg@mail.gmail.com>
 <MW4PR20MB5517888E63C13099E284B97590859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <eba23dc4-c036-fd1b-a1f0-028e8fff602b@web.de> <xmqqh6u6cg4l.fsf@gitster.g>
 <03fd7ddb-8241-1a0a-3e82-d8083e4ce0f7@web.de> <xmqqjzz1nalp.fsf@gitster.g>
 <xmqqsfdpj8ci.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqsfdpj8ci.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5xch1pB5ntA4es4MbNHnW+oSi5sHFl/UzydaeeCeoWjp8EwTm1O
 qQo1IPIdwojxqeSwd91rGjB4m37VysNi0WrwB3UtIWL43cX69IOj1p+B3iTHlDMlw91R9cU
 mx/B3tBslvgBKeoaTC27RG3TP9GkXwBrvtBqIK0nsVeBq+VjGtTyVGFWMfKHgNkMDXewkO0
 0d9U3MzlgmIEGcLuw/wxQ==
UI-OutboundReport: notjunk:1;M01:P0:b4NSaw2R/Rg=;CVYl0AkOvnKmWC3TowAOr2+Ieru
 od3GeSJglfHBiKrBUNEAi3pvvr+z/cb6NvkISj85UWoSoMddY3oZxkDxuOIl3KHZ4njQ46x3X
 jOkGPzx9njehHEVzTh1CBiJtAl8fvOuqsAQY7jMc3tBZhwEyUCUmgf1JL5vhZTqrYrTK39aC6
 XOVtf89xkGukmhjmF31ngW5Wek86mR6HrpLFTH8zG5HaThDgtp+u9/6miRPXi4OiDxWRrVZNh
 BQPMNcisQBICRtm44zcu4bMArP5yT+ZaA1yfrqTq6UPKgKkw+2e4pDWw7/MbyarOw6e0gb2Mf
 L/5Gnp45wfe7vwsE+4z3ykrYNW7o1QtuQ1s2fFtc1iIbpCXu8AnnQtIII9hHe+YNM1OdPq8C+
 Naetm+t2RPGh99xX0oG/9ZUvXHk2Vlj1w6p0hKX75TWuRfflKMTZF444MV/o7o3+mov5tBrJD
 9v856zyvuum8XyaXf70ggyZSy8PqNF1IQ2FR6baYrrPKud2AQ014LAxpdo/49fX1aGN3XOlPw
 9UVhBH8M19WDTGlQeUYVH8txVVFZX2AmORfxACEDh69TLxuteLuSQ3Dftkp6f4mPPRFwTHcvA
 bkTWayFVWRh8HdX+nfP8aBrvFjs+Ug+kVHSg15JisEnazmiCUr4lm6ubfbkb2aq0niRIo/2mF
 /S2oh1sa9MHXlp6/pTd95mFvAJIhPZNGlC9Rf47LF/Bq+1TuXaUGtZVmof3WlrBp6nCRlWGc2
 tnozBW64YNvMyltBonHhfmeYMV3wXsF/N5beRY9khTrhmzgw9frO0/eg8XiJ0Ibtph2Ck+Lr4
 69wuhsOIC5ZqingEGsTRTQx9t4D6NeTzHR6aANm2s8+8vG3m2U//skJ14JxpZkTfqFoTX0rj9
 tOlo61lFxEydWmxZrsnDkJV6aDjpZebU07cqgiS9tbKs3haBn/BeZp4UePXneMq6NL1GBQv8Z
 qxoD2w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.03.23 um 15:47 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I suspect that 54463d32ef was done in a conservative way to avoid
>> unintended side effects to make ERE "enhanced".  I am not 100%
>> certain, but after reading the documentation you pointed at, I do
>> not see a valid expression without ENHANCED flag starting to mean
>> totally different thing with it (well, an extra '?' turning a
>> pattern from greedy to minimal may count as such a change in
>> semantics, but I do not see anybody sensible adding an extra '?'
>> in a pattern in the first place).
>
> Sorry, but that is nonsense.  We cannot avoid being backward
> incompatible if we suddenly flip the "enhanced" bit for BRE.  A
> sane pattern written expecting non-enhanced BRE can change its
> meaning when the "enhanced" mode is enabled.

Right, and there are even more enhancements for ERE, i.e. more
incompatibilities.  Not sure how big of a problem that actually would
be, though.

> But if "enhanced" is what users want, and if that is what the other
> tools on the platform use, then perhaps flipping the "enhanced" bit
> may not be a bad idea.

Apple's grep(1) uses it, with and without -E:

https://github.com/apple-oss-distributions/text_cmds/search?q=3DREG_ENHANC=
ED

E.g. awk(1) and sed(1) don't, AFAICS.

Ren=C3=A9
