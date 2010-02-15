From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 1/6] Fix 'git var' usage synopsis
Date: Sun, 14 Feb 2010 20:36:36 -0600
Message-ID: <20100215023636.GA17444@progeny.tock>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214115533.GA3499@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 03:36:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgqpG-0008HP-5k
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 03:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab0BOCgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 21:36:37 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:48929 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab0BOCgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 21:36:36 -0500
Received: by iwn39 with SMTP id 39so1770625iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 18:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=If9zJroxwCiy2TKY8j7o2z74mozQAOVzCfHRh/PTSPU=;
        b=sDTKI8U2TRhD7bsGhIpNUkXA7iPtnNwMRvSWuzZQDk5MpfNIIvu3opw6fBDl+BFW4g
         vRaJXFlvIqzIxQlzLi1mLOAeWRO0UqMmnklN9rdH4lErc85vUZCxfqUpElY9Kumev8tq
         6sq68PjX9LRP3zaQVNZkKkya6TCVyatooukbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tPjVV+3VbllXUsgTVoWw9hPoBwVfrps0v7NbiGcCCAkpxZfGnWEtdunYWUDYcDPRxz
         xbIf9RDFQZDnqbPyiO2T2wx1Dz0iZUmUETUD546DviV7/wIPODpnUgeT8aMHQjI2EhNB
         WBxx+b0dYSq60EoZtVOi9ge2OACd0T/u3Emvk=
Received: by 10.231.167.4 with SMTP id o4mr3900696iby.66.1266201395696;
        Sun, 14 Feb 2010 18:36:35 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm5858913iwn.5.2010.02.14.18.36.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 18:36:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100214115533.GA3499@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139960>

Jonathan Nieder wrote:

> --- a/builtin-var.c
> +++ b/builtin-var.c
> @@ -6,7 +6,7 @@
>  #include "cache.h"
>  #include "exec_cmd.h"
> =20
> -static const char var_usage[] =3D "git var [-l | <variable>]";
> +static const char var_usage[] =3D "git var (-l | <variable>)";
>  static const char *editor(int flag)
>  {

As Junio noticed, this doesn=E2=80=99t apply.  The problem is a missing
blank line between the static const char var_usage and static const
char *editor lines.  Worse still, I have no clue how it happened.

Here=E2=80=99s a revised patch (generated just like the first one...). =
 It
is really an independent fix from the rest of the series.

-- %< --
Subject: Fix 'git var' usage synopsis

The parameter to 'git var' is not optional.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-var.txt |    2 +-
 builtin-var.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index bb98182..458f3e2 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -8,7 +8,7 @@ git-var - Show a git logical variable
=20
 SYNOPSIS
 --------
-'git var' [ -l | <variable> ]
+'git var' ( -l | <variable> )
=20
 DESCRIPTION
 -----------
diff --git a/builtin-var.c b/builtin-var.c
index 2280518..e6ee7bc 100644
--- a/builtin-var.c
+++ b/builtin-var.c
@@ -6,7 +6,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
=20
-static const char var_usage[] =3D "git var [-l | <variable>]";
+static const char var_usage[] =3D "git var (-l | <variable>)";
=20
 static const char *editor(int flag)
 {
--=20
1.7.0
