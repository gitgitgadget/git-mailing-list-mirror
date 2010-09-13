From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 00/12] gettextize: git-submodule
Date: Mon, 13 Sep 2010 22:09:06 +0000
Message-ID: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHDl-0006mj-4t
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab0IMWJn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:09:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64182 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab0IMWJm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:09:42 -0400
Received: by wwd20 with SMTP id 20so393266wwd.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Z1xgL46JYbfVT8zNJoXJV3DNgeUoNgWASiAuySfJRog=;
        b=WIKNPJ0+wq5CCx8jMBb00JleasKrzgxyCjLm6YFDEIvEDe2PBU3lM/SESnCbeVG8Ht
         0W3lrAyqVhZ6yMaH1Fvauoo+Zsc6cO9wM4YbVvpXaPj2Ppr/FzJVWV1d23CbxH6o0ryH
         +H/6AWL/92pyD+s7uzHaDdPLwjKC1SRWpVptE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=v6yxPUHqnvItju4fd0dw8dCgwgD8uk4pXw/h/H2XYgnmsdXO9AsCPqiOQA3JJGyMUl
         ymDnmfTZnepC44+Z64+vJRFPf2DNRGCYq1AnMY0AhkOT9461gRQpFz3KF4aqtb41xcOB
         EZU4LZql2C6UbjFI4A45mPQIEw4CBIUi1lWic=
Received: by 10.216.235.106 with SMTP id t84mr4923650weq.46.1284415781053;
        Mon, 13 Sep 2010 15:09:41 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.09.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:09:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156134>

This is an RFC on a series that makes git-submodule.sh
translatable. With this git-bisect/rebase/stash are the only
mainporcelain commands that aren't translatable.

I'll be folding this into the next version of the ab/i18n series I'll
be sending to Junio. No need to apply it to the current one.

This is based on a master that has the "tests: use test_cmp instead of
piping to diff(1)" patch applied. Untangling the two was a pain, and
probably unnecessary since by the time this gets merged that patch
will be in maint/master.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (12):
  gettextize: git-submodule add git-sh-i18n
  gettextize: git-submodule echo + eval_gettext messages
  gettextize: git-submodule say + eval_gettext messages
  gettextize: git-submodule die + eval_gettext messages
  gettextize: git-submodule $update_module say + die messages
  gettextize: git-submodule "cached cannot be used" message
  gettextize: git-submodule "Submodule change[...]" messages
  gettextize: git-submodule $errmsg messages
  gettextize: git-submodule "Entering [...]" message
  gettextize: git-submodule "[...] path is ignored" message
  gettextize: git-submodule "path not initialized" message
  gettextize: git-submodule "blob" and "submodule" messages

 git-submodule.sh             |   94 +++++++++++++++++++++-------------=
-------
 t/t7400-submodule-basic.sh   |    4 +-
 t/t7401-submodule-summary.sh |   12 +++---
 t/t7407-submodule-foreach.sh |    4 +-
 4 files changed, 58 insertions(+), 56 deletions(-)

--=20
1.7.3.rc1.220.gb4d42
