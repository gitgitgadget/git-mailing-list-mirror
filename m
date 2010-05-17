From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] Remove editor-specific droppings from .gitignore
Date: Mon, 17 May 2010 02:04:43 +0000
Message-ID: <1274061883-18043-1-git-send-email-avarab@gmail.com>
References: <20100517013549.GA19081@progeny.tock>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 04:06:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODpiZ-0003sD-SA
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 04:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180Ab0EQCGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 22:06:00 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40558 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab0EQCF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 22:05:59 -0400
Received: by fxm6 with SMTP id 6so3294816fxm.19
        for <git@vger.kernel.org>; Sun, 16 May 2010 19:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Np7J60rQXu/U/TbwpM0+M1aZxb97pz61xwLBXj8RYeI=;
        b=F2H5nFZleE8OBQcpXKuzJMAvgp14r3SLXBakjDavi4ZbbKkMaTveTFvupGGRc1Iode
         wqbMm2x4na6rwzWzbwz+A/mobHmMmMw2jaIOTQz5aSvEHd/zEwlVpE5im5yxJcVh5ivw
         6hSLBar64wJt4QC6dmKqnnU5pMGv/2k86e1wU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HsAp8sbE1Ull9j1t4+Es2mc08rPMei1iwbvt+bk92TW1ExpI/M8GWL7NTKtxjLRcr6
         B4ezkyrOAVznFCismcJSdNQv/EO1RAAzHHojluLa8IwAdLv5pa4qVOmtxhD3NFvn4V34
         lSYkHweMebk5d4NYnMDCWoJP1/2czZakG0YSM=
Received: by 10.223.127.212 with SMTP id h20mr5423792fas.89.1274061955682;
        Sun, 16 May 2010 19:05:55 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 13sm23438599fad.19.2010.05.16.19.05.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 19:05:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.84.gd92f8
In-Reply-To: <20100517013549.GA19081@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147204>

Git's own .gitignore files should only contain things created by Git's
build systems, not editor-specific droppings.

See the discussion following the "[PATCH] Add git format-patch
produced patches to .gitignore" thread
(<1273958566-7328-1-git-send-email-avarab@gmail.com>).
---

On Mon, May 17, 2010 at 01:35, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Michael J Gruber wrote:
>
>> Does the git build process call format-patch? No! The .gitignore we
>> distribute is meant for things the build process creates
>
> Ah, true. I seem to remember a thread long ago about whether to
> include editor droppings in .gitignore, but I can=E2=80=99t find it i=
n
> the git or lkml archive.
>
> git=E2=80=99s .gitignore does not include .*.swp, \#*#, *~, indeed.

Thanks both of you, I stand corrected. Anyway, I guess this is a bug
then. It's the only thing ignored by Git's various .gitignore files
that isn't created by the build system.

 git-gui/po/.gitignore |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-gui/po/.gitignore b/git-gui/po/.gitignore
index a89cf44..e358dd1 100644
--- a/git-gui/po/.gitignore
+++ b/git-gui/po/.gitignore
@@ -1,2 +1 @@
 *.msg
-*~
--=20
1.7.1.84.gd92f8
