From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Compiling git with makepp patch
Date: Wed, 25 Aug 2010 23:56:11 +0200
Message-ID: <m262yyuzk4.fsf@igel.home>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de>
	<4C71A53F.2020108@t-online.de> <20100824043220.GA20037@burratino>
	<4C758016.8070104@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: occitan@esperanto.org
X-From: git-owner@vger.kernel.org Wed Aug 25 23:56:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoNxN-0000hc-Qi
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 23:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab0HYV4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 17:56:15 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49859 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab0HYV4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 17:56:13 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 344A21C0047F;
	Wed, 25 Aug 2010 23:56:11 +0200 (CEST)
Received: from igel.home (ppp-88-217-125-198.dynamic.mnet-online.de [88.217.125.198])
	by mail.mnet-online.de (Postfix) with ESMTP id BF4501C001EC;
	Wed, 25 Aug 2010 23:56:11 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 67CD7CA299; Wed, 25 Aug 2010 23:56:11 +0200 (CEST)
X-Yow: ...A housewife is wearing a polypyrene jumpsuit!!
In-Reply-To: <4C758016.8070104@t-online.de> (Daniel Pfeiffer's message of
	"Wed, 25 Aug 2010 22:41:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154482>

Daniel Pfeiffer <occitan@t-online.de> writes:

>  la 08/24/2010 06:32 AM Jonathan Nieder skribis:
>> Hi,
>>
>> Daniel Pfeiffer wrote:
>>> The file needs to be built immediately so
>>> that it can be included, before reading the rest of the makefile.
>>> But the dependency is only known to be phony after running the rule.
>>> Here you have a hen-egg problem, where I have no clue how Gnu make
>>> can cope (this is the one case where it requires .PHONY).
>> GNU make, unlike, say, pmake, reads all the rules before it runs
>> anything iirc.  So you can have
>>
>>   -include foo
>>
>>   foo:
>> 	echo bar:>foo
>> 	echo '	echo hi'>>foo
>>
>> and it will cope okay.
> While that is not the usual use-case for -include, the file might very
> well define some macros, and the rest of the makefile, indeed the foo-rule
> itself might depend on those macros.

GNU make will restart reading all makefiles when any of them was remade.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
