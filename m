From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Add a --bouquet option to git rev-list
Date: Tue, 01 Dec 2009 10:21:32 -0800
Message-ID: <7viqcqzhar.fsf@alter.siamese.dyndns.org>
References: <4b143a9c.c401be0a.364f.ffffba5b@mx.google.com>
 <4B14CF47.5020808@drmicha.warpmail.net>
 <d77df1110912010931l40472723v80ad675a92d23fa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 19:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFXMK-0003NV-Tr
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 19:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbZLASVq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 13:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbZLASVp
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 13:21:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbZLASVp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 13:21:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A4EC843DF;
	Tue,  1 Dec 2009 13:21:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gfGxl6FfhVbV
	YnOxj84T1nTKQTM=; b=Bkvo5hkguzh0JUwAR+vXK7ze0FwRX73x6IgBpWb4UCQN
	rp6orMfCaZeprG9pW5xh034oHZjvKV46+pip7BQWAO1NZDou5ezzgBlIA6kn9mdN
	uevX9GZr6HwUJs/+VNu20F5/CdOQZ6IC76KiLyKlGdLqJwgTjYpLT1WqcB+gZ1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QrbtH4
	yzDLOfKROiVZeIEjyiIUFbVoZCqHv76BM6jsP8Y2ef+akA1W8L9/APKupsdavRYU
	58tx1ESu61dl5M/Jdy5ngNRYqZohvlS6tv/6bfvZ6IjXhua8cAhGDU55M0hHXMhg
	zlU4FfK7Vq1uo9xbUt63QblJ97roucwXx7dz0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE8B1843DC;
	Tue,  1 Dec 2009 13:21:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A2F5843D8; Tue,  1 Dec
 2009 13:21:33 -0500 (EST)
In-Reply-To: <d77df1110912010931l40472723v80ad675a92d23fa3@mail.gmail.com>
 (Nathan W. Panike's message of "Tue\, 1 Dec 2009 11\:31\:56 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5EF454DE-DEA6-11DE-9D79-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134241>

"Nathan W. Panike" <nathan.panike@gmail.com> writes:

>>> include_forks ()
>>> {
>>> =C2=A0 =C2=A0 local head=3D"$(git show -s --pretty=3Dformat:'%H' HE=
AD)";
>>> =C2=A0 =C2=A0 echo "HEAD $(git for-each-ref --format=3D'%(refname)'=
 \
>>> =C2=A0 =C2=A0 =C2=A0 refs/heads refs/remotes | while read ref; do \
>>> =C2=A0 =C2=A0 =C2=A0 if test "$(git merge-base HEAD ${ref}^{commit}=
)" !=3D ""; \
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then echo ${ref}; =
fi; done)"
>>> }

Because you have to traverse the entire history from tips of refs to kn=
ow
if the histories to reach them are disjoint, this is fundamentally a ve=
ry
expensive operation and will not scale to projects with deep histories.

If a low-level support for this kind of thing is necessary, then I do n=
ot
think it should just be "give me set of refs that is related to HEAD". =
 I
suspect that is too inflexible to be useful in other situations.

A command to list refs (i.e. not as rev-list argument that shows list o=
f
commits, but as a new feature of for-each-ref) with new criteria might
have wider use (I am just thinking aloud).  Something like

 - among these refs (you would specify this with --all, --heads, or pre=
fix
   'refs/heads refs/remotes'), list only the ones related to this and t=
hat
   ref (here you would give HEAD or whatever you want to check with as
   argument)"; and=20

 - its counterpart "list the ones that are _not_ related" with the same
   input.

As to the implementation, instead of running get_merge_bases() number o=
f
times (a naive implementation would be O(n*m), I guess), I think it may
make sense to run the traversal in parallel, similar to the way done in
show-branches (but the termination condition would be different).
