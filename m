From: Anthony Baire <anthony.baire@irisa.fr>
Subject: Re: [PATCH] subtree: fix argument validation in add/pull/push
Date: Wed, 27 Nov 2013 21:30:51 +0100
Message-ID: <5296567B.5080704@irisa.fr>
References: <1385577249-29269-1-git-send-email-Anthony.Baire@irisa.fr> <87siuhfy9q.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Nov 27 21:31:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlllB-0003Y5-Ue
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 21:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900Ab3K0Uay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 15:30:54 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:61906 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757783Ab3K0Uax (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Nov 2013 15:30:53 -0500
X-IronPort-AV: E=Sophos;i="4.93,784,1378850400"; 
   d="scan'208";a="45774841"
Received: from lav35-1-82-236-136-112.fbx.proxad.net (HELO [192.168.0.10]) ([82.236.136.112])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-CAMELLIA256-SHA; 27 Nov 2013 21:30:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <87siuhfy9q.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238461>

On 27/11/2013 20:19, Thomas Rast wrote:
> Anthony Baire <Anthony.Baire@irisa.fr> writes:
>
>> When working with a remote repository add/pull/push do not accept a
>> <refspec> as parameter but just a <ref>. They should accept any
>> well-formatted ref name.
> [...]
>>   - update the doc to use <ref> instead of <refspec>
> [...]
>>   OPTS_SPEC="\
>>   git subtree add   --prefix=<prefix> <commit>
>> -git subtree add   --prefix=<prefix> <repository> <commit>
>> +git subtree add   --prefix=<prefix> <repository> <ref>
>>   git subtree merge --prefix=<prefix> <commit>
>> -git subtree pull  --prefix=<prefix> <repository> <refspec...>
>> -git subtree push  --prefix=<prefix> <repository> <refspec...>
>> +git subtree pull  --prefix=<prefix> <repository> <ref>
>> +git subtree push  --prefix=<prefix> <repository> <ref>
>>   git subtree split --prefix=<prefix> <commit...>
> [...]
>> @@ -68,7 +68,7 @@ COMMANDS
>>   --------
>>   add::
>>   	Create the <prefix> subtree by importing its contents
>> -	from the given <refspec> or <repository> and remote <refspec>.
>> +	from the given <commit> or <repository> and remote <ref>.
> AFAICS you are changing refspec->commit in the manpage, but commit->ref
> in the usage message for 'subtree add'?  How does this line up?
>
'git subtree add' accepts a commit when working with the local 
repository and a ref when working with a remote repository:

	git subtree add   --prefix=<prefix> <commit>
	git subtree add   --prefix=<prefix> <repository> <ref>

but the manpage was no in sync with the code. I fixed it for the local 
case too.
Anthony
