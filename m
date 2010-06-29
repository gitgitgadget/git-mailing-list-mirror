From: Junio C Hamano <gitster@pobox.com>
Subject: Re: origin/branchname and tracking branch pointing to different 
 commits?
Date: Tue, 29 Jun 2010 12:27:09 -0700
Message-ID: <7vocet8ws2.fsf@alter.siamese.dyndns.org>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
 <201001071813.01187.trast@student.ethz.ch>
 <76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
 <76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
 <7v7hrtzbau.fsf@alter.siamese.dyndns.org>
 <AANLkTinLVd483-ki6tVb545PgpOFeOLYLR_GiKM5xAl7@mail.gmail.com>
 <20100608183007.GA31293@coredump.intra.peff.net>
 <AANLkTik7bleuzqnMWMJoWljQ5zD0YbwBsFjZT5IzkV0q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 21:27:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTgSw-0008PQ-T9
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 21:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab0F2T1Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 15:27:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab0F2T1X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 15:27:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A5A8C0956;
	Tue, 29 Jun 2010 15:27:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0lRCCVLQFl1e
	1JaLqznjcwhFYKM=; b=qriSDpWr6rh6Na3VpXnOdsFv2Dxd8uZvLaaLXKdcCaL/
	L4nazvvztjgF+On3lxpAtgMSOSAdr4uKiL9AwMxoF4c20jCNLziUABeKJ0kldnLp
	OTla4St1aVEkJyoro1zsgRgnEE9xuvbA6JZ8XzDDdvEl9eEnYnkw99VV19F9KwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RDByNQ
	VM8/ctK+l/t8wWllHwRhiKe/EfF1QTPYUKNSDhwGFoOgREh+dnKd3PWOKtpt8h5U
	TBNEEMG7Aa/qkecKZbBd6qmWhcsKk4RYtgfXqRYDgXwT/UEf1xaZbfd7ep6oCbIQ
	l0xDLjDWelxL9WYYJe1G71kq5vt5e7qfVZfuY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D27AC094B;
	Tue, 29 Jun 2010 15:27:16 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1313CC094A; Tue, 29 Jun
 2010 15:27:10 -0400 (EDT)
In-Reply-To: <AANLkTik7bleuzqnMWMJoWljQ5zD0YbwBsFjZT5IzkV0q@mail.gmail.com>
 (Eugene Sajine's message of "Mon\, 28 Jun 2010 13\:43\:22 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 535B3D46-83B4-11DF-8815-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149925>

Eugene Sajine <euguess@gmail.com> writes:

>> This was discussed a while back:
>>
>> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/127163
>>
>> and I even posted a patch, but never followed up (I think mostly jus=
t
>> due to being busy).. There is some concern about unexpected ref upda=
tes,
>> though.
>
> Jeff, Junio
>
> Could you, please, advise if there is any resolution on the patch?

I do agree with Jeff that what his patch tried to do back in August las=
t
year was introducing backward compatibility and potentially breaking
workflows of existing users by updating refs in an unexpected ways.

However, as I discussed in

    Subject: Re: origin/branchname and tracking branch pointing to diff=
erent  commits?
    Date: Thu, 07 Jan 2010 16:32:09 -0800
    Message-ID: <7v7hrtzbau.fsf@alter.siamese.dyndns.org>

I have a slight suspicion that such an "unexpected ref update" is not a
big issue anymore.  So in principle, I think it is fine to change the
behaviour of "git fetch $there $these_explicit_refs" to additionally
follow the configured remote tracking ref globbing patterns.

Because

 (1) the old patch was never tested in a production context (I don't th=
ink
     it even hit 'pu');

 (2) I offhand do not know how much the codebase changed in the area th=
at
     would affect the assumptions the patch made back then; and

 (3) we will be in feature freeze for 1.7.2 anyway;

I would rather not be the one who is forward-porting the patch myself
if I can avoid it, however.

I could queue a version of the patch (with updates if necessary) to 'pu=
',
but not much more than that right now.
