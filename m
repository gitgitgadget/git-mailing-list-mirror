From: Junio C Hamano <gitster@pobox.com>
Subject: Re: No fchmd. was: Re: [PATCH 00/14] Add submodule test harness
Date: Thu, 10 Jul 2014 12:49:15 -0700
Message-ID: <xmqq61j5805g.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
	<53BD7A36.2030300@kdbg.org>
	<xmqqr41u9w27.fsf@gitster.dls.corp.google.com>
	<20140709195619.GA17454@dcvr.yhbt.net>
	<xmqqion69ovj.fsf@gitster.dls.corp.google.com>
	<53BE3127.8020805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Johannes Sixt <j6t@kdbg.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 21:49:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5KLP-0007Qv-F1
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 21:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbaGJTtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2014 15:49:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52796 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575AbaGJTtX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2014 15:49:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 78D6E27042;
	Thu, 10 Jul 2014 15:49:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aLSFq2MqgU/c
	C10JIpMJcfOy9Ks=; b=UcSHvsiDLiB2ESD25b+2CkYEYTJv882EIthEltSLRuib
	kQFdiiPj9Splk0IklfkPZMS3yVUrrr6Ve3wS7Et61vMCTeUK/hM/0y+jpKbgANRf
	txAKEwnrTUD4qpaz8do3gcq9tDRW6U7m7HftMn9DPD1qTlzHAOlqh0q7JWy0EHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZBWLy1
	GDZo3YQQpI+sYynIU9+6HQIeNix59i6pSjpZULvzDdiNPdAgEYFDVh5CC0rz+wRZ
	i+W9T0EvESTgYBvhBuwJKTnq/M8jVhAK2OnoTQ6SwKVXDG7Omk2B5QsoHy7QzRgW
	sPRyGiDCAbktfzHFuQfD2WwqIWeYfoZ8Yz0nc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 656C727041;
	Thu, 10 Jul 2014 15:49:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F12A827035;
	Thu, 10 Jul 2014 15:49:01 -0400 (EDT)
In-Reply-To: <53BE3127.8020805@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 10 Jul 2014 08:22:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3DE1D386-086B-11E4-95A0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253201>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Isn't the whole problem starting here:
> in config.c:
>
>     fd =3D hold_lock_file_for_update(lock, config_filename, 0);
> In lockfile.c:
>   /* This should return a meaningful errno on failure */
>   int hold_lock_file_for_update(struct lock_file *lk, const char
> *path, int flags)
>   {
>       int fd =3D lock_file(lk, path, flags);
> which leads to
>   static int lock_file(struct lock_file *lk, const char *path, int fl=
ags)
>     []
>     lk->fd =3D open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666=
);
>
> There is no way to tell which permissions the new lockfile should hav=
e.

We follow whategver user's umask says with this code.

> That is somewhat unlucky.
>
> On the other hand, shouldn't we call
> adjust_shared_perm(const char *path) from path.c on the config file?

Good question, but I am not sure.  For $GIT_DIR/config, I tend to
agree we should, but "git config --global foo bar" would not be a
shared file anyway, and my understanding of Eric's original
motivation is to keep $HOME/.gitconfig to be tighter than the user's
umask normally would indicate.

> And to all files which are fiddled through the lock_file API?
> In other words, the lockfile could be created with the restrictive
> permissions
> 600, and once the lockfile had been closed and renamed into the final=
 name
> we apply adjust_shared_perm() on it ?

=46or all files that adjust-shared-perm should apply, yes, but I do
not think it is relevant to the codepath in question.

> I think there are 2 different things missing here:
>
> - Be able to specify permissions to hold_lock_file_for_update(),
>    especially restrictive ones, like 600 and not 666.

Yes (in the sense that "yes we can add an extra parameter") and no
(in the sense that "where would we get the value to pass to the
extra parameter from?  would it be worth to add configurations
variables for different kinds of files?").

If we limit the case to "Inherit permissions from the file we are
replacing by taking a lock on it", which is the topic of discussion
in this thread, we do not have to worry about how to configure the
value (we do not have to) and adding a new parameter to tell the
mode to hold-lock-file-for-update is unneeded (the function will
have a pathname of the original and can learn the current permission
bits itself).

> - Adjust the permissions for "shared files" in a shared repo.
>   This is probably needed for a shared repo, when the user itself
>    has a umask which is too restrictive and adjust_shared_perm()
>    must be run to widen the permissions.

Don't we already do that for $GIT_DIR/config?  In any case that will
not help $HOME/.gitconfig and other files that are not shared.
