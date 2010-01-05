From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Tue, 05 Jan 2010 13:19:59 +0100
Message-ID: <4B432E6F.8000806@web.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <alpine.DEB.1.00.1001051032440.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 05 13:20:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS8Oq-0004iE-9y
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 13:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab0AEMUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 07:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225Ab0AEMUI
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 07:20:08 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:43040 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab0AEMUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 07:20:08 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id D973014448FF7;
	Tue,  5 Jan 2010 13:20:05 +0100 (CET)
Received: from [80.128.61.137] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NS8OG-0007sU-00; Tue, 05 Jan 2010 13:20:00 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <alpine.DEB.1.00.1001051032440.4985@pacific.mpi-cbg.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19/b1f/Zd9WMnOEzsc5O/3Mzs7r7xR5FGpGbZvz
	Ch/RFHSdlBByI7p1gf7f2VuHz7LJrcmA2y0fZRpYmzguKSw0XZ
	hZTsYbMAplQ8v+QRxgQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136186>

Am 05.01.2010 10:46, schrieb Johannes Schindelin:
> But I have a use case here where the shared content is _not_ a library 
> that can live in a subdirectory naturally.

Yes, we had to reorganize a major part of one project too. Heiko could
tell more about that.


>> Having read up about svn externals in the meantime, what about something
>> like this:
>> - Add a command like "git submodule forward" (as update is already in
>>   use) that takes an optional -b <branchname>. It does a fetch in the
>>   submodule, then tries to fast forward (or rebase) to master or the
>>   branch given and stages this commit in the superproject. This should
>>   be the equivalent to doing an "svn update" in a repo with externals.
>>   Or am i missing something?
> 
> Yes.  It is not the decision of the fetcher, but of the guy who adds the 
> submodule to decide what it is.
>
>> - We could also add an option to "git submodule add" to specify the
>>   default branch name for forward.
> 
> That's an obvious precondition for proper always-tip-submodules.  But 
> Git's core data structure, the index, does not allow for it.  _That_ is 
> the difficulty, not what the user interface would look like.

I have never experienced (and never had the need for) such an always-tip
scenario and therefore still seem to have difficulties to grok it. I
assume you always want to have the newest tip at /checkout/ time, not at
/commit/ time? Then my proposal would really not help you.


> I start to wonder whether the insistence that .gitmodules' settings must 
> be overrideable makes any sense in practice.

I know of none, maybe someone else can speak up here?
(And even if it is overrideable, do the settings necessarily have to be
copied into .git/config when they aren't even overridden?)
