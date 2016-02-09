From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH] Documentation/git-clean.txt: don't mention deletion of
 .git/modules/*
Date: Tue, 09 Feb 2016 12:40:56 -0500
Message-ID: <1455039656.2511.177.camel@mattmccutchen.net>
References: <1454790889.23898.225.camel@mattmccutchen.net>
	 <xmqqvb5y6dx2.fsf@gitster.mtv.corp.google.com>
	 <1454971010.2511.89.camel@mattmccutchen.net>
	 <20160208224739.GH6104@lakka.kapsi.fi>
	 <20160209075553.GI6104@lakka.kapsi.fi>
	 <xmqqpow54wkh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Mikko Rapeli <mikko.rapeli@iki.fi>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:41:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTCHm-00025h-GC
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 18:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbcBIRlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2016 12:41:05 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:37247 "EHLO
	homiemail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757723AbcBIRlB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Feb 2016 12:41:01 -0500
Received: from homiemail-a4.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a4.g.dreamhost.com (Postfix) with ESMTP id CE19E51C062;
	Tue,  9 Feb 2016 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=
	mattmccutchen.net; bh=+n603AH89SNcEe1WNCFkCB+iDpI=; b=lyCfiLWxs+
	EgGaLFo1OZJKD9eKGwcC1De5iXrP276lmdCmeEcc9rngcvCx2jkGUwMAf/prk5Vd
	puzYuWJ0m9FeVoWEGMKM1ykN2tLHjg253R8lLD+ZSJ5RKHYFOIdVcglh3F214Col
	AesZ6IB8G07bs3EmFQ1hrP4LYPvhwc7zA=
Received: from main (30-9-175.wireless.csail.mit.edu [128.30.9.175])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a4.g.dreamhost.com (Postfix) with ESMTPSA id 566EC51C069;
	Tue,  9 Feb 2016 09:41:00 -0800 (PST)
In-Reply-To: <xmqqpow54wkh.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285843>

On Tue, 2016-02-09 at 09:34 -0800, Junio C Hamano wrote:
> Mikko Rapeli <mikko.rapeli@iki.fi> writes:
>=20
> > Sorry, can't reproduce the problem where submodules stayed in the
> > tree until
> > git clean was called with two -f's.
> >=20
> > You are right in removing the second part.
>=20
> Thanks, then let's do this.

Looks good except for a typo (below). =C2=A0I'll try to write better co=
mmit
messages in the future.

> -- >8 --
> From: Matt McCutchen <matt@mattmccutchen.net>
> Date: Sat, 6 Feb 2016 15:25:41 -0500
> Subject: [PATCH] Documentation/git-clean.txt: don't mention deletion
> of .git/modules/*
>=20
> The latter half fo

of

> this sentence, the removal of the submodules, was
> never done with (or without) double -f back when it was written, and
> we still do not do so.
>=20
> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> Acked-by: Mikko Rapeli <mikko.rapeli@iki.fi>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =C2=A0Documentation/git-clean.txt | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git-clean.txt b/Documentation/git-
> clean.txt
> index 641681f..51a7e26 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -37,9 +37,7 @@ OPTIONS
> =C2=A0	to false, 'git clean' will refuse to delete files or
> directories
> =C2=A0	unless given -f, -n or -i. Git will refuse to delete
> directories
> =C2=A0	with .git sub directory or file unless a second -f
> -	is given. This affects also git submodules where the storage
> area
> -	of the removed submodule under .git/modules/ is not removed
> until
> -	-f is given twice.
> +	is given.
> =C2=A0
> =C2=A0-i::
> =C2=A0--interactive::
