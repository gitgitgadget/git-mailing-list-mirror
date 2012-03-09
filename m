From: Phil Hord <hordp@cisco.com>
Subject: rerere.autoupdate that wouldn't
Date: Fri, 09 Mar 2012 17:34:40 -0500
Message-ID: <4F5A8580.1010807@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 09 23:34:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S68Oc-0003e9-N7
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 23:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162Ab2CIWem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 17:34:42 -0500
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:30356 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758041Ab2CIWem (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 17:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=887; q=dns/txt;
  s=iport; t=1331332482; x=1332542082;
  h=message-id:date:from:mime-version:to:subject:
   content-transfer-encoding;
  bh=7tOY6XeIW4HviGQ76dbNyH/ymCm0FxAaLtl8QRVDI0w=;
  b=jZy6088EeZgCgnoMhXgyWNiJTCs2N+qp831Zkj57o2Kn9xYc2x5KBlC4
   Qm2+p7Gv9odPZFpB3V8JBExzXw/Ee7i1L26SE1+M1WBDznn2C0QYRw2+a
   VnBZWW8vc6tSR47kGGmIrRPAW1w1782klnITJcZc04wMWOzH3RgvbECuy
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApUFAOyEWk+tJV2c/2dsb2JhbABCgxayKoEHgiMBZT0WGAMCAQIBSw0IAQEeh2iea4EnAZcOkHgEiFOMdoVmijaDAQ
X-IronPort-AV: E=Sophos;i="4.73,560,1325462400"; 
   d="scan'208";a="65257826"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-8.cisco.com with ESMTP; 09 Mar 2012 22:34:41 +0000
Received: from [10.117.80.109] (rtp-hordp-89112.cisco.com [10.117.80.109])
	by rcdn-core-5.cisco.com (8.14.3/8.14.3) with ESMTP id q29MYekn017061
	for <git@vger.kernel.org>; Fri, 9 Mar 2012 22:34:41 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192749>

So now I have rerere.autoupdate=true (living on the edge!), and today I
rebased a branch and git did a new thing: it added the automerged file
to the index like I expected. 

Then git did an unexpected thing.  It told me the merge had failed and
it asked me to clean it up.  There were no other conflicts; just this
one conflict that was already automerged and added to my index.

All I had to do was 'git rebase --continue' and off it went.

But I was hoping for more.  I was hoping that rebase would continue on
its own and quit bothering me with these triflings. 

Is this what is supposed to happen?  Should I look into adding
'rerere.autoContinue=true'?

Maybe instead, the sane thing would be to add 'rerere.autoTest=make
test'.  Then if rerere is so worried about messing up my rebase, he can
take a moment to do a build test to comfort his conscience.

Phil
