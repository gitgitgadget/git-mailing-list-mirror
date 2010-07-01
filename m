From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Test 17 of `t9119-git-svn-info.sh' fails with svn 1.6.9
Date: Thu, 01 Jul 2010 11:17:35 +0200
Message-ID: <4C2C5D2F.90000@drmicha.warpmail.net>
References: <8739w3fupp.fsf@ft.bewatermyfriend.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Eric Wong <normalperson@yhbt.net>
To: Frank Terbeck <ft@bewatermyfriend.org>
X-From: git-owner@vger.kernel.org Thu Jul 01 11:19:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUFvW-0003kw-IY
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab0GAJS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 05:18:29 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54864 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754782Ab0GAJS0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 05:18:26 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EF10410BD68;
	Thu,  1 Jul 2010 05:18:24 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 01 Jul 2010 05:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=A7ZbyLbscnO3uQRZivZsGReibFE=; b=KlB0lZoTiwUCnCvQcuMaRqbWohGfT38EovlWAkAmLS+lm4JCFBn7ty5KRxRK25kajwXjhutC4nPvkd1Bh7uXy4+OFXXmCJWcQBunxeza+BDrO0xYpltxB/YW7Zm4gNYsYcbwyhoKGyA0+1XUB4UxronSGxYxmN6Rek2ZUmpJIyw=
X-Sasl-enc: E//20C9Y9i+04/A2eBZqasDKybzmQLcuD8Llotxu94O8 1277975904
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D1F8F5B852;
	Thu,  1 Jul 2010 05:18:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100625 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <8739w3fupp.fsf@ft.bewatermyfriend.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150018>

Frank Terbeck venit, vidit, dixit 01.07.2010 10:54:
> Hello,
> 
> Running the test suite currently breaks for me at this point:
> 
> [snip]
> *   ok 16: info --url added-file
> * FAIL 17: info added-directory
> 
>                 mkdir gitwc/added-directory svnwc/added-directory &&
>                 ptouch gitwc/added-directory svnwc/added-directory &&
>                 touch gitwc/added-directory/.placeholder &&
>                 cd svnwc &&
>                         svn_cmd add added-directory > /dev/null &&
>                 cd .. &&
>                 cd gitwc &&
>                         git add added-directory &&
>                 cd .. &&
>                 (cd svnwc; svn info added-directory)            >
>                 expected.info-added-directory &&
>                 (cd gitwc; git svn info
>                 added-directory)                >
>                 actual.info-added-directory &&
>                 test_cmp expected.info-added-directory
>                 actual.info-added-directory
> 
> *   ok 18: info --url added-directory
> [...]
> * failed 1 among 38 test(s)
> make[2]: *** [t9119-git-svn-info.sh] Error 1
> [snap]
> 
> I briefly searched the list archives via gmane but didn't find this
> reported yet. I've got no idea what's going on in that test, as I'm no
> expert in subversion matters at all. So I can't be of more help than
> saying "well, it breaks for me.". :)
> 
> Anyway, my svn version is "svn, version 1.6.9 (r901367)". The test suite
> I ran is from yesterdays git master branch. If it matters, this is a
> Linux box running a debian 2.6.26-2-686 kernel; the file system in
> question is `ext3' being mounted `noatime'.

It works for me with the exact same svn version on Fedora 13.

Please run the test like that:
cd t
./t9119-git-svn-info.sh -i

This stop immediately after the failed test. Then, please tell us the
contents of the actual.. and expected... files in the trash... subdir.


Michael

> 
> Regards, Frank
> 
> PS: I hope I Cced the right group of people.

Eric's the svn guy, the rest is just other helpful people ;)
