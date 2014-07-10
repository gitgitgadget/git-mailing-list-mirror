From: Junio C Hamano <gitster@pobox.com>
Subject: Re: No fchmd. was: Re: [PATCH 00/14] Add submodule test harness
Date: Thu, 10 Jul 2014 14:43:03 -0700
Message-ID: <xmqqoaww7uvs.fsf@gitster.dls.corp.google.com>
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
	<xmqq61j5805g.fsf@gitster.dls.corp.google.com>
	<53BEFDA8.7020409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Johannes Sixt <j6t@kdbg.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 23:43:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5M7Y-0006EI-Ky
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 23:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbaGJVnN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2014 17:43:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62017 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbaGJVnM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2014 17:43:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4813228005;
	Thu, 10 Jul 2014 17:42:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qpFPEnrcbvWU
	msEvkAe4gu1fYis=; b=bjfLMreQ6yhj0dFqyLh2L2ak+W8hRBcBpG++yxLwkg+e
	ycDOZuZN1FbMDSS5EtHrskq6NwqN3rxXwp8F02/45X0g3W6xkWRlRZav/n+PtBKM
	FtgpWjzGXVeJle892tBbR/0rvmN997ekSKmpcHRcDKrv60YzMfi4UyYQr4ecNY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iu6Y49
	stoR1OqLz03wGGn59MhMb35L8ibI0Yf/WCrhOJNfXx01+q6LeY5fFdJEdj0jqdiD
	ly4KImrzZBMNzRAko06RGpRyeLqueFAXXUNdgO6iVeChnk485gURkKZYVzl5gFoj
	tbIXvTtSv2TiNbsYTWoJZMCUay297doSOyyPY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CF5B28004;
	Thu, 10 Jul 2014 17:42:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3393727FF6;
	Thu, 10 Jul 2014 17:42:50 -0400 (EDT)
In-Reply-To: <53BEFDA8.7020409@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 10 Jul 2014 22:55:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 23D1A5F6-087B-11E4-823D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253220>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2014-07-10 21.49, Junio C Hamano wrote:
> []
>> If we limit the case to "Inherit permissions from the file we are
>> replacing by taking a lock on it", which is the topic of discussion
>> in this thread, we do not have to worry about how to configure the
>> value (we do not have to) and adding a new parameter to tell the
>> mode to hold-lock-file-for-update is unneeded (the function will
>> have a pathname of the original and can learn the current permission
>> bits itself).
> So something like this:

Yeah, I think something along those lines may be sufficient and we
do not have to do anything when closing/committing, at least POSIX
systems.  I do not know if other filesystems we may care about let
you open with 0400 and still write into it, though.

> (I will probably not have the time to make a proper patch :-(

That's OK.  I see many names on Cc: who are all capable of helping
us ;-)

>
> diff --git a/lockfile.c b/lockfile.c
> index 4899270..134d5c8 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -156,6 +156,11 @@ static void resolve_symlink(struct strbuf *path)
>  /* Make sure errno contains a meaningful value on error */
>  static int lock_file(struct lock_file *lk, const char *path, int fla=
gs)
>  {
> +       int perms =3D 0666;
> +       struct stat st;
> +       if (!lstat(path, &st))
> +               perms =3D st.st_mode & 0777;
> +
>         if (!lock_file_list) {
>                 /* One-time initialization */
>                 sigchain_push_common(remove_lock_file_on_signal);
> @@ -179,7 +184,7 @@ static int lock_file(struct lock_file *lk, const =
char *path, int flags)
>         if (!(flags & LOCK_NODEREF))
>                 resolve_symlink(&lk->filename);
>         strbuf_addstr(&lk->filename, LOCK_SUFFIX);
> -       lk->fd =3D open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, =
0666);
> +       lk->fd =3D open(lk->filename.buf, O_RDWR | O_CREAT | O_EXCL, =
perms);
>         if (lk->fd < 0) {
>                 strbuf_reset(&lk->filename);
>                 return -1;
