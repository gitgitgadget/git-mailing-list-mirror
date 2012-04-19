From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Thu, 19 Apr 2012 08:16:47 +0200
Message-ID: <4F8FADCF.5000006@viscovery.net>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org> <4F8E6A12.9090708@viscovery.net> <4F8F1BC1.3030607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoQ==?= =?UTF-8?B?aSBOZ+G7jWMgRHV5?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 08:17:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKkfx-0007yH-55
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 08:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab2DSGQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 02:16:55 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62758 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753035Ab2DSGQv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 02:16:51 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SKkfg-0004u5-CY; Thu, 19 Apr 2012 08:16:48 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1E1891660F;
	Thu, 19 Apr 2012 08:16:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F8F1BC1.3030607@ramsay1.demon.co.uk>
X-Enigmail-Version: 1.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195925>

Am 4/18/2012 21:53, schrieb Ramsay Jones:
> Johannes Sixt wrote:
>> Am 4/16/2012 8:44, schrieb Junio C Hamano:
>>> * nd/threaded-index-pack (2012-04-11) 3 commits
>>>  - index-pack: support multithreaded delta resolving
>>>  - index-pack: split second pass obj handling into own function
>>>  - compat/win32/pthread.h: Add an pthread_key_delete() implementation
>>
>> With this series, t9300.92 (fast-import, Q: verify pack) consistently
>> fails for me on Windows.
>>
>> I'll have to see when I can dig deeper into this topic...
> 
> Hmm, this works just fine for me.

It's a Heisenbug. I see different failure modes:

error: inflate: data stream error (incorrect header check)
fatal: serious inflate inconsistency

fatal: premature end of pack file, 79 bytes missing

fatal: premature end of pack file, 72 bytes missing

(and I even saw successful runs). It's always the same pack,
pack-54fa663f5ec35*.pack. But running index-pack --verify manually does
not fail. The packs look good because the installed index-pack (which was
built without this topic) does not report an error, either.

Any clues?

-- Hannes
