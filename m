Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC5320A40
	for <e@80x24.org>; Sat,  2 Dec 2017 21:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbdLBV1W (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 16:27:22 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:46572 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbdLBV1V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 16:27:21 -0500
Received: by mail-wm0-f50.google.com with SMTP id r78so8899089wme.5
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 13:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fjcqqM6sy3uTxVxlCaymHri3y8pqLwVB7NBfJqb6fIs=;
        b=aArXLYnhCChTsCo4duCwYvi7WQ26xa6zaAisuE94JPAGJ3Q+dvMRR3n/suHinLRpPj
         kmabb/Vqn8+22gL8MAMGbEdFY0VQC+IHbzaIoSVuxGrwcIs48fMcEa/I3pSx0eho4DRs
         IbZ/VsWNXG4BB5g08Nexb3OGFcTo9I+hb1IqbFzUXdhKWSwajghBRUptq5JYl6bxhU6T
         aYAxPtYp+aIjvNVwQ/91z/okX/dkeu/RHpm5wd9Q/K+pyIXgN9d1BdGS+k/IeCKDL+a7
         pdqrRJ84j8K6TKcrElSInLlf2lNFn2QbOyxHVk16B5S6VnOFSPkV5scOVDqfgszEroCE
         2RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fjcqqM6sy3uTxVxlCaymHri3y8pqLwVB7NBfJqb6fIs=;
        b=dhJV8fG7wwt6gOGMwQtfbtMcd+tPeFTeHuIGUwGmvZa5Idu7PiaQ0h7MF2sl4x9V8F
         spSJH/J+2sp4napEaMOOSVTFzKci5frIbDVBC/CpkDyXksigO/NoCXztHG6uTuMSZYUq
         jJ4Zdn28nW5Yi1O/J4aIjn0FwyWdufH/8H0vedX6PLl7dwBXneInfdP7z8FpMr/Zz/Qk
         SvsFCRPDEEhQqH0MXXPX1aFLOAaFRJtjc0N8MtbE0Hps3R9i3FbXyI2oPxGeCBzcV/9U
         4Ds29Iu/1ofLwZiGNY3WNlAvbRunRY7YUXhiVWUxPi4uyJvbrrcCDU5aJZXE921JTI9F
         NdeA==
X-Gm-Message-State: AKGB3mL+EmdUQYf+6WK1CfLeB/+6wt7OfhSt+0ogUq/Nkr7ihkEDoTXl
        8DexF5DwaMvZUIShIb9vptLfrtNOMnCRblJDa3Y=
X-Google-Smtp-Source: AGs4zMZ0HJJAQx9dDKA8gCHCdYlWuqf87FEzR0GTH/jXQMVb8U+xhURmbLxxTVi79eAiaEphdyVXzKQJjVNGRKxFDGw=
X-Received: by 10.28.107.211 with SMTP id a80mr3827574wmi.71.1512250039633;
 Sat, 02 Dec 2017 13:27:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.151.203 with HTTP; Sat, 2 Dec 2017 13:26:59 -0800 (PST)
In-Reply-To: <CACBZZX4SM45hgA=PW0MEP9Ea0OG_8OTb5U7JCOX7xnd=hT5n3A@mail.gmail.com>
References: <201711231458.vANEwUMK048049@elephants.elehost.com>
 <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com> <CAPkN8xJBWRs-2DxViBACLKzAbD1_EBA2MvmWVZmWgL+Sg72znw@mail.gmail.com>
 <CACBZZX4SM45hgA=PW0MEP9Ea0OG_8OTb5U7JCOX7xnd=hT5n3A@mail.gmail.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Sun, 3 Dec 2017 00:26:59 +0300
Message-ID: <CAPkN8xKDQrf+LMpj9GHw9n_crJ1UUwq7Zek+Z1dgQ0n2Jz5U6g@mail.gmail.com>
Subject: Re: Re: Unify annotated and non-annotated tags
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 24, 2017 at 1:24 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Nov 24, 2017 at 10:52 AM, anatoly techtonik <techtonik@gmail.com>=
 wrote:
>> On Thu, Nov 23, 2017 at 6:08 PM, Randall S. Becker
>> <rsbecker@nexbridge.com> wrote:
>>> On 2017-11-23 02:31 (GMT-05:00) anatoly techtonik wrote
>>>>Subject: Re: Unify annotated and non-annotated tags
>>>>On Sat, Nov 11, 2017 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>>>> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>>>>>
>>>>>> If you would like to mimic output of "git show-ref", repeating
>>>>>> commits for each tag pointing to it and showing full tag name as
>>>>>> well, you could do something like this, for example:
>>>>>>
>>>>>>       for tag in $(git for-each-ref --format=3D"%(refname)" refs/tag=
s)
>>>>>>       do
>>>>>>               printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
>>>>>>       done
>>>>>>
>>>>>>
>>>>>> Hope that helps a bit.
>>>>>
>>>>> If you use for-each-ref's --format option, you could do something
>>>>> like (pardon a long line):
>>>>>
>>>>> git for-each-ref --format=3D'%(if)%(*objectname)%(then)%(*objectname)=
%(else)%(objectname)%(end) %(refname)' refs/tags
>>>>>
>>>>> without any loop, I would think.
>>>>Thanks. That helps.
>>>>So my proposal is to get rid of non-annotated tags, so to get all
>>>>tags with commits that they point to, one would use:
>>>>git for-each-ref --format=3D'%(*objectname) %(refname)' refs/tags>
>>>>For so-called non-annotated tags just leave the message empty.
>>>>I don't see why anyone would need non-annotated tags though.
>>>
>>> I have seen non-annotated tags used in automations (not necessarily wel=
l written ones) that create tags as a record of automation activity. I am n=
ot sure we should be writing off the concept of unannotated tags entirely. =
This may cause breakage based on existing expectations of how tags work at =
present. My take is that tags should include whodunnit, even if it's just t=
he version of the automation being used, but I don't always get to have my =
wishes fulfilled. In essence, whatever behaviour a non-annotated tag has no=
w may need to be emulated in future even if reconciliation happens. An opti=
on to preserve empty tag compatibility with pre-2.16 behaviour, perhaps? Sa=
dly, I cannot supply examples of this usage based on a human memory page-fa=
ult and NDAs.
>>
>> Are there any windows for backward compatibility breaks, or git is
>> doomed to preserve it forever?
>> Automation without support won't survive for long, and people who rely
>> on that, like Chromium team, usually hard set the version used.
>
> Git is not doomed to preserve anything forever. We've gradually broken
> backwards compatibility for a few core things like these.
>
> However, just as a bystander reading this thread I haven't seen any
> compelling reason for why these should be removed. You initially had
> questions about how to extract info about them, which you got answers
> to.
>
> So what reasons remain for why they need to be removed?

To reduce complexity and prior knowledge when dealing with Git tags.

For example, http://readthedocs.io/ site contains a lot of broken
"Edit on GitHub" links, for example - http://git-memo.readthedocs.io/en/sta=
ble/

And it appeared that the reason for that is discrepancy between git
annotated and non-annotated tags. The pull request that fixes the issue
after it was researched and understood is simple
https://github.com/rtfd/readthedocs.org/pull/3302

However, while looking through linked issues and PRs, one can try to
imagine how many days it took for people to come up with the solution,
which came from this thread.
--=20
anatoly t.
