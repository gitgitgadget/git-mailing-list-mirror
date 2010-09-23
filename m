From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] sit-send-email.pl: Add --to-cmd
Date: Thu, 23 Sep 2010 17:29:16 +0000
Message-ID: <AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	<AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	<1285227413.7286.47.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	<20100923090931.GA29789@albatros>
	<20100923120024.GA26715@albatros>
	<1285253867.31572.13.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
	<1285262237.31572.18.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julia Lawall <julia@diku.dk>, git <git@vger.kernel.org>,
	Vasiliy Kulikov <segooon@gmail.com>,
	matt mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 19:31:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oype3-0002uC-2X
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 19:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab0IWR3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 13:29:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63831 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755918Ab0IWR3S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 13:29:18 -0400
Received: by gyd8 with SMTP id 8so660537gyd.19
        for <multiple recipients>; Thu, 23 Sep 2010 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sisUO0NIHoGsh7YM2kD90RNS3O06SPu0QCHePU3M/eo=;
        b=tyUQyzmmqgtJzRpcrVBg5e7e/3HZxwNfCvSjKe9aMNK7Df447k2m9xhtxs9t0SUECY
         Q/XEft89r9TDtYBwI+sisYLZvIMTdk47p77orNqhE/+3/hdYlhqbYBGHxhxC3E0gnRTC
         o1bLMZLW8lOwJHT3nAybWBTXaH7rq6KLKlCAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JcGLzBTKJiz4koC+YBRJQ4cOSmVMS4VRWl5uXwf3xFW+Rg+LSfDIK734rusY8jJPoi
         OSvMOsILpgyHxTspVQm24KzUxCXVi7V8ZCmdRxdKOv8+Og/hseFWffIhwmh4J9GcPRFI
         g0y9dBlU4hsMtvL1p0ETpKG7EJc7SoBOso6PI=
Received: by 10.151.130.20 with SMTP id h20mr3072853ybn.308.1285262956610;
 Thu, 23 Sep 2010 10:29:16 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 23 Sep 2010 10:29:16 -0700 (PDT)
In-Reply-To: <1285262237.31572.18.camel@Joe-Laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156886>

On Thu, Sep 23, 2010 at 17:17, Joe Perches <joe@perches.com> wrote:
> On Thu, 2010-09-23 at 17:58 +0200, Julia Lawall wrote:
>> On Thu, 23 Sep 2010, Joe Perches wrote:
>> > On Thu, 2010-09-23 at 16:00 +0400, Vasiliy Kulikov wrote:
>> > > On Thu, Sep 23, 2010 at 13:09 +0400, Vasiliy Kulikov wrote:
>> > > > On Thu, Sep 23, 2010 at 10:55 +0200, Julia Lawall wrote:
>> > > > > I made some changes to git-send-email to get it to send mail=
 to different
>> > > > > people, ie a different set of addresses for each patch. =C2=A0=
Is that now
>> > > > > possible with the standard version? =C2=A0If not I can submi=
t a patch with my
>> > > > > changes at some point.
>> > > > I use git-send-email --cc-cmd=3Dscript_to_form_cc_list.
>> > I believe that Julia means some mechanism to vary the
>> > "to" addresses for each patch, ie: some "--to-cmd=3Dcmd".
>> Yes, sort of. =C2=A0I took the strategy of precomputing the To addre=
sses, so I
>> just have a collection of files that have different To and Cc addres=
ses.
>> But a --to-cmd option seems like a good idea too.
>
> Perhaps something like this?
>
> Lightly tested only.
>
> I know there's a test harness in git, but
> I don't know how to wire up the new options.

You'd add the tests to t9001-send-email.sh and --tocmd out to some
program you create. Is there anything in particular you need help
with?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> =C2=A0git-send-email.perl | =C2=A0 25 +++++++++++++++++++++++--
> =C2=A01 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 6dab3bf..8e8e4c4 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -70,6 +70,7 @@ git send-email [options] <file | directory | rev-li=
st options >
>
> =C2=A0 Automating:
> =C2=A0 =C2=A0 --identity =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<str> =C2=A0* Use the sendemail.<id> options.
> + =C2=A0 =C2=A0--to-cmd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0<str> =C2=A0* Email To: via `<str> \$patch_path`
> =C2=A0 =C2=A0 --cc-cmd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0<str> =C2=A0* Email Cc: via `<str> \$patch_path`
> =C2=A0 =C2=A0 --suppress-cc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <str> =
=C2=A0* author, self, sob, cc, cccmd, body, bodycc, all.
> =C2=A0 =C2=A0 --[no-]signed-off-by-cc =C2=A0 =C2=A0 =C2=A0 =C2=A0* Se=
nd to Signed-off-by: addresses. Default on.
> @@ -187,7 +188,8 @@ sub do_edit {
> =C2=A0}
>
> =C2=A0# Variables with corresponding config settings
> -my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc=
_cmd);
> +my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
> +my ($to_cmd, $cc_cmd);
> =C2=A0my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encr=
yption);
> =C2=A0my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts, =
$smtp_domain);
> =C2=A0my ($validate, $confirm);
> @@ -214,6 +216,7 @@ my %config_settings =3D (
> =C2=A0 =C2=A0 "smtppass" =3D> \$smtp_authpass,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"smtpdomain" =3D> \$smtp_domain,
> =C2=A0 =C2=A0 "to" =3D> \@to,
> + =C2=A0 =C2=A0"tocmd" =3D> \$to_cmd,
> =C2=A0 =C2=A0 "cc" =3D> \@initial_cc,
> =C2=A0 =C2=A0 "cccmd" =3D> \$cc_cmd,
> =C2=A0 =C2=A0 "aliasfiletype" =3D> \$aliasfiletype,
> @@ -272,6 +275,7 @@ my $rc =3D GetOptions("sender|from=3Ds" =3D> \$se=
nder,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 "in-reply-to=3Ds" =3D> \$initial_reply_to,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
"subject=3Ds" =3D> \$initial_subject,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
"to=3Ds" =3D> \@to,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "to-=
cmd=3Ds" =3D> \$to_cmd,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
"no-to" =3D> \$no_to,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
"cc=3Ds" =3D> \@initial_cc,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
"no-cc" =3D> \$no_cc,
> @@ -711,7 +715,7 @@ if (!defined $sender) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$prompting++;
> =C2=A0}
>
> -if (!@to) {
> +if (!@to && $to_cmd eq "") {

Why compare $to_cmd to "" instead of checking definedness?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0my $to =3D ask("Who should the emails be s=
ent to? ");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0push @to, parse_address_line($to) if defin=
ed $to; # sanitized/validated later
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$prompting++;
> @@ -1238,6 +1242,23 @@ foreach my $t (@files) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0close F;
>
> + =C2=A0 =C2=A0 =C2=A0 if (defined $to_cmd) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open(F, "$to_cmd \=
Q$t\E |")

quotemeta() is for escaping regexes, not shell syntax. You probably
want IPC::Open2 or PC::Open3's functions which'll escape arguments for
you.

Also "open my $f" is better, but I see the existing code uses glob
filehandles (urghl).

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 or die "(to-cmd) Could not execute '$to_cmd'";
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while(<F>) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 my $t =3D $_;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $t =3D~ s/^\s*//g;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $t =3D~ s/\n$//g;

Shouldn't this just be:

    while (my $address =3D <$f>) {
        chomp $address;
        ...

I.e. do you need to strip whitespace from the beginning of the string?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 next if ($t eq $sender and $suppress_from);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 push @to, parse_address_line($t)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 if defined $t; # sanitized/validated later
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printf("(to-cmd) Adding To: %s from: '%s'\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $t, $to_cmd) unless $quiet;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close F
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 or die "(to-cmd) failed to close pipe to '$to_cmd'";
> + =C2=A0 =C2=A0 =C2=A0 }

close F could be skipped if we used lexical handes, but see urghl
above.
