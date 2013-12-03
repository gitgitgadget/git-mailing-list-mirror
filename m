From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Tue, 03 Dec 2013 11:53:46 +0100
Message-ID: <1386068026.2208.16.camel@localhost.localdomain>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
	  <CANQwDwfbNfbFqX+hw09bPLVKAN3RZciJmwdixzHrj89KY8FsTQ@mail.gmail.com>
	 <1385985997.2054.27.camel@localhost.localdomain>
	 <529CC48C.5080902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	sunshine@sunshineco.com
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 11:53:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnnc4-0001sq-PP
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 11:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957Ab3LCKxw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 05:53:52 -0500
Received: from mail-bk0-f42.google.com ([209.85.214.42]:48767 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab3LCKxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 05:53:50 -0500
Received: by mail-bk0-f42.google.com with SMTP id w11so6029328bkz.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 02:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=m4geyke+C5LhMrnnImrRpYhNwDRd6TLomycVDs2uYkE=;
        b=dq6F/LRCd005VkwEhdfJh1X2gGMKFePveW6QjYLhz2iBQuc/4YwYbOardb1EXORyL4
         XJHpUd7bqs1uq7F24gvokujNNmjPnB/iuGApb36wG7TpmgpAQALOeqP7rI4Zvec30qsx
         bqGhQxut0c8jDFZCkmWBZ9DCELt7dpdl4QncqSWjugLMJSn3G7F+8DCMu0OWKoVytFWh
         ULIkyIUkr3I3rX8dvpOAhbH01tIxfIBEggwjaM+WrGCjjx18SrYQWFqhIv6fiaDEuLev
         lnuzMTxjjwnklMQQ2gBa8DfyQvo5ZnO3bBYelryMbmMDV7vWOjDX65XC8oszCzTGd4ku
         tP4g==
X-Gm-Message-State: ALoCoQmS/MYNjBbGY9oEY6mAk9XatuGmLEsqM4f4LzUmIPLkWwH0BhGELD5cV9QrRdNhl6cBCNIw
X-Received: by 10.204.234.137 with SMTP id kc9mr15856bkb.181.1386068028998;
        Tue, 03 Dec 2013 02:53:48 -0800 (PST)
Received: from [192.168.178.31] (p5792264C.dip0.t-ipconnect.de. [87.146.38.76])
        by mx.google.com with ESMTPSA id qg7sm78035934bkb.6.2013.12.03.02.53.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 02:53:48 -0800 (PST)
In-Reply-To: <529CC48C.5080902@gmail.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238686>

On Mon, 2013-12-02 at 18:34 +0100, Jakub Nar=C4=99bski wrote:
> W dniu 2013-12-02 13:06, Krzesimir Nowak pisze:
> > On Mon, 2013-12-02 at 01:21 +0100, Jakub Nar=C4=99bski wrote:
> >> On Thu, Nov 28, 2013 at 12:44 PM, Krzesimir Nowak
> >> <krzesimir@endocode.com>  wrote:
> >>
> >>> Allow @additional_branch_refs configuration variable to tell gitw=
eb to
> >>> show refs from additional hierarchies in addition to branches in =
the
> >>> list-of-branches view.
> >>>
> >>> Signed-off-by: Krzesimir Nowak<krzesimir@endocode.com>
> >>
> >> Why not use %feature hash instead of adding new configuration vari=
able?
> >> I think that this option is similar enough to 'remote_heads' featu=
re
> >> (which BTW should be 'remote-heads'), and could conceivably enable=
d
> >> on a per-repository basis, i.e. with repository configuration over=
ride,
> >> isn't it?
> >
> > I'd like to see some consensus on it before I start changing the pa=
tch
> > again.
>=20
> %feature hash is mainly (but not only) about options that can be
> configured on per-repository basis.  Configuration variables are
> about options that are per-instance (per gitweb).

Well, I am mostly interested in per-instance configuration in this case=
,
but if that is also possible with %feature hash, then ok, I'll try to
make it work.

=46rom what I've seen (correct me please if I got it wrong) feature
settings is taken from per-repository config file from [gitweb] section=
=2E
If there's nothing then some default value is taken. That default value
can be overriden with per-instance perl config file.

So it is easy to override it from per-instance perl config by typing:
$feature{'additional-branch-refs'}{'default'} =3D ['wip', 'no|tf"un,ny'=
];
$feature{'additional-branch-refs'}{'override'} =3D 1;

(Note the edge case of refs/no|tf"un,ny, which passes the git
check-ref-format scrutiny.)

But for now, most of features are quite simple - either booleans,
integers or list of simple strings (in snapshot feature). What I need
here is a list of strings, like CSV in following example:
[gitweb]
	additional_branch_refs =3D wip,"no|tf""un,ny"

Is dependency on external module like Text::CSV or Text::CSV_XS ok? If
not, I can hack some CSV reading code.

>=20
> >> Usually %feature hash is preferred over adding new configuration v=
ariable
> >> but this is not some hard rule. Note however that patches adding n=
ew config
> >> are met with more scrutiny, as it is harder to fix mistakes becaus=
e of
> >> requirement of backwards compatibility of configuration files.
> >>
> >
> > I don't know what kind of backwards compatibility you mention. Whet=
her
> > you want gitweb to survive reading old config file or to honor
> > deprecated/old config variables.
>=20
> I meant here honoring deprecated/old variables, i.e. honoring existin=
g
> configuration files.  See for example backward compatibility for old
> $stylesheet variable vs new @stylesheets in print_header_links().
>=20
> Though in this case it shouldn't be much of a problem; it would be
> easy to honor @additional_branch_refs by setting 'default' for
> 'extra-branch-refs' feature to it.

extra-branch-refs is nicer than additional-branch-refs, I'll use it.

>=20
> >> BTW. there really should be gitweb/CodingGuidelines...
> >>
> >
> > Yes, would be useful. As in every other project. :)
>=20
> Well, Git itself *has* Documentation/CodingGuidelines, but perhaps
> gitweb subsystem should have it's own...
>=20
> [...]
> >>> @@ -3662,7 +3701,8 @@ sub git_get_heads_list {
> >>>                  my ($committer, $epoch, $tz) =3D
> >>>                          ($committerinfo =3D~ /^(.*) ([0-9]+) (.*=
)$/);
> >>>                  $ref_item{'fullname'}  =3D $name;
> >>> -               $name =3D~ s!^refs/(?:head|remote)s/!!;
> >>> +               my $strip_refs =3D join '|', map { quotemeta } ge=
t_branch_refs();
> >>> +               $name =3D~ s!^refs/(?:$strip_refs|remotes)/!!;
> >>>
> >>>                  $ref_item{'name'}  =3D $name;
> >>>                  $ref_item{'id'}    =3D $hash;
> >>> @@ -7179,7 +7219,8 @@ sub snapshot_name {
> >>>                  $ver =3D $1;
> >>>          } else {
> >>>                  # branches and other need shortened SHA-1 hash
> >>> -               if ($hash =3D~ m!^refs/(?:heads|remotes)/(.*)$!) =
{
> >>> +               my $strip_refs =3D join '|', map { quotemeta } ge=
t_branch_refs();
> >>> +               if ($hash =3D~ m!^refs/(?:$strip_refs|remotes)/(.=
*)$!) {
> >>>                          $ver =3D $1;
> >>>                  }
> >>>                  $ver .=3D '-' . git_get_short_hash($project, $ha=
sh);
> >>
> >> One one hand, it is about threating extra branch refs the same way=
 as 'head'.
> >> On the other hand we loose distinction between 'refs/heads/foo' an=
d e.g.
> >> 'refs/wip/foo'. But maybe that's all right...
> >>
> >
> > In git_get_heads_list sub I could append a " ($ref_dir)" to refs wh=
ich
> > are in neither 'heads' nor 'remotes', so heads view would look like=
:
> > master
> > old-stable
> > some-work-in-progress (wip)
> > some-other-branch (other)
> >
> > where both master and old-stable are in refs/heads/,
> > some-work-in-progress in refs/wip/ and some-other-branch in refs/ot=
her/.
> >
> > In case of branch snapshot names (snapshot_name sub) I could change=
 it,
> > so names for branches mentioned above would be
> > "Project-master-<short-hash>.tgz",
> > "Project-old_stable-<short-hash>.tgz",
> > "Project-wip-some-work-in-progress-<short-hash>.tgz"
> > "Project-other-some-other-branch-<short-hash>.tgz"
> >
> > What do you think?
>=20
> That is, I think, a very good idea.  Though perhaps it would be more=20
> readable to add this extra feature as a separate patch, on top of mai=
n one.
>=20

Right, I suppose this patch is going to end up being several patches.

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
