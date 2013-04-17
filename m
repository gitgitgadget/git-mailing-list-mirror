From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 16/33] t3210: test for spurious error messages for dangling
 packed refs
Date: Wed, 17 Apr 2013 10:11:36 +0200
Message-ID: <516E5938.6040704@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu> <1365944088-10588-17-git-send-email-mhagger@alum.mit.edu> <7vobdfvglf.fsf@alter.siamese.dyndns.org> <516D5CC6.10505@alum.mit.edu> <7vip3mhxhq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 10:11:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USNT2-0005Ri-67
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 10:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965985Ab3DQILn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 04:11:43 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:47252 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965847Ab3DQILl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 04:11:41 -0400
X-AuditID: 12074413-b7f226d000000902-d1-516e593c00ae
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 36.E5.02306.C395E615; Wed, 17 Apr 2013 04:11:40 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3H8Bbub012176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 17 Apr 2013 04:11:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vip3mhxhq.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqGsTmRdosHgph0XXlW4mi4beK8wW
	Kx/fZbb40dLD7MDi0f7+HbPHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdcWTebfaC
	69wVL79+Ympg3MzZxcjJISFgIvG7+SwjhC0mceHeerYuRi4OIYHLjBKL2j6yQjjHmSSWrNrK
	AlLFK6AtcfTnbHYQm0VAVeLMgz1MIDabgK7Eop5mMFtUIExi1fplzBD1ghInZz4B6xURUJOY
	2HYIyObgYBaIkTh3VQgkLCwQK7F2yh+wkUICHxglVm12A7E5Bcwk7txYAhZnFtCReNf3gBnC
	lpfY/nYO8wRGgVlINsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqp
	KaWbGCHhLLyDcddJuUOMAhyMSjy8FwpyA4VYE8uKK3MPMUpyMCmJ8l6IyAsU4kvKT6nMSCzO
	iC8qzUktPsQowcGsJMI7PwQox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh
	4FCS4E0CGSpYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPa+AGnn
	LS5IzAWKQrSeYtTlWHnlyWtGIZa8/LxUKXHeBpAiAZCijNI8uBWw5PWKURzoY2Fed5AqHmDi
	g5v0CmgJE9CSA6uyQZaUJCKkpBoYo746B66ddPbTHNvDFqJsa9iyhU1uxgqcO2J85c8d7UeC
	LKlcsxIWsPF2Pv56iv9Cno1UCp9rzO41uhHa2feWSPXxlWjP8Nx9R7s1sHRDo1UK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221518>

On 04/17/2013 01:22 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> would be that it expires *everything*.  But in fact it seems to only
>> expire things that are at least one second old, which doesn't seem at
>> all useful in the real world.  "--expire=all" is accepted without
>> complaint but doesn't do what one would hope.
> 
> Perhaps that is worth fixing, independent of this topic.
> 
> Approxidate gives the current time for anything it does not
> understand, and that is how --expire=all is interpreted as "anything
> older than now".  For that matter, even a string "now" has long been
> interpreted as the current time with the same "I do not understand
> it, so I'll give you the current timestamp" logic, until we added an
> official support for "now" at 93cfa7c7a85e (approxidate_careful()
> reports errorneous date string, 2010-01-26) for entirely different
> reasons.
> 
> A completely untested patch for your enjoyment...

I enjoy it :-)  But it would be better to put the the function in the
date module ("approxidate_expiry_careful()"?) and also use it from other
places where an expiry date is being parsed, like

    prune --expire=<date>
    reflog expire --expire=<date>/--expire-unreachable=<date>
    gc --prune=<date>

(maybe there are others).  And the special values "all" etc. would need
to be documented.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
