From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Does anyone use git-notes?
Date: Wed, 25 Aug 2010 15:43:16 -0700
Message-ID: <7vd3t6pb3v.fsf@alter.siamese.dyndns.org>
References: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 00:43:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoOgq-0001ON-Ce
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 00:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387Ab0HYWnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 18:43:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab0HYWnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 18:43:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A21CD0902;
	Wed, 25 Aug 2010 18:43:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=OnGnJ+ZofnabHUx7aboqfzePQnA=; b=egd2JU
	f/xUl0foS5s+dxqo+lFKClahCFwpRuLzjCGUGEp+jKBvk5f4ljZZK8xvKO1EDq9M
	I2lzcZnh1h3WZNHdb+0uwUT7OA+QfF03ildwb6Hv0D2XxwjIaowRoKJZgmVirvyy
	5BgCLg1oYJoM1tCUr9KBIB76iywq8FMTzJv1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z5JwFXXPgV3dTPwtCSrDRZYMO2vhY9EB
	PxzEcUtEMlI7laayrzpUh7RZBUf+/KwEL7AsPvFFqiCVStOD3qwLmat14wiAjrHW
	cx16zM38jnoMtc52QFqYgKTjv0QZM0cJ8isdHvQiU9RqiavO3VBCpUnTIlk+jZG8
	iltaXIiyk+k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9653D0900;
	Wed, 25 Aug 2010 18:43:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32D6AD08FE; Wed, 25 Aug
 2010 18:43:18 -0400 (EDT)
In-Reply-To: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
 (Scott Chacon's message of "Wed\, 25 Aug 2010 11\:15\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2954F6B4-B09A-11DF-9D38-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154492>

Scott Chacon <schacon@gmail.com> writes:

> I would like to write a post on how to use them, but I'm a bit
> confused as to how people actually use them on a day to day basis.  I
> appears to me in trying to work out a flow for them that the lack of
> an ability to merge them makes them very difficult to use for anything
> practical.  Can someone share with me how they use them and what the
> cycle is?

I have a custom post-applypatch hook (see my "todo" branch) enabled and
then use the amlook script (again, see my "todo" branch) to inspect the
notes the hook left.

After applying a received patch e-mail, the result is annotated with
enough information to identify which message it came from by the hook (I
probably should add more information to the notes, but never got around to
it).  When I am scouring the mailing list backlog to see if I have missed
something interesting (sometimes I find interest in a topic that I thought
totally uninteresting earlier), the amlook script is used to see if the
patch has already been applied, and if so to which branch.

Looking through millions of notes this way won't scale (iow, amlook is a
bad example of using this feature, as the notes tree is used as a database
index in the wrong direction), by the way, so you may probably not want to
use it as a good example.
