From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 19:38:58 -0700
Message-ID: <7vehnut1kt.fsf@alter.siamese.dyndns.org>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
 <7vehnvvyta.fsf@alter.siamese.dyndns.org>
 <20120729142458.GB16223@paksenarrion.iveqy.com>
 <CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
 <7vvch6uw89.fsf@alter.siamese.dyndns.org>
 <7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
 <CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
 <CAJo=hJsgMz-=pdG=HB3KtTE7g6Gvu9mr56dg2+V3WUST+rpAQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 04:39:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svftd-0006W2-AY
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 04:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab2G3CjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 22:39:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab2G3CjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 22:39:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8181C8F9B;
	Sun, 29 Jul 2012 22:39:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jkccAlKLh0+WSxsWYj3vAdq+YD8=; b=sQ2Qsx
	SxpJftePMJF3SZjet0Cx+aD3YQqawaz/YarqpMyYiCc/0xaefnWxzbWqaFNQaRqZ
	Immnk3tGHtVKdBgxWDpIM9BclUJdehGHsDwphj4MbOv+2ffipGOhthJtkUNA4pJV
	OKrgGcCOtsQN4r9AN3+tjMFXJNKI+Qnkms470=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f2/UkmM1q/11p65N5xKvsM98dA3uq4kX
	hIZhcq6IOULlIa1eiXagcHHQQX/FrIqXDxftuN81CifOo2TNK+Rw9SvQLbslHuji
	grdJhT5BYa1ApEVRj3Uv7ShVoowLfuuCdQ+/P5H5ONfyKAiG+2/baRc9stU+xoIu
	8Fig8s/KGog=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E44D8F9A;
	Sun, 29 Jul 2012 22:39:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD4778F99; Sun, 29 Jul 2012
 22:38:59 -0400 (EDT)
In-Reply-To: <CAJo=hJsgMz-=pdG=HB3KtTE7g6Gvu9mr56dg2+V3WUST+rpAQg@mail.gmail.com> (Shawn
 Pearce's message of "Sun, 29 Jul 2012 18:21:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7A2F288-D9EF-11E1-AC80-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202519>

Shawn Pearce <spearce@spearce.org> writes:

> We sort of want this in Gerrit Code Review to pass reviewer names on
> the command line of git push, making it easier for users to upload a
> code review. The idea is similar to what happens with gcc accepting
> linker flags that are just passed onto the linker.

For reviewer names, authentication cookies and things of that nature
where the extra pieces of information affect the outcome in a way
that does not have to change how the underlying protocol exchange
works, such an additional one-way channel from the pusher to pushee
to carry auxiliary information would be sufficient.  The server may
decide to accept otherwise forbidden, or reject otherwise permitted,
push based on the extra information given, for example, and that is
an example of an enhancement that does not have to change how the
underlying protocol exchange works.

The way to expose the extra information parsed by Git to the server
side could be made into calling out to hooks, and at that point,
gitolite would not even have to know about the pack protocol.
Perhaps the interface to such a hook may be "hook can tell Git to
abort the communication by exiting non-zero, after giving a message
to its standard output".

It is a separate matter if it makes sense to add another channel
that goes the other way on demand (i.e.  taking the end-user
response from the pusher and giving it to the pushee, and then
allowing the pushee change its behaviour in a way more than just
simply aborting the connection but performing a useful alternative
operation)---I doubt it is.
