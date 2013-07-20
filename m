From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] Add the NO_SENTINEL build variable
Date: Sat, 20 Jul 2013 18:51:28 +0100
Message-ID: <51EACE20.6030909@ramsay1.demon.co.uk>
References: <51E4338E.4090003@ramsay1.demon.co.uk> <20130715181357.GF14690@google.com> <51E82582.1030204@ramsay1.demon.co.uk> <7vli531ryh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 21 15:03:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0tIf-0001Sc-DC
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 15:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab3GUNDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 09:03:30 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:45531 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754961Ab3GUND3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 09:03:29 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 750C7A64569;
	Sun, 21 Jul 2013 14:03:27 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 922C2A64546;
	Sun, 21 Jul 2013 14:03:26 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Sun, 21 Jul 2013 14:03:25 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vli531ryh.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230931>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Jonathan Nieder wrote:
>>> Ramsay Jones wrote:
>>>
>>>> One of the three gcc compilers that I use does not understand the
>>>> sentinel function attribute. (so, it spews 108 warning messages)
>>>
>>> Do you know what version of gcc introduced the sentinel attribute?
>>> Would it make sense for the ifdef in git-compat-util.h to be keyed on 
>>> __GNUC__ and __GNUC_MINOR__ instead of a new makefile flag?
>>>
>>
>> I have on old (v4.2.1) gcc repo on Linux and looking at
>>
>>     ~/gcc-4.2.1/gcc/ChangeLog-2004
>>
>> I can see that the sentinel attribute was added on 2004-09-04 by
>> Kaveh R. Ghazi.
>>
>> Also, I find "bump version string to version 4.0.0" was on 2004-09-09
>> and "bump version string to version 3.5.0" was on 2004-01-16.
>>
>> Several of my system header files (on Linux) imply that the
>> sentinel attribute is supported by __GNUC__ >= 4. (One of them,
>> ansidecl.h, states that gcc 3.5 supports it but ...)
> 
> Perhaps a message from yesterday would have helped?
> 
>  http://article.gmane.org/gmane.comp.version-control.git/230633
> 
> seems to indicate that checking for version 4 is sufficient.
> 
> Also I asked you to split the __attribute__((sentinel(n)) support
> into a separate patch.  We currently do not pass anything but 0
> (meaning, the sentinel is always at the end), and SENTINEL in all
> capital is easy enough to grep for when somebody _does_ want to have
> such a support, so I'd prefer not to see __attribute__((sentinel(n))
> until it becomes necessary.

Sorry, but I didn't see any of these emails before sending this
and the subsequent patch email. :(

I can sometimes be away from email for several days at a time (and
then spend days trying to read the backlog - I'm on *far* too many
mailing lists!).

[The internet went black on me last night; I couldn't see anything
outside of my ISP's servers (and not all of those). I also couldn't
get any answer at the support phone number, so I probably wasn't the
only one ...]

ATB,
Ramsay Jones
