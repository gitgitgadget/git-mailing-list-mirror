From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: Re: [PATCH] i18n: apply: split to fix a partial i18n message
Date: Thu, 31 May 2012 20:04:36 +0700
Message-ID: <1338469482-30936-1-git-send-email-pclouds@gmail.com>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 15:09:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa57c-0006WW-V3
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945Ab2EaNI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:08:57 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47113 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757516Ab2EaNI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 09:08:56 -0400
Received: by pbbrp8 with SMTP id rp8so1441131pbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Gm2c1Bl32qfq/Y+PBldhpaJs16Xgrh3W0Kh94fziIWY=;
        b=jxPl0zqaPF5smabgS4vazIwoNw2A76F1ZMcuRW5Fwv4cu4KL7cl7pe3zo2y5wXuFOd
         3u4iCkTPi+4fbabPHP2Pc33JlEl/VfATH4k1E/vWREUn4/sK1SHat0p/OD6GRtvOGiLO
         Vx6mLhAG2219Aqck1BpdPDs9MJ4sCAYBFKkW6KzX1dHK073G39CNTBXeO1ZC2OONCB5S
         4LIHkUbYgg+75jQrvHXKwz4wDkSTQGtOrVcg3fEJ9Q4/r4kBkmfiyZr56qHKeXA3Wpkb
         IlMP3P7OKJAgXMWrJfm/lLKT4m6Xu6qY/4GT0SgiY0NAZ1RZH+dLvMvzCAWm/7SRjaZr
         n/vA==
Received: by 10.68.197.136 with SMTP id iu8mr59648243pbc.111.1338469735646;
        Thu, 31 May 2012 06:08:55 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.14])
        by mx.google.com with ESMTPS id ph1sm4140207pbb.45.2012.05.31.06.08.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:08:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 31 May 2012 20:04:43 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198888>

On Thu, May 31, 2012 at 6:20 PM, Jiang Xin <worldhello.net@gmail.com> w=
rote:
> The 4th arg of "new mode (%o) of %s does not match old mode (%o)%s%s"
> is blank string or string " of ". Even mark the string " of " for a
> complete i18n, this message is still hard to translate right.

Your patch looks good. I have a habit of looking for similar spots and
the following patches are the result. These messages are not marked
for translation because I think mass-marking by file or by command is
better.

Not sure if it's the right way to fix these though. For example, while
1/1 looks very good from i18n perspective, code-wise it's quite ugly.
Grouping format strings in array also prevents gcc from checking
correct parameters, I think.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  Remove i18n legos in notifying new branch tracking setup
  reflog: remove i18n legos in pruning message
  merge-recursive: remove i18n legos in conflict messages
  notes-merge: remove i18n legos in merge result message
  rerere: remove i18n legos in result message
  unpack-trees: remove i18n legos in unpack's porcelain error messages

 branch.c          | 48 +++++++++++++++++++++++++++++++++--------------=
-
 builtin/reflog.c  |  8 ++++++--
 merge-recursive.c | 49 +++++++++++++++++++++++++++++++++--------------=
--
 notes-merge.c     | 11 ++++++++---
 rerere.c          | 12 ++++++------
 unpack-trees.c    | 55 +++++++++++++++++++++++++++++++++--------------=
--------
 6 files changed, 119 insertions(+), 64 deletions(-)

--=20
1.7.10.2.549.g9354186
