From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule: Tolerate auto/safecrlf when adding .gitmodules
Date: Wed, 20 Jun 2012 20:21:07 +0200
Message-ID: <4FE21493.8000206@web.de>
References: <cover.1340202515.git.brad.king@kitware.com> <eebc8b3692f8fcb95cf75278f7c9f9982e8f2cd6.1340202515.git.brad.king@kitware.com> <4FE20DD3.6040607@web.de> <4FE21133.2030001@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:42:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPrI-0007oG-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512Ab2FTSmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 14:42:23 -0400
Received: from mout.web.de ([212.227.15.3]:64947 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757369Ab2FTSVO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 14:21:14 -0400
Received: from [192.168.178.48] ([91.3.162.199]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0Lhvko-1S3Q5002yY-00mVxk; Wed, 20 Jun 2012 20:21:09
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <4FE21133.2030001@kitware.com>
X-Provags-ID: V02:K0:FODfst01iG8JHebg+VZe5QPur8sFksc18vf/L8B6V4v
 Hvoot5BORlaIIP6atGNpBPvdw04TgL9yznJETgq+WtYzBqz9EU
 Byhse8bwJIxZ5SjR/vmryvMhQPdqbYinX7ubYAi5DjyI9idJtk
 BB1LriZRea9c788GR8lf63XumvHuV1V3mVqhwczpxu7E5e9uKF
 BSP26nFglVwnICIIOReBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200329>

Am 20.06.2012 20:06, schrieb Brad King:
> On 06/20/2012 01:52 PM, Jens Lehmann wrote:
>> Am 20.06.2012 16:43, schrieb Brad King:
>>> Temporarily disable 'core.safecrlf' to add '.gitmodules' so that
>>> 'git add' does not reject the LF newlines we write to the file
>>> even if both 'core.autocrlf' and 'core.safecrlf' are enabled.
>>> This fixes known breakage tested in t7400-submodule-basic.
>>
>> Hmm, I have no objections against the intention of the patch. But
>> as I understand it this message will reoccur when the user e.g.
>> edits the .gitmodules file later with any editor who just writes
>> lfs and adds it.
>>
>> I don't know terribly much about crlf support but maybe flagging
>> the .gitmodules file in .gitattributes would be a better solution
>> here? Opinions?
> 
> Once a user edits the file with an outside tool it is his/her
> responsibility to add .gitattributes for the file.  In the reported
> case Git is creating the file and already knows the crlf mode when
> creating it.
> 
> I think Junio's proposal to teach "git config" to respect crlf
> configuration is a more general solution.

Yep.
