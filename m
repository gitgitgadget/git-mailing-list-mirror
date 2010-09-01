From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 00/13] gettextize the first 4 C mainporcelain common commands
Date: Wed,  1 Sep 2010 20:43:52 +0000
Message-ID: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:44:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquAc-0006jZ-IT
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab0IAUoS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:18 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54032 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966Ab0IAUoR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:17 -0400
Received: by wwj40 with SMTP id 40so478054wwj.1
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=mB9ynRa3q5JG0ddL/pffwijNtVLyB7TLyWwmyYOq6O8=;
        b=MJpdKe9Mx8xn4/tH8+3VLMnB/cPHCtJUp4gB35C4KyTaCvJwTqkSsIIUKuB1pPdQD+
         XjoP13sNmqXUrd4UWdPmZeSFE5LhFsO1HH+LuDhEspdZg0JRVxyImIBX7CiHXO49totK
         n3m0XbgyMpdQ83pEJIMLTvCxb/7MU0hkgLKsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=FV2xovbqjFfyX8RDiTFWWpvnsUNDDKNbEgAIcpHrDFIXimGiD9A9W6iWBy9iYJDAcX
         fqBnfW3bwzYOybTuEa+GcTTiBHOX90x63uXr6u7Kh8gV1WVr/a81N3LZ0PuKhmkiOoFy
         b68NieWr6g/HZECBw/mUUPGZkC4FH8pxwy6MA=
Received: by 10.227.157.17 with SMTP id z17mr8573638wbw.122.1283373856249;
        Wed, 01 Sep 2010 13:44:16 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155077>

This series makes the first 4 C mainporcelain common commands
translatable with gettext.

I'm avoiding translating things like git-bisect for now simply because
I have some scripts to make this easier that are currently aimed at
the C code.

    $ grep 'mainporcelain common' *txt
  * git-add                                 mainporcelain common
    git-bisect                              mainporcelain common
  * git-branch                              mainporcelain common
  * git-checkout                            mainporcelain common
  * git-clone                               mainporcelain common
    git-commit                              mainporcelain common
    ...

This is around 3 patches per command (so at this rate I should finish
all 22 commands in ~63 patches).

I'm making an effort to split these up into different types of
messages for discussion.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (13):
  git-clone: use builtin.h to get gettext.h
  gettextize: git-clone basic messages
  gettextize: git-clone "Cloning into" message
  gettextize: git-add basic messages
  gettextize: git-add refresh_index message
  gettextize: git-branch basic messages
  gettextize: git-branch "remote branch '%s' not found" message
  gettextize: git-branch "git branch -v" messages
  gettextize: git-branch "(no branch)" message
  gettextize: git-checkout: our/their version message
  gettextize: git-checkout basic messages
  gettextize: git-checkout describe_detached_head messages
  gettextize: git-checkout "Switched to a .. branch" message

 builtin/add.c      |   46 +++++++++++++-------------
 builtin/branch.c   |   69 +++++++++++++++++++-------------------
 builtin/checkout.c |   93 +++++++++++++++++++++++++++-----------------=
--------
 builtin/clone.c    |   63 ++++++++++++++++++-----------------
 4 files changed, 138 insertions(+), 133 deletions(-)

--=20
1.7.2.2.579.g2183d
