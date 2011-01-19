From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: filter-branch --env-filter GIT_AUTHOR_DATE
Date: Wed, 19 Jan 2011 11:32:57 +0100
Message-ID: <4D36BDD9.4050108@viscovery.net>
References: <AANLkTinx7cs6YTvSTTv-njHA+vk264u1EaJettSdBF9U@mail.gmail.com> <4D368C49.3080105@viscovery.net> <AANLkTi=TAhYeWbyocag2myBXA2TfH7_r=hmam51YKbhm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 11:33:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfVLi-0003xp-6a
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 11:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056Ab1ASKdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 05:33:06 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57275 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab1ASKdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 05:33:04 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PfVLW-00087G-P9; Wed, 19 Jan 2011 11:33:01 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 466911660F;
	Wed, 19 Jan 2011 11:32:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTi=TAhYeWbyocag2myBXA2TfH7_r=hmam51YKbhm@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165259>

Am 1/19/2011 11:08, schrieb Tuncer Ayaz:
> On Wed, Jan 19, 2011 at 8:01 AM, Johannes Sixt wrote:
>> Am 1/18/2011 17:43, schrieb Tuncer Ayaz:
>>> To fix invalid timezone info in a repo I ran
>>> git filter-branch --env-filter '
>>>   GIT_AUTHOR_DATE=`echo ${GIT_AUTHOR_DATE}|sed s/+0000/-0800/`' HEAD
>>>
>>> This fixed the invalid entries but the new timezone is -0700
>>> instead of -0800. Is this expected?
>>
>> Parse error. You fixed it, but it is not fixed? So what?
> 
> Fixed because it is not +0000 anymore. Surprised because the new
> timezone is -0700 and not -0800.
> 
>> What do you mean by "the new timezone is"? Do you mean "...is reported
>> as"? If so, reported by which tools?
> 
> git log
> git cat-file $REV

$ git filter-branch -f --env-filter 'echo; echo "$GIT_AUTHOR_DATE"; GIT_AUTHOR_DATE=`echo ${GIT_AUTHOR_DATE}|sed s/+0100/-0800/`; echo "$GIT_AUTHOR_DATE"' -- -1
Rewrite 6fb5ec91707a4433628eae5d9d68153ca8b819fe (1/1)
1292311163 +0100
1292311163 -0800

Ref 'refs/heads/master' was rewritten
$ git cat-file commit HEAD
tree 43554f2216bbcfc96385db0641ae212409f26f21
parent 942f54790453970cfffbfedf29e47ac27b9ba995
author Johannes Sixt <j.sixt@viscovery.net> 1292311163 -0800
committer Johannes Sixt <j.sixt@viscovery.net> 1292311163 +0100

master

*Shrug*

-- Hannes
