From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: 1.8.3 - gitignore not being parsed correctly on OS X; regex support is broken?
Date: Wed, 29 May 2013 18:49:58 +0000 (UTC)
Message-ID: <loom.20130529T204310-306@post.gmane.org>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com> <CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com> <CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com> <51A62A96.6040009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 20:50:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhlSN-0008Vn-7G
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965898Ab3E2Sub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 14:50:31 -0400
Received: from plane.gmane.org ([80.91.229.3]:47829 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965807Ab3E2SuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 14:50:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UhlRw-00088r-55
	for git@vger.kernel.org; Wed, 29 May 2013 20:50:16 +0200
Received: from 233.5.200.37.customer.cdi.no ([37.200.5.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 May 2013 20:50:16 +0200
Received: from oystwa by 233.5.200.37.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 May 2013 20:50:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 37.200.5.233 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225866>

Karsten Blees <karsten.blees <at> gmail.com> writes:

>  <at> =C3=98ystein: in the meantime, could you check if this fixes th=
e problem=20
for you?
>=20
> --- 8< ---
> diff --git a/dir.c b/dir.c
> index a5926fb..13858fe 100644
> --- a/dir.c
> +++ b/dir.c
>  <at>  <at>  -821,6 +821,9  <at>  <at>  static void prep_exclude(stru=
ct=20
dir_struct *dir, const char *base, int baselen)
>  				dir->basebuf, stk->baselen - 1,
>  				dir->basebuf + current, &dt);
>  			dir->basebuf[stk->baselen - 1] =3D '/';
> +			if (dir->exclude &&
> +			    dir->exclude->flags & EXC_FLAG_NEGATIVE)
> +				dir->exclude =3D NULL;
>  			if (dir->exclude) {
>  				dir->basebuf[stk->baselen] =3D 0;
>  				dir->exclude_stack =3D stk;

Hi, Karsten

I applied your fix on v1.8.3 on both systems I mentioned earlier and
from my tests the issue I reported is fixed.

Thank you very much! :)

Regards
=C3=98sse
