From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] Make the 'lock file exists' error more informative
Date: Wed, 4 Mar 2009 15:18:06 +0000
Message-ID: <43d8ce650903040718m6fc384ddv695c546276b7d3c3@mail.gmail.com>
References: <1236179277-12477-1-git-send-email-johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 16:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lesss-0000Kz-BB
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 16:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbZCDPSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 10:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbZCDPSK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 10:18:10 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:39267 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbZCDPSJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 10:18:09 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3959049wfa.4
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 07:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=RSXOVTFSnyv1GnY7uBGAPMYnGLcXq09jcaSKLHbgS9Y=;
        b=pzCGMjuUnR6VqDejzEwEYiRnKqyImXcYIFa6Ptz/bKjYIk3S0wb/gRyb+BBlBuNhiX
         Nug7uZCX2Y5IM2J0X3LD3df3sLJFAafRy+kGJ4LRpzdiDIE1tx4LnSL5lNGtyAHBNq3L
         WEWO1d8xwVmgqDUXIpZLEDjIk3Vba/azqwzYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=SAxrl2nAQlSQ1BNilpOE/jw1dT+NRa8gIRllmBaHDTd753ywNEmaLg79y2Y1Efj25Y
         QFdClGo2LWDH6zvYZi7Xnafpt5da4C8xNbEMeNuhlxFNql97WNRoWMRyVHqx/8XA4U+x
         ixAjALZ7cA32LUfmULeo5Am39nDwId9HXWzvk=
Received: by 10.142.14.18 with SMTP id 18mr4234377wfn.304.1236179887143; Wed, 
	04 Mar 2009 07:18:07 -0800 (PST)
In-Reply-To: <1236179277-12477-1-git-send-email-johnflux@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112222>

2009/3/4 John Tapsell <johnflux@gmail.com>:
> It looks like someone did 90% of the work, then forgot to actually us=
e
> the function

It seems that this was already fixed in the 'next' branch.  (Sorry, I
didn't know about this branch before).

The first bug fix is still required.  (well, for niceness.  In
practise it isn't)

John Tapsell

> ---
> =C2=A0lockfile.c | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index 1db1a2f..3dbb2d1 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -158,7 +158,7 @@ static int lock_file(struct lock_file *lk, const =
char *path, int flags)
>
> =C2=A0NORETURN void unable_to_lock_index_die(const char *path, int er=
r)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D EEXIST) {
> + =C2=A0 =C2=A0 =C2=A0 if (err =3D=3D EEXIST) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("Unable to=
 create '%s.lock': %s.\n\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
"If no other git process is currently running, this probably means a\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
"git process crashed in this repository earlier. Make sure no other git=
\n"
> @@ -184,7 +184,7 @@ int hold_lock_file_for_append(struct lock_file *l=
k, const char *path, int flags)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D lock_file(lk, path, flags);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags & LO=
CK_DIE_ON_ERROR)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("unable to create '%s.lock': %s", path, strerror(errno));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 unable_to_lock_index_die(path, errno);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fd;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> --
> 1.6.2.rc2.23.g77740
>
>
