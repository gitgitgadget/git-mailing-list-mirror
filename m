From: Kristis Makris <kristis.makris-tTJs1oqo2yY@public.gmane.org>
Subject: Re: Git and tagging hook
Date: Tue, 14 Oct 2008 11:03:21 -0700
Message-ID: <1224007401.4073.40.camel@localhost>
References: <1223268332.4072.7.camel@localhost> <48E9BB72.2080008@op5.se>
	<1223399613.20250.1.camel@localhost> <gcg67d$4o2$1@ger.gmane.org>
	<1223484445.4055.8.camel@localhost> <48ECF072.3000506@op5.se>
	<20081014172227.GB6931@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_talos-5956-1224007594-0001-2"
Cc: Andreas Ericsson <ae-n0Zl8IkGad4@public.gmane.org>, scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org,
  git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jakub Narebski <jnareb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jan Hudec <bulb-+ZI9xUNit7I@public.gmane.org>
X-From: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org Tue Oct 14 20:06:30 2008
Return-path: <scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org>
Envelope-to: gcbsu-scmbug-users@m.gmane.org
Received: from 11-74-162-69.static.reverse.lstn.net ([69.162.74.11] helo=mail.loomcm.com)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpoG5-0008An-RN
	for gcbsu-scmbug-users@m.gmane.org; Tue, 14 Oct 2008 20:04:38 +0200
Received: from [69.162.74.11] ([::ffff:127.0.0.1])
  by talos with esmtp; Tue, 14 Oct 2008 11:06:34 -0700
  id 0561029C.48F4DFAA.00001744
Received: from [10.0.0.9] ([::ffff:67.40.69.52])
	by talos with esmtp; Tue, 14 Oct 2008 11:06:32 -0700
	id 05610244.48F4DFA8.00001732
In-Reply-To: <20081014172227.GB6931-hYs7FtC5zV+YSD4dQj0czg@public.gmane.org>
X-Mailer: Evolution 2.6.3 
X-BeenThere: scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: General Scmbug list <scmbug-users.lists.mkgnu.net>
List-Unsubscribe: <http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users>, 
	<mailto:scmbug-users-request-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.mkgnu.net/pipermail/scmbug-users>
List-Post: <mailto:scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org>
List-Help: <mailto:scmbug-users-request-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users>, 
	<mailto:scmbug-users-request-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org?subject=subscribe>
Sender: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
Errors-To: scmbug-users-bounces-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98205>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_talos-5956-1224007594-0001-2
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_talos-5956-1224007594-0001-3"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_talos-5956-1224007594-0001-3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Jan, thanks for trying to clarify this for me.

I am working on adding integration support of Git with bug-trackers,
using Scmbug. There may be an argument here towards/against distributed
bug-trackers when it comes to Git.

Maybe there are things here I don't fully understand yet.

On Tue, 2008-10-14 at 19:22 +0200, Jan Hudec wrote:
> >>> Kristis Makris wrote:
> >>>> I want the integration when I apply the tag to a local repository, N=
OT
> >>>> only when I push/pull.
>=20
> Care to explain why that would ever be useful? It's local, which means th=
at:
>  - the user can take it back without a trace it ever happened (git tag -d=
 or
>    even git update-ref -d) and
>  - noone except the user will see it anyway, so it's not like they should
>    care either.

I have two use cases:

(1) A developer maintains besides his local copy a local bug-tracking
system in which he tracks his changes. We would like to apply various
verification policies when he commits or tags. For example, for tagging
we wants to ensure that he tags giving consistent labels to his
intermediate builds. e.g. as in:

http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-singl=
e/manual.html#VERIFICATION-CHECKS-CONVENTION-BASED-LABELING

Or he may want to have Git force him to also supply a log message along
with a tag, so that he can remember later more accurately why a tag was
created and what it really captures. Even if Git (or other SCM systems)
don't natively support log messages on tags. Scmbug plans to implement
this.

http://bugzilla.mkgnu.net/show_bug.cgi?id=3D219


(2) I would like to apply various verification policies when work from a
local repository is finally merged with the central repository. I assume
there can/will be a central repository, and there is one "software
product" that is being released somewhere among the many copies.

When its time to merge local changes to a central repository, the
verification policies may deem that changes are not acceptable to be
merged with the mainline. e.g. because log messages are too short,
commits during the merge are issued against bugs in "a central"
bugtracker that are either closed, assigned to someone else, or just
plain wrong bug-numbers that belong to other products:

http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-singl=
e/manual.html#VERIFICATION-CHECKS-VALID-LOG-MESSAGE-SIZE
http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-singl=
e/manual.html#VERIFICATION-CHECKS-OPEN-BUG-STATE
http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-singl=
e/manual.html#VERIFICATION-CHECKS-VALID-BUG-OWNER
http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-singl=
e/manual.html#VERIFICATION-CHECKS-VALID-PRODUCT-NAME

(I'm not very clear whether this is how Git works)

Does someone get to write-up a brand new log comment during the merge
and the merge totally disregards older log comments ? My understanding
is that log comments on the local copy are preserved (and will need to
be mapped to bug-numbers in the central bug-tracker.=20

Thus the local verification policies may need to have already been
configured to comply with future verification policies of the central
repository. Else (perhaps considerable) mappings/adjustments will be
needed during the push to the central copy.

> Besides, you don't need git tag to create a tag in git, so the hook would=
n't
> really be guaranteed anyway (I mean, just like the commit hook is not -- =
you
> can still commit by calling write-tree, commit-tree and update-ref and av=
oid
> the hook).

I'm assuming someone who follows the recommended avenue of using Git
wants the advantages of hooks. I certainly can't force people that
bypass hooks to use them.

> For integration with issue tracker, the local tag is neither final, nor
> useful to anybody except the user who did it until it hits the central
> repository. And working on the central repository directly does not seem =
like
> a good idea either.

The local tag is useful to the local user and his local bug-tracker. He
can have tag operations intercepted so that the tag names show up as
versions in his bug-tracker. In this way he can keep track of which bugs
still exist or have recently been introduced/discovered to his local
copy, before he decides to publish his polished, final version:

http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-singl=
e/manual.html#TAGS

And his "local bug-tracker" may be reachable on the web and useful by
others that take a peek at the users progress (even fetching it with
Git).


--=_talos-5956-1224007594-0001-3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI9N7p/KuTDwnYLxERAs91AJwMV5KWilP+fafLJzzyuDQT+PNRQACeOHzR
K8XdvH0SakKgnIe9s6MZzcU=
=Jioc
-----END PGP SIGNATURE-----

--=_talos-5956-1224007594-0001-3--

--=_talos-5956-1224007594-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
scmbug-users mailing list
scmbug-users-G8y9j4K4DsPiwOUmbS1EgQ@public.gmane.org
http://lists.mkgnu.net/cgi-bin/mailman/listinfo/scmbug-users

--=_talos-5956-1224007594-0001-2--
