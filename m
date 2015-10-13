From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 20/44] refs-be-files.c: add methods for misc ref operations
Date: Tue, 13 Oct 2015 09:44:28 +0200
Message-ID: <561CB65C.4040902@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-22-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 09:51:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZluN7-0001pZ-2e
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 09:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbbJMHvl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2015 03:51:41 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51910 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752157AbbJMHvk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 03:51:40 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2015 03:51:40 EDT
X-AuditID: 12074411-f797e6d000007df3-9b-561cb65ea5ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 5B.A0.32243.E56BC165; Tue, 13 Oct 2015 03:44:30 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D7iSfF017646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 03:44:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-22-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqBu3TSbM4OcGSYsPV54zWszfdILR
	outKN5PFvwk1DiweCzaVelzsfsLsseD5fXaPz5vkAliiuG2SEkvKgjPT8/TtErgz/j45wFgw
	n6Pi/NXT7A2MV9i6GDk5JARMJGY/XswIYYtJXLi3HijOxSEkcJlR4u+6H8wQzlkmiY/rDrCC
	VPEKaEuc7zvGBGKzCKhK3H19hQXEZhPQlVjU0wwWFxUIklix/AUjRL2gxMmZT8BqRAQcJC7v
	OsoMYjML+Ep8f7IJrF4YqP7P3I9gNUICbYwSE6/XgticAl4SP57cZYSo15PYcf0XK4QtL9G8
	dTbzBEaBWUhWzEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsY
	IeEsuINxxkm5Q4wCHIxKPLwvImXChFgTy4orcw8xSnIwKYnynt4AFOJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCm9QClONNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfC+
	2QLUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1fhiYLSCpHiA9kpvBdlbXJCY
	CxSFaD3FqCglzvsKZK4ASCKjNA9uLCxJvWIUB/pSmNcQpJ0HmODgul8BDWYCGmzELgUyuCQR
	ISXVwJgS1/4mrYXzjrDB3uQtTaH2c3e3uJVfLZJk2LDE69bKrXs0Ww7dfaK/THcH26Nb+2zb
	55uUHhF4x37s6UL32Xo2t030stSuT3xzRTX7c/ddbd1nRTISE44WO07zmXA81ySQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279487>

On 10/12/2015 11:51 PM, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
>=20
> Add ref backend methods for:
> resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
> create_symref, resolve_gitlink_ref.
>=20
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  builtin/init-db.c |  1 +
>  cache.h           |  7 +++++++
>  refs-be-files.c   | 36 +++++++++++++++++++++++++++---------
>  refs.c            | 47 +++++++++++++++++++++++++++++++++++++++++++++=
++
>  refs.h            | 18 ++++++++++++++++++
>  5 files changed, 100 insertions(+), 9 deletions(-)

This commit doesn't build:

refs-be-files.c:3636:2: error: initialization from incompatible pointer
type [-Werror]
  files_create_symref,
  ^
refs-be-files.c:3636:2: error: (near initialization for
=91refs_be_files.create_symref=92) [-Werror]

Apparently one of the hunks from the subsequent commit is needed in thi=
s
commit.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
