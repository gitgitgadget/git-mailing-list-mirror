From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [PATCH v3 2/3] doc: change environment variables format
Date: Mon, 6 Jun 2016 18:34:27 +0200
Message-ID: <57e1e906-1314-e774-4ca6-89cf772ce19d@grenoble-inp.org>
References: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
 <20160606100905.23006-1-tom.russello@grenoble-inp.org>
 <20160606100905.23006-3-tom.russello@grenoble-inp.org>
 <vpqinxmmmu8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:34:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xUC-000310-Ee
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbcFFQee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 12:34:34 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:43088 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbcFFQec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:34:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 7A5A825A6;
	Mon,  6 Jun 2016 18:34:29 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EECxhvJtOCGG; Mon,  6 Jun 2016 18:34:29 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6B9A325A5;
	Mon,  6 Jun 2016 18:34:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 5F8E92066;
	Mon,  6 Jun 2016 18:34:29 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UZqytVt3RoOs; Mon,  6 Jun 2016 18:34:29 +0200 (CEST)
Received: from [130.190.33.212] (eduroam-033212.grenet.fr [130.190.33.212])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 226EC2055;
	Mon,  6 Jun 2016 18:34:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <vpqinxmmmu8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296532>

On 06/06/16 16:08, Matthieu Moy wrote:
> I'd add to the commit message that one of the goals of this patch is to
> make the use "mostly consistent" with CodingGuidelines, so that people
> writting new doc by mimicking the existing one later get a good
> probability of getting it right even if they didn't read
> CodingGuidelines.

Agreed.

>> @@ -619,7 +619,7 @@ core.excludesFile::
>>  core.askPass::
>>  	Some commands (e.g. svn and http interfaces) that interactively
>>  	ask for a password can be told to use an external program given
>> -	via the value of this variable. Can be overridden by the 'GIT_ASKPASS'
>> +	via the value of this variable. Can be overridden by the `GIT_ASKPASS`
>>  	environment variable. If not set, fall back to the value of the
>>  	'SSH_ASKPASS' environment variable or, failing that, a simple password
>>  	prompt. The external program shall be given a suitable prompt as
> 
> We now have a minor inconsistency between GIT_ASKPASS and SSH_ASKPASS.

This is the side effect of changing only one pattern (GIT_*)

> You can catch this one and a handful others with
> 
>   git grep "'[A-Z_]*' environment"

With this regex, we can even catch environment variables without any
format or prefixed with '$':

git grep ".'\?\$\?[0-9A-Z_]\+'\? environment "

> (That would be a separate patch)

I'm on it.

Thank you.
