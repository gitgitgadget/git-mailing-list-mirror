From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git submodule add: Remove old docs about implicit -f
Date: Sat, 17 Jul 2010 15:53:45 +0000
Message-ID: <1279382025-24814-1-git-send-email-avarab@gmail.com>
References: <4C41C82F.8030200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 17 17:54:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oa9iF-00011v-0L
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 17:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab0GQPx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 11:53:57 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65354 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113Ab0GQPx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 11:53:56 -0400
Received: by eya25 with SMTP id 25so752396eya.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=bg151W6c+GwgVi40eNn9QM226u5Er2yGvyjN4477j9s=;
        b=kve8UJaB5huD8BNziyMAzlPEUqyLztxeW+DHJTT0p6ywSEDqw1zzgSm+ZYrgTjwR7/
         Q/cHz5q+RxDMCZEsahWwGq6vg/9ClyBPMWB5FTCuJyNYsuZufMJm0EeX8b3FR9GO3IPe
         9PTf8DfVwszrJb3ZR/+cOOgXjbPCG0Raufu3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PydARFpJ1C9ROnHE4CPn6kQPKTuOhn7h7NjaNXnptFCl71AOm1Q3kkoWFOUO1rP3Wv
         lVb3U8ym1R+KIXJgKSFcJS5rZkUWUunrpdsz4OF4KE5pZxth/LW7O4aRFPXo7kBGz926
         Zs1+LA+eR2rGlkUbkQqaxIYQC8BDR9rb4uk8A=
Received: by 10.213.10.67 with SMTP id o3mr781925ebo.31.1279382035454;
        Sat, 17 Jul 2010 08:53:55 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-233-160.pools.arcor-ip.net [88.67.233.160])
        by mx.google.com with ESMTPS id x54sm28963749eeh.5.2010.07.17.08.53.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 08:53:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.125.g94e09.dirty
In-Reply-To: <4C41C82F.8030200@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151189>

git submodule add no longer implicitly adds with --force. Remove
references to the old functionality in the documentation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

> To make the behavior of "git submodule add" more consistent with "git=
 add"
> ignored submodule paths should not be silently added when they match =
an
> entry in a .gitignore file. To be able to override that default behav=
ior
> in the same way as we can do that for "git add", the new option "--fo=
rce"
> is introduced.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>

You beat me to it. I like this better than the original functionality
that I implemented, and it's now possible with --ignore-missing.

So,:

    Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

This amended patch removes some obsolete documentation that you
missed.

> +               echo >&2 "The following path is ignored by one of you=
r .gitignore files:" &&
> +               echo >&2 $path &&
> +               echo >&2 "Use -f if you really want to add it."

Is the "it" intentional? We currently say "them" in git add regardless
of how many things are being added, so perhaps we should say "it"
there too for singulars.

I'll jot this down as something to look at for plural support once
gettext gets merged.

 Documentation/git-submodule.txt |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index 617069f..1ed331c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -95,10 +95,6 @@ is the superproject and submodule repositories will =
be kept
 together in the same relative location, and only the
 superproject's URL needs to be provided: git-submodule will correctly
 locate the submodule using the relative URL in .gitmodules.
-+
-The submodule will be added with "git add --force <path>". I.e. git
-doesn't care if the new path is in a `gitignore`. Your invocation of
-"git submodule add" is considered enough to override it.
=20
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
--=20
1.7.2.rc3.125.g94e09.dirty
