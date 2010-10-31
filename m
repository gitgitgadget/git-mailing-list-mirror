From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [RFC/PATCH 0/5] ab/i18n: Things I'll add in the next iteration
Date: Sun, 31 Oct 2010 11:34:15 +0000
Message-ID: <1288524860-538-1-git-send-email-avarab@gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 12:34:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCWBG-0002by-AC
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 12:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334Ab0JaLea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Oct 2010 07:34:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62506 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab0JaLe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 07:34:29 -0400
Received: by wyf28 with SMTP id 28so4574626wyf.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Nv/+8S3yBrI2MMjphEWHTb8cfKhdwt3xwQBFor3DZJo=;
        b=w4GoKetEYVXh7TVovBxhhyp8d9cLyJAKk0uj9wwokbcrbSZ6yotKaenhREAkn+Yt5Q
         +WYwH1fWJttTwucTTMKH6IsbcxjOOFbCDzsTGzsvHwpeA2Fom19QCrcRSuVj5CN+5Y3A
         bDLjS8v0SrCwVhBWRqk82byP1TLTc6V21/IpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=u/VzJc6wODEfijGrDNGHym4IX05OiUzsKwDdHF3C6h19xFcy+tbSzl4dauX9yZIT/p
         vcg8GiQWRu6QX6YWMS5EiJU4nja0ejyMewiePJxLfNLEKGq8TWq/OsT8WoApoP2DvcfH
         yXbaHZ5P8Aa6U0IgGv2EDLSd/uOVmDWfdpNEc=
Received: by 10.216.141.209 with SMTP id g59mr9607494wej.10.1288524867674;
        Sun, 31 Oct 2010 04:34:27 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id x12sm3009770weq.18.2010.10.31.04.34.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 04:34:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.312.ge13a7
In-Reply-To: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160434>

This is an RFC for things I'll add in the next iteration of ab/i18n:

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
  gettext: fix bug in git-sh-i18n's eval_gettext() by using envsubst(1)

This solves the "Buglet in i18n?" issue reported by Johannes Sixt.

  gettextize: git-clone: !fixup "basic messages"
  gettextize: git-init: !fixup "basic messages"
  gettextize: git-revert: !fixup "Your local changes"
  gettextize: git-merge: !fixup "basic messages"

These are all minor fixups to the gettextize portion of the series
that I'll squash into exisitng patches.

 .gitignore                   |    1 +
 Makefile                     |    1 +
 builtin/clone.c              |    2 +-
 builtin/init-db.c            |    2 +-
 builtin/merge.c              |    2 +-
 builtin/revert.c             |    4 +-
 git-sh-i18n.sh               |    7 +-
 sh-i18n--envsubst.c          |  303 ++++++++++++++++++++++++++++++++++=
++++++++
 t/lib-gettext.sh             |   25 ++++
 t/t0200-gettext-basic.sh     |    3 +
 t/t0201-gettext-fallbacks.sh |    3 +
 11 files changed, 343 insertions(+), 10 deletions(-)
 create mode 100644 sh-i18n--envsubst.c

--=20
1.7.3.2.312.ge13a7
