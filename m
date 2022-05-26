Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF70C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbiEZV11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiEZV1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:27:24 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47719D07A
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1653600425;
        bh=//lTQZbm2+jtFWoetDj+ompMHPf5YLZ8NIGSqrozNtE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cs9cEXyjpRktbsUy0F5Q0ZXVvmrWhwaMLtQTvYnXIWBJAqN+CVOVYIt2fSuyi6Yva
         W2pU3zsb8+rEBDmZFkbaU/AhXtRZpVnb9ULOlsQCI3TXi4gUEk84TeMKnPw4zJkjYA
         pxxVThos947Te9suQxRGo+cTGXC2CQqzQnX+kwfA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j1c-1nvyuA3LBq-007h7v; Thu, 26
 May 2022 23:27:04 +0200
Message-ID: <32e5088b-35a1-4e8c-098e-18c465a0a0bb@web.de>
Date:   Thu, 26 May 2022 23:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] rebase.c: state preserve-merges has been removed
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
 <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
 <19baf95d-67d4-d7ed-72a6-96d098171d3a@web.de> <xmqq5ylsxccw.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5ylsxccw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/cSev8i7uFAe43+RufCyodbL+hNsyrUsm9aGrwUgs0VkdTY7Ia+
 9ZDqnliKHdWVOJcYeAoMtuH1q/4KVhmWd2/qG+vqhpjqbCWsyBf+ldb/t5ptzAqQmqYwExm
 NLIdkU2QpppMy3l/MgCFRZeguwvsqD7ClNgoMh0NVTzl2ICGDiIndmkJZNj9upa0cCb+OHB
 Z5nXcLbnZQYb5Poox8gGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OWnWapr2FuI=:xzvLXrchzomHl7CGy541zH
 Z73O70b4nYoCioXWbbXCmsQqocNTPU0bnCnSp1dBCRaoYEymwMDSwaVn1pSZujV3iW4DC3kM8
 s0Hd7E//ct9Y2uTtWpHfTggB8nugS9W6p9pCQGTOq4fMCJrJfy9D/ML+wz3IjN0+ciiixYzCS
 wo/9Gq3G3eodoAiCjKt/6ZYRPh8PKnUFJyW7LujWat/1CpXnHhyifEX/PIYOCl1jE5vMSGgBz
 VDiWLiF1GTY1fuFkDmFU5+1w6PwfVO9Zz8FyCbv5TPmaS4IHwph6o38ptlbFAJi5LLCYAc0o2
 dyb2IOOrYJoYJk5mHrk0J92Uv5CQpw23NLFzX5givrwGCweHVoUehXS33pVeyKuf+q1bdkuHn
 WUgzgOsGnPsSy4RVAAPGhNEiVFFEMD7g9jf0y9BS3sHERh3dIyUsFvpi56/xwYMCOOLnbk4QC
 SsqPdVKUuACJjnwRP6eAgGiLN0a/MLiq/Bv8a0hbJr9s0mN0FF2H5OGMHF+y79RWSEIWZPC1K
 a022GL6/LEVAg9xvOzV8tSfOp2i7R0Na//TF83H2NgYSfl32NqZAaoRyHeoBfa45txLEqERnQ
 bHzpuya6cZHYM0+meZpHUAVS/SmzeQrmxLPwqa0NX/D0l7Q4TVD4XemQHNCZP6hnp/2FiTnzg
 s8rUGSJPG1gRddCZun1qzBKuOetsAA0ipLFAXud0zW73Ec7AhV6lkjnWXea+uo93r5r71feXp
 +VjH2I/m9V7WlVZK/ZRPtfBlR6HpqlL2IioGFtDghnUyHAEccUNmyOMzujtc9VvCYTBoSne7O
 dDei98BD4yYbfO4sR+z7QbN2ll/Xfx7NveOXBNSkTcVoWW/d+xHE0v3WfI8ts6C+rv92aIco9
 mlk3By80PKFzNxAjiCWYLk4JZahTgLXqzyNaXWZMADURmjuleJ0eenx5cIGZqbtHUA15dG8IW
 NJDciXZ3zTif60/i58iB68Zi6su9X4M+S9dZ6tvFH7GSLwiwp6Db96MiwX16DV7pZwuYuI3Om
 d83bDQ1WGtBeoTAQG5Hy0ye9zNHyN2/Fl7jHkTCOi+4fZscn5GtKJmUzDFwoPMZS+ybQdyf+o
 Oiwx2EC1IkZDiPa3ABJErZwvcsCm9Z+nnDV
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.05.22 um 22:33 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>>>  		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
>>>> -			      N_("(DEPRECATED) try to recreate merges instead of "
>>>> +			      N_("(REMOVED) try to recreate merges instead of "
>>>>  				 "ignoring them"),
>>>>  			      1, PARSE_OPT_HIDDEN),
>>>>  		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),

>> Anyway, the new help text explaining what the option once did is a bit
>> confusing.  It would be better to focus on what it's doing now (nothing=
)
>> and/or why we still have it (for backward compatibility), I think.
>
> Do you mean that we should say "this option used to do such and such
> but it is now a no-op" after "(REMOVED)" label, instead of the above
> "this option does such and such"?  I think "(REMOVED)" is a strong
> enough hint that lets us get away without saying "used to" and "but
> it is now a no-op", so I can accept both.
>
> Or do you mean we should say "(REMOVED) for backward compatibility,
> does nothing but errors out"?  I would be less in faviour, then.
> Those who are curious enough to ask --help-all would find it more
> helpful if we said what it used to do.  Otherwise they wouldn't be
> asking --help-all in the first place, no?

When I see an option labeled "REMOVED" then I get confused because a
thing that says it no longer exists is obviously lying -- a removed
option would simply not be listed.  Here the feature is gone and its
option remains, but only reports an educational message now.

Perhaps a better option help text would be something like "no longer
supported, consider using --rebase-merges instead"?

Ren=C3=A9
