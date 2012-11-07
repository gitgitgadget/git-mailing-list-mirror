From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Wed, 7 Nov 2012 09:50:03 +0800
Message-ID: <CAMPhdO-uTUpoQ-NwpvB8tTZc1-29w5fpvvnMoPK18MHhaGjLRA@mail.gmail.com>
References: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com>
 <5097C190.80406@drmicha.warpmail.net> <CAMPhdO-1ar52QGuSzbyFBSKMf48fDb6Bbxw5u3PCuVYxkO2=3w@mail.gmail.com>
 <5097CFCB.7090506@drmicha.warpmail.net> <CAMPhdO-Z3E352KbTvnrxJqCecAUGfHCwOoFRUKzObh35uLnrSw@mail.gmail.com>
 <5098B09B.7060501@viscovery.net> <CAMPhdO_yK02r4c5tTZxFGikmcPiG4G=PMzsPrYOtKCR51Ep0sw@mail.gmail.com>
 <5098BFC0.6040709@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 07 02:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVumt-0008JW-31
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 02:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab2KGBuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 20:50:25 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60065 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab2KGBuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 20:50:25 -0500
Received: by mail-wi0-f172.google.com with SMTP id hq12so4843474wib.1
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 17:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DurjwMoUxpEVBGU3IniJ5imG/phXb6wKBxqRL2cio9g=;
        b=bqDMp2YjB+dxHNSr1cvxNSEMDCQ2L/uZ7GurYFsTq1el1Rny5L8k/QMx6gY5rISQ9V
         xlh1lQCKTCYnHB850rTwgGIl/MQD+JvsHCaW2yupoyrgdO8xeQLc/AVpOdYsucnfS+EO
         uX7HuEkemoYCmzobKKwv6n/9gsIbeyHLd5ta6onOnTrimiFbGwvOTusNysWzrqEyQIBN
         5gDRjSUV+BqZ5YdQKM+Ly9stAHJIV3hAw86gNe5JLdg2JaQfNM1U9UPINz+BFEf0hymf
         Xvr+Yojj8kr+l56bCvI7zvUVG4GAg080oUGwPJlYGi8UzbUNBpToFLvLXopURpDd367a
         kDlQ==
Received: by 10.180.84.102 with SMTP id x6mr5071242wiy.12.1352253023924; Tue,
 06 Nov 2012 17:50:23 -0800 (PST)
Received: by 10.217.54.72 with HTTP; Tue, 6 Nov 2012 17:50:03 -0800 (PST)
In-Reply-To: <5098BFC0.6040709@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209128>

On Tue, Nov 6, 2012 at 3:44 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 11/6/2012 7:56, schrieb Eric Miao:
>> On Tue, Nov 6, 2012 at 2:39 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 11/6/2012 1:58, schrieb Eric Miao:
>>>> E.g. when we merged a series of patches:
>>>>
>>>>   [PATCH 00/08]
>>>>   [PATCH 01/08]
>>>>   ...
>>>>   [PATCH 08/08]
>>>>
>>>> How do we know this whole series after merged when only one of these
>>>> commits are known?
>>>
>>> You can use git name-rev. For example:
>>>
>>> $ git name-rev 9284bdae3
>>> 9284bdae3 remotes/origin/pu~2^2~7
>>>
>>> This tell you that the series was merged two commits before origin/pu, and
>>> then it is the 7th from the tip of the series. Now you can
>>>
>>> $ git log origin/pu~2^..origin/pu~2^2
>>>
>>> to see the whole series.
>>
>> I'm just curious how this is implemented in git, are we keeping the info
>> of the series that's applied in a whole?
>
> If the maintainer did his job well, then everything that you had in [PATCH
> 01/08] ... [PATCH 08/08] is in the commits of the series, and [PATCH
> 00/08] (the cover letter) is in the commit that merged the series.
>
> Anything else that I didn't mention but you consider as "the info of the
> series"?
>
>> But this still looks like be inferred basing on a branch head, and I'm
>> afraid this may not be applicable in every case.
>
> What's the problem? That it's inferred? Or that it needs a branch head?

Take kernel development for example, sub-maintainers not always keep
a patchset in a single branch, instead, there could be a mix of patchset
and single fixing patches on a same branch:

  ---A1---A2---A3---B---C---D---E1---E2---E3---E4---F---G---H---> branch

When we identify a specific patch, e.g. E3, is it possible to figure out
the whole patchset of E<n>?

>
> -- Hannes
