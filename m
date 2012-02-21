From: Christian Hammerl <info@christian-hammerl.de>
Subject: Re: [PATCH] completion: Allow dash as the first character for __git_ps1
Date: Tue, 21 Feb 2012 21:49:24 +0100
Message-ID: <80e5224c-66f4-4bdf-9e0e-9aeb7f4f319d@email.android.com>
References: <1329740273-5580-1-git-send-email-info@christian-hammerl.de> <7vty2jgbsh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 21:49:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzwef-0007F1-Ec
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 21:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109Ab2BUUtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 15:49:40 -0500
Received: from w3variance.de ([85.197.82.140]:52840 "EHLO w3variance.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805Ab2BUUtk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 15:49:40 -0500
Received: from [2.212.244.135] (helo=[10.135.244.135])
	by w3variance.de with esmtpa (Exim 4.75)
	(envelope-from <info@christian-hammerl.de>)
	id 1RzweE-0007Dw-S5; Tue, 21 Feb 2012 21:49:20 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <7vty2jgbsh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191183>

Yes, kind of.

It is more like PS1='\W$(__git_ps1 "-[ %s ]")'. And i am fixing it after each update on my machine. ;-)



Junio C Hamano <gitster@pobox.com> schrieb:

>Christian Hammerl <info@christian-hammerl.de> writes:
>
>> If the argument for `__git_ps1` begins with a dash, `printf` tries to
>> interpret it as an option which results in an error message.
>> The problem is solved by adding '--' before the argument to tell
>> `printf` to not interpret the following argument as an option.
>> Adding '--' directly to the argument does not help because the
>argument
>> is enclosed by double quotes.
>>
>> Signed-off-by: Christian Hammerl <info@christian-hammerl.de>
>> ---
>>  contrib/completion/git-completion.bash |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash
>b/contrib/completion/git-completion.bash
>> index 91c7acb..61ff152 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -313,7 +313,7 @@ __git_ps1 ()
>>  		fi
>>  
>>  		local f="$w$i$s$u"
>> -		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
>> +		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
>>  	fi
>>  }
>
>Hmm, so you may be doing something like PS1='\W$(__git_ps1 "-%s")'?
>OK, and thanks.  

-- 
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.
