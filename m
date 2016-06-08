From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/4] t6030: explicitly test for bisection cleanup
Date: Wed, 8 Jun 2016 15:50:16 +0530
Message-ID: <CAFZEwPM7ir+HnsG_L8M0PauSSxBJe8HvAmVYHthXEKAxmpA26Q@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-2-pranit.bauva@gmail.com> <CAPig+cRxGAR8s_Yn7EmCs0zQe2=F7RnhSw+0mtiZOfJtFkD_FQ@mail.gmail.com>
 <CAFZEwPMpa1BHTP5BEqBHpYiab9G32tVXvLTZ95xhVeOcObCCBg@mail.gmail.com> <CAPig+cSVmA0xbs8AFzeOno15=-rsjd_bGGBt_h9ujRp2g+-d0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 12:20:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAab8-0002gL-K0
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 12:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424695AbcFHKUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 06:20:23 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35850 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423317AbcFHKUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 06:20:18 -0400
Received: by mail-yw0-f179.google.com with SMTP id x189so2894809ywe.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p8e/d/g5qfEqdaJuRjaJcF3YLpRP79+i1LANXo1WunM=;
        b=i0wRw8q/DIEBGzAn8MKs4hl48qNOrKwHmwAgQxQ0NOQ6XSEJhFddtAtsKqmpMcH2hG
         z+ZCVGn9ex7iI/n9QMOe+R0a6M4tTpH2vtUsMeG1DNWUAM5YhmC3iYEiWOGhAlJkA+6X
         cT+l2+Zw+HAJg4qVkGepM0PSXpyGpbnHkW0EhChABDJKXmabS6o9J2FhZMuLl0DKK6v2
         kkw7cQhDcoALV0+mLzS1zq+xCHb1Gu7LaimuSK0mmILAJ+A/sRplRxZMM0jhGaGiq9K0
         C79wsF+jMpXMK81SsTbKRxQrC+KybBF+1APj4FDX48tWNEG1QcBoihWh1GlwevhALt6Z
         1E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p8e/d/g5qfEqdaJuRjaJcF3YLpRP79+i1LANXo1WunM=;
        b=eleaG5ySmO+Dvs3XgitKBqKt4S6Tdt7aAt6IlzMaKS6Cr9Q05dO89uh/5I5cRUCCnY
         pXWXmJgr3Eyy0eS3ER7jjENDJgogVqRXp4u4Lz+55npncUCR6L+JHFCbZ9aO3VY4QudJ
         xo8+mVDPOG6iOuO76TrojIqiDre2xG3J2x8c/ALoeO5buyc9jjg78xMQpuPNXvMQsLxf
         SPoVdYmH6LQItj71OUpoVf7vPdcjJsoFA4wnQPLwNIaNrvf9SGIhaF1mIDmGwv3t7BqH
         /mqv7QFyELQiwBoS42+I7Pef6W1IyTgxMq8lqsfpZ8NiJ/Or9VwoZa6cA4l4prZrwBvC
         6kMg==
X-Gm-Message-State: ALyK8tIhiFcY1CLo49wDr5XGVFOiBLJLFLbAMnbG/SSq/SFKxAfWRYRsbgeu0GZQMbrNFb/TSM7Wc7UuZHwP5g==
X-Received: by 10.37.114.9 with SMTP id n9mr2161571ybc.80.1465381217073; Wed,
 08 Jun 2016 03:20:17 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Wed, 8 Jun 2016 03:20:16 -0700 (PDT)
In-Reply-To: <CAPig+cSVmA0xbs8AFzeOno15=-rsjd_bGGBt_h9ujRp2g+-d0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296781>

Hey Eric,

On Wed, Jun 8, 2016 at 1:47 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 8, 2016 at 4:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Wed, Jun 8, 2016 at 4:51 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
>>>> @@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
>>>> +test_expect_success 'git bisect reset cleans bisection state properly' '
>>>> +       git bisect reset &&
>>>> +       git bisect start &&
>>>> +       git bisect good $HASH1 &&
>>>> +       git bisect bad $HASH4 &&
>>>> +       git bisect reset &&
>>>> +       test -z "$(git for-each-ref "refs/bisect/*")" &&
>>>
>>> I wonder if this would be more easily read as:
>>>
>>>     git for-each-ref "refs/bisect/*" >actual &&
>>>     test_must_be_empty actual &&
>>
>> I just tried to imitate what the test t6030 previously had (a lot of
>> occurrences). Should I still change it to your specified format?
>> Should I also change the others as a side cleanup "while I am at it"?
>
> No, if the 'test -z "$(...)"' is already used heavily in that script,
> just stick with it. As for a side cleanup, perhaps if you have time
> later on, but don't let it derail your project timeline. It's not that
> important.

Sure! I can mark it as "to be cleaned up after GSoC"

Regards,
Pranit Bauva
