From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] t7011: Mark fixed test as such
Date: Mon, 30 Nov 2009 20:18:20 +0700
Message-ID: <fcaeb9bf0911300518n4d4f96fdg28b13e45c2a4462d@mail.gmail.com>
References: <0327ed3d7c4621f205d2d111254d716bd1b06c28.1259432535.git.git@drmicha.warpmail.net>
	 <fcaeb9bf0911290047t43ea3040x730e04baa81d8a98@mail.gmail.com>
	 <4B127DC0.4020108@drmicha.warpmail.net>
	 <fcaeb9bf0911291756g1857fe32r8da8e50f0a137119@mail.gmail.com>
	 <4B13BF3D.7010503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 14:18:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF694-0006zd-Gr
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 14:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbZK3NSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 08:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbZK3NSO
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 08:18:14 -0500
Received: from mail-px0-f188.google.com ([209.85.216.188]:48717 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbZK3NSN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 08:18:13 -0500
Received: by pxi26 with SMTP id 26so2599243pxi.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 05:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=S/FBcx92qY4tp4yBJOOvMtt6J158cTCdEWEFC6Ixkoo=;
        b=lXE1ZGhaM25qcbEDZPjpmSaIJre1iodqes9BoR/qSEQTtqtHIMvAEqaB2YpXhv8NLg
         UL4QdkVu8bQ2KmSr/Uj8DUUWb0XYYBSkoTx2SPIsgwRTkmmej/xUnDb4ABZ7QqsXWAPM
         03i2nZgofjq37cJ+aWBggjdNT/BMP8xuHEBiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BVRrGt8Arsg8RWKqEfOYi8pJ4jduY1IxgHQDKRxrVSbHeukJvhyMhCYxtkB2cqgE2N
         Rongnut2RvDf+jgur7SxncGqbjK5rV4B/O/rQJZck8UOCjXJLU7cBrBY9DFjwriCKjOZ
         Jv2sGRY1SaGsTyET5RS9NwdNQN9sDChanrmek=
Received: by 10.114.9.6 with SMTP id 6mr3050595wai.35.1259587100031; Mon, 30 
	Nov 2009 05:18:20 -0800 (PST)
In-Reply-To: <4B13BF3D.7010503@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134100>

On 11/30/09, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>  Regarding 16/17: Seeing a FIXED is very misleading. I caught it during
>  my work on a patch series and was confused. FIXED usually occurs only
>  while working on a fix, before adjusting the test. So, unless the reroll
>  of nd/sparse is to happen very soon, I still suggest marking it as
>  expect_success as proposed, and then modifying the test during the reroll.

I won't work on it until this weekend. If you insist, then better put
command "true" after test_must_fail to indicate that the test is
broken (could be line-wrapped by gmail, but it's simple enough to
recreate)

diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index e996928..da8dcbb 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -152,6 +152,7 @@ test_expect_failure 'commit on skip-worktree
absent entries' '
 	git reset &&
 	setup_absent &&
 	test_must_fail git commit -m null 1
+	true
 '

 test_expect_failure 'commit on skip-worktree dirty entries' '
-- 
Duy
