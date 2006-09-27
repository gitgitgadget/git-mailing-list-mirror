From: Josh Triplett <josh@freedesktop.org>
Subject: [RFC] git-split: Split the history of a git repository by subdirectories
 and ranges
Date: Wed, 27 Sep 2006 01:05:56 -0700
Message-ID: <451A30E4.50801@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6258718625FC0ADD4372EF3B"
Cc: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Wed Sep 27 10:06:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSUQq-00088E-9f
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 10:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWI0IGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 04:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWI0IGD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 04:06:03 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:11745 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932169AbWI0IF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 04:05:59 -0400
Received: (qmail 530 invoked from network); 27 Sep 2006 08:05:59 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.121]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 27 Sep 2006 08:05:58 -0000
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27888>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6258718625FC0ADD4372EF3B
Content-Type: multipart/mixed;
 boundary="------------090801000305050606080408"

This is a multi-part message in MIME format.
--------------090801000305050606080408
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I co-maintain the X C Binding (XCB) project with Jamey Sharp.
Previously, several XCB-related projects all existed under the umbrella
of a single monolithic GIT repository with per-project subdirectories.
We have split this repository into individual per-project repositories.

Jamey Sharp and I wrote a script called git-split to accomplish this
repository split. git-split reconstructs the history of a sub-project
previously stored in a subdirectory of a larger repository. It
constructs new commit objects based on the existing tree objects for the
subtree in each commit, and discards commits which do not affect the
history of the sub-project, as well as merges made unnecessary due to
these discarded commits.  When git-split finishes, it will output the
sha1 for the new head commit, suitable for redirection into a file in
=2Egit/refs/heads.  At that point, you can clone the new head, or copy th=
e
repository and prune out undesired heads, tags, and objects.

I have attached git-split for review.  If the GIT community has any
interest in seeing git-split become a part of GIT, we can write up the
necessary documentation and patch.

We would like to acknowledge the work of the gobby team in creating a
collaborative editor which greatly aided the development of git-split.

- Josh Triplett

--------------090801000305050606080408
Content-Type: text/plain;
 name="git-split"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-split"

IyEvdXNyL2Jpbi9weXRob24KIyBnaXQtc3BsaXQ6IFNwbGl0IHRoZSBoaXN0b3J5IG9mIGEg
Z2l0IHJlcG9zaXRvcnkgYnkgc3ViZGlyZWN0b3JpZXMgYW5kIHJhbmdlcwojIENvcHlyaWdo
dCAoQykgMjAwNiBKYW1leSBTaGFycCwgSm9zaCBUcmlwbGV0dAojCiMgWW91IGNhbiByZWRp
c3RyaWJ1dGUgdGhpcyBzb2Z0d2FyZSBhbmQvb3IgbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJt
cyBvZgojIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkg
dGhlIEZyZWUgU29mdHdhcmUKIyBGb3VuZGF0aW9uOyB2ZXJzaW9uIDIgZGF0ZWQgSnVuZSwg
MTk5MS4KIwojIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0
IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQKIyBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91
dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCiMgTUVSQ0hBTlRBQklMSVRZIG9yIEZJ
VE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZSBHTlUKIyBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCgpmcm9tIGl0ZXJ0b29scyBpbXBv
cnQgaXppcApmcm9tIHN1YnByb2Nlc3MgaW1wb3J0IFBvcGVuLCBQSVBFCmltcG9ydCBvcywg
c3lzCgpkZWYgcnVuKGNtZCwgc3RkaW49Tm9uZSwgZW52PXt9KToKICAgIG5ld2VudiA9IG9z
LmVudmlyb24uY29weSgpCiAgICBuZXdlbnYudXBkYXRlKGVudikKICAgIHJldHVybiBQb3Bl
bihjbWQsIHN0ZGluPVBJUEUsIHN0ZG91dD1QSVBFLCBlbnY9bmV3ZW52KS5jb21tdW5pY2F0
ZShzdGRpbilbMF0KCmRlZiBwYXJzZV9hdXRob3JfZGF0ZShzKToKICAgICIiIkdpdmVuIGEg
R0lUIGF1dGhvciBvciBjb21taXR0ZXIgc3RyaW5nLCByZXR1cm4gKG5hbWUsIGVtYWlsLCBk
YXRlKSIiIgogICAgKG5hbWUsIGVtYWlsLCB0aW1lLCB0aW1lem9uZSkgPSBzLnJzcGxpdChO
b25lLCAzKQogICAgcmV0dXJuIChuYW1lLCBlbWFpbFsxOi0xXSwgdGltZSArICIgIiArIHRp
bWV6b25lKQoKZGVmIGdldF9zdWJ0cmVlKHRyZWUsIG5hbWUpOgogICAgb3V0cHV0ID0gcnVu
KFsiZ2l0LWxzLXRyZWUiLCB0cmVlLCBuYW1lXSkKICAgIGlmIG5vdCBvdXRwdXQ6CiAgICAg
ICAgcmV0dXJuIE5vbmUKICAgIHJldHVybiBvdXRwdXQuc3BsaXQoKVsyXQoKZGVmIGlzX2Fu
Y2VzdG9yKG5ld19jb21taXRzLCBjdXIsIG90aGVyKToKICAgICIiIlJldHVybiBUcnVlIGlm
IGN1ciBoYXMgb3RoZXIgYXMgYW4gYW5jZXN0b3IsIG9yIEZhbHNlIG90aGVyd2lzZS4iIiIK
ICAgIHJldHVybiBydW4oWyJnaXQtbWVyZ2UtYmFzZSIsIGN1ciwgb3RoZXJdKS5zdHJpcCgp
ID09IG90aGVyCgpkZWYgd2Fsayhjb21taXRzLCBuZXdfY29tbWl0cywgY29tbWl0X2hhc2gs
IHByb2plY3QpOgogICAgY29tbWl0ID0gY29tbWl0c1tjb21taXRfaGFzaF0KICAgIGlmIG5v
dChjb21taXQuaGFzX2tleSgibmV3X2hhc2giKSk6CiAgICAgICAgdHJlZSA9IGdldF9zdWJ0
cmVlKGNvbW1pdFsidHJlZSJdLCBwcm9qZWN0KQogICAgICAgIGNvbW1pdFsibmV3X3RyZWUi
XSA9IHRyZWUKICAgICAgICBpZiBub3QgdHJlZToKICAgICAgICAgICAgcmFpc2UgRXhjZXB0
aW9uKCJEaWQgbm90IGZpbmQgcHJvamVjdCBpbiB0cmVlIGZvciBjb21taXQgIiArIGNvbW1p
dF9oYXNoKQogICAgICAgIG5ld19wYXJlbnRzID0gbGlzdChzZXQoW3dhbGsoY29tbWl0cywg
bmV3X2NvbW1pdHMsIHBhcmVudCwgcHJvamVjdCkKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBmb3IgcGFyZW50IGluIGNvbW1pdFsicGFyZW50cyJdXSkpCgogICAgICAgIG5l
d19oYXNoID0gTm9uZQogICAgICAgIGlmIGxlbihuZXdfcGFyZW50cykgPT0gMToKICAgICAg
ICAgICAgbmV3X2hhc2ggPSBuZXdfcGFyZW50c1swXQogICAgICAgIGVsaWYgbGVuKG5ld19w
YXJlbnRzKSA9PSAyOiAjIENoZWNrIGZvciB1bm5lY2Vzc2FyeSBtZXJnZQogICAgICAgICAg
ICBpZiBpc19hbmNlc3RvcihuZXdfY29tbWl0cywgbmV3X3BhcmVudHNbMF0sIG5ld19wYXJl
bnRzWzFdKToKICAgICAgICAgICAgICAgIG5ld19oYXNoID0gbmV3X3BhcmVudHNbMF0KICAg
ICAgICAgICAgZWxpZiBpc19hbmNlc3RvcihuZXdfY29tbWl0cywgbmV3X3BhcmVudHNbMV0s
IG5ld19wYXJlbnRzWzBdKToKICAgICAgICAgICAgICAgIG5ld19oYXNoID0gbmV3X3BhcmVu
dHNbMV0KICAgICAgICBpZiBuZXdfaGFzaCBhbmQgbmV3X2NvbW1pdHNbbmV3X2hhc2hdWyJu
ZXdfdHJlZSJdICE9IHRyZWU6CiAgICAgICAgICAgIG5ld19oYXNoID0gTm9uZQoKICAgICAg
ICBpZiBub3QgbmV3X2hhc2g6CiAgICAgICAgICAgIGFyZ3MgPSBbImdpdC1jb21taXQtdHJl
ZSIsIHRyZWVdCiAgICAgICAgICAgIGZvciBuZXdfcGFyZW50IGluIG5ld19wYXJlbnRzOgog
ICAgICAgICAgICAgICAgYXJncy5leHRlbmQoWyItcCIsIG5ld19wYXJlbnRdKQogICAgICAg
ICAgICBlbnYgPSBkaWN0KHppcChbIkdJVF9BVVRIT1JfIituIGZvciBuIGluIFsiTkFNRSIs
ICJFTUFJTCIsICJEQVRFIl1dLAogICAgICAgICAgICAgICAgICAgICAgICAgICBwYXJzZV9h
dXRob3JfZGF0ZShjb21taXRbImF1dGhvciJdKSkKICAgICAgICAgICAgICAgICAgICAgICAr
emlwKFsiR0lUX0NPTU1JVFRFUl8iK24gZm9yIG4gaW4gWyJOQU1FIiwgIkVNQUlMIiwgIkRB
VEUiXV0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXJzZV9hdXRob3JfZGF0ZShj
b21taXRbImNvbW1pdHRlciJdKSkpCiAgICAgICAgICAgIG5ld19oYXNoID0gcnVuKGFyZ3Ms
IGNvbW1pdFsibWVzc2FnZSJdLCBlbnYpLnN0cmlwKCkKCiAgICAgICAgY29tbWl0WyJuZXdf
cGFyZW50cyJdID0gbmV3X3BhcmVudHMKICAgICAgICBjb21taXRbIm5ld19oYXNoIl0gPSBu
ZXdfaGFzaAogICAgICAgIGlmIG5ld19oYXNoIG5vdCBpbiBuZXdfY29tbWl0czoKICAgICAg
ICAgICAgbmV3X2NvbW1pdHNbbmV3X2hhc2hdID0gY29tbWl0CiAgICByZXR1cm4gY29tbWl0
WyJuZXdfaGFzaCJdCgpkZWYgbWFpbihhcmdzKToKICAgIGlmIG5vdCgxIDw9IGxlbihhcmdz
KSA8PSAzKToKICAgICAgICBwcmludCAiVXNhZ2U6IGdpdC1zcGxpdCBzdWJkaXIgW25ld2Vz
dCBbb2xkZXN0XV0iCiAgICAgICAgcmV0dXJuIDEKCiAgICBwcm9qZWN0ID0gYXJnc1swXQog
ICAgaWYgbGVuKGFyZ3MpID4gMToKICAgICAgICBuZXdlc3QgPSBhcmdzWzFdCiAgICBlbHNl
OgogICAgICAgIG5ld2VzdCA9ICJIRUFEIgogICAgbmV3ZXN0X2hhc2ggPSBydW4oWyJnaXQt
cmV2LXBhcnNlIiwgbmV3ZXN0XSkuc3RyaXAoKQogICAgaWYgbGVuKGFyZ3MpID4gMjoKICAg
ICAgICBvbGRlc3QgPSBhcmdzWzJdCiAgICAgICAgb2xkZXN0X2hhc2ggPSBydW4oWyJnaXQt
cmV2LXBhcnNlIiwgb2xkZXN0XSkuc3RyaXAoKQogICAgZWxzZToKICAgICAgICBvbGRlc3Rf
aGFzaCA9IE5vbmUKCiAgICBncmFmdHMgPSB7fQogICAgdHJ5OgogICAgICAgIGZvciBsaW5l
IGluIGZpbGUoIi5naXQvaW5mby9ncmFmdHMiKS5yZWFkKCkuc3BsaXQoIlxuIik6CiAgICAg
ICAgICAgIGlmIGxpbmU6CiAgICAgICAgICAgICAgICBjaGlsZCwgcGFyZW50cyA9IGxpbmUu
c3BsaXQoTm9uZSwgMSkKICAgICAgICAgICAgICAgIHBhcmVudHMgPSBwYXJlbnRzLnNwbGl0
KCkKICAgICAgICAgICAgICAgIGdyYWZ0c1tjaGlsZF0gPSBwYXJlbnRzCiAgICBleGNlcHQg
SU9FcnJvcjoKICAgICAgICBwYXNzCgogICAgdGVtcCA9IHJ1bihbImdpdC1sb2ciLCAiLS1w
cmV0dHk9cmF3IiwgbmV3ZXN0X2hhc2hdKS5zcGxpdCgiXG5cbiIpCiAgICBjb21taXRzID0g
e30KICAgIGZvciBoZWFkZXJzLG1lc3NhZ2UgaW4gaXppcCh0ZW1wWzA6OjJdLCB0ZW1wWzE6
OjJdKToKICAgICAgICBjb21taXQgPSB7fQogICAgICAgIGNvbW1pdF9oYXNoID0gTm9uZQog
ICAgICAgIGhlYWRlcnMgPSBbaGVhZGVyLnNwbGl0KE5vbmUsIDEpIGZvciBoZWFkZXIgaW4g
aGVhZGVycy5zcGxpdCgiXG4iKV0KICAgICAgICBmb3Iga2V5LHZhbHVlIGluIGhlYWRlcnM6
CiAgICAgICAgICAgIGlmIGtleSA9PSAicGFyZW50IjoKICAgICAgICAgICAgICAgIGNvbW1p
dC5zZXRkZWZhdWx0KCJwYXJlbnRzIiwgW10pLmFwcGVuZCh2YWx1ZSkKICAgICAgICAgICAg
ZWxpZiBrZXkgPT0gImNvbW1pdCI6CiAgICAgICAgICAgICAgICBjb21taXRfaGFzaCA9IHZh
bHVlCiAgICAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICAgICBpZiBrZXkgaW4gY29tbWl0
OgogICAgICAgICAgICAgICAgICAgIHJhaXNlIEV4Y2VwdGlvbignRHVwbGljYXRlIGtleSAi
JXMiJyAlIGtleSkKICAgICAgICAgICAgICAgIGNvbW1pdFtrZXldID0gdmFsdWUKICAgICAg
ICBjb21taXRbIm1lc3NhZ2UiXSA9ICIiLmpvaW4oW2xpbmVbNDpdKyJcbiIKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb3IgbGluZSBpbiBtZXNzYWdlLnNwbGl0
KCJcbiIpXSkKICAgICAgICBpZiBjb21taXRfaGFzaCBpcyBOb25lOgogICAgICAgICAgICBy
YWlzZSBFeGNlcHRpb24oIkNvbW1pdCB3aXRob3V0IGhhc2giKQogICAgICAgIGlmIGNvbW1p
dF9oYXNoIGluIGdyYWZ0czoKICAgICAgICAgICAgY29tbWl0WyJwYXJlbnRzIl0gPSBncmFm
dHNbY29tbWl0X2hhc2hdCiAgICAgICAgaWYgY29tbWl0X2hhc2ggPT0gb2xkZXN0X2hhc2gg
b3IgInBhcmVudHMiIG5vdCBpbiBjb21taXQ6CiAgICAgICAgICAgIGNvbW1pdFsicGFyZW50
cyJdID0gW10KICAgICAgICBjb21taXRzW2NvbW1pdF9oYXNoXSA9IGNvbW1pdAoKICAgIHBy
aW50IHdhbGsoY29tbWl0cywgZGljdCgpLCBuZXdlc3RfaGFzaCwgcHJvamVjdCkKCnRyeToK
ICAgIGltcG9ydCBwc3ljbwogICAgcHN5Y28uZnVsbCgpCmV4Y2VwdCBJbXBvcnRFcnJvcjoK
ICAgIHBhc3MKCmlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6IHN5cy5leGl0KG1haW4oc3lz
LmFyZ3ZbMTpdKSkK
--------------090801000305050606080408--

--------------enig6258718625FC0ADD4372EF3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFGjDkGJuZRtD+evsRAiOMAJ9mNRN0dYuymxq4ZNQudHBUl3gxowCdFkL9
wfG3AjnFQG0NopaUFO8+GCw=
=qWY+
-----END PGP SIGNATURE-----

--------------enig6258718625FC0ADD4372EF3B--
