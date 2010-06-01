From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v2 5/6] gettext: Add a Gettext interface for Perl
Date: Tue, 1 Jun 2010 19:06:08 +0000
Message-ID: <AANLkTilLWZA6OrXhF28qCao2svpZWZiEwb5nVhXUTB9i@mail.gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
	<1275252857-21593-6-git-send-email-avarab@gmail.com>
	<m3iq62r8jn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 21:06:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJWn4-00074V-Tl
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 21:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044Ab0FATGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 15:06:13 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:44168 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab0FATGM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 15:06:12 -0400
Received: by pxi18 with SMTP id 18so2097434pxi.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Hci9vT+PYeHgwR6Hv9iuV2hq9FAHJaJc2HxrmIy6WMo=;
        b=Y8BL5tlvXNm06jXUh+pu9e30HW8scD1vFJLDNrJ+yLJWr0TTQk9nDHYPKXj/NfbxTU
         H7rBiDri9GVasX12HzB3+5QVkVqZXckQLsC4zWr+Ou/QLUGM20+lj2xxrmTI/wBecVJ0
         CLni3w3R2YmMzKFLrCyhInFRktO8sQdVkgrlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OMao5ecQtmOYwTmOrOXJQYVYEzpExqx8ckUgFQGp4NjyMJ4oIXN/RpMkhZZGQWud5k
         6vZhrQwXg11lfNPTB1b0NW36egaYF57BefiXQb7zx0nuF7TzO9EVfvu+axuGUugEVvlF
         7KdX12e+uF9NHoMExrj6OVBarpEQFhNgDWM68=
Received: by 10.141.23.15 with SMTP id a15mr5015235rvj.278.1275419169190; Tue, 
	01 Jun 2010 12:06:09 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 1 Jun 2010 12:06:08 -0700 (PDT)
In-Reply-To: <m3iq62r8jn.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148153>

On Tue, Jun 1, 2010 at 17:00, Jakub Narebski <jnareb@gmail.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Make Git's gettext messages available to Perl programs through
>> Locale::Messages. Gracefully fall back to English on systems that
>> don't contain the module.
>
> This is I think a very good idea, both providing wrapper with fallbac=
k
> to untranslated messages (and encapsulating translation), and using t=
he
> Locale::Messages module from libintl-perl library. =C2=A0The "On the =
state of
> i18n in Perl" (http://rassie.org/archives/247) blog post from 26 Apri=
l
> 2009 provides nice counterpoint to Locale::Maketext::TPJ13 / The Perl
> Journal #13 article[1] from 1999... especially because using gettext =
is
> natural for translating git command output and GUI, because git uses =
it
> already for Tcl/Tk (gitk and git-gui), and it is natural solution for
> code in C, which slightly less than half of git code.
>
> Well, we could use Locale::Maketext::Gettext, but it is not in Perl
> core either, and as http://rassie.org/archives/247 says its '*.po'
> files are less natural. =C2=A0The gettext documentation (gettext.info=
) also
> recommends libintl-perl, or to be more exact Locale::TextDomain from
> it.
>
> [1] http://search.cpan.org/perldoc?Locale::Maketext::TPJ13
> =C2=A0 =C2=A0http://interglacial.com/~sburke/tpj/as_html/tpj13.html

Locale::Maketext is a less complete and non-standard alternative as
the above blogs note. I think the main reason it's used in favor of
Gettext in many Perl projects is that it can be compiled stand-alone
from the CPAN, i.e. it doesn't depend on libintl.

That's comfortable when CPAN is your main distribution channel, but
Git's main distribution channel is via OS packages, which can
trivially introduce a gettext dependency (for which they doubtless
already have a package).

Locale::Maketext has a Gettext emulation layer, but using it would be
a potential source of bugs (no emulation is perfect).

That being said the way I wrote Git::Gexttext means any alterante
implementation or emulation layer can be seemlessly added later on. We
could use (or write) something for Perl, C or Shell that completely
bypasses libintl for systems that don't have a gettext C library.

> The question is why not use Locale::TextDomain, the high-level Perl-y
> framework, wrapper around Locale::Messages from the same libintl-perl
> library? =C2=A0The gettext documentation (in gettext.info, chapter "1=
3.5.18
> Perl") says:
>
> =C2=A0Prerequisite
> =C2=A0 =C2=A0 `use POSIX;'
> =C2=A0 =C2=A0 `use Locale::TextDomain;' (included in the package libi=
ntl-perl
> =C2=A0 =C2=A0 which is available on the Comprehensive Perl Archive Ne=
twork CPAN,
> =C2=A0 =C2=A0 http://www.cpan.org/).
>
>
> This would change
>
> =C2=A0- =C2=A0 =C2=A0 =C2=A0print "Emails will be sent from: ", $send=
er, "\n";
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0printf gettext("Emails will be sent from:=
 %s\n"), $sender;
>
> to either
>
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0print __"Emails will be sent from: ", $se=
nder, "\n";
>
> or
>
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0printf __("Emails will be sent from: %s\n=
"), $sender;
>
> or
>
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0print __x("Emails will be sent from: {sen=
der}\n",
> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sender=
 =3D> $sender);

I didn't use Locale::TextDomain because it exports a fatter interface
by default, and I'm not sure at this point what subset of it it would
make sense to support.

This is the default Locale::TexdDomain interface:

   @EXPORT =3D qw (__ __x __n __nx __xn __p __px __np __npx $__ %__
                 N__ N__n N__p N__np);

My Git::Gettext only exports a single gettext() function now. I think
it's better at this point to have a really small interface and decide
later if we'd like to expand it, preferably in a way that'll work
consistently across C, Perl and Shell programs.

We might want to improve plural support, add msgctxt etc. later. But
for an initial implementation I'd rather have something simple &
stupid.

>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>> ---
>> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A04 ++-
>> =C2=A0git-send-email.perl | =C2=A0 =C2=A03 +-
>> =C2=A0perl/Git/Gettext.pm | =C2=A0 83 ++++++++++++++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0perl/Makefile.PL =C2=A0 =C2=A0| =C2=A0 =C2=A05 ++-
>> =C2=A04 files changed, 92 insertions(+), 3 deletions(-)
>> =C2=A0create mode 100644 perl/Git/Gettext.pm
>>
>> diff --git a/Makefile b/Makefile
>> index dce2faa..2101713 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1884,7 +1884,9 @@ cscope:
>> =C2=A0 =C2=A0 =C2=A0 $(FIND) . -name '*.[hcS]' -print | xargs cscope=
 -b
>>
>> =C2=A0pot:
>> - =C2=A0 =C2=A0 $(XGETTEXT) -k_ -o po/git.pot $(C_OBJ:o=3Dc) $(SCRIP=
T_SH)
>> + =C2=A0 =C2=A0 $(XGETTEXT) --keyword=3D_ --output=3Dpo/git.pot --la=
nguage=3DC $(C_OBJ:o=3Dc)
>> + =C2=A0 =C2=A0 $(XGETTEXT) --join-existing --output=3Dpo/git.pot --=
language=3DShell $(SCRIPT_SH)
>
> Shouldn't this line be in earlier patch, i.e. in "gettext: Add a
> Gettext interface for shell scripts"?

It needed to be split up into seperate line in the Perl commit because =
=2E..

>> + =C2=A0 =C2=A0 $(XGETTEXT) --join-existing --output=3Dpo/git.pot --=
language=3DPerl $(SCRIPT_PERL)
>
> From gettext documentation (in gettext.info, chapter "13.5.18 Perl"):
>
> =C2=A0Extractor
> =C2=A0 =C2=A0 `xgettext -k__ -k\$__ -k%__ -k__x -k__n:1,2 -k__nx:1,2 =
-k__xn:1,2
> =C2=A0 =C2=A0 -kN__ -k'
>
> Is it equivalent to specifying 'xgettext --language=3DPerl'?

I'm doing --language=3DPerl because gettext doesn't recognize .perl as =
a
valid Perl extension. It only knows about `pl', `PL', `pm', `cgi'. (As
an aside, I haven't found why Git chose to use the quaint .perl
extension).

But yeah, using --language=3DPerl is overshooting it with regards to
keyword extraction. From "5.1 Invoking the `xgettext' Program":

     To disable the default keyword specifications, the option `-k' or
     `--keyword' or `--keyword=3D', without a KEYWORDSPEC, can be used.

I'll check if I can supply --keyword to all the XGETTEXT invocations.

> Of course the above assumes that you are using Locale::TextDomain, or
> at least use the same conventions.
>
>>
>> =C2=A0POFILES :=3D $(wildcard po/*.po)
>> =C2=A0MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git=
=2Emo,$(POFILES))
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 111c981..a36718e 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -26,6 +26,7 @@ use Term::ANSIColor;
>> =C2=A0use File::Temp qw/ tempdir tempfile /;
>> =C2=A0use Error qw(:try);
>> =C2=A0use Git;
>> +use Git::Gettext qw< :all >;
>
> Please follow the existing convention, i.e.
>
> =C2=A0+use Git::Gettext qw(:all);
>
> like you see in context line for 'use Error'.
>
>
> Well, not that git-send-email.perl is very consistent about this
> issue, see 'use File::Temp qw/ tempdir tempfile /;' versus
> 'use Error qw(:try);' but I'd reather you didn't introduce yet
> another form.

OK. I'll change that. I usually just pick whatever Perl quote
delimiters that happen to, literally, be close at hand at the time :)

>> =C2=A0Getopt::Long::Configure qw/ pass_through /;
>>
>> @@ -674,7 +675,7 @@ if (!defined $sender) {
>> =C2=A0 =C2=A0 =C2=A0 $sender =3D $repoauthor || $repocommitter || ''=
;
>> =C2=A0 =C2=A0 =C2=A0 $sender =3D ask("Who should the emails appear t=
o be from? [$sender] ",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 default =3D> $sender);
>> - =C2=A0 =C2=A0 print "Emails will be sent from: ", $sender, "\n";
>> + =C2=A0 =C2=A0 printf gettext("Emails will be sent from: %s\n"), $s=
ender;
>
> As I wrote, this IMHO should be either
>
> =C2=A0+ =C2=A0 =C2=A0 printf __("Emails will be sent from: %s\n"), $s=
ender;
>
> or
>
> =C2=A0+ =C2=A0 =C2=A0 print __x("Emails will be sent from: {sender}\n=
", sender =3D> $sender);
>
> (note that parantheses differ in those two examples).

I'd prefer the former argument expansion form (i.e. %s, not
{$sender}), just so translators don't have to deal with two different
argument forms.

As for __ or gettext I don't mind. I just picked the former on a whim
to match the Shell version. Maybe I should just change C|Perl|Shell to
use _?

And we can use _, __ is just used to disambiguate it from the _
filehandle, and Perl's pretty good at disambiguating that already:

    $ perl -E 'sub _ ($) { scalar reverse $_[0] }; say _("moo"); stat
"/etc/hosts"; say ((stat(_))[7])'
    oom
    168

>> =C2=A0 =C2=A0 =C2=A0 $prompting++;
>> =C2=A0}
>>
>> diff --git a/perl/Git/Gettext.pm b/perl/Git/Gettext.pm
>> new file mode 100644
>> index 0000000..f434783
>> --- /dev/null
>> +++ b/perl/Git/Gettext.pm
>> @@ -0,0 +1,83 @@
>> +package Git::Gettext;
>
> Should this package be named Git::Gettext, or other name would be
> better, perhaps Git::I18N (like e.g. Games::Risk have
> Games::Risk::I18N), or Git::Locale, or even Git::Translator?
>
> Not very important.

I really have no opinion on that, but it does seem like a lot of Perl
packages on CPAN use the ::I18N suffix.

>> +use strict;
>> +use warnings;
>> +use Exporter;
>> +use base 'Exporter';
>
> O.K.
>
> The alternative would be to use
>
> =C2=A0+use Exporter qw(import);

Not if we want to maintain 5.6 support. The `use Exporter "import"'
form was only introduced in 5.8. I use it everywhere where I don't
have to care about 5.6 support (which is everywhere but Git).

>> +
>> +our $VERSION =3D '0.01';
>> +
>> +our @EXPORT;
>> +our @EXPORT_OK =3D qw< gettext >;
>
> Same comment as above: more common way is to use qw(gettext) not
> qw< gettext >; it is also the notation used in Exporter documentation=
=2E

Will do.

>> +our %EXPORT_TAGS;
>> +@{ $EXPORT_TAGS{'all'} } =3D @EXPORT_OK;
>
> Why not simply
>
> =C2=A0+our %EXPORT_TAGS =3D ('all' =3D> [ @EXPORT_OK ]);
>
> or the reverse
>
> =C2=A0+our %EXPORT_TAGS =3D ('all' =3D> [qw(gettext)]);
> =C2=A0+our @EXPORT_OK =C2=A0 =3D @{$EXPORT_TAGS{'all'}};
>
> or the reverse using tag utility functions
>
> =C2=A0+our %EXPORT_TAGS =3D ('all' =3D> [qw(gettext)]);
> =C2=A0+Exporter::export_ok_tags('all');

Just because it some old code of mine I had around that I copied
from. I could rewrite it to a nicer form.

Actually I was considering changing it to just have @EXPORT and
nothing else. You're going to use gettext if you use the medule
anyway, so we might as well just import them all everywhere we use
Gettext in Perl.

>> +
>> +sub __bootstrap_locale_messages {
>> + =C2=A0 =C2=A0 our $TEXTDOMAIN =3D 'git';
>> +
>> + =C2=A0 =C2=A0 # TODO: How do I make the sed replacements in the to=
p level
>> + =C2=A0 =C2=A0 # Makefile reach me here?
>> + =C2=A0 =C2=A0 #our $TEXTDOMAINDIR =3D q|@@LOCALEDIR@@|;
>
> In Perl (well, in gitweb/gitweb.perl) we use '++VAR++' and not
> '@@VAR@@' for placeholders, because '@' is sigil in Perl. =C2=A0This =
is not
> important in above example, because it is not interpolated string.

I'll change it to follow that convention.

> Make invoked on perl/Makefile, when invoked from main Makefile by
> '$(MAKE) -C perl' (via QUIET_SUBDIR0) passes 'localedir' to submake;
> perl/Makefile should probably have something like
>
> =C2=A0localedir ?=3D $(sharedir)/locale
>
> That is assuming that 'localedir' is added to list of exported
> variables.
>
> But I am not sure how such substitution should be performed.

I'll try to get something like that to work. Actually the main problem
seemed to be that it had a hybrid handwritten Makefile and one made by
EU::MM.

>> + =C2=A0 =C2=A0 our $TEXTDOMAINDIR =3D q</usr/local/share/locale>;
>
> Why q<...> and not simply '...'?

Same reason I use qw<>, that is no particular reason other than it
being easier to type on my keyboard. I'll just change it to ''.

>> + =C2=A0 =C2=A0 require POSIX;
>> + =C2=A0 =C2=A0 POSIX->import(qw< setlocale >);
>> + =C2=A0 =C2=A0 # Non-core prerequisite module
>> + =C2=A0 =C2=A0 require Locale::Messages;
>> + =C2=A0 =C2=A0 Locale::Messages->import(qw< :locale_h :libintl_h >)=
;
>> +
>> + =C2=A0 =C2=A0 setlocale(LC_MESSAGES(), '');
>> + =C2=A0 =C2=A0 setlocale(LC_CTYPE(), '');
>> + =C2=A0 =C2=A0 textdomain($TEXTDOMAIN);
>> + =C2=A0 =C2=A0 bindtextdomain($TEXTDOMAIN =3D> $TEXTDOMAINDIR);
>> +
>> + =C2=A0 =C2=A0 return;
>> +}
>
> This would probably be a bit simpler with Locale::TextDomain.
>
>> +
>> +BEGIN
>> +{
>> + =C2=A0 =C2=A0 local ($@, $!);
>> + =C2=A0 =C2=A0 eval { __bootstrap_locale_messages() };
>> + =C2=A0 =C2=A0 if ($@) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Oh noes, no Locale::Me=
ssages here
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *gettext =3D sub ($) { $=
_[0] };
>
> Do you intended to use subroutine protytype here? =C2=A0Ah, I see tha=
t
> Locale::Messages::gettext has the same prototype...

Yeah, otherwise the fallback would have different semantics.

>> + =C2=A0 =C2=A0 }
>> +}
>
> Does it need to be in BEGIN block? =C2=A0Probably yes.

I'm pretty sure it needs to all be at BEGIN time. I recall that
declaring prototypes at runtime was an error in some older versions,
but it works now:

    $ perl -E '*meh =3D sub ($) { "foo" }; say prototype "meh"'
    $

Anyway since it's code that's being use'd it's going to always be at
BEGIN time anyway. I just wanted to be explicit.

>> +
>> +1;
>> +
>> +__END__
>> +
>
> It's nice that you have provided documentation.
>
>> +=3Dhead1 NAME
>> +
>> +Git::Gettext - Perl interface to Git's Gettext localizations
>> +
>> +=3Dhead1 DESCRIPTION
>> +
>> +Git's internal interface to Gettext via L<Locale::Messages>. If
>> +L<Locale::Messages> can't be loaded (it's not a core module) we
>> +provide stub passthrough fallbacks.
>
> Very good.
>
> It would probably be better though to use L<Locale::TextDomain>
> instead of low(er)-level L<Locale::Messages>.
>
>> +
>> +=3Dhead1 FUNCTIONS
>> +
>> +=3Dhead2 gettext($)
>> +
>> +L<Locale::Messages>'s gettext function if all goes well, otherwise =
our
>> +passthrough fallback function.
>
> Other packages use _T() function for that, or like Locale::TextDomain
> __() function.
>
>> +
>> +=3Dhead1 EXPORTS
>> +
>> +Exports are done via L<Exporter>. Invididual functions can be
>> +exporter, or all of them via the C<:all> export tag.
>
> Shouldn't this be described in less technical way in SYNOPSIS and
> DESCRIPTION sections instead?

Yeah, maybe. But there's a convention for `=3Dhead1 EXPORTS' in perl
core / CPAN. So that's what I added at a whim.

>> +
>> +=3Dhead1 AUTHOR
>> +
>> +E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gmail.com>
>> +
>> +=3Dhead1 LICENSE AND COPYRIGHT
>> +
>> +Copyright 2010 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avarab@gm=
ail.com>
>> +
>> +This program is free software, you can redistribute it and/or modif=
y
>> +it under the same terms as Perl itself.
>
> Which is dual licensed: GPL + Perl artistic.
>
> Was it intended to use 'same terms as Perl itself' rather than GPLv2
> or GPLv2+?

It's the permissive boilerplate I auto-insert for Perl code. I'll just
remove it. The COPYING file at the top level will suffice.

>> +
>> +=3Dcut
>> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
>> index 0b9deca..702ec7c 100644
>> --- a/perl/Makefile.PL
>> +++ b/perl/Makefile.PL
>> @@ -16,7 +16,10 @@ endif
>> =C2=A0MAKE_FRAG
>> =C2=A0}
>>
>> -my %pm =3D ('Git.pm' =3D> '$(INST_LIBDIR)/Git.pm');
>> +my %pm =3D (
>> + =C2=A0 =C2=A0 'Git.pm' =3D> '$(INST_LIBDIR)/Git.pm',
>> + =C2=A0 =C2=A0 'Git/Gettext.pm' =3D> '$(INST_LIBDIR)/Git/Gettext.pm=
',
>> +);
>>
>> =C2=A0# We come with our own bundled Error.pm. It's not in the set o=
f default
>> =C2=A0# Perl modules so install it if it's not available on the syst=
em yet.
>> --
>> 1.7.1.248.gcd6d1
>>
