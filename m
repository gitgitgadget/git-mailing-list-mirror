From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Wed, 02 Jul 2014 19:09:39 +0200
Message-ID: <vpqbnt7k7qk.fsf@anie.imag.fr>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
	<1404280905-26763-2-git-send-email-tanayabh@gmail.com>
	<xmqqd2dnitm7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 19:10:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2O35-00084r-PJ
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583AbaGBRKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:10:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35761 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaGBRKP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:10:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s62H9dd8029215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Jul 2014 19:09:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s62H9dod004155;
	Wed, 2 Jul 2014 19:09:39 +0200
In-Reply-To: <xmqqd2dnitm7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 02 Jul 2014 10:00:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Jul 2014 19:09:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s62H9dd8029215
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404925784.02583@Jk8GJ7oKbpqvZnseUyRCbg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252800>

Junio C Hamano <gitster@pobox.com> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
>> index 230b3a0..2c02fee 100644
>> --- a/Documentation/technical/api-config.txt
>> +++ b/Documentation/technical/api-config.txt
>> @@ -77,6 +77,75 @@ To read a specific file in git-config format, use
>>  `git_config_from_file`. This takes the same callback and data parameters
>>  as `git_config`.
>>  
>> +Querying For Specific Variables
>> +-------------------------------
>> +
>> +For programs wanting to query for specific variables in a non-callback
>> +manner, the config API provides two functions `git_config_get_value`
>> +and `git_config_get_value_multi`.They both read values from an internal
>> +cache generated previously from reading the config files.
>> +
>> +`git_config_get_value` takes two parameters,
>> +
>> +- a key string in canonical flat form for which the corresponding value
>
> What is "canonical flat form"?

Actually, it's defined above in the same file (was here before the
patch):

  - the name of the parsed variable. This is in canonical "flat" form: the
    section, subsection, and variable segments will be separated by dots,
    and the section and variable segments will be all lowercase. E.g.,

But it might make sense to reword the doc, e.g. introduce a glossary
section at the beginning.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
