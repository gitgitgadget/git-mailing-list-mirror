From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Output site name with valid utf8 in OPML
Date: Tue, 29 Nov 2011 11:35:21 -0800 (PST)
Message-ID: <m3hb1mlo1z.fsf@localhost.localdomain>
References: <CAKD0UuyJDaHyofM5VYG-R03mgYi_1QBJvQufv927+x6YYzPU2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?J=FCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Nov 29 20:35:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVTSj-0004I4-B7
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 20:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab1K2TfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 14:35:25 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52986 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235Ab1K2TfY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 14:35:24 -0500
Received: by bkas6 with SMTP id s6so925643bka.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 11:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Zl5IhiNB/JjMVWXvmNTBBX/ToRdAORD8bc/tGFaTPxE=;
        b=kW6JjAE/EbVL3rvb63vhzlZpcBGMGYlYQbYZRdXo1ZMzV7G31rDCajZFGjgQDazEGr
         zQavIQuhaYMA1zVJNpfmgj6uFDeZW+rjZ6L+X53Tb5gyvSSzQ8FDJLnrBeSJd9tHW049
         N/bhpwfEVDlHKjAy+9w97eW2PUSXJLCqENAAc=
Received: by 10.205.135.133 with SMTP id ig5mr25414786bkc.84.1322595322779;
        Tue, 29 Nov 2011 11:35:22 -0800 (PST)
Received: from localhost.localdomain (abvz161.neoplus.adsl.tpnet.pl. [83.8.223.161])
        by mx.google.com with ESMTPS id p13sm17255039bkd.4.2011.11.29.11.35.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 11:35:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pATJZL9p002014;
	Tue, 29 Nov 2011 20:35:21 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pATJZKgd002011;
	Tue, 29 Nov 2011 20:35:20 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAKD0UuyJDaHyofM5VYG-R03mgYi_1QBJvQufv927+x6YYzPU2w@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186076>

J=FCrgen Kreileder <jk@blackdown.de> writes:

> Signed-off-by: Juergen Kreileder <jk@blackdown.de>
> ---
>  gitweb/gitweb.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4f0c3bd..df747c1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -7699,11 +7699,12 @@ sub git_opml {
>  		-charset =3D> 'utf-8',
>  		-content_disposition =3D> 'inline; filename=3D"opml.xml"');
>=20
> +	my $title =3D esc_html($site_name);
>  	print <<XML;
>  <?xml version=3D"1.0" encoding=3D"utf-8"?>
>  <opml version=3D"1.0">
>  <head>
> -  <title>$site_name OPML Export</title>
> +  <title>$title OPML Export</title>
>  </head>
>  <body>
>  <outline text=3D"git RSS feeds">
> --=20

Thanks.  That is certainly correct... but it is more than just
handling utf8, isn't it.  It was also about not escaping XML
(think of site name containing eg. '<< foo >>' etc.).

So the subject / commit message should be corrected.

--=20
Jakub Nar=EAbski
