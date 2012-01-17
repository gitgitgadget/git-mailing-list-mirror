From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep doesn't follow symbolic link
Date: Mon, 16 Jan 2012 22:44:51 -0800
Message-ID: <7v7h0qu8t8.fsf@alter.siamese.dyndns.org>
References: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
 <CALkWK0=-LZH4MYhX50v-RWpGA2r+6q50YxsKaOxc0mJ__yuK7g@mail.gmail.com>
 <877h0zlvwd.fsf@thomas.inf.ethz.ch> <7vwr8za04q.fsf@alter.siamese.dyndns.org>
 <CACsJy8BfvhWxqBOj=+7AiF8dZBVEASAuxiOsjOvpmfE3uPrO3A@mail.gmail.com>
 <7v1ur1yazf.fsf@alter.siamese.dyndns.org>
 <CACsJy8CaBAEJo_LuvjYhb2kfofH83cbR5DFDffmmCU3uJFqk+g@mail.gmail.com>
 <7vwr8ruv1j.fsf@alter.siamese.dyndns.org>
 <CACsJy8B9AGuRSx_5P22TOsqrA1rTEjQb78NN7PcTuK53iUmP_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pang Yan Han <pangyanhan@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 07:45:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn2nO-0005sa-3F
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 07:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab2AQGoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jan 2012 01:44:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886Ab2AQGoz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2012 01:44:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AC4F4228;
	Tue, 17 Jan 2012 01:44:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=k/xxyf2nwAZ2
	hrShnaO3EjqLWvs=; b=e/3H9hZkkENqQxrnDsFt0/W3TKzT2CpVXPQobWkbQvru
	e4q2TRu0WXpylgyJL+aFZLpl5OFz9YiaIEnk9MqolyTTdK9c1+4Q2D/Qw2bhBsEz
	Ji0a7hSNXVfqcSDdItCvDj3QQcV6+v+ZX7LilCI6E9hQ+d6SQWZGOK2LjJkMIuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o733Bg
	w7dHrZD+z+/Vs3ty8/VlsLGeA6fQLvhYgJSZxCAZUlY9QOEucvByHm9LnCoQtB6G
	U6YGtNQw2TyJxOVCshhyTt+b8wOsXsyVdYxoM4Nzqe1C85XE+xNl0aSq/koPtdZv
	XDZmmVUDW8VTvQI8twLTpQznAmjLkOWeNjGgg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0225F4227;
	Tue, 17 Jan 2012 01:44:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 795AC4226; Tue, 17 Jan 2012
 01:44:53 -0500 (EST)
In-Reply-To: <CACsJy8B9AGuRSx_5P22TOsqrA1rTEjQb78NN7PcTuK53iUmP_w@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 17 Jan 2012 08:55:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2E98CC2-40D6-11E1-9DE0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188693>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> OK resolving links to untracked contents is bad and should only be
> supported in --no-index case, resolving links to tracked contents sho=
uld
> be ok in principal?

Conceptually it is not as bad, but I doubt it is still "ok".

It would defeat one of the fundamental properties of Git (or any conten=
t
based revision control scheme for that matter): a tree object records t=
he
hash of its contents, so if two subtrees agree at the content hash leve=
l,
you do not have to descend into them to compare what they contain.

Imagine that you have a symlink at a/b/c/d that points a file e at the
root level, and you are running "git log a/b/c".  Even if the entire
hierarchy a/ does not change in a commit since its parent, you may have=
 to
show a/b/c/d only because "e" has changed.

So I suspect that the required change would involve a lot more than a
na=C3=AFve "when we reach the leaf level, if it is a symlink, read the =
link
contents and call get_tree_entry() to dereference the blob, or if the l=
ink
points outside the tree, use 0{40} to say 'contents undefined'".

After you compare 'a' of parent and child and find them to be identical=
,
you still need to anticipate that the hierarchy _might_ have a symbolic
link somewhere deep inside, and read _everything_ at least once in orde=
r
to find symbolic links and where they point at (if you did that to pare=
nt
already, and if you know that the child agrees with it at 'a', then you
can obviously do not have to read everything in the child---you know th=
e
parent and the child have the same _contents_ in 'a' at that point). An=
d
then grab the pointee out of parent tree and child tree to compare.

I personally do not think it is worth it.
