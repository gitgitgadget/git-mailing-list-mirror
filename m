From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 5/6] config: add `git_die_config()` to the config-set API
Date: Mon, 28 Jul 2014 13:16:15 +0200
Message-ID: <vpqvbqhu41s.fsf@anie.imag.fr>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
	<1406543635-19281-6-git-send-email-tanayabh@gmail.com>
	<53D62C1A.5000203@ramsay1.demon.co.uk> <53D62DBD.9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiv6-0007Jc-Vo
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 13:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbaG1LQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 07:16:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60677 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbaG1LQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 07:16:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6SBGEVr010307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2014 13:16:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6SBGF0d015561;
	Mon, 28 Jul 2014 13:16:16 +0200
In-Reply-To: <53D62DBD.9@gmail.com> (Tanay Abhra's message of "Mon, 28 Jul
	2014 16:32:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Jul 2014 13:16:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6SBGEVr010307
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407150975.35754@ZCTu4xPko9n2PYQhOYXfnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254308>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/28/2014 4:25 PM, Ramsay Jones wrote:
>> On 28/07/14 11:33, Tanay Abhra wrote:
>>> +	if (!kv_info->linenr)
>>> +		die("unable to parse command-line config");
>>> +	else
>>> +		die("bad config file line %d in %s",kv_info->linenr, kv_info->filename);
>> 
>> How about including the 'key' string in the error message?
>> Similar comment applies to an earlier patch in this series.
>>
>
> git_config_get_string & pathname() are already raising a
> config_error_nonbool() with the error message,
> "Missing value for 'key'".
>
> For other cases, I was just following the previous error message,
> but it can be done for the new git_config().

It is good to follow the existing in this patch (better code, same
behavior), but I agree with Ramsay that including key in the error
message (for both branches of the if/then/else) in a further patch would
be good, and should be straightforward enough.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
