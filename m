From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git push: remove incomplete options list from help text
Date: Mon, 19 Oct 2009 11:54:12 +0900
Message-ID: <20091019115412.6117@nanako3.lavabit.com>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
	<4ADB4AE8.5070007@hartwork.org>
	<20091018235240.GU6115@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 04:54:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MziOP-0003Uj-Pv
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 04:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbZJSCyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 22:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbZJSCyb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 22:54:31 -0400
Received: from karen.lavabit.com ([72.249.41.33]:56445 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbZJSCyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 22:54:31 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 8678F11B909;
	Sun, 18 Oct 2009 21:54:35 -0500 (CDT)
Received: from 3916.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 23M7PAFQ1FA8; Sun, 18 Oct 2009 21:54:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=6ZeXr7T73FNyWap9akOnjgcPvybPIkbCXrnfXcoer0feeUe9uJP62LPKTpitEQa4NLdLHZF/Td2p3Z9hVsd+uIqLYvOqsySMiRZblvSFlxte2N2Ik7Yw/NmQOz7Wl91AFk/Px+pL4PTJQtYV8RLpqxUH5M7EouZKJAGh91v5+0Y=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091018235240.GU6115@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130639>

'git push -h' shows usage text with incomplete list of options and then
has a separate list of options that are supported. Imitate the way othe=
r
commands (I looked at 'git diff' for an example) show their options.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---
Quoting Miklos Vajna <vmiklos@frugalware.org>

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Sun, Oct 18, 2009 at 07:05:44PM +0200, Sebastian Pipping <webmaste=
r@hartwork.org> wrote:
>> If I'm not mistaken --quiet is not documented in the git-push man pa=
ge.
>> This includes release 1.6.5.1.
>
> Here is a patch to document it.

% git push -h
usage: git push [--all | --mirror] [-n | --dry-run] [--porcelain] [--ta=
gs]
[--receive-pack=3D<git-receive-pack>] [--repo=3D<repository>] [-f | --f=
orce]
[-v] [<repository> <refspec>...]

    -q, --quiet           be quiet
    -v, --verbose         be verbose
    --repo <repository>   repository
    --all                 push all refs
    --mirror              mirror all refs
    --tags                push tags
    -n, --dry-run         dry run
    --porcelain           machine-readable output
    -f, --force           force updates
    --thin                use thin pack
    --receive-pack <receive-pack>
                          receive pack program
    --exec <receive-pack>
                          receive pack program

 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 3cb1ee4..6686b79 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
=20
 static const char * const push_usage[] =3D {
-	"git push [--all | --mirror] [-n | --dry-run] [--porcelain] [--tags] =
[--receive-pack=3D<git-receive-pack>] [--repo=3D<repository>] [-f | --f=
orce] [-v] [<repository> <refspec>...]",
+	"git push <options> [<repository> <refspec>...]",
 	NULL,
 };
=20
--=20
1.6.5.rc1.18.g53a9a




--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
