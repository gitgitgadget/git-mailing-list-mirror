From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 0/6] fix repo name when cloning a server's root
Date: Thu, 6 Aug 2015 09:22:21 +0200
Message-ID: <55C30B2D.5000308@web.de>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438687797-14254-1-git-send-email-ps@pks.im>
 <xmqq4mkd4p1x.fsf@gitster.dls.corp.google.com>
 <20150805211947.GC21134@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	pclouds@gmail.com
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 09:42:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNFpC-0005mC-GQ
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 09:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbbHFHmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 03:42:46 -0400
Received: from mout-xforward.web.de ([82.165.159.2]:61095 "EHLO
	mout-xforward.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbbHFHmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 03:42:46 -0400
X-Greylist: delayed 1211 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Aug 2015 03:42:45 EDT
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Mcnuz-1Z5RXV3J4L-00Hz8Z; Thu, 06 Aug 2015 09:22:25
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.1.0
In-Reply-To: <20150805211947.GC21134@sigill.intra.peff.net>
X-Provags-ID: V03:K0:cY6Dv0WBbOOO8yDICT2Qikv1vUMgnhn8cX6hHdMJsxAEQ6VEZ+u
 tQ85npv7/25V0cbmbXW3MUrjWeC7yLO+p3TASisxw6lhp4mdMANKv9WMXbLgc3Nu1OOnrEk
 Eqr9SVpTHjmIhUb9ApypOTZgcxvhY0RTrFybx48gE6mlaI1i06qLUoSsX1XabR4J0pFreCz
 nRG36tgnfV+WglcviThAg==
X-UI-Out-Filterresults: junk:10;V01:K0:wJ/S4hyq+T8=:m7YBKeJFiI3ylsVU/79bZw2O
 FmX4Tf2dqye2Qp4flc6H1KsRix6lWUJBGr4tDDtlof1fXQ9jd+algqb53rg+4x3juynu+tuir
 gN/0yqCiiEmi75AtTJIb7NIktz0cWaHnLbF/t8O6yzF0NuijQgwRlCtsPhDm2oGkuGE6fCRKu
 FNb3x53X7Jgiqu7y7hcJ6Qh3J68fF/Ehh17qLEsHnxBa4T9V6KKW8ZKjV0Q7Bl79g3ciLFRjQ
 liI3iyNp2wU2eC8B0GX2seciCAEX15iEc/mm1SW3UIUe/bqLtclyTpqUSgo6oiTPM6RWfYZ50
 VIFZpUytrps0DVbWNv2aUPlfBMMvFG7OIa4LLhEByi5MLBEjcgq708AfpTD7HSzYd38G28Xa1
 6lrNh3NoKEwTgnqnf3YVySXMZ43D31ZLOwJlyqLPa0lGKLPNSSW/nsFtGT3r4/9BXnB0ruISS
 u/Qrahy+Q0fGaRESnt0UYLm+j7iizvRBUoJDVPybHaRh9FIdQKEqg00Djh2fhlz+/R3oDARJP
 gRD5g8oqNc6wJLcTMbImQfKSV3AFfpCbYwn2n2oSpd+qnMSj68PGUzDv8i/HiSNlpKJ4kY1Dg
 jiTYnAMrrraH8sE8fGgddWXsfo17sZxbnYRknuOdwSCVL+1qiN00+mUI51i4itL1P4tpprpDT
 kgX9/TNnWZ6AOng/EugHCQSSmOZPRDyIlKqszIvl1MAyTLuzUDO/wml+nsrdr1zp2M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275417>

On 2015-08-05 23.19, Jeff King wrote:
> On Wed, Aug 05, 2015 at 10:34:34AM -0700, Junio C Hamano wrote:
> 
>>> As you can see, there is a lot of complexity in there and I'm not
>>> convinced this is better than just exposing
>>> 'parse_connect_url()', which already handles everything for us.
I try expose and use parse_connect_url():
It handles the scp-like syntax "host:/path,
literall IPV6 addresses, port numbers,
':' without a port number and all other Git specific parsing,
which is inside and outside the RFC 3986.
(I should know, because I managed to break the parser twice,
and fix it)

I added a diagnostics to connect.c, and if you run the a simply test,
we can see that the colon slash logic is often unsufficient:

tb@mypc:~/projects/git/tb.150731_connect> ./git fetch-pack --diag-url ssh://host/
Diag: url=ssh://host/
Diag: protocol=ssh
Diag: userandhost=host
Diag: port=NONE
Diag: path=/
Diag: guesseddir=host/
tb@macce:~/projects/git/tb.150731_connect> ./git fetch-pack --diag-url ssh://host:/
Diag: url=ssh://host:/
Diag: protocol=ssh
Diag: userandhost=host
Diag: port=NONE
Diag: path=/
Diag: guesseddir=/


On top of that, you can easily write test cases in t5601, as many as you want.
The (minor) drawback is that it doesn't handle http:// or https://,
but that is easy to add in the parser, and doesn't break existing code.

The major which remains is to search for '@' in userandhost,
and strip that off.
(Or when there is a '@', search for a ':' before the '@', and strip that off)
After that, all non-printable characters should be %-escaped.
If we replace ':' as non-printable as well, we can make Windows users 1% more happy.


>>
>> If the function "handles everything for us", that's fine, but the
>> primary reason I am hesitant is because parse_connect_url() was
>> designed specifically not to have to worry about some protocols
>> (e.g. I think feeding it a "http://" would fail, and more
>> importantly, its current callers want such a call to fail).  Also it
>> is meant to handle some non-protocols (e.g. scp style host:path that
>> does not follow <scheme>://...).
> 
> True, but the transport code _is_ handling that at some point. It makes
> me wonder if it would be possible to push the call to transport_get
> further up inside cmd_clone(), and then provide some way to query the
> remote path and hostname from the transport code. Then guess_dir_name
> could just go away entirely, in favor of something like:
> 
>   dir_name = transport_get_path(transport);
>   if (!*dir_name)
> 	dir_name = transport_get_host(transport);
> 
> That may be overly simplistic or unworkable, though. I haven't dug into
> the code.
> 
>> Also does it handle the "2222" case above?  I do not think
>> parse_connect_url() even calls get_host_and_port() to be able to
>> tell what "2222" means in these examples.
> 
> Speaking of which, has anyone tested whether the old or new code handles
> external remote helpers? Certainly:
> 
>   foo::https://host/repo.git
> 
> should still use repo.git. But technically the string handed to
> git-remote-foo does not have to look anything like a URL. In those cases
> neither guess_dir_name nor the transport code have any idea what anything
> to the right of the "::" means; we probably have to resort to blind
> guessing based on characters like colon and slash.
> 
It is easy to strip the foo:: part of the url, assume that
the remote helper uses a RFC 3986 similar url syntax, so that we
can feed the reminding https://host/repo.git into the parser (see above).

If the remote helper doesn't do this, we can't guess anything, can we ?
So error out and tell the user seems the right thing to do.

In the hope that this is useful, pushed my prototype branch to
https://github.com/tboegi/git/tree/150731_connect_diag_guess_name
