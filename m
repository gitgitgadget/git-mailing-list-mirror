From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v2 3/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Thu, 29 Mar 2012 19:25:57 +0200
Message-ID: <20120329192557.4bd45322@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1332543417-19664-4-git-send-email-michal.kiedrowicz@gmail.com>
	<201203281633.53916.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 19:26:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJ6v-0006OU-Dh
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 19:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759766Ab2C2R0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 13:26:05 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44925 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758773Ab2C2R0D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 13:26:03 -0400
Received: by wibhj6 with SMTP id hj6so262760wib.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=6BwjiNQ41cUVfIF4k2wi7p5nH48MuCWN/4iAAg2Fj6k=;
        b=pChGzpTz18mfwb3U3DvFF+6tAxY0M9tg12T5Bgl6c5yvkFU5eLY+yuhAlzQpEL+8id
         Ik7iQhJuF60ONbSyGJze8J7QMm+5eboYOCWX2R9/ar1YtuM+UtOpQ4Jb3cM7aq/XJi05
         khEJP/vcDJhbBtxx6RUJcWTU+0L5ERYfBkxp5jC9DXUpr6M4Hh8k9DbqrVVCjJDil188
         w79yWehqZfcvnjpyfczWPtrBgHIx6xU2+AZTC1FKCvW+1LD7xrqQKhUSpTz+kvEBukTW
         5Ss8SNReO72nPf/N7RSIxwqwjUe+uMtcxE/hCtH0on0H84+6eXqMQooyExgyohMnKoLn
         tphA==
Received: by 10.180.106.9 with SMTP id gq9mr7584996wib.17.1333041960424;
        Thu, 29 Mar 2012 10:26:00 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id fl2sm31159816wib.4.2012.03.29.10.25.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 10:25:59 -0700 (PDT)
In-Reply-To: <201203281633.53916.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194276>

Jakub Narebski <jnareb@gmail.com> wrote:

> On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:
>=20
> > Currently, print_sidebyside_diff_chunk() does two things: it
> > accumulates diff lines and prints them.  Accumulation may be used t=
o
> > perform additional operations on diff lines,  so it makes sense to =
split
> > these two things.  Thus, the code that prints diff lines in a side-=
by-side
> > manner is moved out of print_sidebyside_diff_chunk() to a separate
> > subroutine.
> >
> Right, that is quite sensible.
>=20
> > The outcome of this patch is that print_sidebyside_diff_chunk() is =
now
> > much shorter and easier to read.
> >=20
> Nice effect.
>=20
> > This is a preparation patch for diff refinement highlightning.  It =
should
> > not change the gitweb output, but it slightly changes its behavior.
> > Before this commit, context is printed on the class change. Now, it=
'it
> > printed just before printing added and removed lines.
>=20
>                                                       , and at the en=
d
>   of chunk.
>=20
> IMVHO such change is irrelevant.
>=20
> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

Thanks.

>=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
> >  gitweb/gitweb.perl |   97 ++++++++++++++++++++++++++++------------=
------------
> >  1 files changed, 52 insertions(+), 45 deletions(-)
>=20
> Nice code movement.
> =20
