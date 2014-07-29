From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/6] rewrite git_config() to use the config-set API
Date: Tue, 29 Jul 2014 14:38:03 +0200
Message-ID: <vpqsilk8hn8.fsf@anie.imag.fr>
References: <1406633302-23144-1-git-send-email-tanayabh@gmail.com>
	<1406633302-23144-4-git-send-email-tanayabh@gmail.com>
	<53D786F9.9070002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:38:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC6fq-0007J8-GH
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 14:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbaG2Mia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 08:38:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51092 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753356AbaG2Mi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 08:38:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6TCc29Z020687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2014 14:38:04 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6TCc3CK029153;
	Tue, 29 Jul 2014 14:38:03 +0200
In-Reply-To: <53D786F9.9070002@gmail.com> (Tanay Abhra's message of "Tue, 29
	Jul 2014 17:05:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Jul 2014 14:38:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6TCc29Z020687
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407242286.4967@bnxxksCGpkHITnlV6XFmiw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254425>

Tanay Abhra <tanayabh@gmail.com> writes:

>> diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
>> index cd04543..741e080 100755
>> --- a/t/t4055-diff-context.sh
>> +++ b/t/t4055-diff-context.sh
>> @@ -79,7 +79,7 @@ test_expect_success 'non-integer config parsing' '
>>  test_expect_success 'negative integer config parsing' '
>>  	git config diff.context -1 &&
>>  	test_must_fail git diff 2>output &&
>> -	test_i18ngrep "bad config file" output
>> +	test_i18ngrep "bad config variable" output
>>  '
>>
>>  test_expect_success '-U0 is valid, so is diff.context=0' '
>>
>
> This was a minor fixup with only a changed word, so I didn't flip it and
> fix after in the series as you said yesterday. Dunno if it's alright.

You did right. It's not a new test, but an existing one that needs
update together with your code update.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
