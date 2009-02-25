From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] git submodule: Fix adding of submodules at paths
 with ./
Date: Wed, 25 Feb 2009 14:04:19 +0100
Message-ID: <49A541D3.4030001@viscovery.net>
References: <80055d7c0902241556s4d24285bqd171275f58bdb37d@mail.gmail.com> <1235559820-3096-1-git-send-email-git@drmicha.warpmail.net> <1235559820-3096-2-git-send-email-git@drmicha.warpmail.net> <1235559820-3096-3-git-send-email-git@drmicha.warpmail.net> <49A529AB.8010700@viscovery.net> <49A53B15.4060608@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 14:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcJSX-0001Ff-6t
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 14:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbZBYNE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 08:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbZBYNE3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 08:04:29 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:25958 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbZBYNE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 08:04:28 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LcJQx-0007J2-ST; Wed, 25 Feb 2009 14:04:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 944F0A865; Wed, 25 Feb 2009 14:04:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <49A53B15.4060608@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111451>

Michael J Gruber schrieb:
> Johannes Sixt venit, vidit, dixit 25.02.2009 12:21:
>> Michael J Gruber schrieb:
>>> +	# strip superfluous ./ from path
>>> +	path=$(echo "$path" | sed -e 's|^\(\./\)*||' -e's|/\./|/|g')
>> At a minimum:
>>
>> 	path=$(echo "$path" | sed -e 's|^/\(\./\)*|/|g' -e's|^\./||')
>>
>> Otherwise you would turn "foo./bar" into "foobar", right?
> 
> Wrong.

Ouch! Point taken. I didn't notice the ^ in the first expression, and I
even copy-pasted and edited it!

> Now, the /// are in fact a valid concern[1], although probably not that
> common an isue.

I'm fine if only common use cases are taken care of. If you say that ./ is
common and /// is not, then I'll believe it because I'm not a git
submodule user (yet) and can't argue about this with my own experience.

-- Hannes
