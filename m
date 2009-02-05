From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH v4 1/4] Add log.mailmap as configurational option for
 mailmap location
Date: Thu, 05 Feb 2009 20:33:56 +0100
Message-ID: <498B3F24.6080305@trolltech.com>
References: <cover.1233819451.git.marius@trolltech.com> <cover.1233819451.git.marius@trolltech.com> <565c86bdbc8d6303d7d468fa196fb54ff7bd2352.1233819451.git.marius@trolltech.com> <7vljskeq21.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:35:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVA0d-0000Cq-JS
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 20:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760784AbZBETdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 14:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760779AbZBETdi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 14:33:38 -0500
Received: from hoat.troll.no ([62.70.27.150]:40232 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760750AbZBETdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 14:33:37 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 17E0020FBF;
	Thu,  5 Feb 2009 20:33:31 +0100 (CET)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id D62992044F;
	Thu,  5 Feb 2009 20:33:30 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <7vljskeq21.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108601>

Junio C Hamano said the following on 05.02.2009 18:44:
> Marius Storm-Olsen <marius@trolltech.com> writes:
> 
>> diff --git a/config.c b/config.c
>> index 790405a..9ebcbbe 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -565,6 +565,13 @@ static int git_default_branch_config(const char *var, const char *value)
>>  	return 0;
>>  }
>>  
>> +static int git_default_log_config(const char *var, const char *value)
>> +{
>> +	if (!strcmp(var, "log.mailmap"))
>> +		return git_config_string(&git_log_mailmap, var, value);
>> +	return 0;
>> +}
>> +
>>  int git_default_config(const char *var, const char *value, void *dummy)
>>  {
>>  	if (!prefixcmp(var, "core."))
>> @@ -579,6 +586,9 @@ int git_default_config(const char *var, const char *value, void *dummy)
>>  	if (!prefixcmp(var, "branch."))
>>  		return git_default_branch_config(var, value);
>>  
>> +	if (!prefixcmp(var, "log."))
>> +		return git_default_log_config(var, value);
>> +
> 
> The placement of this looked *really* wrong, as mailmap is not
> *that* important to most of the commands.
> 
> Initially I wondered if this should be better done inside existing 
> git_log_config().  I suspect that the reason you didn't do so is
> because you would want to use this also in blame, which is not part
> of the log family, and does not use git_log_config() (nor it
> should).
> 
> Which probably means that the code can stay here (it is just two
> strcmp and assignment to a pointer variable), but also suggests
> that log.mailmap is perhaps misnamed.


Correct, that was my reasoning behind it. Since shortlog is the only 
place in the documentation where mailmap is *directly* mentioned, it 
feels slightly tied to log. But, since blame and pretty.c also 
reference it, I needed the configuration option to be read as default.

Given that in total shortlog, blame, log, diff-tree, rev-list, show 
and whatchanged use it (the latter 5 through the pretty option), I'm 
tempted to say that it justifies its own option (mailmap.file?); but 
it would still have to be handled by git_default_config(). Renaming it 
would give it stronger reason to *be there* though.

I'm fine either way, really. Though, I think if we rename the option, 
it also justifies pulling the mailmap documentation out of 
git-shortlog.txt, into its own file, and link to it from shortlog, and 
the other commands which use it (git-blame.txt and pretty-format.txt)

I'll happily do the job, if "yay", or leave it as is if "nay".
Either way, feel free to rename log.mailmap to something else.

--
.marius
