From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Mon, 03 Oct 2011 13:17:14 -0700 (PDT)
Message-ID: <m37h5jt19v.fsf@localhost.localdomain>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
	<CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
	<vpq7h5jtngj.fsf@bauges.imag.fr>
	<CALkWK0nuLHpG9xqAAVL4T21N-31m7=A3_amp7Mf0Sw9jobYDRg@mail.gmail.com>
	<CALkWK0nt4PXfBxGcAnavUkKM6AhKpZnw1NtZsNznzmGZiguFqA@mail.gmail.com>
	<CALkWK0mNBG8EwysjO8uoR+fU5ZM=Pz9es3t_+s6cFgR6NSodGQ@mail.gmail.com>
	<vpq39g7gua3.fsf@bauges.imag.fr> <4E68CA0C.5080702@unixsol.org>
	<4E68CC08.4040201@unixsol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Georgi Chorbadzhiyski <gf@unixsol.org>
X-From: git-owner@vger.kernel.org Mon Oct 03 22:17:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAox2-0000Zo-HE
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 22:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512Ab1JCURT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 16:17:19 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42595 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab1JCURS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 16:17:18 -0400
Received: by eya28 with SMTP id 28so3192567eya.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=O+6VvzubsNl3CofbZn0p2gE5GluCgSnyKGyHyFp2Vs4=;
        b=IOeXEhBSYUyEi9W8AqK6L7cbuDqwNqycQ7HXEqgtD39j7tjW7UeyMYtAUkO8yYtCIf
         a2pn3jVDQFN5zAiMTyqR+7IU+tFepS8Ikhl/rFBZ9iZA5EisbUucinZmqu4Hp3aF5ya6
         Ny+cU7qUkHtrkNO+d41lRK62ejm7SwCp3V+GA=
Received: by 10.223.51.69 with SMTP id c5mr414487fag.136.1317673036917;
        Mon, 03 Oct 2011 13:17:16 -0700 (PDT)
Received: from localhost.localdomain (abvr121.neoplus.adsl.tpnet.pl. [83.8.215.121])
        by mx.google.com with ESMTPS id t19sm22530776faj.23.2011.10.03.13.17.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 13:17:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p93KG8hJ002032
	for <git@vger.kernel.org>; Mon, 3 Oct 2011 22:16:31 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p88H38ND024942;
	Thu, 8 Sep 2011 19:03:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E68CC08.4040201@unixsol.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182710>

Georgi Chorbadzhiyski <gf@unixsol.org> writes:
> Around 09/08/2011 04:58 PM, Georgi Chorbadzhiyski scribbled:
[...]
> > In order for this to work, confirmation should be split from send_m=
essage()
> > and from a quick look this not seem very easy. Might be easier to j=
ust
> > disable the sleep if user was asked for confirmation. It'll be good=
 to
> > not sleep after last email, but main "foreach my $t (@files) {" loo=
p should
> > pass some hint to send_message().
>=20
> The attached patch (apply on on top of the original) should implement=
 the
> idea.
>=20
> --=20
> Georgi Chorbadzhiyski
> http://georgi.unixsol.org/
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 7239fd4..d4559c9 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1149,7 +1149,7 @@ X-Mailer: git-send-email $gitversion
>  		}
>  	}
> =20
> -	if (!$dry_run && $sleep) {
> +	if (!$dry_run && $sleep && $message_num < scalar $#files && $confir=
m eq 'never') {
                                                  ^^^^^^^^^^^^^^

>  		print "Sleeping: $sleep second(s).\n" if (!$quiet);
>  		sleep($sleep);
>  	};

Errr... what?  If we have @files array, then '$#files' is index of
last element in array, which is scalar anyway, and 'scalar $#files' is
a no-op.

You can get number of elements in array with 'scalar @files', though
_implicit_ scalar context would also work, like e.g. right hand side
of '<' operator.

--=20
Jakub Nar=EAbski
