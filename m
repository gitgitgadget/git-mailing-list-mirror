From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/5] Update compat/regex
Date: Tue, 17 Aug 2010 09:24:37 +0000
Message-ID: <1282037082-12996-1-git-send-email-avarab@gmail.com>
References: <20100817080322.GA28476@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 11:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlIQs-0001Gc-FN
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 11:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224Ab0HQJ0D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 05:26:03 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62919 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab0HQJ0A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 05:26:00 -0400
Received: by wwi17 with SMTP id 17so844005wwi.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UwnbMzhkHE5HLe5zJgdA6sz1MhNlqi/56U+zHUTB9Mg=;
        b=vcSwOxAfnUeNP65NXHUCVp2WUZGzHU0yrWxYOwkAockAOVP2oFfB/GY1nBx3L2HDRx
         czujAMgze6EKMseKkQoX5orJcD7MXcqX5Gyka+/SAkwNv8U4ZGh2PtUMLbIrfp1Qwptk
         cW+6KZfOtolGafVSybPYlP7R1vPxgRprefi2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ECbkEK9I6C3bMGh1ksZorGyopEFCGuowZ7dN+sYvzcA1Dqs0ATfp8PYlVN6/RMdcFe
         TE/+V/C5qp9Y++b1KJmwIqF7ed1MT0a2iDNNFvE0GYglFS2iO8NOwrNCskIODf3qUGfA
         FHT6j7rs0gkztiKYNVFY5/3pQTxRddHLYwbeo=
Received: by 10.227.142.139 with SMTP id q11mr5582580wbu.103.1282037159258;
        Tue, 17 Aug 2010 02:25:59 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm3916254weq.33.2010.08.17.02.25.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 02:25:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
In-Reply-To: <20100817080322.GA28476@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153737>

Here's a (hopefully) final version of this series. Changes since the
v2 RFC:

 * Re-apply Frank Li's regerror() patch already in Git as
   v1.6.5-rc2~23. There was no need to apply another msvc fix,
   v1.7.0-rc0~15, because it had already been fixed upstream.

 * Include Jonathan Nieder's autoconf patch and add his Acked-by to
   the rest, add my Tested-by to his.

 * Fix text alignment in one of the commit messages.

Note: This patch is intentionally diff --check unclean so we don't
diverge from upstream. This series can also be pulled from
http://github.com/avar/git/tree/update-fallback-regex-engine-v3 if the
whitespace causes issues with git-am.

=46rank Li (1):
  Change regerror() declaration from K&R style to ANSI C (C89)

Jonathan Nieder (1):
  autoconf: don't use platform regex if it lacks REG_STARTEND

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  compat/regex: use the regex engine from gawk for compat
  compat/regex: get the gawk regex engine to compile within git
  t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND

 Makefile                      |    4 +
 compat/regex/regcomp.c        | 3889 ++++++++++++++++++++++++++++++++
 compat/regex/regex.c          | 5003 +--------------------------------=
--------
 compat/regex/regex.h          |  462 +++--
 compat/regex/regex_internal.c | 1744 ++++++++++++++
 compat/regex/regex_internal.h |  810 +++++++
 compat/regex/regexec.c        | 4377 +++++++++++++++++++++++++++++++++=
++
 config.mak.in                 |    1 +
 configure.ac                  |   21 +
 t/t7008-grep-binary.sh        |    2 +-
 10 files changed, 11207 insertions(+), 5106 deletions(-)
 create mode 100644 compat/regex/regcomp.c
 create mode 100644 compat/regex/regex_internal.c
 create mode 100644 compat/regex/regex_internal.h
 create mode 100644 compat/regex/regexec.c

--=20
1.7.2.1.389.gc3d0b
