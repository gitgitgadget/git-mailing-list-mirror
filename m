From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [GUILT] [PATCH] Fix fatal "guilt graph" error in sha1sum invocation.
Date: Thu, 15 Mar 2012 10:49:44 +0100
Message-ID: <m2haxqjirr.fsf@igel.home>
References: <87399bpaq9.fsf@opera.com> <m2k42nmf5g.fsf@igel.home>
	<4F61AB63.5040304@opera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff Sipek <jeffpc@josefsipek.net>, git@vger.kernel.org,
	ceder@lysator.liu.se
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 10:49:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S87Jm-0002Ow-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 10:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760984Ab2COJtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 05:49:51 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:57347 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab2COJtv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 05:49:51 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3V7lQK0w23z3hhb5;
	Thu, 15 Mar 2012 10:49:44 +0100 (CET)
X-Auth-Info: 1bqUZMaTB05XMTuVWLnf7VuXJpFVOmXcSU8ePuYc9lg=
Received: from igel.home (ppp-93-104-138-214.dynamic.mnet-online.de [93.104.138.214])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3V7lQK0GT6z4KK5H;
	Thu, 15 Mar 2012 10:49:45 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id B572BCA29F; Thu, 15 Mar 2012 10:49:44 +0100 (CET)
X-Yow: I once decorated my apartment entirely in ten foot salad forks!!
In-Reply-To: <4F61AB63.5040304@opera.com> (Per Cederqvist's message of "Thu,
	15 Mar 2012 09:42:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193205>

Per Cederqvist <cederp@opera.com> writes:

> On 03/14/2012 03:27 PM, Andreas Schwab wrote:
>
>> Per Cederqvist<cederp@opera.com>  writes:
>>
>>> -	openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
>>> +	if [ $# = 1 ]
>>> +	then
>>> +		openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
>>> +	else
>>> +		openssl dgst -sha1 | sed 's,$,  -,'
>>
>> $ openssl dgst -sha1</dev/null
>> (stdin)= da39a3ee5e6b4b0d3255bfef95601890afd80709
>
> Was that on a Darwin?

No.

$ openssl version
OpenSSL 1.0.0e 6 Sep 2011

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
