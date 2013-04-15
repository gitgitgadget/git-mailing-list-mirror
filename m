From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Sun, 14 Apr 2013 20:04:35 -0700
Message-ID: <7vppxw335o.fsf@alter.siamese.dyndns.org>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
 <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org>
 <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 05:04:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URZit-0000FH-U2
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 05:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933959Ab3DODEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 23:04:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932620Ab3DODEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 23:04:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C0F3F78B;
	Mon, 15 Apr 2013 03:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ey0Nf4wlK8dYIqRjlttTzsoPW7M=; b=u436CEsLlFHslv2lsGhE
	27yS8FU4DMe+Us+tpcAe4pAsJXDCxkvypUzAmmiuEey+BMg33gtQipZe0YDe1CKv
	JSgPpRshLq0DAy3ZUBgSx8BkR5GgSW/si2d4hWGsoNMhd0OBMv2glFGu69mUL9Jr
	iW5MnIJgShuvBlq21BCaEBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=f7lSNlOYpHxO2CTQLZu6DYE8i5kCamFsFd260+2CQyFnq1
	MhnEMzfs2Od5vA9Ej8cpGTmDqwk0i1VFQjXYJzMlXQub6zUVrllbQ87ovENeslPb
	EdBQsr8psLqaNVujxbd/WwBPQX9qePOGmZggebTgWPBVOyRv/RNm86AwuZp68=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 303EEF78A;
	Mon, 15 Apr 2013 03:04:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A43BF789; Mon, 15 Apr 2013
 03:04:37 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 351AE586-A579-11E2-802C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221190>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> ...  In my proposal, the
> precedence order branch.<name>.pushremote, remote.pushdefault,
> branch.<name>.remote, remote.default, origin, remains the same: we
> just want to change which branch that <name> refers to.

That "changing the meaning of <name>" in the middle, and doing so
will be confusing to the users, is exactly the issue, isn't it?

> In my
> opinion, it is a much more subtle change than the entirely new
> precedence order that you're inventing.

Adding "--" has never been my itch. I just brought it up out of thin
air as a possible alternative that is less confusing.

If it does not work well, we do not have to add it, but it is
dubious that we would want to add something that is even more
confusing.

Just like Peff, I am sympathetic to people who want to omit "where
to" and have Git automatically make a guess, and would be happy if
we can find a reasonable solution to that problem.

But I am not convinced what we discussed in these threads are good
solutions. At least not yet.
