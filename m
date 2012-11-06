From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Tue, 06 Nov 2012 08:44:00 +0100
Message-ID: <5098BFC0.6040709@viscovery.net>
References: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com> <5097C190.80406@drmicha.warpmail.net> <CAMPhdO-1ar52QGuSzbyFBSKMf48fDb6Bbxw5u3PCuVYxkO2=3w@mail.gmail.com> <5097CFCB.7090506@drmicha.warpmail.net> <CAMPhdO-Z3E352KbTvnrxJqCecAUGfHCwOoFRUKzObh35uLnrSw@mail.gmail.com> <5098B09B.7060501@viscovery.net> <CAMPhdO_yK02r4c5tTZxFGikmcPiG4G=PMzsPrYOtKCR51Ep0sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 08:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVdpc-0004Zf-9m
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 08:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab2KFHoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 02:44:06 -0500
Received: from so.liwest.at ([212.33.55.23]:49941 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab2KFHoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 02:44:05 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TVdpJ-0002kA-By; Tue, 06 Nov 2012 08:44:01 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2030A1660F;
	Tue,  6 Nov 2012 08:44:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <CAMPhdO_yK02r4c5tTZxFGikmcPiG4G=PMzsPrYOtKCR51Ep0sw@mail.gmail.com>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209101>

Am 11/6/2012 7:56, schrieb Eric Miao:
> On Tue, Nov 6, 2012 at 2:39 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 11/6/2012 1:58, schrieb Eric Miao:
>>> E.g. when we merged a series of patches:
>>>
>>>   [PATCH 00/08]
>>>   [PATCH 01/08]
>>>   ...
>>>   [PATCH 08/08]
>>>
>>> How do we know this whole series after merged when only one of these
>>> commits are known?
>>
>> You can use git name-rev. For example:
>>
>> $ git name-rev 9284bdae3
>> 9284bdae3 remotes/origin/pu~2^2~7
>>
>> This tell you that the series was merged two commits before origin/pu, and
>> then it is the 7th from the tip of the series. Now you can
>>
>> $ git log origin/pu~2^..origin/pu~2^2
>>
>> to see the whole series.
> 
> I'm just curious how this is implemented in git, are we keeping the info
> of the series that's applied in a whole?

If the maintainer did his job well, then everything that you had in [PATCH
01/08] ... [PATCH 08/08] is in the commits of the series, and [PATCH
00/08] (the cover letter) is in the commit that merged the series.

Anything else that I didn't mention but you consider as "the info of the
series"?

> But this still looks like be inferred basing on a branch head, and I'm
> afraid this may not be applicable in every case.

What's the problem? That it's inferred? Or that it needs a branch head?

-- Hannes
