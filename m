From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Fri, 20 Mar 2009 15:49:50 +0200
Message-ID: <49C39EFE.8040507@dawes.za.net>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>	 <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>	 <20090319214001.GA6253@blimp.localdomain>	 <alpine.DEB.1.00.0903200025170.10279@pacific.mpi-cbg.de>	 <81b0412b0903200130s594ce3beyae21eb0b5cc8fe0@mail.gmail.com>	 <alpine.DEB.1.00.0903201015270.10279@pacific.mpi-cbg.de> <81b0412b0903200639v6d99067csb7715d9a5a3f0ba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 14:51:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkf8I-0005bC-5d
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 14:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbZCTNuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 09:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbZCTNuD
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 09:50:03 -0400
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:49357 "EHLO
	spunkymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752052AbZCTNuC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 09:50:02 -0400
Received: from artemis.local (unknown [41.246.8.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a2.g.dreamhost.com (Postfix) with ESMTP id 7B19487086;
	Fri, 20 Mar 2009 06:49:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <81b0412b0903200639v6d99067csb7715d9a5a3f0ba4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113957>

Alex Riesen wrote:
> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> On Fri, 20 Mar 2009, Alex Riesen wrote:
>>
>>> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>>> Now, we _do_ have msysGit, you _do_ have shown the capability to fix
>>>> issues when they arise, so I do _not_ see any obstacle why you should
>>>> not go msysGit, rather than staying with the pain of trying to stay
>>>> POSIX-compatible, but not quite all the time.
>>> I understand. It is not pure POSIX compatibility I seek. I just can't
>>> use MinGW port, because I absolutely must use the cygwin environment
>>> (for "hysterical" reasons) and they don't play well together (tried,
>>> yes. Conflicting libraries, but you already know that).
>> Maybe we can work on those conflicting libraries?  After all, we do have a
>> "rebase.exe" tool now (for all those as puzzled by the naming as I was:
>> the rebase.exe tool can shift the memory range used by a .dll so that it
>> does not overlap with that one of another .dll).
> 
> As long as they can be made to coexist I'm fine. Wasn't the problem
> that MinGW/MSYS used cygwin1.dll if it were in PATH? Or was it
> something else with their supporting libraries?
> 
> My other problem is that the cygwin programs, and the worst of all - a
> proprietary compiler based on cygwin, must be in PATH. AFAIR, the
> presence of cygwin in PATH broken shell scripting.

How about a wrapper that fixes the PATH before exec'ing git? i.e.
removes cygwin and the compiler.

Rogan
