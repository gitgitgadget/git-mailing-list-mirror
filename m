From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] index-v4: document the entry format
Date: Wed, 02 May 2012 10:04:11 -0700
Message-ID: <7vlilaikfo.fsf@alter.siamese.dyndns.org>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
 <xmqqzk9w93zu.fsf@junio.mtv.corp.google.com>
 <xmqqpqas93sa.fsf_-_@junio.mtv.corp.google.com>
 <87vckhuofj.fsf@thomas.inf.ethz.ch> <7vlilcczzb.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvFfVbYRKtPDJbd8MXKFDAyk==Sbm8oTgypbpE2O4o1=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 02 19:04:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPcyS-0003j9-SI
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 19:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab2EBREP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 13:04:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527Ab2EBREO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 13:04:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B44E76D8D;
	Wed,  2 May 2012 13:04:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xKtiosHS8e+Z1l+DpHag1q77GoA=; b=yhztbA
	W3DFtrbBGuXCzWlJRWSE7MZx2voIuwaUJn1KUOpKkCT9m5vkoEeqA5D0k8uF7DGK
	vbnBqR3shKxsNH2pIR0ZQc1JLiDkVPi+prM2KQBg8fz9oAylrPSElT4wmngo+deF
	lVIKo3FxxflumqVbTHgeLs9Tr4Sin5SfShdE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AWq/xnX9Tq50lOzIgL6BKerI1XLDTg1Z
	L4+rUKJxY2lzEMjJSfGhiiVQm0snGx4CxYk1IllzznHx/gK84zzAErJ/v81i2vAl
	qO/kuqXyO6Zcdw9N13lAqaO3kh/3E3/TXFEQ4frjxdUi/nmBZ8uC972I/Il5A9jX
	Iub3ELTY07I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AACF16D8C;
	Wed,  2 May 2012 13:04:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7082D6D8A; Wed,  2 May 2012
 13:04:12 -0400 (EDT)
In-Reply-To: <CAJo=hJvFfVbYRKtPDJbd8MXKFDAyk==Sbm8oTgypbpE2O4o1=w@mail.gmail.com> (Shawn
 Pearce's message of "Wed, 2 May 2012 08:12:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D72AEEB0-9478-11E1-AF10-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196842>

Shawn Pearce <spearce@spearce.org> writes:

> IMHO, keep this in next to avoid releasing it until we know the
> outcome of the GSoC project. The handful of WebKit developers that use
> Git that really benefit from index v4 can use it by building and
> installing their own next.
> ...
> Its only a few months to wait and see where "v5" goes. If v5 is
> successful, v4 will just be a minor footnote in the history of Git,
> and other tools won't need to support v4, they can go straight to v5.

You may not have noticed this, but there is no practical difference
between keeping it in 'next' and releasing it to 'master' from the
third-party tool's point of view.

There is _only_ one way to end up with v4 version of index: running "git
update-index --index-version 4".  When creating a new index, or working in
a repository, starting from an index written in the current version, you
will get v2 (or v3) index (this gentle handling of backward compatibility
comes from later parts of the series).  It is either running that command
or running 'next' version *and* running that command---either way, the
user deliberately has to ask for it, and if a third-party tool like jgit
chooses to ignore v4, it is not the end of the world.  The user opted-in
can run "git update-index --index-version 2" to revert it before using
such a tool.

For a third-party tool, lack of support of v4 is similar to not supporting
a config file that does not record the core.repositoryformatversion, which
the user can manually add it with the editor, and much less serious than
not supporting the v3 version of the index, which the user cannot do much
about it.

I would say that the cost of not merging the refactoring in the earlier
parts of the series and the gentler handling of backward compatibility in
the later parts of the series is much higher.
