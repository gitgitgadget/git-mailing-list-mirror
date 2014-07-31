From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config.c: mark error and warnings strings for translation
Date: Thu, 31 Jul 2014 14:18:32 +0200
Message-ID: <vpq61idafhj.fsf@anie.imag.fr>
References: <1406806283-21571-1-git-send-email-Matthieu.Moy@imag.fr>
	<53DA3269.40901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 14:19:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCpKK-0007JL-0X
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 14:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbaGaMTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 08:19:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60506 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbaGaMTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 08:19:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6VCIVpn006951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 14:18:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VCIWmD025485;
	Thu, 31 Jul 2014 14:18:32 +0200
In-Reply-To: <53DA3269.40901@gmail.com> (Tanay Abhra's message of "Thu, 31 Jul
	2014 17:41:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 Jul 2014 14:18:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VCIVpn006951
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407413912.3532@LOWyEFz31gLaymUuGcDR2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254562>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/31/2014 5:01 PM, Matthieu Moy wrote:
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> Noticed while reviewing Tanay's patches, but this one is independant
>> from his series, both syntactically and semantically.
>> 
>>  config.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>> 
>> diff --git a/config.c b/config.c
>> index a191328..76eeb63 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -457,9 +457,9 @@ static int git_parse_source(config_fn_t fn, void *data)
>>  			break;
>>  	}
>>  	if (cf->die_on_error)
>> -		die("bad config file line %d in %s", cf->linenr, cf->name);
>> +		die(_("bad config file line %d in %s"), cf->linenr, cf->name);
>>  	else
>> -		return error("bad config file line %d in %s", cf->linenr, cf->name);
>> +		return error(_("bad config file line %d in %s"), cf->linenr, cf->name);
>
> Can I package your patch with mine in which I am going to change the
> error message to print the variable name also?

Yes, you can include it as PATCH 1 for example, and then build on top.

>> @@ -662,7 +662,7 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
>>  		return config_error_nonbool(var);
>>  	*dest = expand_user_path(value);
>>  	if (!*dest)
>> -		die("Failed to expand user dir in: '%s'", value);
>> +		die(_("Failed to expand user dir in: '%s'"), value);
>
> nit : error messages start with a small letter. same case below for "Invalid". ;)

Indeed. Then I'm letting you continue on the patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
