From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Sat, 16 Jan 2010 09:00:30 +0800
Message-ID: <be6fef0d1001151700se963950i6932d30bae3ca940@mail.gmail.com>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rudolf Polzer <divVerent@alientrap.org>,
	Miles Bader <miles@gnu.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:01:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVx1o-0006Oj-GY
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758416Ab0APBAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 20:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758389Ab0APBAc
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:00:32 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:50681 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758370Ab0APBAb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 20:00:31 -0500
Received: by iwn35 with SMTP id 35so943352iwn.4
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 17:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JyzBBgs27ljFtB2nxZTKcGAyqtVzQaR6ZTMjQZRT2ik=;
        b=HLjtWf8l3yZsepjl02Iyl9eCDin79gcNxS8yMThRvOKTFSX0jTqj2nAFKMw3SkVtzX
         PnIT5flaajDTbRy5AFgB8U+7OKdakddKKYGpJa/W2YnsXl1DCSFes+18/xayrvNi5O5B
         T31Rivb9tcWTVVe0xTeSbQcTQ+18JvP5bdW+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tubF7N0LNelNmQDMDA7hVJ6uZPbDRuFhFMsrw9U9J2oRQQLineT9UefFTuBm0aJ/Mh
         Cz2FRByyavtCcAjv2dPkMtNpE774qO1CIE6mmR6Km1HBYD70tlTczBMNqhj7j09Tw+YR
         nTMDrDXXLDaEWJx7EbE8bcCcaI97zomBSHoSw=
Received: by 10.231.125.19 with SMTP id w19mr966870ibr.8.1263603630079; Fri, 
	15 Jan 2010 17:00:30 -0800 (PST)
In-Reply-To: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137180>

Hi,

I'm adding people from the "git push --track" thread here, since this
feature is related to what they want.

(sorry for any line-wrap mangling in the patch.)

--=20
Cheers,
Ray Chuan

On Sat, Jan 16, 2010 at 6:47 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Frequent complaint is lack of easy way to set up upstream (tracking)
> references for git pull to work as part of push command. So add switc=
h
> --set-upstream (-u) to do just that.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> ---
> Changes from v1:
> - Handle 'git push -u <remote> HEAD' correctly.
> - Add testsuite (thanks Peff), with some additional tests to test del=
ete.
> - Modify documentation for push -u (thanks Matthieu Moy).
>
> =A0Documentation/git-push.txt | =A0 =A09 +++++-
> =A0builtin-push.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0t/t5523-push-upstream.sh =A0 | =A0 64 ++++++++++++++++++++++++++++=
++++++++++++++++
> =A0transport.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 49 ++++++++++++++=
+++++++++++++++++++
> =A0transport.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A05 files changed, 123 insertions(+), 1 deletions(-)
> =A0create mode 100755 t/t5523-push-upstream.sh
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index e3eb1e8..2a5394b 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
> =A0--------
> =A0[verse]
> =A0'git push' [--all | --mirror | --tags] [-n | --dry-run] [--receive=
-pack=3D<git-receive-pack>]
> - =A0 =A0 =A0 =A0 =A0[--repo=3D<repository>] [-f | --force] [-v | --v=
erbose]
> + =A0 =A0 =A0 =A0 =A0[--repo=3D<repository>] [-f | --force] [-v | --v=
erbose] [-u | --set-upstream]
> =A0 =A0 =A0 =A0 =A0 [<repository> <refspec>...]
>
> =A0DESCRIPTION
> @@ -122,6 +122,13 @@ nor in any Push line of the corresponding remote=
s file---see below).
> =A0 =A0 =A0 =A0the name "origin" is used. For this latter case, this =
option
> =A0 =A0 =A0 =A0can be used to override the name "origin". In other wo=
rds,
> =A0 =A0 =A0 =A0the difference between these two commands
> +
> +-u::
> +--set-upstream::
> + =A0 =A0 =A0 For every branch that is up to date or successfully pus=
hed, add
> + =A0 =A0 =A0 upstream (tracking) reference, used by argument-less
> + =A0 =A0 =A0 linkgit:git-pull[1] and other commands. For more inform=
ation,
> + =A0 =A0 =A0 see 'branch.<name>.merge' in linkgit:git-config[1].
> =A0+
> =A0--------------------------
> =A0git push public =A0 =A0 =A0 =A0 #1
> diff --git a/builtin-push.c b/builtin-push.c
> index 28a26e7..75ddaf4 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -218,6 +218,7 @@ int cmd_push(int argc, const char **argv, const c=
har *prefix)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPT_BOOLEAN( 0 , "thin", &thin, "use t=
hin pack"),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPT_STRING( 0 , "receive-pack", &recei=
vepack, "receive-pack", "receive pack program"),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPT_STRING( 0 , "exec", &receivepack, =
"receive-pack", "receive pack program"),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OPT_BIT('u', "set-upstream", &flags, "S=
et upstream for git pull", TRANSPORT_PUSH_SET_UPSTREAM),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPT_END()
> =A0 =A0 =A0 =A0};
>
> diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
> new file mode 100755
> index 0000000..e098d37
> --- /dev/null
> +++ b/t/t5523-push-upstream.sh
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +
> +test_description=3D'push with --set-upstream'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup bare parent' '
> + =A0 =A0 =A0 git init --bare parent &&
> + =A0 =A0 =A0 git remote add upstream parent
> +'
> +
> +test_expect_success 'setup local commit' '
> + =A0 =A0 =A0 echo content >file &&
> + =A0 =A0 =A0 git add file &&
> + =A0 =A0 =A0 git commit -m one
> +'
> +
> +check_config() {
> + =A0 =A0 =A0 (echo $2; echo $3) >expect.$1
> + =A0 =A0 =A0 (git config branch.$1.remote
> + =A0 =A0 =A0 =A0git config branch.$1.merge) >actual.$1
> + =A0 =A0 =A0 test_cmp expect.$1 actual.$1
> +}
> +
> +test_expect_success 'push -u master:master' '
> + =A0 =A0 =A0 git push -u upstream master:master &&
> + =A0 =A0 =A0 check_config master upstream refs/heads/master
> +'
> +
> +test_expect_success 'push -u master:other' '
> + =A0 =A0 =A0 git push -u upstream master:other &&
> + =A0 =A0 =A0 check_config master upstream refs/heads/other
> +'
> +
> +test_expect_success 'push -u master2:master2' '
> + =A0 =A0 =A0 git branch master2 &&
> + =A0 =A0 =A0 git push -u upstream master2:master2 &&
> + =A0 =A0 =A0 check_config master2 upstream refs/heads/master2
> +'
> +
> +test_expect_success 'push -u master2:other2' '
> + =A0 =A0 =A0 git push -u upstream master2:other2 &&
> + =A0 =A0 =A0 check_config master2 upstream refs/heads/other2
> +'
> +
> +test_expect_success 'push -u :master2' '
> + =A0 =A0 =A0 git push -u upstream :master2 &&
> + =A0 =A0 =A0 check_config master2 upstream refs/heads/other2
> +'
> +
> +test_expect_success 'push -u --all' '
> + =A0 =A0 =A0 git branch all1 &&
> + =A0 =A0 =A0 git branch all2 &&
> + =A0 =A0 =A0 git push -u --all &&
> + =A0 =A0 =A0 check_config all1 upstream refs/heads/all1 &&
> + =A0 =A0 =A0 check_config all2 upstream refs/heads/all2
> +'
> +
> +test_expect_success 'push -u HEAD' '
> + =A0 =A0 =A0 git checkout -b headbranch &&
> + =A0 =A0 =A0 git push -u upstream HEAD &&
> + =A0 =A0 =A0 check_config headbranch upstream refs/heads/headbranch
> +'
> +
> +test_done
> diff --git a/transport.c b/transport.c
> index b5332c0..e5b462b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -8,6 +8,7 @@
> =A0#include "bundle.h"
> =A0#include "dir.h"
> =A0#include "refs.h"
> +#include "branch.h"
>
> =A0/* rsync support */
>
> @@ -135,6 +136,47 @@ static void insert_packed_refs(const char *packe=
d_refs, struct ref **list)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static void set_upstreams(struct transport *trans, struct ref *refs)
> +{
> + =A0 =A0 =A0 struct ref *i;
> + =A0 =A0 =A0 for (i =3D refs; i; i =3D i->next) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *localname;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *tmp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *remotename;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char sha[20];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int flag =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check suitability for tracking. Mu=
st be successful /
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* alreay up-to-date ref create/modif=
y (not delete).
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i->status !=3D REF_STATUS_OK &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i->status !=3D REF_STAT=
US_UPTODATE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!i->peer_ref)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!i->new_sha1 || is_null_sha1(i->new=
_sha1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Chase symbolic refs (mainly for HEAD=
). */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 localname =3D i->peer_ref->name;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 remotename =3D i->name;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D resolve_ref(localname, sha, 1, =
&flag);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp && flag & REF_ISSYMREF &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !prefixcmp(tmp, "refs/h=
eads/"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 localname =3D tmp;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Both source and destination must be =
local branches. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!localname || prefixcmp(localname, =
"refs/heads/"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!remotename || prefixcmp(remotename=
, "refs/heads/"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 install_branch_config(BRANCH_CONFIG_VER=
BOSE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 localname + 11, trans->=
remote->name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 remotename);
> + =A0 =A0 =A0 }
> +}
> +
> =A0static const char *rsync_url(const char *url)
> =A0{
> =A0 =A0 =A0 =A0return prefixcmp(url, "rsync://") ? skip_prefix(url, "=
rsync:") : url;
> @@ -974,6 +1016,10 @@ int transport_push(struct transport *transport,
> =A0 =A0 =A0 =A0verify_remote_names(refspec_nr, refspec);
>
> =A0 =A0 =A0 =A0if (transport->push) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Maybe FIXME. But no important transp=
ort uses this case. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags & TRANSPORT_PUSH_SET_UPSTREAM=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("This transport doe=
s not support using --set-upstream");
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return transport->push(transport, refs=
pec_nr, refspec, flags);
> =A0 =A0 =A0 =A0} else if (transport->push_refs) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ref *remote_refs =3D
> @@ -1002,6 +1048,9 @@ int transport_push(struct transport *transport,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0verbose | porcelain, porcelain,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0nonfastforward);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags & TRANSPORT_PUSH_SET_UPSTREAM=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_upstreams(transport=
, remote_refs);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(flags & TRANSPORT_PUSH_DRY_RUN))=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct ref *ref;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (ref =3D remote_re=
fs; ref; ref =3D ref->next)
> diff --git a/transport.h b/transport.h
> index 97ba251..c4314dd 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -91,6 +91,7 @@ struct transport {
> =A0#define TRANSPORT_PUSH_VERBOSE 16
> =A0#define TRANSPORT_PUSH_PORCELAIN 32
> =A0#define TRANSPORT_PUSH_QUIET 64
> +#define TRANSPORT_PUSH_SET_UPSTREAM 128
>
> =A0/* Returns a transport suitable for the url */
> =A0struct transport *transport_get(struct remote *, const char *);
> --
> 1.6.6.102.gd6f8f.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
