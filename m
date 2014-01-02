From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2013, #05; Thu, 26)
Date: Thu, 02 Jan 2014 13:11:32 -0800
Message-ID: <xmqqd2kaozqz.fsf@gitster.dls.corp.google.com>
References: <xmqq1u0zcoci.fsf@gitster.dls.corp.google.com>
	<CAPig+cQXsdFocFeSR8YKh8crOwBFP0ZK0td2UbP-yypRYJhREQ@mail.gmail.com>
	<7vmwjmj628.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ79qbEDai69T7pwvdTRk9rHBE5aSAKMZuOtwCw5qKPzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 22:11:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypYZ-0006gX-8i
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbaABVLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:11:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbaABVLv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:11:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA3A85E0BD;
	Thu,  2 Jan 2014 16:11:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r7tYt9/C8+GQejBy7gutcWud2OE=; b=Lxvujh
	1n6TwSBC6WI56t6Wy7i85MX3wPqIBQTrbdV4ImUE1ciGF/KqyVZ7JR7ugUIP0EC5
	A7GDHcnbJrwjmRkSZgFZU8DVEZiAyCelG36fhpyCDfoTLeON+cNFPps79bFsemG9
	ez0ogzh7QqH3Ra97B6VmqeXyrTPxd2MyAfTD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vlj4dSri44M5HBdKrVlE9BIH1Fa5gM4G
	VapIvAKxx4GL3rKPD5Pyq9SwbMJu53YE55RkVBKFaHOvH1lve6bknfX4MhuCERNu
	vA1uA3zkUHHrCD9mM52mU6/IM8SdNl1d7hEKeABTzXkdPuJddfqzwBJJ4foZ56dM
	wUxvWqUSuBA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8898A5E0BB;
	Thu,  2 Jan 2014 16:11:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACA885E0B7;
	Thu,  2 Jan 2014 16:11:48 -0500 (EST)
In-Reply-To: <CAPig+cQ79qbEDai69T7pwvdTRk9rHBE5aSAKMZuOtwCw5qKPzQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 2 Jan 2014 15:47:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7E291D68-73F2-11E3-8AE7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239883>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Dec 27, 2013 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> On Thu, Dec 26, 2013 at 4:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> [New Topics]
>>>
>>> Would $gmane/239575 [1] be of interest for "New Topics"?
>>>
>>> [1]: http://article.gmane.org/gmane.comp.version-control.git/239575/
>>
>> Actually I was planning to scoop it up directly to master but forgot
>> to do so.
>
> Make sense.
>
>> Running "git diff maint pu -- name-hash.c" shows that we have added
>> a comment that mentions index_name_exists---that needs to be
>> adjusted, too, by the way.
>
> Oops, yes, I had noticed that too when testing atop 'pu' but then
> forgot about it when preparing the patch for submission on 'master'.
>
> I'm not sure how to move forward with this now that kb/fast-hashmap,
> with which it has a textual conflict, has graduated to 'next'. Should
> this become a two-patch series with one for scooping directly to
> 'master' and one for 'next' to sit atop kb/fast-hashmap? (But how will
> the textual conflict be handled?)

I have a feeling that a small unused helper function is not a huge
breakage that needs to be immediately fixed, so a single patch as a
clean-up on top of whatever is cooking on 'next' should be the best
approach, I would think.
