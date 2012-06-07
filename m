From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please revert e371046b6473907aa6d62b7862a3afe9d33561e1
Date: Thu, 07 Jun 2012 09:49:41 -0700
Message-ID: <7vd35bjcd6.fsf@alter.siamese.dyndns.org>
References: <m24nqoohss.fsf@gmail.com>
 <CA+39Oz4f_Wn1cVzqNWO76HZWa4AswSBpbriaRc0OznapVLJfGg@mail.gmail.com>
 <4FD05B45.2090006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Adam <thomas@xteddy.org>, John Wiegley <jwiegley@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 07 18:49:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScfuB-0001Kg-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 18:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760315Ab2FGQtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 12:49:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759264Ab2FGQto (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 12:49:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADF0E8268;
	Thu,  7 Jun 2012 12:49:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZBPrIzr1a+J2vXodPxY1b07Ajcs=; b=Of4Skx
	8JjjFX7lKwOJHRqHByEVIPGVocznN/xwLJGnuslS+y7qDwQpHddzL7xMrLTYnzuN
	ZbgigurkCuUES7KiRhNQU+QyftnQNST5kS5fWKG29LC9VofcsJH7puqnNgPhTnpM
	ZCQhyy1OD4cJPQYdOrm35NsRD7vj9T2/IU15g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m7IC3AZUXgvRTHUbXbvYjUMMC7wWxMqc
	zE6Dl+qE7LDU9R4cabfSpl54+fQ14PoMM+1hf35NrtXWuCVBTsKaFM6KbCZVEHcf
	rqwQpiz37ySFKG5k+j0vgqWeNFptCZZoCGXvaXvglHggXCW1Vt5vH0q22XN/OXHX
	Hfj+uJpB9kg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3DC88267;
	Thu,  7 Jun 2012 12:49:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 381788266; Thu,  7 Jun 2012
 12:49:43 -0400 (EDT)
In-Reply-To: <4FD05B45.2090006@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 07 Jun 2012 09:41:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7EFC222-B0C0-11E1-81D6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199418>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/06/2012 07:54 PM, Thomas Adam wrote:
>> On 6 June 2012 11:28, John Wiegley<jwiegley@gmail.com>  wrote:
>>> I've spoken to the author of this commit, Matthias Urlichs.  Here is an
>>> excerpt of our conversation:
>>>
>>>> On Sat, 2012-04-21 at 00:08 -0500, John Wiegley wrote:
>>>>> Just wanted to let you know that this bit me.  I have a client whose CVS
>>>>> repository I'm converting to Git, and they have _many_ log messages that
>>>>> are larger than 32k in size.
>>>>
>>>> Feel free to submit a patch that reverts this. These days, there's probably
>>>> no user of cvs2git left, but at that time it was important to get the same
>>
>> This assertion is not only wrong, it's just ludicrous.  The intended
>> functionality has a statement of intent with regards to its
>> functionality -- and as a user of cvs2git, I'd not want to lose *any*
>> of that functionality.
>
> I was confused about this conversation.  The commit that John Wiegley
> proposes to revert is from 2005.  The "cvs2git" functionality in
> cvs2svn was not added until 2007.  So it must be that commit
> e371046b64 was added for compatibility with some other cvs2git script
> (i.e., not the one that is part of the cvs2svn project).  Nowadays the
> only script called "cvs2git" that I ever see mentioned (and I maintain
> a Google search on that string) is the one from the cvs2svn project.
> So I assume that the old "cvs2git" script (the one mentioned in commit
> e371046b64's log message) has died off.

The way I read the log message of e371046b64 is that the repository
resulting from the conversion without this patch will be different
for repositories that were originally converted by the older
cvs2git.  So my impression is that it does not matter if the older
tool died long time ago.  As long as repositories converted by it
still lives in the field, reverting the patch will start producing
different (and arguably more correct) results for people who are
using such a repository that started its life long time ago.

The potential negative impact is not huge for projects that used
cvsimport for a one-time converion, and further developments all
happen in git, of course...
