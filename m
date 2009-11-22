From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 2/4] apply: apply works outside a repository
Date: Sun, 22 Nov 2009 17:19:45 +0100
Message-ID: <4B0964A1.2040302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 22 17:19:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCFAH-0001ga-7u
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 17:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbZKVQTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 11:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbZKVQTm
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 11:19:42 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:54380 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbZKVQTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 11:19:41 -0500
Received: by ey-out-2122.google.com with SMTP id 4so811197eyf.19
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 08:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=rQ98Q6MbLsxsP1TWDIOpa1Bhijj6hyqgHs4Lh7Haiq4=;
        b=v7mZ9MOmIdUDZS2zbVodzOu3RhPaKEZa0NkozbSlRHL+fmZujuWizbGxQZZUMoXUu0
         RyuirFeAVSniy+HMZiFkacQYUtocb58extRIVxaBQBvJsOlmPQ79TO+/cSVGNT3yLl0a
         /PexPATwnoF2HOo4QxI/eexJORjILa/ZLaCTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=KerDOE17qGA9jY5sWPvYnphzGrthProiYSyhYDrph2eY+FwgCqlzrT7wd6Iz26BEdt
         Ik8jTDvr84/d4FXCc6nSHgEDZL1EjU2kApryfsLVzJdhfIC/YGVgFhB02WJ3Yj0cnSaa
         VMziscMTmKzLT532Gn1NayynhdsVLRutMjS3M=
Received: by 10.213.24.3 with SMTP id t3mr2487358ebb.40.1258906786644;
        Sun, 22 Nov 2009 08:19:46 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm835489eyb.2.2009.11.22.08.19.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 08:19:46 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133440>

The documentation for 'git apply' talks about applying a
patch/diff to the index and to the working tree, which seems
to imply that it will not work outside a git repository.

Actually 'git patch' works outside a repository (which can
be useful especially for applying binary or rename patches that
the standard "patch" utility cannot handle), so the documentation
should mention it.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/git-apply.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 4f791ee..6857a68 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -23,6 +23,10 @@ DESCRIPTION
 Reads supplied 'diff' output and applies it on a git index file
 and a work tree.
=20
+'git-apply' can also be used outside a git repository as long
+as no options that require a git repository are given
+(e.g. `--index` or `--cached`).
+
 OPTIONS
 -------
 <patch>...::
--=20
1.6.5.3.298.g39add
