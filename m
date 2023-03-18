Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B65C74A5B
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 21:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCRVal (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 17:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRVak (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 17:30:40 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CC5211DC
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1679175025; i=l.s.r@web.de;
        bh=0JBadRETp0f2PdANyT2QV2l1FQoMvC5G0Xk9YAVzqGk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NzJCEb7p7AUYeKhqilRpdS6376WwZHY889BCYuOxHrkMshlNHL9p7wN2Og5psyOAW
         7VOnTgsxKpGd3zldEqElGT2s7dWgUVyr+QiQwzfD+1ivp8fjNpzI0Sk9Gbepk0hGHc
         opx12SXHPAgSQMWqvcvF5/9DqGXeMLxCjaBWYynkHoAGzyENJyX9KLHEcwO+5Snm0D
         TUazE8v5k402bQg/KFMHZLqbkQ0X4lrreHY9pqPw2dycz9JN0Ap1HfGBQlvTiv/RCF
         qs2+XEYqSs2mpiY3ZUCvBFram02VFHE7GLkGorhrxdLChriIt09aW+CciaGuc6d3lh
         4IG6Ni8nDnitQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.43]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mx0Mr-1qSBTu2wvr-00yLdP; Sat, 18
 Mar 2023 22:30:25 +0100
Message-ID: <9e215e5c-0b67-0362-fd53-8c22b8d348ff@web.de>
Date:   Sat, 18 Mar 2023 22:30:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Bug in git archive + .gitattributes + relative path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org,
        =?UTF-8?Q?Matthias_G=c3=b6rgens?= <matthias.goergens@gmail.com>
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
 <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
 <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
 <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de> <xmqqcz5lbxiq.fsf@gitster.g>
 <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de> <xmqqo7p59049.fsf@gitster.g>
 <3da35216-ca42-9759-d4f9-20451a44c231@web.de> <xmqq4jqx8q6q.fsf@gitster.g>
 <f7949f1b-4bad-e1bf-4754-f8b79e3ce279@web.de> <xmqqjzzly84q.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqjzzly84q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ey+yu52gcpERtuk3xgMu+YSfj37ExN1aYFvVslD0ClGV7uyxJzY
 Ckq3GXrzWSXUfHh9N7SgJ7MXDpqQNY5Xd+VpoDwFYvqBAJps8imyOZirQ1ksOU6vS4g1WCL
 uWEIRREu7vPh1+6AqZkMK8hdL3hzz47ghyTWrnvGV0pS6sokyUSmNekRs1sGuPolFCAvmS8
 QRHVf1RU/K1eV7kGV0dIA==
UI-OutboundReport: notjunk:1;M01:P0:7pf/5LuuX6I=;nA3iR8gldHlhbhVKxuDb+K5yjc5
 ceA4px5UXfpr9YS3LVrxlEufFiHctCPazRuzg3qBioSu2NQWhEDx7aXCDCc3Eh+O9ubg9+IC5
 DxHhmO2+x5c+g35wGeb/8FH6Lo0/tIV/G64MVJsMErLABLk9WQLAzWBL2Y5JLDZQcRbA2qhU1
 Tjf9lT3NQJTBoF7tHqV45l1c6P7d1jRVQ8FSYJDJRNraV3SOsVutryol6GH7YmuMKWCtHvW4K
 PpClCJbeYSB0zLwGxPgmmRnSQxMyHmaRqcMIQNg3ZrVgo90LhBWNun2EMpiJ/kcion2Dmiikb
 hMdHBJLeT+sf/yjoBOtvrrE0NRmjVYOVsCEzQ0E4WC3ChjWTykPWNnEzBUNPgJeNecPpRlu65
 URY0/HeN2fmj4uTIF8RsPrnBSu95TPZVG32+pzDvjyue7oCvtYBBkASh2PThA18dnXSbEYpu6
 vc8Unq2/t8INvz9DzJWhRg/mwG2f8kMeOE8Aj0n2qC5LAsDmnlCiVA/sDokt0rwap3zGx70uE
 od40U6XZDUgaSySmrWPgHD5A/87A5ID76HGz0MkfI3hnc1T7MwEChsswuwFLWnsjHqlCUsGqw
 I9X+y/bFkNPpw6/vMKEoyAo4lIsQ4P8ryjpar7MPp2R5YQ1Utw7zklFk4fJiU87WVbVThZyFt
 aCVeQs8IOxMfv74SWwJvv600lT2ZmHRI8yLOMfCCURKYEocwbYvKFRvOm7c5FdgbDAK8vc+r0
 l0pbnE9QDwhM6jVY76U+LX0Zv9xO10AIBnYVkP50E1iFVqUUrZPXTjQKFG+5z8VD/2DmMBZmE
 wGiUBrvVVZt5584VmMTgMWxRqFTSLTZm+QHYHiNFiXNKpcr3stNRd6cylc2EwzgBsoSZ6ii6U
 DsiH58jyXqR4r5RuQEjNPPvu3U10XV1XybKPCoHeZg0TJzrF1K46eH6b/6Va2L886OGO7SMHO
 yt66QeuQHLNG6X0jQKJa3HHhlZw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.03.23 um 22:25 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>>  * fail loudly when "git -C sub archive <pathspec>" makes us use
>>>    "../" prefix because <pathspec> goes above the $PWD for backward
>>>    compatibility and sanity.
>>
>> Without the patch this fails, but are there really people that depend o=
n
>> it failing?  We could certainly forbid it, but do we need to?
>
> I dunno.  It was an obvious way to avoid having to think about
> interaction with --strip-components and "../", but there certainly
> may be other solutions for it people can think of.
>
> Also on the receiving end, don't people get upset to see that their
> "tar xf" escapes the directory they just created only to extract the
> tarball?

bsdtar creates entries starting with "../" without complaint, but
refuses to extract them as-is -- you need to e.g. use --strip-components
to get rid of those dots.  Awkward.

Not allowing those entries to be created is more consistent, especially
since we're already restrictive like that.  OK.

>>>  * with --some-option, make "git -C sub archive --some-option :/"
>>>    act exactly like "git archive :/".
>>
>> Perhaps I'm reading this too literally, but it would be easier to remov=
e
>> "-C sub" from that command. Or to add "-C $(git rev-parse --show-cdup)"=
.
>> We could add a shortcut for that (see patch below).
>
> More like
>
> 	$ cd some/deep/place
> 	... work work work
> 	$ git archive --full-tree :/other :/hier :/archy
>
> is what I had in mind.  Without --full-tree, due to the first bullet
> point above, paths in our archive are relative to some/deep/place.

I don't see the difference.  Here ":/other" is the youngest commit with
"other" in its message, ":/hier" and ":/archy" are pathspecs selecting
subdirectories.  If we stay in a different subdirectory then this is
simply currently forbidden and we'd keep it like that:

   $ cd xdiff
   $ git archive :/needle :/t/t0019 :/t/t4020 | tar tf -
   fatal: pathspec ':/t/t0019' did not match any files

We'd just improve the message a bit.  Going up still helps:

   $ git -C "$(git rev-parse --show-cdup)" archive :/needle :/t/t0019 :/t/=
t4020 | tar tf -
   t/
   t/t0019/
   t/t0019/parse_json.perl
   t/t4020/
   t/t4020/diff.NUL

   # We could shorten that.
   $ ../git --cdup archive :/needle :/t/t0019 :/t/t4020 | tar tf -
   t/
   t/t0019/
   t/t0019/parse_json.perl
   t/t4020/
   t/t4020/diff.NUL

Or am I missing something here?

Ren=C3=A9
