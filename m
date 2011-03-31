From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH 3/3] builtin/show.c: do not prune by pathspec
Date: Thu, 31 Mar 2011 13:42:03 +0200
Message-ID: <4D94688B.1070703@viscovery.net>
References: <4D94322A.8030409@drmicha.warpmail.net> <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net> <4D9454D9.6060406@viscovery.net> <4D945E3E.9010006@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 13:42:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5GGX-0002H3-O6
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 13:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372Ab1CaLmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 07:42:10 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:26573 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab1CaLmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 07:42:09 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q5GGK-0002D9-BH; Thu, 31 Mar 2011 13:42:04 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 106181660F;
	Thu, 31 Mar 2011 13:42:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D945E3E.9010006@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170473>

Am 3/31/2011 12:58, schrieb Michael J Gruber:
> Johannes Sixt venit, vidit, dixit 31.03.2011 12:18:
>> Am 3/31/2011 11:17, schrieb Michael J Gruber:
>>> By design, "git show commit -- path" is not "git show commit:path", and
>>> there is no reason to change that. But "git show commit -- path" simply
>>> returns nothing at all "most of the time" because it prunes by pathspec
>>> even though it does not walk commits. This is pretty useless.
>>>
>>> So, turn off pruning (but keep diff limiting of course) so that "git
>>> show commit -- path" shows the commit message and the diff that the
>>> commit introduces to path (filtered by path); only the diff will be
>>> empty "most of the time".
>>
>> How does this interfere with git show --walk commit -- path? Will it now
>> show all commits instead of just those that changed path?
> 
> Hmpft,
> 
> git show --walk origin/master
> fatal: unrecognized argument: --walk
> 
> No, that is without my patch ;)
> 
> In other words: "ENOPARSEOPTS in revision.c", there is no "--walk".

8-( Oops sorry, and thanks for doing research that I should have done. At
first, I thought it's named --walk because we have --no-walk. But the name
is --do-walk.

My question is then:

How does this interfere with git show --do-walk commit -- path?

-- Hannes
