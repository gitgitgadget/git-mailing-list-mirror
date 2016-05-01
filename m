From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Sun, 1 May 2016 13:00:09 +0700
Message-ID: <20160501060009.GA30748@lanh>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
 <xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
 <CACsJy8A8vbp4-LrxoNX510Nme97EKfu0hBBs-LDRap1Z5=v3rA@mail.gmail.com>
 <20160427101833.GA5536@lanh>
 <xmqqy47z9geq.fsf@gitster.mtv.corp.google.com>
 <20160501002852.GA3963@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 01 08:00:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awkQj-0006v5-Eo
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 08:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbcEAGAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 02:00:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36690 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbcEAGAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 02:00:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id p185so18485899pfb.3
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 23:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IWSDMhFxhbnpgzGTZJEA7mTUBrhdlsMpApuwiAUMjyY=;
        b=C5313C3lQB/3LETmqWf8LHysOiIf3VOv0J3t5RWfGkCJAFGuCRpECtKV83/LKyWmfH
         Jl3GUn0EONOkYAMzw6j4Beh98c45G89iUV3xZOWwSCiZjnMgwBl9i6557VSHwRKgObKF
         ViHdk+tqqOMBjdH21J+wlXf08kc0rkgs0VMD/fdiIM47ZfHrEsCg9WypiecbRdn8Zqxb
         ojMgwDIWeGehSONzX6O22P+qMT+OjteT0TECw+AOs9nE2t+WwWqwmXmEqNHbyuRAT3q5
         TBfdT0YqiHuccsPXLv5glSw/OsRzRIBeXYBSL2Lpiz9eysWr77z5elnj30yz8NkNYMb7
         4gjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IWSDMhFxhbnpgzGTZJEA7mTUBrhdlsMpApuwiAUMjyY=;
        b=C4uRLe5mO7FGRoy1x7cLOZPAq70MlOJIUmm0Lktsw0TcFQ5CBncbj0TPLOpzgB7eAb
         BqVwk8n1dIYKS5wNs+c5Nt8CB8Kkllg6bPjZXe+hPHP8fJjcdcZpgTTSWB43ClaZwUEk
         mpdFARp5TpVgk23lT2CtDqoVhm15pXOmGCNZYkvNW5x0kqjXRzhnw+mQN4YwzqvnHiSb
         JPMROL/xaDLOofyi4IJgSC14LToz142s796MtPB/g8KPexUkLTt0eoBxRwSsWUiwSNsY
         9h5gk/xDV0IjU1MbpRr1sVIOhw6z1LuBvUts+YE8/unB3xQKMA9oo44L3eWBkTbn737C
         a0NA==
X-Gm-Message-State: AOPr4FV+ypsYex/vqYPPk4RGGM50KJhoo09jFCE93yTVyVZmcyT0UZLwo41GoF1woqbO/A==
X-Received: by 10.98.84.2 with SMTP id i2mr41983469pfb.55.1462082414602;
        Sat, 30 Apr 2016 23:00:14 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id i1sm35451656pfj.17.2016.04.30.23.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Apr 2016 23:00:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 13:00:09 +0700
Content-Disposition: inline
In-Reply-To: <20160501002852.GA3963@lanh>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293136>

On Sun, May 01, 2016 at 07:28:52AM +0700, Duy Nguyen wrote:
> On Wed, Apr 27, 2016 at 09:15:41AM -0700, Junio C Hamano wrote:
> > Duy Nguyen <pclouds@gmail.com> writes:
> >=20
> > > This patch forces bin-wrappers regeneration every time a test pro=
gram
> > > is updated. A bit wasteful, but I don't see a better option (whic=
h is
> > > also why I limit this to test programs only).
> >=20
> > In other words, when we update the location where the programs that
> > would be eventually installed are created, we'd see the same
> > problem.
> >=20
> > I actually wonder if it is a better overall structure to move
> > t/helper/test-foo back to test-foo, while keeping the source file
> > that contains main() for test-foo at t/helper/test-foo.c.  Then we
> > do not have to have many copies that are slightly different in
> > bin-wrappers, but they can all be
> >=20
> > 	exec "${GIT_EXEC_PATH}/$0" "$@"
> >=20
> > instead of "bin-wrappers/git-bar" being
> >=20
> > 	exec "${GIT_EXEC_PATH}/git-bar" "$@"
> >=20
> > and "bin-wrappers/test-foo" being
> >=20
> > 	exec "${GIT_EXEC_PATH}/t/helper/test-foo" "$@"
> >=20
>=20
> It's not a perfect solution (rebuild bin-wrappers when the real binar=
y
> moves) but I think it's the best option so far.

I may have rushed to judgement. wrap-for-bin.sh has always been the
dependency for bin-wrappers/*. If we force that file to change, then
bin-wrappers/* will be recreated when switching branches. So how about
this?

-- 8< --
Subject: [PATCH] wrap-for-bin.sh: handle t/helper/ paths internally

Commit e6e7530 (test helpers: move test-* to t/helper/ subdirectory -
2016-04-13) moves test-* to t/helper. However because bin-wrappers/*
only depend on wrap-for-bin.sh, when switching between a branch that ha=
s
this commit and one that does not, bin-wrappers/* may not be regenerate=
d
and point to the old/outdated test programs. Fix it by force updating
wrap-for-bin.sh so that it will be regenerated anyway.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile        |  2 +-
 wrap-for-bin.sh | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index dd178ee..38dcdf7 100644
--- a/Makefile
+++ b/Makefile
@@ -2204,7 +2204,7 @@ bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))|' < $< >=
 $@ && \
+	     -e 's|@@PROG@@|$(@F)|' < $< > $@ && \
 	chmod +x $@
=20
 # GNU make supports exporting all variables by "export" without parame=
ters.
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index db0ec6a..bb334ed 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -18,11 +18,19 @@ GITPERLLIB=3D'@@BUILD_DIR@@/perl/blib/lib'"${GITPER=
LLIB:+:$GITPERLLIB}"
 GIT_TEXTDOMAINDIR=3D'@@BUILD_DIR@@/po/build/locale'
 PATH=3D'@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
+case "@@PATH@@" in
+    test-*)
+	PROG=3D"${GIT_EXEC_PATH}/t/helper/@@PROG@@"
+	;;
+    *)
+	PROG=3D"${GIT_EXEC_PATH}/@@PROG@@"
+	;;
+esac
=20
 if test -n "$GIT_TEST_GDB"
 then
 	unset GIT_TEST_GDB
-	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+	exec gdb --args "$PROG" "$@"
 else
-	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+	exec "$PROG" "$@"
 fi
--=20
2.8.0.rc0.210.gd302cd2
-- 8< --
