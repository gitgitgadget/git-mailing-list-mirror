From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 0/7] tests: use skip_all=* to skip tests
Date: Wed, 11 Aug 2010 19:04:03 +0000
Message-ID: <1281553450-26467-1-git-send-email-avarab@gmail.com>
References: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 21:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGbS-00034v-DJ
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849Ab0HKTE3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:04:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38416 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab0HKTE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:04:28 -0400
Received: by wyb32 with SMTP id 32so462329wyb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=PveqR20VVhDj6CqnYrMs32PNtSINgxV+o9GSX5H7K9w=;
        b=srgys2yxG+aw6eq2QO71sBFYA3YhO0OFwOz3m0HprmiwB9F+f3e2Ey3AuPE8yxHfpW
         LtxArWC4TrZ0erOlNZn2j5Xd4hZV+EHH59hEALFcCtfng5qZVQeZweFiMqNwIFwNKe2i
         SUGh0VrikrJEt9XnPa+8dQPShLFuRl0p25G6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rzMJoHlmwz49PHIAFhAwzt4mbAwmeJF2mVtBpa5iRekbz4XYV97bUfB2oehUBNl/t3
         Z+RNcNKjeIi3bYnQmw80Qqh6+Z5ZbsHKtiMW0b22tltJ0U4fULc/BIEZfMFJFmzIn4Gd
         fwMMpqOzQWYiQQ7nY3dLSCCVtupxhSm2Hh6oo=
Received: by 10.227.134.85 with SMTP id i21mr16953947wbt.127.1281553466945;
        Wed, 11 Aug 2010 12:04:26 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b18sm369379wbb.19.2010.08.11.12.04.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 12:04:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153281>

On Wed, Aug 11, 2010 at 18:32, Junio C Hamano <gitster@pobox.com> wrote=
:
> Except for a few which I'll comment separately all of these looked
> reasonable (I didn't look at 7/7 very carefully, though).

Thanks for the review. Here's a v2 that fixes the isssues raised.

Like v1 aside from these fixes, all but one spotted by Junio:
   =20
    diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
    index 0e6cb4f..b5d89a2 100755
    --- a/t/t1304-default-acl.sh
    +++ b/t/t1304-default-acl.sh
    @@ -28 +27,0 @@ fi
    -
    diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
    index 10e2db3..ab0c2f0 100755
    --- a/t/t4016-diff-quote.sh
    +++ b/t/t4016-diff-quote.sh
    @@ -14 +14 @@ P2=3D'pathname with SP'
    -if P3=3D'pathname
    +P3=3D'pathname
    @@ -16 +16 @@ with LF'
    -: 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1"
    +if : 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1"
    diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
    index 694e28d..e9783c3 100755
    --- a/t/t5705-clone-2gb.sh
    +++ b/t/t5705-clone-2gb.sh
    @@ -6 +6,6 @@ test_description=3D'Test cloning a repository larger =
than 2 gigabyte'
    -test -n "$GIT_TEST_CLONE_2GB" && test_set_prereq CLONE_2GB
    +if test -z "$GIT_TEST_CLONE_2GB"
    +then
    +       say 'Skipping expensive 2GB clone test; enable it with GIT_=
TEST_CLONE_2GB=3Dt'
    +else
    +       test_set_prereq CLONE_2GB
    +fi

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
  t/t1304-default-acl: change from skip_all=3D* to prereq skip
  t/t5705-clone-2gb: change from skip_all=3D* to prereq skip
  t/t7005-editor: change from skip_all=3D* to prereq skip
  t/t5503-tagfollow: change from skip_all=3D* to prereq skip
  t/t4016-diff-quote: change from skip_all=3D* to prereq skip
  t/t3902-quoted: change from skip_all=3D* to prereq skip
  t/t3300-funny-names: change from skip_all=3D* to prereq skip

 t/t1304-default-acl.sh |   14 +++++---
 t/t3300-funny-names.sh |   82 +++++++++++++++++++++++++++++++++++-----=
--------
 t/t3902-quoted.sh      |   38 ++++++++++++----------
 t/t4016-diff-quote.sh  |   22 +++++++++----
 t/t5503-tagfollow.sh   |   33 ++++++++++++++-----
 t/t5705-clone-2gb.sh   |   16 +++++----
 t/t7005-editor.sh      |   10 +++---
 7 files changed, 142 insertions(+), 73 deletions(-)

--=20
1.7.2.1.295.gdf931
