From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/8] vcs-svn, svn-fe: add a couple of options
Date: Mon, 4 Jul 2011 13:06:53 +0200
Message-ID: <CAGdFq_gQFGy6xWYv_9sN=Txk0hmzT7h=LUfLP-Q4=EFEvS=KLA@mail.gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 13:07:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qdh07-0006ld-Ot
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 13:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab1GDLHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jul 2011 07:07:34 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38010 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab1GDLHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2011 07:07:33 -0400
Received: by pzk9 with SMTP id 9so1586104pzk.19
        for <git@vger.kernel.org>; Mon, 04 Jul 2011 04:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MEWfSICVKHOgOakMNSyDHQgKL/rfPsnGpxncupV+QFU=;
        b=fRp7q+YOPVgCnG7XJOcmgL29dEEAd+EA6L/iUNirBEkxvIjneqdD7pRaG/uKT20tNZ
         ZXwbKWWZQH8+gu1+juJWEoT+0zp+Dlf6a1y09PlndvB9zmuv/aTXxZQRya/d3JxrEJmc
         TBX0TGeWtSXxtDUeRRinzxpgArg+LHK557qLU=
Received: by 10.68.51.162 with SMTP id l2mr3274993pbo.100.1309777653093; Mon,
 04 Jul 2011 04:07:33 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Mon, 4 Jul 2011 04:06:53 -0700 (PDT)
In-Reply-To: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176594>

Heya,

[+Ram]

On Sun, Jul 3, 2011 at 19:57, Dmitry Ivankov <divanorama@gmail.com> wro=
te:
> This patch set adds a few options for svn-fe that can be used in
> a svn remote helper and useful in general for vcs-svn/. The last
> three patches add the options, others prepare the ground for them.
>
> The patch base is svn-fe branch at git://repo.or.cz/git/jrn.git
>
> Dmitry Ivankov (8):
> =C2=A0vcs-svn: move url parameter from _read to _init
> =C2=A0svn-fe: add man target to Makefile
> =C2=A0svn-fe: add EXTLIBS needed for parse-options
> =C2=A0svn-fe: add usage and unpositional arguments versions
> =C2=A0test-svn-fe: use parse-options
> =C2=A0vcs-svn: allow to specify dump destination ref
> =C2=A0vcs-svn: convert REPORT_FILENO to an option
> =C2=A0vcs-svn: allow to disable 'progress' lines
>
> =C2=A0contrib/svn-fe/Makefile =C2=A0 | =C2=A0 18 ++++----
> =C2=A0contrib/svn-fe/svn-fe.c =C2=A0 | =C2=A0 42 +++++++++++++++++--
> =C2=A0contrib/svn-fe/svn-fe.txt | =C2=A0 29 +++++++++++--
> =C2=A0t/t9010-svn-fe.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 99 +++++=
++++++++++++++++++++++++++++++++--------
> =C2=A0test-svn-fe.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 50 ++++++++++++++++-------
> =C2=A0vcs-svn/fast_export.c =C2=A0 =C2=A0 | =C2=A0 13 +++++-
> =C2=A0vcs-svn/fast_export.h =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0vcs-svn/svndump.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 11 ++---
> =C2=A0vcs-svn/svndump.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 =
+-
> =C2=A09 files changed, 205 insertions(+), 63 deletions(-)
>
> --
> 1.7.3.4

--=20
Cheers,

Sverre Rabbelier
