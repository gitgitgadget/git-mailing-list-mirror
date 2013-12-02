From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Mon, 02 Dec 2013 13:06:37 +0100
Message-ID: <1385985997.2054.27.camel@localhost.localdomain>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
	 <CANQwDwfbNfbFqX+hw09bPLVKAN3RZciJmwdixzHrj89KY8FsTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	sunshine@sunshineco.com
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 13:06:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnSH1-0007d2-2f
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 13:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab3LBMGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 07:06:43 -0500
Received: from mail-bk0-f48.google.com ([209.85.214.48]:35961 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704Ab3LBMGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 07:06:41 -0500
Received: by mail-bk0-f48.google.com with SMTP id v10so5288832bkz.21
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 04:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=PgHnGP/rdBXgv1k8R7wQ0AJmNmBdtYLgiAGjMTM55xE=;
        b=EqFTEJUl18ZkMHK1o9smaD5pthRf6c/CsrkGIj59I37dCVxA1hLkz2D6txjiFUQgrb
         4fVHzMB0O2CGOqAd0Ukm14A6je/4crrKo7rothFFqklFwO+hQyrS9j4D55okbCAvgc32
         PQCxhZ3b73JFkFH2IKrIC1itlyepQ7nRHWF/kpY++1Df1HfhQ+hpvt8ijlN7rCQqwMCH
         ftVmM2XQjNh4PupZj+ffr3XWkQIEvLhRI5Pt79g2Zao1I8rZzUIVbQxEIrP8+MpT5GIp
         ++D+KmU/0HXtNWPk1TTqTRaXZf5RBESsQ0UtBD4/l38W7Dd4ajpCwzLsHfF/A+BNivRI
         uQkQ==
X-Gm-Message-State: ALoCoQlHawyZtYpHGxYeVZw76BgJKAe0AehH0i1gVT876L7qApwAzd+083xt1oInhp4Wc+lsUqOX
X-Received: by 10.204.77.65 with SMTP id f1mr154209bkk.156.1385986000082;
        Mon, 02 Dec 2013 04:06:40 -0800 (PST)
Received: from [192.168.1.100] (95-91-241-36-dynip.superkabel.de. [95.91.241.36])
        by mx.google.com with ESMTPSA id t2sm74502716bkh.3.2013.12.02.04.06.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 02 Dec 2013 04:06:39 -0800 (PST)
In-Reply-To: <CANQwDwfbNfbFqX+hw09bPLVKAN3RZciJmwdixzHrj89KY8FsTQ@mail.gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238628>

On Mon, 2013-12-02 at 01:21 +0100, Jakub Nar=C4=99bski wrote:
> On Thu, Nov 28, 2013 at 12:44 PM, Krzesimir Nowak
> <krzesimir@endocode.com> wrote:
>=20
> > Allow @additional_branch_refs configuration variable to tell gitweb=
 to
> > show refs from additional hierarchies in addition to branches in th=
e
> > list-of-branches view.
> >
> > Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
>=20
> Why not use %feature hash instead of adding new configuration variabl=
e?
> I think that this option is similar enough to 'remote_heads' feature
> (which BTW should be 'remote-heads'), and could conceveilably enabled
> on a per-repository basis, i.e. with repository configuration overrid=
e,
> isn't it?

I'd like to see some consensus on it before I start changing the patch
again.

>=20
> Usually %feature hash is preferred over adding new configuration vari=
able
> but this is not some hard rule. Note however that patches adding new =
config
> are met with more scrutiny, as it is harder to fix mistakes because o=
f
> requirement of backwards compatibility of configuration files.
>=20

I don't know what kind of backwards compatibility you mention. Whether
you want gitweb to survive reading old config file or to honor
deprecated/old config variables. If the former than I have already read
somewhere that you always should use config vars like:
our $config =3D 'value';
Note the 'our' which avoids gitweb failures in case of config variable
removal.

> BTW. there really should be gitweb/CodingGuidelines...
>=20

Yes, would be useful. As in every other project. :)

> > ---
> >  Documentation/gitweb.conf.txt | 13 ++++++++
> >  gitweb/gitweb.perl            | 75 +++++++++++++++++++++++++++++++=
++----------
> >  2 files changed, 71 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.c=
onf.txt
> > index e2113d9..cd1a945 100644
> > --- a/Documentation/gitweb.conf.txt
> > +++ b/Documentation/gitweb.conf.txt
> > @@ -549,6 +549,19 @@ This variable matters only when using persiste=
nt web environments that
> >  serve multiple requests using single gitweb instance, like mod_per=
l,
> >  FastCGI or Plackup.
> >
> > +@additional_branch_refs::
> > +       List of additional directories under "refs" which are going=
 to be used
> > +       as branch refs. You might want to set this variable if you =
have a gerrit
> > +       setup where all branches under refs/heads/ are official,
> > +       push-after-review ones and branches under refs/sandbox/, re=
fs/wip and
> > +       refs/other are user ones where permissions are much wider, =
for example
> > ++
> > +------------------------------------------------------------------=
--------------
> > +our @additional_branch_refs =3D ('sandbox', 'wip', 'other');
> > +------------------------------------------------------------------=
--------------
>=20
> I think the last (long) sentence would better read if it began with "=
=46or example
> if you have... then you could set this variable to ...", IMVHO.
>=20

Right, thanks. Will rephrase it.

> BTW. if we decide on using %feature hash instead, it would be in the
> "CONFIGURING GITWEB FEATURES" section.

Yes, but I'll wait for some consensus with it.

>=20
> > ++
> > +It is an error to specify a ref that does not pass "git check-ref-=
format"
> > +scrutiny.
>=20
> Hmmm... One one hand erroring out on invalid refs means that we can
> find error in config earlier and easier, on the other hand ignoring i=
nvalid
> refs would make it resilent to errors in gitweb config (and repositor=
y config,
> if we use %feature with per-repository override).
>=20

We could ignore bad values, but that would make it harder to find out
what exactly is wrong when something we configured to be shown is not
shown at all.

>=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> [...]
> > @@ -626,6 +630,10 @@ sub feature_avatar {
> >         return @val ? @val : @_;
> >  }
> >
> > +sub get_branch_refs {
> > +    return ('heads', @additional_branch_refs);
> > +}
>=20
> Nice way of ensuring that list of all branches starts with "heads".
>=20
> >  # checking HEAD file with -e is fragile if the repository was
> >  # initialized long time ago (i.e. symlink HEAD) and was pack-ref'e=
d
> >  # and then pruned.
> > @@ -680,6 +688,19 @@ sub read_config_file {
> >         return;
> >  }
> >
> > +# performs sanity checks on parts of configuration.
> > +sub config_sanity_check {
> > +       # check additional refs validity
> > +       my %unique_branch_refs =3D ();
> > +       for my $ref (@additional_branch_refs) {
> > +               die_error(500, "Invalid ref '$ref' in \@additional_=
branch_refs") unless (validate_ref($ref));
> > +               # 'heads' are added implicitly in get_branch_refs()=
=2E
> > +               $unique_branch_refs{$ref} =3D 1 if ($ref ne 'heads'=
);
> > +       }
> > +       @additional_branch_refs =3D sort keys %unique_branch_refs;
> > +       %unique_branch_refs =3D undef;
> > +}
>=20
> This subroutine is quite similar to filter_snapshot_fmts for 'snapsho=
t'
> feature, perhaps the name should be patterned after it, i.e.
> filter_branch_refs() or something...
>=20
> If there were generic config_sanity_check(), it would call filter_bra=
nch_refs().

I had an additional_branches_refs_check() sub which was called by
config_sanity_check(), but I scrapped it. I wanted config_sanity_check(=
)
to be general configuration checker, but for now it would only call a
single function, so I inlined it. If later more configuration checking
will be added then the current body could be moved to separate sub.

I can move it back to separate sub if you want.

>=20
> > @@ -698,8 +719,11 @@ sub evaluate_gitweb_config {
> >
> >         # Use first config file that exists.  This means use the pe=
r-instance
> >         # GITWEB_CONFIG if exists, otherwise use GITWEB_SYSTEM_CONF=
IG.
> > -       read_config_file($GITWEB_CONFIG) and return;
> > -       read_config_file($GITWEB_CONFIG_SYSTEM);
> > +       if (!read_config_file($GITWEB_CONFIG)) {
> > +               read_config_file($GITWEB_CONFIG_SYSTEM);
> > +       }
> > +
> > +       config_sanity_check();
> >  }
>=20
> I'm not sure if evaluate_gitweb_config is best place for sanity check
> of said gitweb config, and not e.g. in run_request()... though having
> it there has its own advantages.
>=20
> BTW. it can be written as:
>=20
>   -       read_config_file($GITWEB_CONFIG) and return;
>   -       read_config_file($GITWEB_CONFIG_SYSTEM);
>   +      read_config_file($GITWEB_CONFIG) or
>   +      read_config_file($GITWEB_CONFIG_SYSTEM);
>   +
>   +       config_sanity_check();
>=20

Ok, will rewrite it.

>=20
> Anyway if we were to use %feature hash, there is configure_gitweb_fea=
tures()
> for calling filter_branch_refs().
>=20
> >  # Get loadavg of system, to compare against $maxload.
> > @@ -1452,6 +1476,16 @@ sub validate_pathname {
> >         return $input;
> >  }
> >
> > +sub validate_ref {
> > +       my $input =3D shift || return undef;
> > +
> > +       # restrictions on ref name according to git-check-ref-forma=
t
> > +       if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> > +               return undef;
> > +       }
> > +       return $input;
> > +}
> > +
> >  sub validate_refname {
> >         my $input =3D shift || return undef;
>=20
> Hmmm... validate_ref() is IMHO too similar to validate_refname(),
> and it isn't about *parameter* validation. Perhaps check_ref_format()=
?

Ok.

>=20
> > @@ -1462,10 +1496,9 @@ sub validate_refname {
> >         # it must be correct pathname
> >         $input =3D validate_pathname($input)
> >                 or return undef;
> > -       # restrictions on ref name according to git-check-ref-forma=
t
> > -       if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> > -               return undef;
> > -       }
> > +       # check git-check-ref-format restrictions
> > +       $input =3D validate_ref($input)
> > +               or return undef;
> >         return $input;
> >  }
>=20
> Nice refactoring (it *could*, but doesn't need to, be in separate pat=
ch).
>=20
> > @@ -2515,6 +2548,7 @@ sub format_snapshot_links {
> >  sub get_feed_info {
> >         my $format =3D shift || 'Atom';
> >         my %res =3D (action =3D> lc($format));
> > +       my $matched_ref =3D 0;
> >
> >         # feed links are possible only for project views
> >         return unless (defined $project);
> > @@ -2522,12 +2556,17 @@ sub get_feed_info {
> >         # or don't have specific feed yet (so they should use gener=
ic)
> >         return if (!$action || $action =3D~ /^(?:tags|heads|forks|t=
ag|search)$/x);
> >
> > -       my $branch;
> > -       # branches refs uses 'refs/heads/' prefix (fullname) to dif=
ferentiate
> > -       # from tag links; this also makes possible to detect branch=
 links
> > -       if ((defined $hash_base && $hash_base =3D~ m!^refs/heads/(.=
*)$!) ||
> > -           (defined $hash      && $hash      =3D~ m!^refs/heads/(.=
*)$!)) {
> > -               $branch =3D $1;
> > +       my $branch =3D undef;
> > +       # branches refs uses 'refs/' + $get_branch_refs()[x] + '/' =
prefix
> > +       # (fullname) to differentiate from tag links; this also mak=
es
> > +       # possible to detect branch links
> > +       for my $ref (get_branch_refs()) {
> > +               if ((defined $hash_base && $hash_base =3D~ m!^refs/=
\Q$ref\E/(.*)$!) ||
> > +                   (defined $hash      && $hash      =3D~ m!^refs/=
\Q$ref\E/(.*)$!)) {
> > +                       $branch =3D $1;
> > +                       $matched_ref =3D $ref;
> > +                       last;
> > +               }
> >         }
>=20
> Nice!
>=20
> > @@ -3662,7 +3701,8 @@ sub git_get_heads_list {
> >                 my ($committer, $epoch, $tz) =3D
> >                         ($committerinfo =3D~ /^(.*) ([0-9]+) (.*)$/=
);
> >                 $ref_item{'fullname'}  =3D $name;
> > -               $name =3D~ s!^refs/(?:head|remote)s/!!;
> > +               my $strip_refs =3D join '|', map { quotemeta } get_=
branch_refs();
> > +               $name =3D~ s!^refs/(?:$strip_refs|remotes)/!!;
> >
> >                 $ref_item{'name'}  =3D $name;
> >                 $ref_item{'id'}    =3D $hash;
> > @@ -7179,7 +7219,8 @@ sub snapshot_name {
> >                 $ver =3D $1;
> >         } else {
> >                 # branches and other need shortened SHA-1 hash
> > -               if ($hash =3D~ m!^refs/(?:heads|remotes)/(.*)$!) {
> > +               my $strip_refs =3D join '|', map { quotemeta } get_=
branch_refs();
> > +               if ($hash =3D~ m!^refs/(?:$strip_refs|remotes)/(.*)=
$!) {
> >                         $ver =3D $1;
> >                 }
> >                 $ver .=3D '-' . git_get_short_hash($project, $hash)=
;
>=20
> One one hand, it is about threating extra branch refs the same way as=
 'head'.
> On the other hand we loose distinction between 'refs/heads/foo' and e=
=2Eg.
> 'refs/wip/foo'. But maybe that's all right...
>=20

In git_get_heads_list sub I could append a " ($ref_dir)" to refs which
are in neither 'heads' nor 'remotes', so heads view would look like:
master
old-stable
some-work-in-progress (wip)
some-other-branch (other)=20

where both master and old-stable are in refs/heads/,
some-work-in-progress in refs/wip/ and some-other-branch in refs/other/=
=2E

In case of branch snapshot names (snapshot_name sub) I could change it,
so names for branches mentioned above would be
"Project-master-<short-hash>.tgz",
"Project-old_stable-<short-hash>.tgz",
"Project-wip-some-work-in-progress-<short-hash>.tgz"
"Project-other-some-other-branch-<short-hash>.tgz"

What do you think?

Cheers,
--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
