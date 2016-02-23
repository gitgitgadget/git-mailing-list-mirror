From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/5] diff: activate diff.renames by default
Date: Tue, 23 Feb 2016 22:11:11 +0100
Message-ID: <vpq60xff7yo.fsf@anie.imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249498-3232-6-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqk2lvywch.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:11:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYKEu-0000PG-7m
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 22:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbcBWVLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 16:11:20 -0500
Received: from mx1.imag.fr ([129.88.30.5]:40553 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755279AbcBWVLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 16:11:20 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1NLB92X023100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 22:11:09 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NLBBLV014966;
	Tue, 23 Feb 2016 22:11:11 +0100
In-Reply-To: <xmqqk2lvywch.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Feb 2016 13:01:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Feb 2016 22:11:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NLB92X023100
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456866674.45966@2ZhQnNwvO0iCqWHCtqs6oA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287126>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 7f96c64..6e34df3 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -103,6 +103,7 @@ static int log_line_range_callback(const struct option *option, const char *arg,
>>  static void init_log_defaults()
>>  {
>>  	init_grep_defaults();
>> +	git_diff_ui_default_config();
>>  }
>
> Why isn't the new function called init_diff_ui_defaults()?

Indeed, that's a better name. I changed it.

>> diff --git a/diff.c b/diff.c
>> index 2136b69..d5db898 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -168,6 +168,11 @@ long parse_algorithm_value(const char *value)
>>   * never be affected by the setting of diff.renames
>>   * the user happens to have in the configuration file.
>>   */
>> +void git_diff_ui_default_config()
>
> s/()/(void)/;  same for the declaration in the header file.

Fixed. 'doing too much C++ and not enough C ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
