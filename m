From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Tue, 6 Nov 2012 14:56:06 +0800
Message-ID: <CAMPhdO_yK02r4c5tTZxFGikmcPiG4G=PMzsPrYOtKCR51Ep0sw@mail.gmail.com>
References: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com>
 <5097C190.80406@drmicha.warpmail.net> <CAMPhdO-1ar52QGuSzbyFBSKMf48fDb6Bbxw5u3PCuVYxkO2=3w@mail.gmail.com>
 <5097CFCB.7090506@drmicha.warpmail.net> <CAMPhdO-Z3E352KbTvnrxJqCecAUGfHCwOoFRUKzObh35uLnrSw@mail.gmail.com>
 <5098B09B.7060501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 06 07:56:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVd5X-000239-A4
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 07:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab2KFG43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 01:56:29 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45109 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab2KFG42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 01:56:28 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so133399lbo.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 22:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4S7siWV0n/SL39x+byswWeytuaiFzZLE6OeMuTNrBYg=;
        b=Z4U2uHbR/WtjvSAQ0rI+YWoKBnAnVfOyJrQ+gZIxNyIKO014fy3p9Mux1OKl/u6HhX
         qoAEVfR/mCw99gZaP12IUxG8lL8u2//962Cmgd7kR2hr+LilmseKmNBPlWV6IMQ30/ie
         oU7uElljuCrncRobxl3jL10cv1Gkj5w3IbOsXq1uKZmZO/1uRBMRPxMKEYNH/gOOGLgT
         EHnSivvOEo4vtB4D9soMm+DwSzO0mwFYqGzDXqRv2BQFTmZNAJocncWg8Mpvj/reYs93
         ILyYZoZPKVra1lEm9KBXak8gVPP96lWuoNXCDTMR+zNHSGkFFpN+ol7WydOvjKUBNJcK
         WPzw==
Received: by 10.112.30.227 with SMTP id v3mr97871lbh.65.1352184986945; Mon, 05
 Nov 2012 22:56:26 -0800 (PST)
Received: by 10.114.75.1 with HTTP; Mon, 5 Nov 2012 22:56:06 -0800 (PST)
In-Reply-To: <5098B09B.7060501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209099>

On Tue, Nov 6, 2012 at 2:39 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 11/6/2012 1:58, schrieb Eric Miao:
>> On Mon, Nov 5, 2012 at 10:40 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Eric Miao venit, vidit, dixit 05.11.2012 15:12:
>>>> The problem is, most cases we have no idea of the base rev1, and commit rev2
>>>> which it's leading up to. E.g. for a single patch which is between
>>>> commit rev1..rev2,
>>>> how do we find out rev1 and rev2.
>>
>> E.g. when we merged a series of patches:
>>
>>   [PATCH 00/08]
>>   [PATCH 01/08]
>>   ...
>>   [PATCH 08/08]
>>
>> How do we know this whole series after merged when only one of these
>> commits are known?
>
> You can use git name-rev. For example:
>
> $ git name-rev 9284bdae3
> 9284bdae3 remotes/origin/pu~2^2~7
>
> This tell you that the series was merged two commits before origin/pu, and
> then it is the 7th from the tip of the series. Now you can
>
> $ git log origin/pu~2^..origin/pu~2^2
>
> to see the whole series.

I'm just curious how this is implemented in git, are we keeping the info
of the series that's applied in a whole?

But this still looks like be inferred basing on a branch head, and I'm
afraid this may not be applicable in every case.

>
> -- Hannes
