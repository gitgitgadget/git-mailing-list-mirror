From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH v2] git submodule foreach: Skip eval for more than one
 argument
Date: Fri, 27 Sep 2013 06:23:55 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1309270606290.20647@dr-wily.mit.edu>
References: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu> <CALKQrgfhUEE+E5KsAWbP_zj6tozk+V=qvNU1PX9Z73Vu8unTiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Sep 27 12:29:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPVIk-0006nh-3j
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 12:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab3I0K30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Sep 2013 06:29:26 -0400
Received: from dmz-mailsec-scanner-3.mit.edu ([18.9.25.14]:47256 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751170Ab3I0K3C convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 06:29:02 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2013 06:29:02 EDT
X-AuditID: 1209190e-b7f988e0000009a7-6d-52455cc0d025
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.FD.02471.0CC55425; Fri, 27 Sep 2013 06:24:00 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id r8RANwoL006916;
	Fri, 27 Sep 2013 06:23:58 -0400
Received: from localhost (dr-wily.mit.edu [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r8RANtQx010557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 27 Sep 2013 06:23:57 -0400
In-Reply-To: <CALKQrgfhUEE+E5KsAWbP_zj6tozk+V=qvNU1PX9Z73Vu8unTiQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IR4hRV1j0Q4xpk8OG4rEXXlW4mi4beK8wW
	8+7uYnJg9rj08jubx8VLyh6fN8kFMEdx2aSk5mSWpRbp2yVwZfw/foO94JVUxc3nkxkbGFvE
	uhg5OSQETCR+nlzFCGGLSVy4t54NxBYS2McoMXNrRRcjF5C9kVFiYdcGJghnG5PEhdfnwTpY
	BLQlHk1qButgE1CTmLthMjuILSKgKrHj8S+wOLOAn8SLoyuZQGxhgUCJ5gsQ9ZxAdu++C2Bz
	eAUcJX7tf8cOsbmNUeLGd7AaUQFdib2HzrBD1AhKnJz5hAViprrEgU8XGSFsbYn7N9vYJjAK
	zkJSNgtJ2SwkZQsYmVcxyqbkVunmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmIEB7Qk3w7G
	rweVDjEKcDAq8fAKZLgECbEmlhVX5h5ilORgUhLl3RDpGiTEl5SfUpmRWJwRX1Sak1p8iFGC
	g1lJhHeBJ1CONyWxsiq1KB8mJc3BoiTOe5PDPkhIID2xJDU7NbUgtQgmK8PBoSTBKwqMXCHB
	otT01Iq0zJwShDQTByfIcB6g4QejQIYXFyTmFmemQ+RPMSpKifNKgDQLgCQySvPgemEJ5xWj
	ONArwryMIFU8wGQF1/0KaDAT0GCHDieQwSWJCCmpBsbZaVvmsBnkdSfq8HklZ3w4N7UtzJPX
	I6dh7bEUkxent5+pMizqaArT4TnZemX/Rd8tX1OWWztbrZjbaiEveVuT/ekr393HWBebnPxj
	IeMhn791TyGb26RayVAl7QN7i949nrm5lFlUz9973bcM7jyX3+/XRc/cdYIn0vjD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235452>

=E2=80=98eval "$@"=E2=80=99 created an extra layer of shell interpretat=
ion, which was
probably not expected by a user who passed multiple arguments to git
submodule foreach:

$ git grep "'"
[searches for single quotes]
$ git submodule foreach git grep "'"
Entering '[submodule]'
/usr/lib/git-core/git-submodule: 1: eval: Syntax error: Unterminated qu=
oted string
Stopping at '[submodule]'; script returned non-zero status.

To fix this, if the user passed more than one argument, just execute
"$@" directly instead of passing it to eval.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---

On Fri, 27 Sep 2013, Johan Herland wrote:
> 1. Please add the use case you mention above as a new test case, so
> that we can easily catch future regressions.

Test added.

> 2. If we are unlucky there might be existing users that work around t=
he=20
> existing behavior by adding an extra level of quoting (i.e. doing the=
=20
> equivalent of git submodule foreach git grep "\'" in your example=20
> above). Will their workaround break as a result of your change? Is th=
at=20
> acceptable?

Anyone adding an extra level of quoting ought to realize that they shou=
ld=20
be passing a single argument to submodule foreach, so that the reason f=
or=20
the extra quoting is clear:
  git submodule foreach "git grep \'"
will not break.  If someone is actually doing
  git submodule foreach git grep "\'"
then this will change in behavior.  I think this change is important.

(One could even imagine someone feeding untrusted input to
  git submodule foreach git grep "$variable"
which, without my patch, results in a nonobvious shell code injection=20
vulnerability.)

I considered an alternative fix where the first argument is always=20
shell-evaulated and any others are not (i.e. cmd=3D$1 && shift && eval=20
"$cmd \"\$@\""), which is potentially more useful in case the command=20
needs to use $path.  But that may be too confusing, and this way has so=
me=20
precedent (e.g. perl=E2=80=99s system()).

Anders


 git-submodule.sh             | 7 ++++++-
 t/t7407-submodule-foreach.sh | 9 +++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c17bef1..3381864 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -545,7 +545,12 @@ cmd_foreach()
 				sm_path=3D$(relative_path "$sm_path") &&
 				# we make $path available to scripts ...
 				path=3D$sm_path &&
-				eval "$@" &&
+				if [ $# -eq 1 ]
+				then
+					eval "$1"
+				else
+					"$@"
+				fi &&
 				if test -n "$recursive"
 				then
 					cmd_foreach "--recursive" "$@"
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.s=
h
index be93f10..6b2fd39 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -329,4 +329,13 @@ test_expect_success 'command passed to foreach --r=
ecursive retains notion of std
 	test_cmp expected actual
 '
=20
+test_expect_success 'multi-argument command passed to foreach is not s=
hell-evaluated twice' '
+	(
+		cd super &&
+		git submodule foreach "echo \\\"quoted\\\"" > ../expected &&
+		git submodule foreach echo \"quoted\" > ../actual
+	) &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.8.4
