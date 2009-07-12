From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v2] init-db: migrate to parse-options
Date: Sun, 12 Jul 2009 20:37:16 +0200
Message-ID: <20090712203716.20ac4261@gmail.com>
References: <4A598E03.10204@gmail.com>
	<1247394272-6944-1-git-send-email-michal.kiedrowicz@gmail.com>
	<7v8witn4e5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 20:37:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ3vZ-0007Mb-D8
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 20:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbZGLShY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jul 2009 14:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754588AbZGLShX
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 14:37:23 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:36438 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbZGLShW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jul 2009 14:37:22 -0400
Received: by ewy26 with SMTP id 26so2127083ewy.37
        for <git@vger.kernel.org>; Sun, 12 Jul 2009 11:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=bXX2UHc/nk/B9R7nFiQrFam/bJOcX5qEu/53tAJ5nqQ=;
        b=heQHWcD/QWwZTYYIvjdrn7bW+mczVjUiMddbote+wyRnHAvKWZ7vW6/Q8uefN7v1qw
         XPX+IYNrd34WvKxnHm4V1vNYZcrjlFWtDwYQaYMasyQz00RrExCIRb4TwlEkFbZj0T48
         Ww/dMnkAZ/dThY8c7HYq5dYut+vK7W3wLq9Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=k7abVtIwnamhkaA0MD/e/1NQJk6Gt7mjqlxEKf8jA3WnRmZ3AA/mNh0y4SakYC5ACZ
         rkWba0dKSAqbJLW9HaDQRSg+XffKS5cxWSNWC7hSctiRad7jQCQXcztPKcy2Vc7jFzrT
         aNQXL4kG5lqGDSiSfJtq/JUc7webnW8ivFs84=
Received: by 10.211.194.9 with SMTP id w9mr4018095ebp.10.1247423840911;
        Sun, 12 Jul 2009 11:37:20 -0700 (PDT)
Received: from localhost (77-253-195-139.adsl.inetia.pl [77.253.195.139])
        by mx.google.com with ESMTPS id 23sm4352181eya.39.2009.07.12.11.37.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Jul 2009 11:37:20 -0700 (PDT)
In-Reply-To: <7v8witn4e5.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123156>

Junio C Hamano <gitster@pobox.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > Also add missing --bare to init-db synopsis.
> >
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
> >  Documentation/git-init-db.txt |    2 +-
> >  builtin-init-db.c             |   51
> > ++++++++++++++++++++++++----------------- 2 files changed, 31
> > insertions(+), 22 deletions(-)
>=20
> The subject says patch v2 but there is no description since the
> previous round, nor ...
>=20
> > diff --git a/Documentation/git-init-db.txt
> > b/Documentation/git-init-db.txt index 1fd0ff2..eba3cb4 100644
> > --- a/Documentation/git-init-db.txt
> > +++ b/Documentation/git-init-db.txt
> > @@ -8,7 +8,7 @@ git-init-db - Creates an empty git repository
> >  ...
> > diff --git a/builtin-init-db.c b/builtin-init-db.c
> > index 4a56006..d68f61b 100644
> > --- a/builtin-init-db.c
> > +++ b/builtin-init-db.c
> > @@ -6,6 +6,7 @@
> > ...
>=20
> ... I see any change in the blob object name recorded on the index
> line.
>=20
> What is going on?

I just added "PARSE_OPT_NONEG" flag to "shared" option in reply to
Stephen's comment:

Stephen Boyd <bebarino@gmail.com> wrote:
> Or you can add PARSE_OPT_NONEG here and avoid the above comment.

Sorry I haven't described the change, I just thought it was obvious.


BTW: There is a difference:

> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 4a56006..9b1ce45 100644

and=20

> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 4a56006..d68f61b 100644


--=20
Micha=C5=82 Kiedrowicz
