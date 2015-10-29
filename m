From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCHv2 0/8] Expose the submodule parallelism to the user
Date: Thu, 29 Oct 2015 23:50:57 +0000
Message-ID: <5632B0E1.8040309@ramsayjones.plus.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
 <1446074504-6014-1-git-send-email-sbeller@google.com>
 <56321CF4.60807@ramsayjones.plus.com>
 <CAGZ79kYXrOFDqs5c-OYG2vRO9GY_aoD_GU1=TkRtOMaGC_GowA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 00:51:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrwyR-0001YJ-Jy
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 00:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173AbbJ2XvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 19:51:11 -0400
Received: from avasout07.plus.net ([84.93.230.235]:40551 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbbJ2XvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 19:51:10 -0400
Received: from [10.0.2.15] ([87.114.3.134])
	by avasout07 with smtp
	id bBqx1r0042tV80P01Bqy8n; Thu, 29 Oct 2015 23:50:59 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JN/GyJ+b c=1 sm=1 tr=0
 a=qQ71F3v+nKp5qei/W0vv8w==:117 a=qQ71F3v+nKp5qei/W0vv8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=gFx7NAWHfTl2va5yEs4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kYXrOFDqs5c-OYG2vRO9GY_aoD_GU1=TkRtOMaGC_GowA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280462>



On 29/10/15 15:51, Stefan Beller wrote:
> On Thu, Oct 29, 2015 at 6:19 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
> 
>> Hmm, is there a way to _not_ fetch in parallel (override the
>> config) from the command line for a given command?
>>
>> ATB,
>> Ramsay Jones
> 
> git config submodule.jobs 42
> git <foo> --jobs 1 # should run just one task, despite having 42 configured

Heh, yes ... I didn't pose the question quite right ...
> 
> It does use the parallel processing machinery though, but with a maximum of
> one subcommand being spawned. Is that what you're asking?

... but, despite that, you correctly inferred what I was really
asking about! :)

I was just wondering what overhead the parallel processing machinery
adds to the original 'non-parallel' code path (for the j=1 case).
I suspect the answer is 'not much', but that's just a guess.
Have you measured it? What happens if there is only a single
submodule to fetch?

ATB,
Ramsay Jones
