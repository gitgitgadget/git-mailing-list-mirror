From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] run-command: fix an 'different modifiers' sparse warning
Date: Thu, 25 Feb 2016 23:08:31 +0000
Message-ID: <56CF896F.3000601@ramsayjones.plus.com>
References: <56CF576B.4020401@ramsayjones.plus.com>
 <xmqqfuwgo83n.fsf@gitster.mtv.corp.google.com>
 <20160225213935.GA3612@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:08:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ51i-0007xp-OL
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbcBYXIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:08:45 -0500
Received: from avasout04.plus.net ([212.159.14.19]:46507 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbcBYXIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:08:44 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id Nn8c1s0024mu3xa01n8dTN; Thu, 25 Feb 2016 23:08:37 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=NXsjGeGkFf8Dz6FXUFoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160225213935.GA3612@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287472>



On 25/02/16 21:39, Jeff King wrote:
> On Thu, Feb 25, 2016 at 12:20:12PM -0800, Junio C Hamano wrote:
> 
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>>> ---
>>>
>>> Hi Jeff,
>>>
>>> If you need to re-roll your 'jk/epipe-in-async' branch, could you
>>> please squash this into the relevant patch. (ie. "write_or_die:
>>> handle EPIPE in async threads", 24-02-2016).
>>>
>>> Thanks!
>>
>> I actually was planning to merge this to 'next' today, so I'll
>> squash it in without waiting for a reroll.
> 
> I am OK with that. But I do find it interesting that we must mark
> NORETURN in both the declaration and the definition, but we don't for
> __attribute__((format)).
> 
>> By the way, doesn't it bother anybody to give two different types to
>> the same function depending on NO_PTHREAD?  It is not a new issue
>> added by this series, but async_exit() that claims to return int
>> does not (naturally) return anything, and sparse does not seem to
>> care (neither do we).
> 
> It would have bothered me if I had noticed. :)
> 
> It is simply a bug, and sparse (and the compiler) do not notice it
> because it only shows up if you compile with NO_PTHREADS=1. And I think
> it is added by this series:

Wow, I can't believe that I didn't notice this myself while editing
the file! :-D

ATB,
Ramsay Jones
