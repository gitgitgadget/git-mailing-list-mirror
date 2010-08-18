From: Knittl <knittl89@googlemail.com>
Subject: [PATCH re-roll] Do not display 'Switched to a new branch' when the
 branch existed
Date: Wed, 18 Aug 2010 10:38:04 +0200
Message-ID: <AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>
References: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 10:39:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OleAp-0007Lg-VU
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 10:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab0HRIid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 04:38:33 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40886 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab0HRIib convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 04:38:31 -0400
Received: by qwh6 with SMTP id 6so238241qwh.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 01:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=G/fJ3dO+y52VIZTgJ7WT9xXaN4kGgSaEkBsQvpbNsxA=;
        b=lExTdqD2IBpyqNVnvBjQAxNIO+VFk6VrncQ8bASh8458asMRyV6u1BjF6dLBrQBwVI
         IbAMbFo/p1avfw5eBTHDNFGNIepkO8awwqcDce60ELp4BPJsNmOCw4D1gI9eR+xrAf1i
         qvT3twkYzQWS4pMUYX3GTMlhzVlylJslORKLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=sDbuw8zMVFSe3R0T6FoP7HjdjgGpWiX/xL302R7jLM58AMoPHZ632jYDmDm2ckJR47
         Sf1/4s9SszaR1ij2mDo5gMRgXhxpQeYLzJok92kCb2w4yr/ygWaAIW/rv6pSmZSzbUYq
         UzwGSXiu8cfWqnLjlkF0P1Y5kyPfy9wJN/Z78=
Received: by 10.229.224.81 with SMTP id in17mr5729470qcb.140.1282120710324;
 Wed, 18 Aug 2010 01:38:30 -0700 (PDT)
Received: by 10.220.179.8 with HTTP; Wed, 18 Aug 2010 01:38:04 -0700 (PDT)
In-Reply-To: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153816>

=46rom 16f540c87f8c7b87692dfd488d507802ae975312 Mon Sep 17 00:00:00 200=
1
=46rom: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Wed, 18 Aug 2010 10:35:42 +0200
Subject: [PATCH] builtin/checkout: fix info message for `git checkout <=
branch>`

Since 02ac98374eefbe4a46d4b53a8a78057ad8ad39b7 `git checkout` would
always display 'Switched to a new branch <branch>` even if the branch
had already existed.

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---

stupid me, i forgot to reset author in re-used commit =85

 builtin/checkout.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4ad7427..ed7cde1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -536,7 +536,9 @@ static void update_refs_for_switch(struct
checkout_opts *opts,
 					new->name);
 			else
 				fprintf(stderr, "Switched to%s branch '%s'\n",
-					opts->branch_exists ? " and reset" : " a new",
+					opts->branch_exists
+						? " and reset"
+						: opts->new_branch ? " a new" : "",
 					new->name);
 		}
 		if (old->path && old->name) {
--=20
1.7.1.574.g421e3


--=20
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
