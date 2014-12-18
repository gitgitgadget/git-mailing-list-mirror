From: Stefan Beller <sbeller@google.com>
Subject: Re: Introducing a test_create_repo_bare (was Re: [PATCHv2 6/6]
 t5543-atomic-push.sh: add basic tests for atomic pushes)
Date: Wed, 17 Dec 2014 16:14:27 -0800
Message-ID: <CAGZ79kYiYiErT-fuiQLCW_0zByiJJt_pfJ5RGUiFAP4jgxLuVA@mail.gmail.com>
References: <CAGZ79kY=TP31VJxPZnjb04og-vHU+-c4d+AgAkis2Q7yeDeXbg@mail.gmail.com>
	<xmqq61d996oc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 01:14:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1Oji-0008UO-3v
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 01:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbaLRAO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 19:14:29 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:64589 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbaLRAO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 19:14:28 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so38891igb.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 16:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/qO5fyVtCIVSzJgM/Rkt+nUM4x1EbQfW2cRVFE4bjqM=;
        b=Tl/wKI3ASDVi2586aZgLkTgAXtWM8zsrAukstgGjgvEyZ+QTHL4iL3aHbmLB06YE9A
         d8f13Hwffh9P/eY4PD/vjOUW1OXpQcgseK86hzwLxs1y/25oFmhqJ29gMs5pTbkrnjOe
         ogVULtleNiNG4RDWDoJz8IfGvstxKrzLf21rIyL/I4E+f4QmjcFtK+ZhXk+WOcEyVmSp
         mmP3EMkLzS4gi1e199WbwLbj1LaYeThLzcStoY8LICMOEICNExC7tzytOdKiUrKxr4fy
         TwUHjffJFdEeAG5x0YVJRUqHNM7cOB+y9unZtWHrNSPPW2JcTnOCGg8ig/UfmUCM09Nz
         vHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/qO5fyVtCIVSzJgM/Rkt+nUM4x1EbQfW2cRVFE4bjqM=;
        b=SAw+ryW56KfSbU/LUoeMaY+a6aKHwplDz/vtb7QJLAJ5TrhkVVgZ1Ikq7GB8FFt5y/
         6v1zzqKDrKhgtGs1BNQ8OVu/WYZ7s+2Wh+xhgBg7/jPeebei36n5AoJmJo0UQohfa45M
         prHLok2iFbtdomJAeRy40nFEj2wTELSrjJ+lWm+lsJCf4vbYtu16xr8EB7Ps1uHfqnUK
         QJ7p3ox99cNE3V/Gp+yj5ciQbHGWi7XBfwPa8o8UF9pe+s4IiOCmlz9yTo1tYJfzNucs
         UYPmYAXCHnCzKJF4tL+9Qoit2qFAxKNzVur19U+Agtak8t8uLTIfoVJusvCmH2deSisG
         Eikw==
X-Gm-Message-State: ALoCoQm7wJwEwVXUNHj2g2ufoEppzUElp2UGHfEuEIyXCDnNrvcH4hL+ZGruHebo3NXXYQGmoPIi
X-Received: by 10.50.107.36 with SMTP id gz4mr11095097igb.25.1418861667878;
 Wed, 17 Dec 2014 16:14:27 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Wed, 17 Dec 2014 16:14:27 -0800 (PST)
In-Reply-To: <xmqq61d996oc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261511>

On Wed, Dec 17, 2014 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Dec 16, 2014 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>>> +     (
>>>> +             cd upstream && git config receive.denyCurrentBranch warn
>>>> +     ) &&
>>>
>>> I was wondering how you would do this part after suggesting use of
>>> test_create_repo, knowing very well that one of them was a bare one
>>> ;-).
>>>
>>> We might want to extend test_create_repo to allow creating a bare
>>> repository, but this is also OK.
>>
>> So I searching through all the tests, where it would make sense to do that.
>> I searched for "denyCurrentBranch" and came up with this list where I think
>> it makes sense to replace (git init | test_create_repo | or alike) by a
>> test_create_repo_bare or add the --bare option to test_create_repo
>>
>> places where test_create_repo_bare is easily introducable:
>> t5517-push-mirror.sh # setup an upstream repo
>> t5543-atomic-push.sh # setup an upstream repo
>> t5701-clone-local.sh # Test  'clone empty repository'
>>
>> not as easy:
>> t5400-send-pack.sh # we commit to that repo while being inside
>> t5405-send-pack-rewind.sh # we commit to that repo while being inside
>> t5516-fetch-push.sh # we test the various denyCurrentBranch options
>>
>> unsure:
>> t5522-pull-symlink.sh # just cloning the repo
>>
>> So I think we don't need the test_create_repo_bare yet.
>
> Thanks for digging.
>
> We already knew we do not *NEED* it.  We have been surviving without
> one.
>
> You need to remember that adding and using a new helper is *NOT* the
> ultimate goal; categorizing those that do not want bare repositories
> as "not as easy" is misguided.  They truly do not want bare, so they
> are not our target audience in the first place.  For the same reason,
> "easily introduceable" is not a good criteria to look for.
>
> The issue is if some existing tests will be helped, if we had such a
> helper.  That is, do we "git init --bare" by hand in some test?  Are
> these tests in such a hand-crafted repositories more susceptible to
> future breakages because they do not use the template from the built
> location or they do not disable hooks?  If we had such tests, then
> they would benefit by having a "bare" mode of test_create_repo.
>
>

You're right, I was looking at the wrong criteria. There are rougly 125
" --bare" outside outside of the t0001-init.sh and t5601-clone.sh
which are not relying on the template nor the $GIT_EXEC_PATH/git-init

The occurrences outside these two tests are mostly init and clone with --bare
although we also have a few "git --bare foo" commands to operate on
the bare repos.

Looking at it the other way round it seems to be more work to fix it. :/
