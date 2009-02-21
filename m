From: walt <w41ter@gmail.com>
Subject: Re: Is this a git-bisect bug?
Date: Sat, 21 Feb 2009 12:56:20 -0800
Message-ID: <gnppph$r8r$1@ger.gmane.org>
References: <gnpccl$l69$1@ger.gmane.org> <87skm7em72.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 21:58:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Layvg-0007gZ-74
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 21:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbZBUU43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 15:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753182AbZBUU43
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 15:56:29 -0500
Received: from main.gmane.org ([80.91.229.2]:52489 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbZBUU42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 15:56:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Laytf-00049L-1q
	for git@vger.kernel.org; Sat, 21 Feb 2009 20:56:27 +0000
Received: from adsl-69-234-201-18.dsl.irvnca.pacbell.net ([69.234.201.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 20:56:27 +0000
Received: from w41ter by adsl-69-234-201-18.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 20:56:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-201-18.dsl.irvnca.pacbell.net
User-Agent: Thunderbird/3.0a2pre (X11; 2009022105)
In-Reply-To: <87skm7em72.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110981>

Teemu Likonen wrote:
> On 2009-02-21 09:07 (-0800), walt wrote:
>
>> I'm using the current git.git to bisect a bug in Linus.git.
>>
>> I got this far and then ran into trouble:
>> good 2.6.29-rc5-00094-gc951aa6
>> bad  2.6.29-rc5-00112-g3501033
>>
>> A glance at git log will show that those two commits were
>> both from Feb 17 with only one other commit between them.
>>
>> So, why does this happen?:
>>
>> $git bisect start 3501033 c951aa6
>> Bisecting: 8 revisions left to test after this
>> be716615fe596ee117292dc615e95f707fb67fd1] x86, vm86: fix preemption bug
>
> Someone will probably give real explanation but non-linear development
> is part of it:
>
> $ git log --graph --pretty=oneline --abbrev-commit c951aa6..3501033
>
> *   3501033 Merge branch 'x86-fixes-for-linus' of git:// [...]
> |\
> | * be71661 x86, vm86: fix preemption bug
 > ...

I see now that git bisect actually found the guilty commit for me,
but completely confused me by turning out five kernels in a row
with the names 2.6.29-rc3-00nnn while I was bisecting an rc5 kernel.
I stopped because of those tag names when I should have just forged
ahead.

I would be interested to hear opinions on whether that rc3 tag is
the correct one to use for the bisected kernels.

Thanks.
