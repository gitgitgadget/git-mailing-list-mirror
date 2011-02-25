From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 11:54:14 -0800
Message-ID: <7vei6vao0p.fsf@alter.siamese.dyndns.org>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
 <7v8vx4aqun.fsf@alter.siamese.dyndns.org>
 <AANLkTinzhd_nL265e7DZA4xEnXqDn-5m=9GPS7JsFY-S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:54:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3kG-0008RS-Po
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932862Ab1BYTy1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 14:54:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810Ab1BYTy1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 14:54:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA70C4D1D;
	Fri, 25 Feb 2011 14:55:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ktHlAfG+7qsK
	db1/8skJI6u1NYI=; b=TWn3KU4g6gX+Pbf0bUfny7G45uFIkenFsK2mQTwxFFOH
	UC7BEhzBDUxkX1QBqV/a/ODcqWxuOubuoUzclF5EYaYdJgIZNQGeLLoMcwnV9n4U
	0DkKBrjxX+8aUy6X1A27ZHnILOSwnYG9DseX+JpEfr0VhpQIHAX0WI5AbTQz3hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dEfA3d
	R9QNIMlB7Bl6seVs0YYBFOw6zgJk5C/vp/RWGSwBIeTQOBi2A1qVRM1Yzj1PEwTr
	l75gGhKfdb8GuZVFeFex/VFStrrTHnoW+szLgjEB0adoslKhK0uSiZoOxyRYkMfL
	sroIgUQeAkLzpEYE5QGxPeokq5stgsIi0Glww=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 981484D1B;
	Fri, 25 Feb 2011 14:55:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0AA324D1A; Fri, 25 Feb 2011
 14:55:31 -0500 (EST)
In-Reply-To: <AANLkTinzhd_nL265e7DZA4xEnXqDn-5m=9GPS7JsFY-S@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 25 Feb
 2011 20\:43\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 371CE7F6-4119-11E0-95CC-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167927>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But just like we now have:
>
>     Revert "some commit"
>
>     This partially reverts commit <sha1>.
>
> We could have with <path>:
>
>     Revert "some commit"
>
>     This partially reverts commit <sha1>. Only the path <path> has
>     been reverted, which is X out of Y files changed in the original
>     commit.
>
> Or something like that.

Yes, that is exactly what I was suggesting, no?

On the similar line of thought, it might be a good idea to update the
commit template we give slightly perhaps like...

     Revert "some commit"

     This partially reverts commit <sha1>.
    +#
    +# DESCRBE HERE how the change in <sha1>
    +# was a wrong thing to do.
