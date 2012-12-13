From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Thu, 13 Dec 2012 11:31:49 -0800
Message-ID: <7vmwxhycii.fsf@alter.siamese.dyndns.org>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
 <CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
 <7vvcc6z801.fsf@alter.siamese.dyndns.org>
 <CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 20:32:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjEVv-0000LB-2p
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 20:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab2LMTbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 14:31:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46450 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755598Ab2LMTbw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 14:31:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00E5BA7FD;
	Thu, 13 Dec 2012 14:31:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2hA1itbJNEogUk2DLK58hMUw3fw=; b=djP/JC
	og0KKOHvcJ6HvNJ+UKpRNwF+cqymYSfogUG/Le2zsL8oGRCps19XnxFOWqxNRnzz
	h8RNWQ+laNzk/mYC9S0VrJQhShC2T25QKxVvuun3vsfvDiMLWH0zvlzv7/xUm4fA
	Cr91xKpTKjz7DPPYUWIjMDTZ7H70uNHSUvy7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XnmDrmSi4fWAVq06BqSdrXKsMzs2Q8MX
	QeoVuw2rx+1Lca0bhgOMztUCRqOPgy+oxeOTgEDW5YWMIkgxmE37tT+QDzq+4ZDn
	Fk+0tOSsRvXlmUzlCHOfiJXLUJdP4FZ92DqfMBj8QbaXXoCAbTAWJtuY5fqMn4sP
	MkyP49b5Lag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2461A7FC;
	Thu, 13 Dec 2012 14:31:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4542EA7F9; Thu, 13 Dec 2012
 14:31:51 -0500 (EST)
In-Reply-To: <CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 13 Dec 2012 04:08:17 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE617A90-455B-11E2-89BB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211469>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Dec 13, 2012 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>>  New remote helper for bzr (v3).  With minor fixes, this may be ready
>>>>  for 'next'.
>>>
>>> What minor fixes?
>>
>> Lookng at the above (fixup), $gmane/210744 comes to mind
>
> That doesn't matter. The code and the tests would work just fine.

One of us must be very confused.  Perhaps you were looking at a
wrong message (or I quoted a wrong one?).

  ... goes and double checks ...

One of the review points were about this piece in the test:

    > +cmd=<<EOF
    > +import bzrlib
    > +bzrlib.initialize()
    > +import bzrlib.plugin
    > +bzrlib.plugin.load_plugins()
    > +import bzrlib.plugins.fastimport
    > +EOF
    > +if ! "$PYTHON_PATH" -c "$cmd"; then

    I cannot see how this could have ever worked.

And I still don't see how your "would work just fine" can be true.

>> but there may be others.  It is the responsibility of a contributor to keep
>> track of review comments others give to his or her patches and
>> reroll them, so I do not recall every minor details, sorry.

There may be others, but $gmane/210745 is also relevant, I think.

> There is nothing that prevents remote-bzr from being merged.

What we merge may not be perfect.  Bugs and misdesigns are often
identified long after a topic is merged and it is perfectly normal
we fix things up in-tree.  There are even times where we say "OK, it
is known to break if the user does something that pokes this and
that obscure corners of this code, but the benefit of merging this
99% working code to help users that do not exercise the rare cases
is greater than having them wait for getting the remaining 1% right,
so let's merge it with known breakage documentation".

But it is totally a different matter to merge a crap with known
breakage that is one easy fix away from the get-go.  Allowing that
means that all the times we spend on reviewing patches here go
wasted, discouraging reviewers.

If you want others to take your patches with respect, please take
reviewers' comments with the same respect you expect to be paid by
others.
