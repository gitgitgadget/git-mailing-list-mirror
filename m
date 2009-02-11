From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-filter-branch: Add more error-handling
Date: Wed, 11 Feb 2009 16:36:31 +0100
Message-ID: <4992F07F.2080005@viscovery.net>
References: <1234361365-63711-1-git-send-email-git@randomhacks.net> <4992E79D.10208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Kidd <git@randomhacks.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 16:38:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHA2-0001kD-Fx
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 16:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731AbZBKPge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 10:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbZBKPgd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 10:36:33 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11162 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbZBKPgd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 10:36:33 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LXH8Z-0003sp-AN; Wed, 11 Feb 2009 16:36:31 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2C5C96EF; Wed, 11 Feb 2009 16:36:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <4992E79D.10208@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109426>

Johannes Sixt schrieb:
>> @@ -483,7 +486,7 @@ test -z "$ORIG_GIT_INDEX_FILE" || {
>>  }
>>  
>>  if [ "$(is_bare_repository)" = false ]; then
>> -	git read-tree -u -m HEAD
>> +	git read-tree -u -m HEAD || die "Unable to checkout rewritten tree"
> 
> Here you shouldn't die.

I take this back. I was distracted by the 'exit $ret' that is visible in
the context:

>>  fi
>>  
>>  exit $ret

But this exit statement is pointless: ret is initialized to zero and never
changed.

-- Hannes
