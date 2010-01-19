From: tzachi perelstein <tzachi_perelstein@yahoo.com>
Subject: git-describe recognize modified files
Date: Tue, 19 Jan 2010 01:53:03 -0800 (PST)
Message-ID: <829260.92036.qm@web45202.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 10:59:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXAsK-0000uO-2C
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 10:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab0ASJ7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 04:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489Ab0ASJ7q
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 04:59:46 -0500
Received: from web45202.mail.sp1.yahoo.com ([68.180.197.59]:45248 "HELO
	web45202.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754906Ab0ASJ7p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2010 04:59:45 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2010 04:59:45 EST
Received: (qmail 92286 invoked by uid 60001); 19 Jan 2010 09:53:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1263894783; bh=1O50kit4jgjl4JM0+mI65CUhPowjnb130IIcWPUNp4Y=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=YjofLSqFLMpQYFsi7iIm/KyBc2IvxOtzReA4Ge78/JwAJx/0FwCLjGnb+8cl/7U3fLEBEqaS64ECtPUbM1rwbsyls9vB++kA7qM7ZOgro59dMnFx5rKloACjJs+5yWElejWM+/uxcbo0A71edREQXDLOADz3i+aQIn+rG8G6xZI=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=Mq75CTgJylWA18vRVWibbiXPeviwvWDazgFxAZtALARxqMPuwCkQJ5LlgqR9wuz+Si/vrcKEKKeYb75nrdmUQ8D88RXTdExTm1dS/JzgJKmTyosqt/+mvjoudzvWMzkRM/TUEFeoeJ7EzfrtRlv9RvhZI3qLuqCW/QFpydvONWs=;
X-YMail-OSG: 3eL3fxwVM1m_fqQ2RUu_MXDue0zTCvO2KjcJlE0dDO3p5CPBU96vMD1YnKH2171MrvQskvAItGH1KfzNtYFrN4v4_Tr5LgjWmb.s0LAKjVWnXbYII5orog9AyCwnq46w.BMG1Yyx6ba7Zt0EwqOpdpcv3oS72UIs9f4nywkpzYUkZWYB9Ab_.bzdGItSEYFlO2Fhq7k_dtp8GJQIuzW43XjEoZX8aRN80GQ_9uca.ZRMgBOPQtth6I0FxG_jZA3CSck-
Received: from [80.179.89.178] by web45202.mail.sp1.yahoo.com via HTTP; Tue, 19 Jan 2010 01:53:03 PST
X-Mailer: YahooMailClassic/9.0.20 YahooMailWebService/0.8.100.260964
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137446>

I use git-describe to form a build version automatically. This allows me
to deliver temporary builds for testing without having to make manual
tags for them. The only thing that bothers me about this is that from
the output of git-describe I cannot tell if there are some modified
files in tree or not. In both cases I will get the same version. 

To solve this issue, in addition to git-describe, my do_version script
also run git-status, and if there are "modified:" files then it
concatenates the string "+dirty" to output of git-describe. This way by
looking at the version I'm able to know whether a specific version is
valid (checkout-able) or not.

It would be nice to have this option supported in git-describe IMO. I'm willing to implement that and submit a patch for review, but I'd like to hear your opinion first. 

Tzachi



      
