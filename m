From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC v2 5/6] gettext: Add a Gettext interface for Perl
Date: Tue, 01 Jun 2010 10:00:18 -0700 (PDT)
Message-ID: <m3iq62r8jn.fsf@localhost.localdomain>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
	<1275252857-21593-6-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>,
	=?iso-8859-4?q?Jakub_Nar=EAbski?= <jnareb@gmail.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 19:23:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJVB5-0003ma-VQ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab0FARWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 13:22:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43520 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab0FARWy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 13:22:54 -0400
Received: by bwz11 with SMTP id 11so209676bwz.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=C93zbstwxyojiOM0Z+OLC1F7kh1vrnDxkM4apq4/3jM=;
        b=RHJIMjCREh54c0Yg1S6mnUwv530l6OM5qVgKWriP1s4GiSoqRnF4vyJx8jOymlLgQU
         zjOrejsD54xuqFOK9nsaN5qFUc+UmVldwmTcehVXnQaMYnxO5+GBpSy8bebVCizrLbiq
         rmALNAi5JL4OxyFyuPYm2LWh9tceGk4OTk0JA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=oPvsbOjtIhqtq7QFn7WIu7e7/z+9N7wvOUPHhoaWXSCM6iI78+hvcw3mnFx4IEZd/A
         ed7ZgkL4d2fhmgt21E2sSr/ojw/6X9zxG5UYTu9LIONIlzZviQAyzi6gu+wcRU8n5zCN
         YxdMQP+S4MmxkeAxD9/mqGThEWcNrCs2Ma0dY=
Received: by 10.204.6.12 with SMTP id 12mr853750bkx.171.1275411620096;
        Tue, 01 Jun 2010 10:00:20 -0700 (PDT)
Received: from localhost.localdomain (abvg224.neoplus.adsl.tpnet.pl [83.8.204.224])
        by mx.google.com with ESMTPS id v14sm3928837bkz.20.2010.06.01.10.00.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 10:00:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o51H287N001701;
	Tue, 1 Jun 2010 19:02:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o51H1noe001696;
	Tue, 1 Jun 2010 19:01:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1275252857-21593-6-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148142>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> Make Git's gettext messages available to Perl programs through
> Locale::Messages. Gracefully fall back to English on systems that
> don't contain the module.

This is I think a very good idea, both providing wrapper with fallback
to untranslated messages (and encapsulating translation), and using the
Locale::Messages module from libintl-perl library.  The "On the state o=
f
i18n in Perl" (http://rassie.org/archives/247) blog post from 26 April
2009 provides nice counterpoint to Locale::Maketext::TPJ13 / The Perl
Journal #13 article[1] from 1999... especially because using gettext is
natural for translating git command output and GUI, because git uses it
already for Tcl/Tk (gitk and git-gui), and it is natural solution for
code in C, which slightly less than half of git code.

Well, we could use Locale::Maketext::Gettext, but it is not in Perl
core either, and as http://rassie.org/archives/247 says its '*.po'
files are less natural.  The gettext documentation (gettext.info) also
recommends libintl-perl, or to be more exact Locale::TextDomain from
it.

[1] http://search.cpan.org/perldoc?Locale::Maketext::TPJ13
    http://interglacial.com/~sburke/tpj/as_html/tpj13.html


The question is why not use Locale::TextDomain, the high-level Perl-y
framework, wrapper around Locale::Messages from the same libintl-perl
library?  The gettext documentation (in gettext.info, chapter "13.5.18
Perl") says:

  Prerequisite
     `use POSIX;'
     `use Locale::TextDomain;' (included in the package libintl-perl
     which is available on the Comprehensive Perl Archive Network CPAN,
     http://www.cpan.org/).


This would change

 -	print "Emails will be sent from: ", $sender, "\n";
 +	printf gettext("Emails will be sent from: %s\n"), $sender;

to either

 +	print __"Emails will be sent from: ", $sender, "\n";

or

 +	printf __("Emails will be sent from: %s\n"), $sender;

or

 +	print __x("Emails will be sent from: {sender}\n",
 +	          sender =3D> $sender);


>=20
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> ---
>  Makefile            |    4 ++-
>  git-send-email.perl |    3 +-
>  perl/Git/Gettext.pm |   83 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  perl/Makefile.PL    |    5 ++-
>  4 files changed, 92 insertions(+), 3 deletions(-)
>  create mode 100644 perl/Git/Gettext.pm
>=20
> diff --git a/Makefile b/Makefile
> index dce2faa..2101713 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1884,7 +1884,9 @@ cscope:
>  	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
> =20
>  pot:
> -	$(XGETTEXT) -k_ -o po/git.pot $(C_OBJ:o=3Dc) $(SCRIPT_SH)
> +	$(XGETTEXT) --keyword=3D_ --output=3Dpo/git.pot --language=3DC $(C_=
OBJ:o=3Dc)
> +	$(XGETTEXT) --join-existing --output=3Dpo/git.pot --language=3DShel=
l $(SCRIPT_SH)

Shouldn't this line be in earlier patch, i.e. in "gettext: Add a
Gettext interface for shell scripts"?

> +	$(XGETTEXT) --join-existing --output=3Dpo/git.pot --language=3DPerl=
 $(SCRIPT_PERL)

=46rom gettext documentation (in gettext.info, chapter "13.5.18 Perl"):

  Extractor
     `xgettext -k__ -k\$__ -k%__ -k__x -k__n:1,2 -k__nx:1,2 -k__xn:1,2
     -kN__ -k'

Is it equivalent to specifying 'xgettext --language=3DPerl'?

Of course the above assumes that you are using Locale::TextDomain, or
at least use the same conventions.

> =20
>  POFILES :=3D $(wildcard po/*.po)
>  MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(=
POFILES))
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 111c981..a36718e 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -26,6 +26,7 @@ use Term::ANSIColor;
>  use File::Temp qw/ tempdir tempfile /;
>  use Error qw(:try);
>  use Git;
> +use Git::Gettext qw< :all >;

Please follow the existing convention, i.e.

  +use Git::Gettext qw(:all);

like you see in context line for 'use Error'.


Well, not that git-send-email.perl is very consistent about this
issue, see 'use File::Temp qw/ tempdir tempfile /;' versus=20
'use Error qw(:try);' but I'd reather you didn't introduce yet
another form.

> =20
>  Getopt::Long::Configure qw/ pass_through /;
> =20
> @@ -674,7 +675,7 @@ if (!defined $sender) {
>  	$sender =3D $repoauthor || $repocommitter || '';
>  	$sender =3D ask("Who should the emails appear to be from? [$sender]=
 ",
>  	              default =3D> $sender);
> -	print "Emails will be sent from: ", $sender, "\n";
> +	printf gettext("Emails will be sent from: %s\n"), $sender;

As I wrote, this IMHO should be either

  +	printf __("Emails will be sent from: %s\n"), $sender;

or

  +	print __x("Emails will be sent from: {sender}\n", sender =3D> $send=
er);

(note that parantheses differ in those two examples).

>  	$prompting++;
>  }
> =20
> diff --git a/perl/Git/Gettext.pm b/perl/Git/Gettext.pm
> new file mode 100644
> index 0000000..f434783
> --- /dev/null
> +++ b/perl/Git/Gettext.pm
> @@ -0,0 +1,83 @@
> +package Git::Gettext;

Should this package be named Git::Gettext, or other name would be
better, perhaps Git::I18N (like e.g. Games::Risk have
Games::Risk::I18N), or Git::Locale, or even Git::Translator?

Not very important.

> +use strict;
> +use warnings;
> +use Exporter;
> +use base 'Exporter';

O.K.

The alternative would be to use

  +use Exporter qw(import);

> +
> +our $VERSION =3D '0.01';
> +
> +our @EXPORT;
> +our @EXPORT_OK =3D qw< gettext >;

Same comment as above: more common way is to use qw(gettext) not=20
qw< gettext >; it is also the notation used in Exporter documentation.

> +our %EXPORT_TAGS;
> +@{ $EXPORT_TAGS{'all'} } =3D @EXPORT_OK;

Why not simply

  +our %EXPORT_TAGS =3D ('all' =3D> [ @EXPORT_OK ]);

or the reverse

  +our %EXPORT_TAGS =3D ('all' =3D> [qw(gettext)]);
  +our @EXPORT_OK   =3D @{$EXPORT_TAGS{'all'}};

or the reverse using tag utility functions

  +our %EXPORT_TAGS =3D ('all' =3D> [qw(gettext)]);
  +Exporter::export_ok_tags('all');

> +
> +sub __bootstrap_locale_messages {
> +	our $TEXTDOMAIN =3D 'git';
> +
> +	# TODO: How do I make the sed replacements in the top level
> +	# Makefile reach me here?
> +	#our $TEXTDOMAINDIR =3D q|@@LOCALEDIR@@|;

In Perl (well, in gitweb/gitweb.perl) we use '++VAR++' and not
'@@VAR@@' for placeholders, because '@' is sigil in Perl.  This is not
important in above example, because it is not interpolated string.


Make invoked on perl/Makefile, when invoked from main Makefile by
'$(MAKE) -C perl' (via QUIET_SUBDIR0) passes 'localedir' to submake;
perl/Makefile should probably have something like

  localedir ?=3D $(sharedir)/locale

That is assuming that 'localedir' is added to list of exported
variables.


But I am not sure how such substitution should be performed.

> +	our $TEXTDOMAINDIR =3D q</usr/local/share/locale>;

Why q<...> and not simply '...'?

> +
> +	require POSIX;
> +	POSIX->import(qw< setlocale >);
> +	# Non-core prerequisite module
> +	require Locale::Messages;
> +	Locale::Messages->import(qw< :locale_h :libintl_h >);
> +
> +	setlocale(LC_MESSAGES(), '');
> +	setlocale(LC_CTYPE(), '');
> +	textdomain($TEXTDOMAIN);
> +	bindtextdomain($TEXTDOMAIN =3D> $TEXTDOMAINDIR);
> +
> +	return;
> +}

This would probably be a bit simpler with Locale::TextDomain.

> +
> +BEGIN
> +{
> +	local ($@, $!);
> +	eval { __bootstrap_locale_messages() };
> +	if ($@) {
> +		# Oh noes, no Locale::Messages here
> +		*gettext =3D sub ($) { $_[0] };

Do you intended to use subroutine protytype here?  Ah, I see that
Locale::Messages::gettext has the same prototype...

> +	}
> +}

Does it need to be in BEGIN block?  Probably yes.

> +
> +1;
> +
> +__END__
> +

It's nice that you have provided documentation.

> +=3Dhead1 NAME
> +
> +Git::Gettext - Perl interface to Git's Gettext localizations
> +
> +=3Dhead1 DESCRIPTION
> +
> +Git's internal interface to Gettext via L<Locale::Messages>. If
> +L<Locale::Messages> can't be loaded (it's not a core module) we
> +provide stub passthrough fallbacks.

Very good.

It would probably be better though to use L<Locale::TextDomain>
instead of low(er)-level L<Locale::Messages>.

> +
> +=3Dhead1 FUNCTIONS
> +
> +=3Dhead2 gettext($)
> +
> +L<Locale::Messages>'s gettext function if all goes well, otherwise o=
ur
> +passthrough fallback function.

Other packages use _T() function for that, or like Locale::TextDomain
__() function.

> +
> +=3Dhead1 EXPORTS
> +
> +Exports are done via L<Exporter>. Invididual functions can be
> +exporter, or all of them via the C<:all> export tag.

Shouldn't this be described in less technical way in SYNOPSIS and
DESCRIPTION sections instead?

> +
> +=3Dhead1 AUTHOR
> +
> +E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail.com>
> +
> +=3Dhead1 LICENSE AND COPYRIGHT
> +
> +Copyright 2010 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gma=
il.com>
> +
> +This program is free software, you can redistribute it and/or modify
> +it under the same terms as Perl itself.

Which is dual licensed: GPL + Perl artistic.

Was it intended to use 'same terms as Perl itself' rather than GPLv2
or GPLv2+?

> +
> +=3Dcut
> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
> index 0b9deca..702ec7c 100644
> --- a/perl/Makefile.PL
> +++ b/perl/Makefile.PL
> @@ -16,7 +16,10 @@ endif
>  MAKE_FRAG
>  }
> =20
> -my %pm =3D ('Git.pm' =3D> '$(INST_LIBDIR)/Git.pm');
> +my %pm =3D (
> +	'Git.pm' =3D> '$(INST_LIBDIR)/Git.pm',
> +	'Git/Gettext.pm' =3D> '$(INST_LIBDIR)/Git/Gettext.pm',
> +);
> =20
>  # We come with our own bundled Error.pm. It's not in the set of defa=
ult
>  # Perl modules so install it if it's not available on the system yet=
=2E
> --=20
> 1.7.1.248.gcd6d1
>=20

--=20
Jakub Narebski
Poland
ShadeHawk on #git
