From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 09:38:46 -0800
Message-ID: <7vpr4o3lg9.fsf@alter.siamese.dyndns.org>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>, Mark Lodato <lodatom@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Steve Diver <squelch2@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 18:39:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc0F1-0002OH-1K
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 18:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab0BARjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 12:39:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0BARjG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 12:39:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 789BB9604D;
	Mon,  1 Feb 2010 12:39:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B3Q1NIFkdqK5FSYstJsQpWjJvRI=; b=Xs2jvA
	tR36NtayD7+HsDtIZ7EiIoWRHTES4Oydyb1LRdReVD7j5rpUnitvT2ZTDIpE7CqK
	+KvMzG/I5XxcNxAPTo9ohe3yYABmU04EdrS51SK4yu74l8mxih0kwdGoikKgxaN3
	LxwKIObeNwPHgiXygYXec0/thcXZr7dCxMdoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DcVvh2Xf0EIm5RxiJadT1z+FpkC56wAc
	7GsxoDI1LYJjTkfPS2NgehePh2FMd2+HAYk9e/OHcr/HMGxEaErZFWlC9y818vMQ
	PTHgxBQ7avsUAzdSJ2RVpIf9L2bI2r+a9UQM8lL+t+HTpMjtqG5dKkesuJNJnofP
	OY2Uu8fiJ4k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA0A596046;
	Mon,  1 Feb 2010 12:38:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85F879602E; Mon,  1 Feb
 2010 12:38:48 -0500 (EST)
In-Reply-To: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
 (Steve Diver's message of "Mon\, 1 Feb 2010 11\:52\:51 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC6A120C-0F58-11DF-9200-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138630>

Steve Diver <squelch2@googlemail.com> writes:

> Would it be a safe assumption to describe a 'detached HEAD' state as
> being synonymous with a (local) personal scratchpad or temporary
> workspace based on and from the original committed object?

A commonly used term since we started discussing the detached HEAD late
2006 (v1.5.0 timeframe) is a "temporary branch" or a "throw-away" branch.
See c847f53 (Detached HEAD (experimental), 2007-01-01), for example.

I do not think we need yet another term "scratchpad" for this, but what is
important is that both introductory and full documentation explain the
detached HEAD well.

Currently we say:

    Detached HEAD
    -------------

    It is sometimes useful to be able to 'checkout' a commit that is
    not at the tip of one of your branches.  The most obvious
    example is to check out the commit at a tagged official release
    point, like this:

    ------------
    $ git checkout v2.6.18
    ------------

    Earlier versions of git did not allow this and asked you to
    create a temporary branch using the `-b` option, but starting from
    version 1.5.0, the above command 'detaches' your HEAD from the
    current branch and directly points at the commit named by the tag
    (`v2.6.18` in the example above).

If read carefully (some may argue that it does not need a very careful
reading to get it, though), this hints that "detached HEAD" state is a
substitute for using a temporary branch, but it may not be strong enough.

I thought that a documentation update in this area was already planned?
