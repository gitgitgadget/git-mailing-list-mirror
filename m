From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-archive ignores submodules
Date: Thu, 16 Apr 2015 21:03:10 +0200
Message-ID: <5530076E.50605@web.de>
References: <CAL1ZDKZs++NkLoHZ_w_YebQuZYG3rgAiH5SsaQfTmb9MPHjR3w@mail.gmail.com>	<20150416175623.GJ21868@paksenarrion.iveqy.com> <CAL1ZDKbcmrer481fRY2NEHUQ1J5tjRbHz2yLEcszh3Q-NjcvcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pedro Rodrigues <prodrigues1990@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 21:03:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yip4N-0003S2-C3
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 21:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbbDPTDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 15:03:20 -0400
Received: from mout.web.de ([212.227.17.11]:58608 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbbDPTDS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 15:03:18 -0400
Received: from [192.168.178.41] ([79.211.97.138]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MQNiS-1Yv1rC1rNE-00ThIm; Thu, 16 Apr 2015 21:03:14
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAL1ZDKbcmrer481fRY2NEHUQ1J5tjRbHz2yLEcszh3Q-NjcvcQ@mail.gmail.com>
X-Provags-ID: V03:K0:MBH3ScBEBLhoEDKAIU2Hp/pp1kp7MV7pxRHwPfo1VCrlZ7TUs32
 SkN1On4jOyLxJRmhA2F1dABPpv3IGF4KqCUlYH9ufO2T3Gv8f/ItE1Y4k8jthV4IlPfyxX5
 3PO3PjThU6rNdKutxuDqe+6klhiP/bmZR4xk5xwypF32lsJSTb1NGZS5iA1CpTXDDPfHbJ9
 POrXbxkjtjBVWERj4LC4Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267328>

Am 16.04.2015 um 20:09 schrieb Pedro Rodrigues:
> Good to know about git submodule foreach.
>
> Simpler yet, I'm using:
>
> zip -r ../project.zip . -x *.git*
>
> Which essentially does the same thing I would need from git-archive
> --recurse-submodule, zip everything excluding .git folders. Still
> would be better to use git itself.

Yes.

> 2015-04-16 18:56 GMT+01:00 Fredrik Gustafsson <iveqy@iveqy.com>:
>> On Thu, Apr 16, 2015 at 06:35:38PM +0100, Pedro Rodrigues wrote:
>>> I've been using git-archive as my main way of deploying to production
>>> servers, but today I've come across a git repo with submodules and
>>> found out that git archive has no option to include submodules on the
>>> output archive.
>>
>> As far as I know this is an known limitation that's just waiting for
>> someone to solve. Thanks for bringing attention to it.

I just rebased a patch Lars Hjemli posted in 2009 (which I kept in my
GitHub repo to resurrect it when I find the time) to current master:

https://github.com/jlehmann/git-submod-enhancements/commits/archive--submodules

See gmane/$107030 for its original posting. Apart from renaming the
'--submodule' option to '--recurse-submodules' and solving a merge
conflict I didn't change anything. Not sure why it wasn't accepted
back then, I'll have to read that thread more closely ...

If people are interested I could try to polish it and resubmit it.
It would be great if Pedro could test that it does what he expects.
