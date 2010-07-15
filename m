From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSOC 02/11] gitweb: Prepare for splitting gitweb
Date: Thu, 15 Jul 2010 20:05:51 +0200
Message-ID: <201007152005.54197.jnareb@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com> <1279178951-23712-3-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 15 20:06:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZSox-00020A-Fc
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 20:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933980Ab0GOSGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jul 2010 14:06:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58394 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933730Ab0GOSF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 14:05:59 -0400
Received: by bwz1 with SMTP id 1so749930bwz.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=lPHFqFgEZLDDLnJI1cwmGGz4jzXRpvtEQrYPYtkqFxc=;
        b=B5gewDaapKpCPMAkbVyAvzJ4sR7gp0yIUauMp5zdaDmmKMXu0zm3Z6ceK9m+EiK58z
         4pN6fFp05oYyicYlzJdMqemSEJt715HONrw6YyOiQGMYIzLWz8SChKUqaf5dGGrOA8y3
         JOTMC4O+A/3h+pAHZwxTa5IxE+SdYaPkGh3Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=rm74CC5gsnTGK0tDMZCZ9TFMh0aBB91Hgu0Smo+9v6eruLBlr+8+931ltfogprezQb
         Z77Fsc8ZIwACanh/Ft1EZvzMSa3gnARwuwfR8japj+Wqh+TzJzaaaXlhjrCHq1Fi+onu
         8/UzLN2a7CZrRxk0sX607Ua9Vx+zcaxpLS2t8=
Received: by 10.204.34.9 with SMTP id j9mr14749308bkd.179.1279217157382;
        Thu, 15 Jul 2010 11:05:57 -0700 (PDT)
Received: from [192.168.1.13] (abwm47.neoplus.adsl.tpnet.pl [83.8.236.47])
        by mx.google.com with ESMTPS id a9sm6905715bky.23.2010.07.15.11.05.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 11:05:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1279178951-23712-3-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151103>

On Thu, 15 Jul 2010, Pavan Kumar Sunkara wrote:

> Prepare gitweb for having been split into modules that are to be
> installed alongside gitweb in 'lib/' subdirectory, by adding
>=20
>   use lib __DIR__.'/lib';
>=20
> to gitweb.perl (to main gitweb script), and preparing for putting
> modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.
>=20
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---

=46irst, it would be better if the comment from the cover letter about
this patch (quoted below) was [also] put as the comment for this=20
patch (i.e. in this area).

> The second patch is produced by my commit ammend to Jakub Nar=EAbski'=
s
> initial commit to prepare splitting of gitweb in the message-id:
> http://mid.gmane.org/1276531710-22945-4-git-send-email-jnareb@gmail.c=
om
>
> There is a small ammendment to that patch.
> $(INSTALL) -m 644 $(mod) '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(mod)'
> is changed to
> $(INSTALL) -m 644 $(mod) '$(DESTDIR_SQ)$(gitwebdir_SQ)/$(dir
> $(mod))';) because it is better if we gave 'dir $(mod)' as the target
> for install command rather than '$(mod)' because it may cause
> problems in the future when gitweblibdir is used and the modules are
> installed elsewhere rather than in /use/share/gitweb.

Second, I don't quite understand the reason for your amendment.  The
difference is between two argument

  install [OPTION]... SOURCE DEST

in my original version of this patch, and two argument

  install [OPTION]... SOURCE DIRECTORY

after your change.  In both cases we install _single_ file at once.
What problems first version may cause if $(gitweblibdir) is used
and it points elsewhere than $(gitwebdir)/lib?

>  gitweb/Makefile    |    3 +++
>  gitweb/gitweb.perl |    9 +++++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
>=20
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index d2584fe..c7610b3 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -55,6 +55,7 @@ PERL_PATH  ?=3D /usr/bin/perl
>  bindir_SQ =3D $(subst ','\'',$(bindir))#'
>  gitwebdir_SQ =3D $(subst ','\'',$(gitwebdir))#'
>  gitwebstaticdir_SQ =3D $(subst ','\'',$(gitwebdir)/static)#'
> +gitweblibdir_SQ =3D $(subst ','\'',$(gitwebdir)/lib)#'
>  SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))#'
>  PERL_PATH_SQ  =3D $(subst ','\'',$(PERL_PATH))#'
>  DESTDIR_SQ    =3D $(subst ','\'',$(DESTDIR))#'
> @@ -150,6 +151,8 @@ install: all
>  	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
>  	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_S=
Q)'
> +	$(foreach dir,$(sort $(dir $(GITWEB_MODULES))),test -d '$(DESTDIR_S=
Q)$(gitwebdir_SQ)/$(dir)' || $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwe=
bdir_SQ)/$(dir)';)
> +	$(foreach mod,$(GITWEB_MODULES),$(INSTALL) -m 644 $(mod) '$(DESTDIR=
_SQ)$(gitwebdir_SQ)/$(dir $(mod))';)

Third, if you were folloring git mailing list (or at least patches for
gitweb on it), you would notice new version of my "gitweb: Prepare for
splitting gitweb" patch:

  "[PATCHv3/RFC] gitweb: Prepare for splitting gitweb"
  Message-ID: <201007080920.38724.jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/150463/focus=3D=
150544

which uses shell for loop, instead of make's $(foreach ...) function to
avoid _possible_ problems with generating a command line that exceeded
the maximum argument list length, as explained in comment section of

  http://thread.gmane.org/gmane.comp.version-control.git/150463/focus=3D=
150463

Note that this version uses SOURCE DIRECTORY version rather than
SOURCE DEST, like in your patch... probably unnecessary.

> =20
>  ### Cleaning rules
> =20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 518328f..bda7da3 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -9,6 +9,14 @@
> =20
>  use strict;
>  use warnings;
> +
> +use File::Spec;
> +# __DIR__ is taken from Dir::Self __DIR__ fragment
> +sub __DIR__ () {
> +	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1=
]);
> +}
> +use lib __DIR__ . '/lib';
> +
>  use CGI qw(:standard :escapeHTML -nosticky);
>  use CGI::Util qw(unescape);
>  use CGI::Carp qw(fatalsToBrowser set_message);
> @@ -16,6 +24,7 @@ use Encode;
>  use Fcntl ':mode';
>  use File::Find qw();
>  use File::Basename qw(basename);
> +
>  binmode STDOUT, ':utf8';
> =20
>  our $t0;

In "[PATCHv3/RFC] gitweb: Prepare for splitting gitweb" this spurious
change was removed from patch.


Anyway, eventual replacing of this patch by other version should be
fairly easy, so it shouldn't hold this series.

--=20
Jakub Narebski
Poland
