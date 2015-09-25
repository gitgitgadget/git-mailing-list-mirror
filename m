From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Fwd: diff not finding difference
Date: Fri, 25 Sep 2015 12:25:00 +0200
Message-ID: <560520FC.7050501@drmicha.warpmail.net>
References: <CAKepmajSPgGK-DqR3Bxf2Xqxj2Gz0MazRNxM6wsVcSiBQsoE4Q@mail.gmail.com>
 <CAKepmajegSMO91YZOe+P_BH2kzzR=RMqCE94XRQSfZzOVYKt6A@mail.gmail.com>
 <8abeb16d123a602ee11dab3f93dab51e@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git-mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jack Adrian Zappa <adrianh.bsc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 12:25:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfQBk-0004Eo-Mr
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 12:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbbIYKZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 06:25:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58851 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752505AbbIYKZF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2015 06:25:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 292B120330
	for <git@vger.kernel.org>; Fri, 25 Sep 2015 06:25:02 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 25 Sep 2015 06:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=MEplavSFKa32RasKEFYHx1YFjAA=; b=aDDb0k
	SSmvyq5enEMBMIEz15QumStqUSuEgKDBFLjE2d8rxkqm0ubn7VRb7ZWKHlLwY5MS
	FLAITs7OnHrliLFLWcPom58hN+I4zhpHCdmQlHoewQWEs4L/mbhB8ASwWdtXDeHZ
	puG7DO2uSmmwlOVFWCg4wdgU0v5sDUPIHDyeY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=MEplavSFKa32Ras
	KEFYHx1YFjAA=; b=D1+pKwXMkFyFSEC6EtCnys+pWd5MgHxSnB7g7SGVav+EF7y
	Gi1W7ejQ8aGaVCUpLeQyUehkzCih5LR5QECFt13NNXTf51Rs7jhECm82nJHIyQzG
	AL8PAQTCBO7lRsvU0mh+WLonHws82m5ZDvs7l9haIdumM4DI0eErUebrFUqY=
X-Sasl-enc: 7K+u4nWqb6Um63JAfsNq+dLf+k2DOW88+PVqbSJP/y02 1443176701
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 732696800E8;
	Fri, 25 Sep 2015 06:25:01 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <8abeb16d123a602ee11dab3f93dab51e@dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278657>

Johannes Schindelin venit, vidit, dixit 25.09.2015 12:11:
> Hi Jack Adrian,
> 
> On 2015-09-24 23:09, Jack Adrian Zappa wrote:
>> This is a weird one:
>> 
>> [file-1 begin]
>> 
>> abcd efg hijklmnop
>> 
>> [file-1 end]
>> 
>> [file-2 begin]
>> 
>> blah blah blah 
>> /////////////////////////////////////////////////////////////////////////////////
>>
>> 
abdc boo ya!
>> 
>> [file-2 end]
>> 
>> Do a diff between these and it won't find any difference.
>> 
>> Same with the following two lines, each in a different file: sabc
>> fed ghi jkl abc def ghi jkl
>> 
>> I first noticed this on the command line git and then in VS2013.
>> The original problem was like my first example.  The files were
>> much longer, but all that git would see is the addition of the line
>> of ////..., but not the removal of the original line.
>> 
>> I've tried some other simple file changes with similar results. 
>> Something seems to be definitely broken in git diff. :(
> 
> You might want to show your exact command-line invocation, i.e. the
> full information. I suspect that you missed the fact that `git diff a
> b` does not compare the file a to the file b, but instead it compares
> both a and b to what is recorded in the index. With one quirk: if the
> files a and b are not even recorded in the index, `git diff` will
> output nothing.
> 
> Now, the really confusing part for you was probably that your
> `file-2` *was* recorded in the index (maybe you made a backup copy
> with the extra file extension `.bak` or some such, and then called
> `git diff my-file.bak my-file` where `my-file` *actually is tracked
> by Git* but `my-file.bak` is not).
> 
> But `git diff` has so nice features that I wanted to use it myself to
> compare files or directories. That is why I introduced the
> `--no-index` option, years ago. And so I suspect that you called

Ah, now is a good time to rename my (shell) alias "gdiff" for "git diff
--no-index" to dschodiff.

Thanks, Dscho :)
Michael

P.S.: Note that dschodiff works perfectly even outside a git working
directory, with all the --color-words and whitespace goodness and what not!
