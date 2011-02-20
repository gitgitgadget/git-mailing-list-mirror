From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/72] t/test-lib.sh: add always-set NO_GETTEXT_POISON
 prerequisite
Date: Sat, 19 Feb 2011 20:10:42 -0600
Message-ID: <20110220021031.GB17305@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 03:11:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqylK-0006Uf-KY
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 03:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab1BTCKt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 21:10:49 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63443 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab1BTCKs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 21:10:48 -0500
Received: by iwn8 with SMTP id 8so734966iwn.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 18:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aaepLXsdO/EWKkGgHeP6r707/PZZRykvR9Bz5Sts5hk=;
        b=WpT9yLT5fHuXsmnVGdfuqDq8/LM3jxoqcQRP65komok8mgr34P28i+F4QnMvLyEZcq
         QykXCOPKwu7cFB3UKV6bWyVKTnL8QDbMbq+MbsGC53vbpl4AYCAIYHG7R3mfhUVe1MC9
         C4Tp8F7TvSaTc4C/QrqGH0zjJDnlJ+t67gHIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cxybAAMfgt81KK9lu9lnYnbsBbvq4oXyOji9G/UHFpjyFjLbyCpAUu+YuqU+4/28x7
         SoQ1sUtR5IEYZqgf4jqL7DwqtjzaMa+VVJcC2eDn+nPv/GnNuH0ty9sR41UtgeQUBngn
         M40ZWxdhSeBJJnaP67GqxOdTcXKjb/WDF8xA8=
Received: by 10.231.182.13 with SMTP id ca13mr1835839ibb.57.1298167847969;
        Sat, 19 Feb 2011 18:10:47 -0800 (PST)
Received: from elie (adsl-69-209-79-88.dsl.chcgil.ameritech.net [69.209.79.88])
        by mx.google.com with ESMTPS id u9sm3457620ibe.20.2011.02.19.18.10.46
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 18:10:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298143495-3681-4-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167391>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Add a new test prerequisite called NO_GETTEXT_POISON to t/test-lib.sh
> that's always set for now.

Suppose I am writing a new family of tests.  Which of them will need
the NO_GETTEXT_POISON prerequisite?  The name doesn't make it easy to
guess.

If later the testsuite learns to take a --lang=3D option to test that
git works correctly in my native language, I'd think this same
prerequisite would be relevant for that, too.  So maybe:

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib.sh |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ffcfa2e..32004c1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1079,10 +1079,8 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
=20
-# Always set the NO_GETTEXT_POISON prerequisite while we don't have a
-# real gettext implementation in Git. This will be replaced by
-# something that varies in a future patch series.
-test_set_prereq NO_GETTEXT_POISON
+# We can rely on output using the C locale.
+test_set_prereq ENGLISH
=20
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYML=
INKS
--=20
1.7.4.1
