From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/18] Change style of some regular expressions to make
 them clearer
Date: Thu, 6 Jun 2013 21:54:18 -0400
Message-ID: <CAPig+cQvWJ8RRsqKEMooV_AntTBZ1Pi=WA_1LFU955J+9jDzTg@mail.gmail.com>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-3-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 03:54:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uklsn-0007Kq-1F
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 03:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab3FGByV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 21:54:21 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:61134 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab3FGByU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 21:54:20 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so1321770lab.25
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 18:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QLN2BDb2wlLaZPGZsMPk5ZiEmcJV4F63oCN3xiMJung=;
        b=XiwXpy226hXbJ25GiDeXxzQij1V+bpOIuD0/f8IyKN+VrJ56XYWym8HW+v0lmuSWCP
         s+KIXrPLEGOb1k5SQJel6/eXKEL1cnLz91UR6v6ZdKXc5nIvlZvnGpE/dbUtnGXtyfav
         fir/sxu2dtmbH9KvzjLQrvh4xGdt1jGxcUDjbug3Pzl81qGykp0cjA21EI9mVibyTwrk
         w6oIi+KDOWYbMmAuoc/rOlC85GZ5hlX8tbv35VuaAnd7CqQ/TZKg4hdSKXDIgTPD8bl+
         4onrwDWaym04oCRBGV3ejLQwTQkWSE36au5ZAxbaEdpRdswbhT1mRdQebXtVEik3LGhe
         HgAg==
X-Received: by 10.152.1.230 with SMTP id 6mr18996443lap.21.1370570058397; Thu,
 06 Jun 2013 18:54:18 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 18:54:18 -0700 (PDT)
In-Reply-To: <1370547263-13558-3-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: 0AWTIRvdYzFS6A0UX58_hFEFqoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226579>

On Thu, Jun 6, 2013 at 3:34 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> - Remove m modifier when useless (m// and // was used randomly; this =
makes the
> code more coherent)
> - Remove stringy split (split('c', ...) instead of split(/c/, ...))
> - Use {}{} instead of /// when slashes or used inside the regexp so a=
s not to
> escape it.
>
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 83cf292..482cd95 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -121,7 +121,7 @@ chomp($dumb_push);
>  $dumb_push =3D ($dumb_push eq "true");
>
>  my $wiki_name =3D $url;
> -$wiki_name =3D~ s/[^\/]*:\/\///;
> +$wiki_name =3D~ s{[^/]*://}{};
>  # If URL is like http://user:password@example.com/, we clearly don't
>  # want the password in $wiki_name. While we're there, also remove us=
er
>  # and '@' sign, to avoid author like MWUser@HTTPUser@host.com
> @@ -762,7 +762,7 @@ sub get_more_refs {
>         my @refs;
>         while (1) {
>                 my $line =3D <STDIN>;
> -               if ($line =3D~ m/^$cmd (.*)$/) {
> +               if ($line =3D~ /^$cmd (.*)$/) {
>                         push(@refs, $1);
>                 } elsif ($line eq "\n") {
>                         return @refs;
> @@ -1168,11 +1168,11 @@ sub mw_push_revision {
>                 my @local_ancestry =3D split(/\n/, run_git("rev-list =
--boundary --parents $local ^$parsed_sha1"));
>                 my %local_ancestry;
>                 foreach my $line (@local_ancestry) {
> -                       if (my ($child, $parents) =3D $line =3D~ m/^-=
?([a-f0-9]+) ([a-f0-9 ]+)/) {
> -                               foreach my $parent (split(' ', $paren=
ts)) {
> +                       if (my ($child, $parents) =3D $line =3D~ /^-?=
([a-f0-9]+) ([a-f0-9 ]+)/) {
> +                               foreach my $parent (split(/ /, $paren=
ts)) {

This is a behavior-altering change. split(' ',...) is handled as a
special case[*1*] which strips leading whitespace and then splits on
/\s+/ (run of whitespace). Changing it to split(/ /,...) makes it
match only a single space (rather than a run of whitespace).

[*1*] http://perldoc.perl.org/functions/split.html

>                                         $local_ancestry{$parent} =3D =
$child;
>                                 }
> -                       } elsif (!$line =3D~ m/^([a-f0-9]+)/) {
> +                       } elsif (!$line =3D~ /^([a-f0-9]+)/) {
>                                 die "Unexpected output from git rev-l=
ist: $line";
>                         }
>                 }
> @@ -1190,10 +1190,10 @@ sub mw_push_revision {
>                 # history (linearized with --first-parent)
>                 print STDERR "Warning: no common ancestor, pushing co=
mplete history\n";
>                 my $history =3D run_git("rev-list --first-parent --ch=
ildren $local");
> -               my @history =3D split('\n', $history);
> +               my @history =3D split(/\n/, $history);
>                 @history =3D @history[1..$#history];
>                 foreach my $line (reverse @history) {
> -                       my @commit_info_split =3D split(/ |\n/, $line=
);
> +                       my @commit_info_split =3D split(/[ \n]/, $lin=
e);
>                         push(@commit_pairs, \@commit_info_split);
>                 }
>         }
> @@ -1272,7 +1272,7 @@ sub get_mw_namespace_id {
>                 # Look at configuration file, if the record for that =
namespace is
>                 # already cached. Namespaces are stored in form:
>                 # "Name_of_namespace:Id_namespace", ex.: "File:6".
> -               my @temp =3D split(/[\n]/, run_git("config --get-all =
remote."
> +               my @temp =3D split(/\n/, run_git("config --get-all re=
mote."
>                                                 . $remotename .".name=
spaceCache"));
>                 chomp(@temp);
>                 foreach my $ns (@temp) {
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
