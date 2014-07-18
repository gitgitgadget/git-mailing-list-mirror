From: Junio C Hamano <gitster@pobox.com>
Subject: Re: a more helpful message on "git status" output
Date: Fri, 18 Jul 2014 14:12:13 -0700
Message-ID: <xmqqy4vql6c2.fsf@gitster.dls.corp.google.com>
References: <CAKQhN+rK0ftwC5hX4hDhXZbcEGAfCCBXRaQXYnMFLmR=n21OLA@mail.gmail.com>
	<xmqq38dympo8.fsf@gitster.dls.corp.google.com>
	<CAKQhN+p5FpX-GEZeX0t-Y1Sq6+fdfRpE+ACqhKgdLWGFRj0ToA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Juli=C3=A1n?= Landerreche <maniqui@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 23:12:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8FSB-0008WJ-2f
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 23:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbaGRVM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 17:12:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62881 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762161AbaGRVM0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 17:12:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7FA129374;
	Fri, 18 Jul 2014 17:12:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lVH7SBIAnEgR
	cGGlmg6w4C340uo=; b=Y9nI4HhNqgeMuWi+BMr5Jmft0fymlRnaiZNQ2vvm4qA0
	WiATdJFnVQZw7vh1sH8zzohke3mKAjww53NwPU4GVP/IJpN3VoY9OuL7+/xIFjjp
	G0fc0omRg6+FKLuXUFG2utasooZFw8dIZJUbLVf/uchwRWcvs3BZOPkntAjNvYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=avmJLx
	hzu+SgX07nmfGvCJirZ29cgUWCQgBnx+uYQEwrPa5vRIBacncXR3w04DZXxnGa4a
	gis48po/ggQaIFXv08flLpNxMFPeLYE64e6S+5ksR8cZRl7KkUrzYO0KVDnJ6BtO
	OrXXCzr/wpoy2inb+saKsjVzeznjGHvF2fVys=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA4B029373;
	Fri, 18 Jul 2014 17:12:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F386529365;
	Fri, 18 Jul 2014 17:12:14 -0400 (EDT)
In-Reply-To: <CAKQhN+p5FpX-GEZeX0t-Y1Sq6+fdfRpE+ACqhKgdLWGFRj0ToA@mail.gmail.com>
	(=?utf-8?Q?=22Juli=C3=A1n?= Landerreche"'s message of "Fri, 18 Jul 2014
 16:47:15 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3135D6AE-0EC0-11E4-B672-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253847>

Juli=C3=A1n Landerreche <maniqui@gmail.com> writes:

>> By running "git pull", the user may obtain yet newer commits from
>> the upstream, which very likely will happen in an active project, or
>> "git fetch" launched by "git pull" will return without doing
>> anything after noticing there is nothing new.
>>
>> As long as the updates to the upstream is also a fast-forward, it
>> will still fast-forward you, but to an even newer state of the
>> upstream.
>>
>> There is no harm done[*1*] by suggesting "git pull" over "git
>> merge", no?
>
> OK, I'm mostly convinced.
> A more verbose, educational output could read:
>
>   (use "git pull" to fetch newer commits from upstream and update you=
r
> local branch)
>   (use "git merge" to update your local branch)

I actually do not like that, to be honest.

These brief reminders should be just that, and if anything, we
should aim to make them shorter and more concise, not longer and
more verbose.  They will never be sufficient to replace "education"
(otherwise why would we even have complete manual?)---they should
just point the users clearly in the right direction.
