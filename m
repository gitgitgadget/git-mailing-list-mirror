From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Tue, 21 Oct 2014 11:14:10 -0700
Message-ID: <xmqqwq7tz3wt.fsf@gitster.dls.corp.google.com>
References: <20141020115943.GA27144@gmail.com>
	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
	<20141020222809.GB223410@vauxhall.crustytoothpaste.net>
	<CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com>
	<54461483.9010600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 20:14:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgdwn-0002L8-T5
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 20:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbaJUSOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 14:14:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751191AbaJUSON (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 14:14:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE4291518B;
	Tue, 21 Oct 2014 14:14:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ByAnwDZzRwh8YMWnKGJnhqPIcNs=; b=w4Z0GSPyY/JcoaQdYZ1q
	q153B0VSUMqlPQfSc0A7dFpLqLZViyifpgPYTzdmWpzi7p8+WjXN+jKWhhQVD1Oz
	+9WJuIunKO5YBvHiY6YVDZ9/A2gBsNNxduofwXRFPxnocdqVzBwkIzkGJy/15+V3
	sqUGlvDcbO2xdy2bmX2omP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TmPNB4JWfFxX7dqyMp2p96Uk3bas528e3K/lvbYYsAbcuk
	HacZStweV848FoZT1+wjoblMOUHjWknjApOUDvlLN3S+N8G80NlzXA/S3yAxGJYx
	TUVlOI06rvva0KgyjO4nuer2BblEbCmiAUCy9n1D/StWo85mikg6R1/B1kse4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D3BE81518A;
	Tue, 21 Oct 2014 14:14:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E85F15188;
	Tue, 21 Oct 2014 14:14:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F15303C-594E-11E4-BA16-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Unfortunately, the git archive doc clearly says that the umask is
> applied to all archive entries.

Is an extended pax header "an archive entry"?  I doubt it, and the
above is not relevant.  The mode bits for the archive entry that it
applies to does not come from there.

See my other message for my final judgement on this one.  I wouldn't
have minded if the original used the same umask for those ignored
mode bits, but changing the bits to be ignored after the fact is not
helping any real use case and only hurts existing users.

That is not to say that we cannot later fix bigger issues in the
output.  I just do not see that otherwise-unused mode bits in the
extended pax header big enough an issue to spend brain cycles to
carefully lay and execute transition plans to avoid breaking
existing users.
