From: Ivan Todoroski <grnch@gmx.net>
Subject: Re: [PATCH v3 3/4] fetch-pack: test cases for the new --stdin option
Date: Tue, 03 Apr 2012 02:23:32 +0200
Message-ID: <4F7A4304.9040800@gmx.net>
References: <4F79C195.6090905@gmx.net> <4F79C2C8.3020009@gmx.net> <7v4nt2exlr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 02:23:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SErWg-0001Fd-5H
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 02:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab2DCAXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 20:23:04 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:54408 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751497Ab2DCAXD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 20:23:03 -0400
Received: (qmail invoked by alias); 03 Apr 2012 00:23:00 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.173.116]
  by mail.gmx.net (mp002) with SMTP; 03 Apr 2012 02:23:00 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX1/oGoZ8E+PoSrj0lC5j7qoj//A7G3dsIZMzhLmUhO
	nfFzuoy9LSOUql
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <7v4nt2exlr.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194582>

On 02.04.2012 21:34, Junio C Hamano wrote:
> Ivan Todoroski <grnch@gmx.net> writes:
> 
>> +test_expect_success 'setup tests for the --stdin parameter' '
>> +	for head in C D E F
>> +	do
>> +		add $head
>> +	done &&
>> +	for head in A B C D E F
>> +	do
>> +		git tag $head $head
>> +	done
>> +	cat >input <<EOF
>> +refs/heads/C
>> +refs/heads/A
>> +refs/heads/D
>> +refs/tags/C
>> +refs/heads/B
>> +refs/tags/A
>> +refs/heads/E
>> +refs/tags/B
>> +refs/tags/E
>> +refs/tags/D
>> +EOF
>> +	sort <input >expect
>> +	(
>> +	echo refs/heads/E &&
>> +	echo refs/tags/E &&
>> +	cat input
>> +	) >input.dup
>> +'
> 
> 
> This breaks && chain; also it is easier to read if indentation is used
> properly.
> 
> I'll queue it after fixing the above locally (the rest looked OK to me).
> 
> Thanks.

I just saw the neat <<- trick in your reworked version, nice! Somehow 
I've never stumbled on to that part of the bash man page before. :|

When I look back how many shell scripts I've mangled with indentation 
like above, it breaks my heart. :)
