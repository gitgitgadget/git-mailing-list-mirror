From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jk/tag-contains (Re: What's cooking in git.git (Jul 2010, #05;
 Wed, 28))
Date: Sun, 01 Aug 2010 21:04:23 -0700
Message-ID: <7vocdlpsmw.fsf@alter.siamese.dyndns.org>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
 <20100730183709.GC18544@coredump.intra.peff.net>
 <20100731060703.GA21207@burratino>
 <20100731123328.GA5273@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 02 06:04:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfmGb-0003wy-4O
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 06:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab0HBEEg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 00:04:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab0HBEEf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 00:04:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A3CCA870;
	Mon,  2 Aug 2010 00:04:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0V/envBSvINj
	no3ESPPMLojNIIQ=; b=MlAQc+78PurAN81PztCBqUIIHkNUbRgX7jw5ATo3Vy2g
	LMzNjBU9ZQ/TDTmmcENaGRT+qnDm7swM1d+QSd3jFBbRE5ncNfI3J0WbfhJxJzf2
	q1lEJH41O0h6ogGHRkvdX33SAvUqbzh9uydApBurmbg6WXqHDom9Bt0F30/QxjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rp/TkY
	QdUDx910Rp2hJgaqU7ZOgatZExJ72VmcX6jTT7g89e8pgBKqVv98tyDDYE9VEg6o
	fbQoyBsFPw2PIkz9KHgi6sqjnAVTc66FFLNeVBF7Ka2VvaooeaoppAr2EmMV3Jfo
	RBVjoAKD+JSD498n+HjmzG4ddDsvvfAl3I7Fg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E817CA86F;
	Mon,  2 Aug 2010 00:04:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A5B2CA86B; Mon,  2 Aug
 2010 00:04:25 -0400 (EDT)
In-Reply-To: <20100731123328.GA5273@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 31 Jul 2010 08\:33\:28 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C381F50-9DEB-11DF-AAF3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152388>

Jeff King <peff@peff.net> writes:

> On Sat, Jul 31, 2010 at 01:07:03AM -0500, Jonathan Nieder wrote:
>
>> > The third one is where we start defaulting things to "assume no mo=
re
>> > than 1 day of clock skew by default", which can cause incorrect an=
swers
>> > in the face of skew.
>>=20
>> I think the default should be something that (just barely) works
>> correctly for linux-2.6.git.
>
> I am tempted by that (and it is why I made the fourth patch to actual=
ly
> calculate the worst skew). But my concern is that there are projects
> with even worse skew. Maybe that is unfounded.
>
>> > The fourth is just an illustrative patch for per-repo skew detecti=
on.
>>=20
>> I have been hoping for a chance to look these over, time hasn=E2=80=99=
t come my
>> way yet.

Sorry, but I am right in the middle of phisically moving, so my weekend
and evening git time has been nil recently.

> It just a git-skew program to calculate the skew, but doesn't do
> anything fancy like detect-on-gc. However, it would be nice to have
> somebody sanity check the algorithm. Looking at it again, I think it
> might actually miss some skew if the skewed commit can be reached in
> multiple ways.
>
>> Additional things to do (this is mostly a note to myself):
>>=20
>>  - refuse to commit with a timestamp long before any parent
>
> Agreed.

You need to be careful here, though.  What if you pulled from somebody
whose clock is set grossly in the future?

>>  - check slop and warn about it in fsck (maybe your patch does this
>>    already)
>
> No, it doesn't, but it is something we should probably do.

I wonder if we can make fsck to notice a commit with a wrong timestamp
(i.e. older than some of its parents) and make a note of it (hopefully
they are miniscule minority)---then during the revision traversal when =
we
hit such a commit, we perhaps ignore its timestamp (pretending as if it=
s
timestamp is one of its children or parent---I haven't thought about th=
e
details, but the note fsck leaves can record what adjusted timestamp
should be used) to fix the issue?
