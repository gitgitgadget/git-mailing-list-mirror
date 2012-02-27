From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] fsck: do not print dangling objects by default
Date: Mon, 27 Feb 2012 07:42:32 +0100
Message-ID: <4F4B25D8.8040803@in.waw.pl>
References: <20120226204357.GA26088@ecki> <7vty2ddzqj.fsf@alter.siamese.dyndns.org> <7vhayddxgp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 07:42:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1uII-0008Rz-4h
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 07:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab2B0Gmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 01:42:40 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55206 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab2B0Gmk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 01:42:40 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S1uIA-0004vi-9l; Mon, 27 Feb 2012 07:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7vhayddxgp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191601>

On 02/26/2012 11:46 PM, Junio C Hamano wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> I think that both the ultimate goal explained above, and the direction in
>> which the documentation updates tries to move us, are good.  I only gave a
>> cursory look at the code changes, but what they implement seems to match
>> the intention.
>>
>> Of course I may be missing something, so objections from others to argue
>> why we shouldn't do this is very much welcomed to stop me and Clemens ;-).
>
> Let's start with the obvious.
>
> It is much easier for a user to use a new option on the command line when
> he wants to use an improved behaviour when he runs the command manually.
> Having to update scripts that run the command to act on its output, on the
> other hand, is much more painful to the users.
>
> And the intended audience for this change clearly is interactive users
> that follow the user-manual to try things out.
>
> Given that, isn't it not just sufficient but actually better to instead
> add a new --no-dangling option and keep the default unchanged?

I understood the goal of this change as "modify fsck output to not show 
confusing 'dangling' messages by default. Not when running the tutorial 
and having the output explained in parallel, but when someone runs 
git-fsck to clean up the repository. In that situation, if somebody 
knows enough to run --no-dangling, than they know enough to ignore the 
'dangling' messages in the output.

For the knowledgeable user, --no-dangling could be useful to avoid 
uninteresting messages which usually dwarf the rest of output, but this 
would be less important.

Zbyszek
