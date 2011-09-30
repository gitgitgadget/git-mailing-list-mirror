From: Junio C Hamano <gitster@pobox.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 19:28:10 -0700
Message-ID: <7v1uuyrcg5.fsf@alter.siamese.dyndns.org>
References: <1316960136073-6829212.post@n2.nabble.com>
 <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org>
 <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr>
 <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr>
 <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com>
 <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com>
 <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
 <CABURp0q8YhTS-GDYOANEa19P-V2wf_EUTo=RHqnhDB619w=y-w@mail.gmail.com>
 <7vd3ejrqin.fsf@alter.siamese.dyndns.org>
 <7v4nzvrp3k.fsf@alter.siamese.dyndns.org>
 <CABURp0rjBdx+=_8R5g16fNKWis3=GgJw9SQ9D53H6xu_-Tq3Uw@mail.gmail.com>
 <7vd3ejq74z.fsf@alter.siamese.dyndns.org>
 <CAMOZ1BuUvuyrf3Tio+9EZR_-b3zy-RWpq36+0rmDO+QKWaVmxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 04:28:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Spr-0001yH-2B
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 04:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab1I3C2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 22:28:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab1I3C2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 22:28:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29E736CAB;
	Thu, 29 Sep 2011 22:28:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1COXO/pjJqHDLrf8tpLC0OZrtG4=; b=m1uomh
	NNBhkB4fYnEpvJqLopMCKHSeKbJ6/bi4+cMkv1mEuvJheAmNsZwPPtMY+ot9xHmO
	cdB8EKZYnTH/irP+5H5OVTzmOxn4VFwEQZ7WY3of1XwNhBNqBKV5pmZHpH0/I4qJ
	6UC24Vz7Wa+7BTVssrSJx7x1VjPnMfEh1j3c4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cLtycu90HUqHiNq6xHeMIWjMyAfGlEHQ
	LhGa4ZapYloWgB5HbzO0HKN/Z1fI66mKXl9lakh1oZH+k8Q280YDhFZ4IyiCHW3t
	gmszxIifhReMr/TkHbLW9TKsBEDaf+2JeywSltB3bBjYlSYr21P9DlvBIp+Yr+bb
	533kyDbbKNI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2037D6CAA;
	Thu, 29 Sep 2011 22:28:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 886636CA8; Thu, 29 Sep 2011
 22:28:11 -0400 (EDT)
In-Reply-To: <CAMOZ1BuUvuyrf3Tio+9EZR_-b3zy-RWpq36+0rmDO+QKWaVmxQ@mail.gmail.com> (Michael
 Witten's message of "Fri, 30 Sep 2011 00:51:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7A222A8-EB0B-11E0-B051-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182461>

Michael Witten <mfwitten@gmail.com> writes:

> The main issue with "git commit --no-parent" is [supposedly] safety, but it
> can be made pretty safe:
>
>   $ cd repo
>   $ # Hack away as usual or not
>   $ git status # As with any other commit.
>   $ git commit --no-parent
>   Error! There must be another branch head directly referencing the
>   same commit that is directly referenced by the current branch head!

That safety indeed will work, and I kind of like it. I think this is in
line with what we try to do when you come back from a detached HEAD state.

You may also want to allow this when HEAD is detached already (I am just
thinking aloud here). One possible workflow may be to start from somewhere
random, such as the last customer release point:

	git checkout rel-2011-09-01
        # strip proprietary stuff away
	# make sure the result is satisfactory
	git commit --no-parent
        git checkout -b opensource

By the way, I am not convinced enough with the "git status" argument,
though.

The output from "status" and "diff" will show what you changed, but in the
"strip proprietary stuff" scenario, what you care much more about is what
you forgot to remove.

If my current source is littered with a confidencial name of an unreleased
device that I need to remove, I am more likely to use "git grep" on the
_remaining_ files, and this does not make a difference between "checkout
--orphan" or "commit --no-parent".

But I would imagine I would not _know_ what I am looking for until I see
it. There may be the name of another confidential device in the source
that I need to sanitize, too.

In a "strip" scenario, I suspect that the most natural way to verify would
be to run "git diff" between what is about to be committed and an empty
tree and inspect the output. That would be what I would do if I were
starting from an empty repository, populating the working tree and the
index with what I think is releaseable.

Another an advantage of "commit --no-parent" is that we do not have to
worry about a corner case like this:

	git checkout --orphan xyzzy
        # time passes, you do many things
        git checkout foo
	git branch | grep xyzzy ;# not found -- what happened to the branch?
