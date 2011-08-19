From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Unable to build git on Lion - missing config.h from Perl header
 files
Date: Fri, 19 Aug 2011 17:19:11 -0500
Message-ID: <6LbwaepC5kIygT8uWl1Wf2A7S_AD1YkTya7FLCpDK4LOS7CNxjOveFLpzZtHv0dg_JJ8l78oW6XVugLUDAHkvBFItwH2yzYH6BgRAAZkFuM@cipher.nrlssc.navy.mil>
References: <611AB1F99D784B92B1F7278139D6EED5@gmail.com> <9B588F2F-ACDF-4DA7-BE30-E075CA729731@gmail.com> <CAGDPfJoG_ksfL5vqzGWe5jqW646CKB=Qxm9_G5d=ZHMWfixweA@mail.gmail.com> <201108200012.17580.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sorin Sbarnea <sorin.sbarnea@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 20 00:40:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuXjs-0003gy-6i
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 00:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234Ab1HSWk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 18:40:26 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:48113 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756395Ab1HSWkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 18:40:25 -0400
X-Greylist: delayed 1262 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Aug 2011 18:40:25 EDT
Received: by mail3.nrlssc.navy.mil id p7JMJBXW008836; Fri, 19 Aug 2011 17:19:11 -0500
In-Reply-To: <201108200012.17580.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Aug 2011 22:19:11.0577 (UTC) FILETIME=[057CE490:01CC5EBE]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179737>

On 08/19/2011 05:12 PM, Thomas Rast wrote:
> Sorin Sbarnea wrote:
>> This was a clean-new Lion install, not an upgrade. I just installed
>> Xcode on alternate location /Developer41 instead of /Developer
>>
>> Yes, I did a `make clean` but it has no effect.
>>
>> The problem is that on Lion there is no config.h in the perl
>> directory, only a perl.h file.
> 
> Color me puzzled, but where is it getting the config.h idea from?
> 
>   $ git grep config\\.h
>   compat/fnmatch/fnmatch.c:# include <config.h>
>   compat/regex/regex.c:#include "config.h"
>   t/t4014-format-patch.sh:test_expect_success '--no-add-headers overrides config.headers' '
> 
> Similarly, 'git grep config perl' only turns up matches in perl code.
> So what tells it to use config.h?

Probably MakeMaker.

Setting NO_PERL_MAKEMAKER may help:

   rm perl/perl.mak
   make NO_PERL_MAKEMAKER=1

-Brandon
