From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 09/10] config: add core.untrackedCache
Date: Mon, 04 Jan 2016 10:09:00 -0800
Message-ID: <xmqqd1thp683.fsf@gitster.mtv.corp.google.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-10-git-send-email-chriscool@tuxfamily.org>
	<xmqqlh8cg9y2.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0pOiqa5ZxwM0Vfzr_wMJ+HDrXyhzJ+TmRDED5GH+koMw@mail.gmail.com>
	<xmqqbn97cyh3.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD35VZ3QCLg525RCpacDrRHqt7EhxV1MeL-9xxHf8BCZ+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 19:09:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG9ZC-0004Vs-QM
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 19:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbcADSJK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jan 2016 13:09:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752850AbcADSJF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2016 13:09:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55A8A3464D;
	Mon,  4 Jan 2016 13:09:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HNHeXGhQFQLY
	bFy7HI3vI/Hi6Rk=; b=G9EEyswVEgQMZUnZEoLw0noicl2T7tI6votA5q8hVMsu
	VA85aqvNTliPUjKIoL6cMIk4Qx+g3+2AU3h7aG/fi0yaECVpjt6uAjOseL0tJVud
	n2eYBtgc4tsywVCDi4kul3ylIc6YeJULwtcshP/H5xsX65tf/TnP1ta1RY4BoOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hwtZUR
	gnpxIlIGgtOyO/V4kjnKdRZ7XbzAqpa2xF2gEeR1PjCIvUMyxzE03tXIrQBKyM24
	z5O4E/+fxe7aVxEQBM42uYseQXUyryXX+T/hUFA0t4SVEFYdsb1eCYn1HBuluqw2
	7iyidZTH/lTebGTQ9MWk7ZRqTB0Afkrw2cus8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D0623464C;
	Mon,  4 Jan 2016 13:09:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF25D34647;
	Mon,  4 Jan 2016 13:09:03 -0500 (EST)
In-Reply-To: <CAP8UFD35VZ3QCLg525RCpacDrRHqt7EhxV1MeL-9xxHf8BCZ+A@mail.gmail.com>
	(Christian Couder's message of "Thu, 31 Dec 2015 13:33:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CF12B8A-B30E-11E5-8C76-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283311>

Christian Couder <christian.couder@gmail.com> writes:

> What scenario do you have in mind where people would have to do thing=
s
> differently?

They eventually will see a system in which that they do not have do
anything after flipping the configuration, yet will still see stale
"you must run 'git status'" on their websearches and SO questions,
which would be a cost for them to remember that they no longer have
to do the extra 'git status'.

>> Itt sounds like somewhat a short-sighted mindset to design the
>> system, and I was hoping that by now you would have become better
>> than that.
>>
>> The real question is what are the problems in implementing this in
>> the way Duy suggested in the previous discussion.  The answer may
>> fall into somewhere between "that approach does not work in such and
>> such cases, so this is the best I could come up with" and "I know
>> that approach is far superiour, but I have invested too much in this
>> inferiour approach and refuse to rework it further to make it better=
=2E"
>
> My question is why should I invest time thinking about and testing
> another approach when the current approach seems simpler, less bug
> prone, faster and without any downside?

As to the downside, I think Duy's "at the time we read the index" is
the least problematic route from the maintainability point of view.
What are you doing to help people who make changes in the future to
the system to make "git add $dir" or "git clean $dir" aware of the
untracked cache not to forget doing the "oh, the config says we want
to add the untracked cache if missing, so we do it here" in their
new codepath?  Whey you say "This is only about status", you are
essentially saying "It's outside the scope of my job, I was hired to
improve the usability of 'git status' with untracked cache and I do
not care about the longer term overall health of the system".

Now, you said something about "simpler", "less bug prone" and
"faster" (I doubt you can make such statements that involve
comparison without investing time thinking about other approaches,
though, but that is a separate topic).  That would mean that you see
"complexity", "error prone-ness", and "slowness" in the way Duy
suggested---that is exactly the question I asked you in the message
you are responding to.  What are the problems in implementing this
in the way Duy suggested?  What kind of "complexity" do you see?
Which part is more "error prone"?  Why does it have to be "slower"?

>> Using of not using untracked-cache is (supposed to be) purely
>> performance and not correctness thing, and I do not think the users
>> and the scripts do not deserve to see a failure from "update-index
>> --untracked-cache" only because there is a stray core.untrackedCache
>> set to 'false' somewhere.
>
> This "stray core.untrackedCache" could not have been put there by
> users of previous git versions because it has no meaning before this
> patch series. So I don't understand why you call it "a stray
> core.untrackedCache".
>
> It is no more "stray" to me than the call to "update-index --untracke=
d-cache".
>
> If it has been put in /etc/git.config by an admin and if the user
> thinks he knows better, the user can still change the config locally
> to override the system one.

You are assuming that everybody constantly looks at /etc/git.config
to make sure evil admins won't do things that affect their
repositories and use of Git in potentially negative way.  I doubt
anybody does.

By the way, I understand that this "stray one affects without user
being aware of it" is the primary the reason why =C3=86var wants this
'configuration automatically adds untracked cache even to the
existing index' feature---everybody will get it without even be
aware of the change their admins make.  Which may be a good thing
for those who use the configuration variable.
