From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] t6030: explicitly test for bisection cleanup
Date: Wed, 8 Jun 2016 04:17:38 -0400
Message-ID: <CAPig+cSVmA0xbs8AFzeOno15=-rsjd_bGGBt_h9ujRp2g+-d0A@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-2-pranit.bauva@gmail.com> <CAPig+cRxGAR8s_Yn7EmCs0zQe2=F7RnhSw+0mtiZOfJtFkD_FQ@mail.gmail.com>
 <CAFZEwPMpa1BHTP5BEqBHpYiab9G32tVXvLTZ95xhVeOcObCCBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 10:17:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYgO-0008JZ-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 10:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151AbcFHIRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 04:17:42 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35555 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018AbcFHIRj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 04:17:39 -0400
Received: by mail-io0-f174.google.com with SMTP id o189so2777077ioe.2
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 01:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FmoLv9tbXlUhNHxpsCkji/aqT+XpU7Thz+JW5o2DvoY=;
        b=0OCQr6p3l+5ldsBaKc3AmvKNGv5v6taEaVbuFDz+LSQp2QCDO6jPbYhYgi16e0NQD7
         1XShpqZyjF3LxyKbnpPt2bfTOISpY0VDgztFlDGX2qBoMyRnrJimnIXGiZiiY/w+oe+R
         Dq/29Kfb7W3xFU12cHbFz3oj9JPYnlJkTOSJ7rK0xT3cZULUkmG6NwcPPaPk3iVOiexz
         d9rZTDB6UMktWCFkjOTu/vSXPWpycClih3V984Hw9n/H7vCshKW7iwn+2/6u5zvDvB9l
         j9YPy3ArNQl1cITwvpfDsz87OvaciTbVS67CV1wPViQn0R86N9So/WTkwk86ah2OjKxH
         fjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FmoLv9tbXlUhNHxpsCkji/aqT+XpU7Thz+JW5o2DvoY=;
        b=UULYsViDr2a51Qfnulo7OB9buKdE2pBYuFJrtVG1h1ZEsnS59RcZcrFvBPD/LBnmwg
         UqG+Am+7F3aQs0lV2H4wwf4q/56IgBXa8MxqDZPrDZSbcKDu23MjoyNegt1CDnoq9yrW
         LHk99fvsk7vWSp6jcPDnBBjiI3UN2O0/r7aEU98CIT1unLBJ5b+gczDbVdReTZUPBIoE
         DloBeAiI4yEOQQ0j1h3Faud1vj2U3pmh+rhuFUYpZkG024hAl5ZLF3W0XlZrxKkZjMmU
         Wnh1TONdeJ2w3CNjjSNY6V3GdRXFiWt67Z0HtrUDejFYhlTi2nFGhH6blJKwFYCuAcTP
         MhsQ==
X-Gm-Message-State: ALyK8tI8P5U4/Q/RPUcF0rmW8F1TM7Q4fFKbMU/vrrlRlrecnt+0nWRtyGkll8HS714wYIU4yZjErA/oV/nOAQ==
X-Received: by 10.107.25.13 with SMTP id 13mr6136149ioz.104.1465373858934;
 Wed, 08 Jun 2016 01:17:38 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 01:17:38 -0700 (PDT)
In-Reply-To: <CAFZEwPMpa1BHTP5BEqBHpYiab9G32tVXvLTZ95xhVeOcObCCBg@mail.gmail.com>
X-Google-Sender-Auth: 9lzzZH-8yfhr9rNJvkSlszwABK8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296769>

On Wed, Jun 8, 2016 at 4:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, Jun 8, 2016 at 4:51 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
>>> @@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
>>> +test_expect_success 'git bisect reset cleans bisection state properly' '
>>> +       git bisect reset &&
>>> +       git bisect start &&
>>> +       git bisect good $HASH1 &&
>>> +       git bisect bad $HASH4 &&
>>> +       git bisect reset &&
>>> +       test -z "$(git for-each-ref "refs/bisect/*")" &&
>>
>> I wonder if this would be more easily read as:
>>
>>     git for-each-ref "refs/bisect/*" >actual &&
>>     test_must_be_empty actual &&
>
> I just tried to imitate what the test t6030 previously had (a lot of
> occurrences). Should I still change it to your specified format?
> Should I also change the others as a side cleanup "while I am at it"?

No, if the 'test -z "$(...)"' is already used heavily in that script,
just stick with it. As for a side cleanup, perhaps if you have time
later on, but don't let it derail your project timeline. It's not that
important.
