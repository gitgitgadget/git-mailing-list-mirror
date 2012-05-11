From: demerphq <demerphq@gmail.com>
Subject: Re: Git.pm
Date: Fri, 11 May 2012 10:27:31 +0200
Message-ID: <CANgJU+XuPo00U+7r1xtK0BcD1YfrWhpCZ2DO10DEc_PpOvtFdQ@mail.gmail.com>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
	<CAFouetgwRpB1GFJOC8PTVryVY-94S3xa5ZiSaWQWoz070qQ-6g@mail.gmail.com>
	<CAB3zAY0NeXuH-wXyYkbim5U74eANY4hq5D6SsVLu3KeUqHFqzQ@mail.gmail.com>
	<20120426203136.GA15432@burratino>
	<CAB3zAY3VHtUobJfJ7=nSKb_6uJOXLGVHzR18qV6txPkzf54cDw@mail.gmail.com>
	<4FAC2B2E.7060101@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Subho Banerjee <subs.zero@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>, git <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Fri May 11 10:27:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSlCP-0001Ye-73
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 10:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab2EKI1f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 May 2012 04:27:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61636 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932Ab2EKI1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2012 04:27:32 -0400
Received: by yenm10 with SMTP id m10so2352214yen.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=e9io5X3LlyJhLKT5EWGok33rYeQRMYyHBbAjmFIlkiE=;
        b=XAsqJxSwkEY3wiYKih+j4Ce+Do7r2vZrbzo8E9A9Pufcq8cwiMDQ7i/B6L8Zv8Vqwo
         y2fG2IMRVaRNfV+L+LXYQ1WK170Tzjl53ix53Tdm6AvKMbRsm4c4B44G0cUqCcsVeFA/
         Tk3W9D5GWXvJ292ypkTMbx6yQm7LPG7BecSy/6jMHFk5g0VpgcvkzjT79aUxDLm77r0T
         jhXBZjWqX4dG30JdRGO6qAIPNmJXEa+AyqgYM6PArdijbVcQZBEKI4ufZPNCEOHgo8Wk
         frcMcYi456tmeu67FU9jhCFkEcMo8hKNx0NKMEQiLplvpRcs8wItD3Z1KiY7PTtPAw7i
         zEdQ==
Received: by 10.236.75.234 with SMTP id z70mr9545631yhd.5.1336724851164; Fri,
 11 May 2012 01:27:31 -0700 (PDT)
Received: by 10.236.152.35 with HTTP; Fri, 11 May 2012 01:27:31 -0700 (PDT)
In-Reply-To: <4FAC2B2E.7060101@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197661>

On 10 May 2012 22:55, Andrew Sayers <andrew-git@pileofstuff.org> wrote:
> Try::Tiny is an increasingly standard part of Perl - for example, it'=
s
> used extensively in Moose. =A0There's a good list of arguments about =
why
> you should use it instead of eval in the Try::Tiny documentation:
> http://search.cpan.org/~nuffin/Try-Tiny-0.01/lib/Try/Tiny.pm
>
> Now I've got that talking point done, here's what I really think :)
>
> Try::Tiny is designed on the assumption that throwing and catching
> objects is something people should do all the time, and it can cause
> subtle errors that are only worth the hassle if you get a lot of bene=
fit
> from doing so. =A0It's easy enough to come up with ideas for where th=
ey
> might be useful, but in the real world advanced uses for exceptions a=
re
> usually a sign you're doing it wrong. =A0Three of the most common rea=
sons
> for frequent/complex exceptions are handling errors further up the ca=
ll
> stack, recovering from operations that fail, and clever error-handlin=
g.
>
>
> If you want exceptions to be caught by code further up the call stack
> than the immediate caller, you're likely to be disappointed. =A0This =
is
> one of the places where "separation of concerns" applies - if I use a
> module that uses a module that uses your module, then catching
> exceptions from your code will just cause my program to break when so=
me
> module in the middle obscures your error by adding its own layer of
> error handling.
>
>
> If you have an operation that really might fail, and you want to
> encourage most people to handle it most of the time, it's better to h=
ave
> a function with a meaningful name and good documentation. =A0This put=
s the
> burden on the calling function to handle the error instead of letting
> them think "oh well, if it dies someone else will handle it". =A0It a=
lso
> forces you to split functions along boundaries that make your code
> readable, instead of falling for the temptation to make something tha=
t
> "just works"... until it doesn't, and the maintainer has to go
> spelunking through code they don't know. =A0So instead of:
>
> =A0 try {
> =A0 =A0 =A0 Foo::frobnicate( widgets =3D> 3 );
> =A0 } catch {
> =A0 =A0 =A0if (ref($_) eq 'Error::Widget') {
> =A0 =A0 =A0 =A0 =A0die "Could not add 3 widgets";
> =A0 =A0 =A0}
> =A0 }
>
> It's better to ask the people using your module to write:
>
> =A0 my $foo =3D Foo->new;
> =A0 $foo->add_widgets(3) or die "could not add 3 widgets"
> =A0 $foo->frobnicate;
>
> This is easier to document, easier to write and easier to read.
>
>
> If you have an operation where calling code is supposed to do somethi=
ng
> more complicated than give up, it's better to use a callback. =A0This
> gives you an opportunity to document what's needed, and to check that
> the calling code is doing the right thing before it's too late. =A0So
> instead of:
>
> =A0 =A0my $widgets =3D 3;
> =A0 =A0while ( $widgets ) {
>
> =A0 =A0 =A0 =A0try {
> =A0 =A0 =A0 =A0 =A0 =A0Foo::frobnicate($widgets);
> =A0 =A0 =A0 =A0 =A0 =A0$widgets =3D 0;
> =A0 =A0 =A0 =A0} catch {
> =A0 =A0 =A0 =A0 =A0 =A0if ( $_->{remaining_widgets} < 2 ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die $_->{error};
> =A0 =A0 =A0 =A0 =A0 =A0} elsif ( $_->{remaining_widgets} =3D=3D 2 ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$widgets =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> =A0 =A0}
>
> It's better to ask people using your module to write:
>
> =A0 =A0Foo::Frobnicate(
> =A0 =A0 =A0 =A0widgets =3D> 3,
> =A0 =A0 =A0 =A0error_handler =3D> sub {
> =A0 =A0 =A0 =A0 =A0 =A0 my ( $remaining_widgets, $error ) =3D @_;
> =A0 =A0 =A0 =A0 =A0 =A0 die $error if $broken_widgets < 2;
> =A0 =A0 =A0 =A0 =A0 =A0 return "give up" if $remaining_widgets =3D=3D=
 2;
> =A0 =A0 =A0 =A0 =A0 =A0 return "continue";
> =A0 =A0 =A0 =A0},
> =A0 =A0);
>
> Again, this is more readable and easier to document.
>
>
> Aside from the philosophical angle, Try::Tiny is particularly hard to
> maintain because it looks like a language extension, but is actually
> just an ordinary module. =A0The try {} and catch {} blocks are anonym=
ous
> subroutines, which lead to some wonderfully unintuitive behaviour. =A0=
See
> what you think these do, then run the code to find out:
>
>
> =A0 =A0sub foo {
> =A0 =A0 =A0 =A0try {
> =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> =A0 =A0}
>
> =A0 =A0sub bar {
>
> =A0 =A0 =A0 =A0our @args =3D @_;
> =A0 =A0 =A0 =A0our @ret;
>
> =A0 =A0 =A0 =A0try {
> =A0 =A0 =A0 =A0 =A0 =A0@ret =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wantarray
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0? =A0 grep( /blah/, @args )
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: [ grep( /blah/, @args ) ]
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0return @ret;
> =A0 =A0}
>
> =A0 =A0my $foo =3D "bar";
> =A0 =A0sub baz {
> =A0 =A0 =A0 =A0my $foo =3D "baz";
> =A0 =A0 =A0 =A0try {
> =A0 =A0 =A0 =A0 =A0 =A0print $foo;
> =A0 =A0 =A0 =A0}
> =A0 =A0}
>
> =A0 =A0sub qux {
> =A0 =A0 =A0 =A0my $ret;
> =A0 =A0 =A0 =A0try {
> =A0 =A0 =A0 =A0 =A0 =A0$ret =3D "value";
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return $ret;
> =A0 =A0}
>
> =A0 =A0print foo, "\n";
> =A0 =A0print bar( "blah", "blip" ), "\n";
> =A0 =A0baz;
> =A0 =A0print qux, "\n";
>
>
> In short, Try::Tiny looks like a lot of gain for not much pain, but
> actually it's the other way around.

Total agreement.

Yves
--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
