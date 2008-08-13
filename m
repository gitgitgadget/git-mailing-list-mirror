From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Why doesn't git-apply remove empty file
Date: Wed, 13 Aug 2008 23:52:58 +0200
Message-ID: <48A357BA.8060003@lsrfire.ath.cx>
References: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com>	 <7vod3xpxq2.fsf@gitster.siamese.dyndns.org> <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 23:54:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTOIK-0005RG-Fi
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 23:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbYHMVxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2008 17:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbYHMVxN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 17:53:13 -0400
Received: from india601.server4you.de ([85.25.151.105]:47755 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbYHMVxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 17:53:12 -0400
Received: from [10.0.1.200] (p57B7DDA7.dip.t-dialin.net [87.183.221.167])
	by india601.server4you.de (Postfix) with ESMTPSA id 88AFA2F8041;
	Wed, 13 Aug 2008 23:53:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92283>

=46rancis Moreau schrieb:
>     $ mkdir a b
>     $ date > a/f
>     $ diff -Nurp a/f b/f
>     --- a/f 2008-08-13 09:27:29.000000000 +0200
>     +++ b/f 1970-01-01 01:00:00.000000000 +0100
>     @@ -1 +0,0 @@
>     -Wed Aug 13 09:27:29 CEST 2008
>=20
> So '/dev/null' doesn't appear here. I think patch(1) uses the date of
> b/f for removing
> the file.
>=20
> If we keep going on:
>=20
>     $ diff -Nurp a b > test.patch
>     $ ( cd a && git apply ../test.patch )
>     $ ls a
>     f
>     $ cat a/f
>     $
>=20
> of course patch(1) does remove the file.

I bet you are using GNU patch.  It removes files that are empty after
patching and you need to specify --posix to make it keep empty files.

Larry Wall's original version of patch keeps empty files by default and
you need to use the option option -E (or --remove-empty-files) to make
it remove them.

Ren=E9
