From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Don't do status in submodules if status.SubmoduleSummary
 	unset
Date: Thu, 20 May 2010 22:14:01 +0200
Message-ID: <4BF59809.7080706@web.de>
References: <AANLkTil1QHA3G2VaITdm7DkDmN1IhZ_u2SWLrelyxkF2@mail.gmail.com>	 <4BF57538.5040204@web.de> <AANLkTikQDEwA7Iih9hniYzLfSGnPvZ9PTDNtSKfJPa9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 22:14:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFC8B-0001lO-Hr
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 22:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab0ETUOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 16:14:05 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:51794 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0ETUOE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 16:14:04 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id B9BE315A8D8DF;
	Thu, 20 May 2010 22:14:01 +0200 (CEST)
Received: from [80.128.65.231] (helo=[192.168.178.26])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OFC80-0000oH-00; Thu, 20 May 2010 22:14:00 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTikQDEwA7Iih9hniYzLfSGnPvZ9PTDNtSKfJPa9d@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+n+mM56+bvkL+akuRWliRKM0VHlWtthlXBhD7x
	nU/wcGVXX455LUiBhC3an/vJk+Im9gQgn3K8B7uT+HARJ/1Ues
	fC6PgFLrxQPqLAGrdBAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147414>

Am 20.05.2010 21:34, schrieb Alex Riesen:
> On Thu, May 20, 2010 at 19:45, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 20.05.2010 16:12, schrieb Alex Riesen:
>>> Maybe because we do a (kind of) gentle status run on submodules
>>> whether the status.SubmoduleSummary set or not.
>>
>> Yup, because checking a submodule for its dirtiness has to be done
>> no matter if the summary output is also wanted.
> 
> Yeah. Why?

Because summary output only describes what commits happened in the
submodule (that operation is rather cheap). The status run is done
to tell what changes in the submodules work tree have occurred since
the last commit there (and for that we have to scan the whole tree).


>>> Usually a background
>>> run of "git status" for every submodules goes unnoticed, just
>>> sometimes a submodule is a little too big.
>>>
>>> I tried this, but feels like a bit of overkill.
>>
>> This patch seems to disable submodule output completely for the default
>> case (when status.SubmoduleSummary is false) and breaks 17 test cases.
> 
> That's why I said it feels like overkill

I just wanted to confirm your feeling ;-)
