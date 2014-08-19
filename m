From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative submodule URLs
Date: Tue, 19 Aug 2014 12:19:13 -0700
Message-ID: <xmqqoavguw26.fsf@gitster.dls.corp.google.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
	<20140819102421.GA5012@book.hvoigt.net>
	<CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
	<xmqqiolowi1f.fsf@gitster.dls.corp.google.com>
	<CAHd499B9Wa=Y6P+OD8Ea-6dA4yZSkGZZSR9CwZAM45evDL_Qiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:19:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJowK-0000pS-2Q
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 21:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbaHSTTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 15:19:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54798 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912AbaHSTTX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 15:19:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4CFE33C43;
	Tue, 19 Aug 2014 15:19:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rx5/q4DD9xd+ogWRtoAAWC7x1vY=; b=JfnMKy
	SrqsVFm/jB7c2eKCTsaSSnd0LMlE7bS/KNxXVfRufXTaFKOIG+JJOrozBu3lhn4o
	vYfvku7OcawZojUle6Q/SW+1Q36z9ZgcPK+qixkMUxl/UBP2y+YYz202Z1MhGYl6
	HUwFDfgrbZrV0ZsXA13G6xQPKcL8Yj70NgndM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mC5BTMtwEaZy/GuYrpDmgfKitM2ERexE
	cTa74Ocg06B4rKQcQRuqoYAUvBNE4qTVQD4h5+HyZ6qVeow3JRmDiwF9AiBemuy3
	qiuFExLuNthpbFLb/Gj3sJ12iQUjChk9FiQDr6ct52PXwRtXWXpZ+z9dSw51vLS1
	mDMA+Kqs0+8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBD9D33C42;
	Tue, 19 Aug 2014 15:19:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D4DE133C39;
	Tue, 19 Aug 2014 15:19:14 -0400 (EDT)
In-Reply-To: <CAHd499B9Wa=Y6P+OD8Ea-6dA4yZSkGZZSR9CwZAM45evDL_Qiw@mail.gmail.com>
	(Robert Dailey's message of "Tue, 19 Aug 2014 11:50:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B53370BE-27D5-11E4-BDA5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255512>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> Maybe I'm misunderstanding something here and you can help me out.
>
> All the reading I've done (mostly github) says that 'upstream' points
> to the authoritative repository that you forked from but do not have
> permissions to write to. 'origin' points to the place you push your
> changes for pull requests (the fork).

I do not know if that is how GitHub teaches people, but I would have
to say that these are strange phrasing.  I suspect that part of
their documentation was written long time ago, back when nobody on
the GitHub side were involved in design (let alone implementation)
of Git, and I would take it with a grain of salt.

Having said that, here is a summary of the current support for
referring to different repositories in Git:

   The word 'origin' refers to where things originate from; a place
   you push to is where things go, so it makes no sense to use that
   word to refer to the repository where you publish your work
   result.  The 'origin' may or may not be where you can push (or
   you would want to push) to.  It is where you 'pull' from to
   synchronize with the 'upstream'.

   The 'upstream' in SCM context refers to those who control a
   logically more authoritative history than you, whose work you
   derive your work from, i.e. synonymous to 'origin'.

   For people like Linus (i.e. he may pull from others but that is
   to take in changes made as derived work; he does not pull to grab
   more authoritative work), there is no need to say 'upstream'; or
   you can consider he is his own 'upstream'.

   For those who use CVS-style central repository model (i.e. they
   would pull from that single central shared repository, and push
   their work back to the same repository), 'origin' are writable to
   them and they push to them.  For people with CVS-style central
   shared repository model, their central repository is their
   'upstream' with respect to their local copy.

   Since these two classes of people need just one other repository
   to refer to, we just used 'origin' when we did the very initial
   version of "git clone", and these users can keep using that name
   to refer to that single other repository they interact with.

   The support for the triangular workflow in which you pull from
   one place and push the result of work to another, which the
   configuration variable 'remote.pushdefault' is a part of, is
   relatively a more recent development in Git.  I am not sure we
   have added an official term to our glossary to refer to the
   repository you push your work result to, but in the discussions
   we have seen phrases like 'publishing repository' used, I think.
   It must be writable by you, of course, and it may or may not be
   the same as the 'origin' repository.
