From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Need some help with git rebase
Date: Thu, 31 Dec 2009 12:06:01 +0100
Message-ID: <89AAB33C-89D4-46E9-A950-1CBFB4D2CBB3@wincent.com>
References: <4B38B3A7.6010900@steek.com> <1262211866.7068.1.camel@kheops> <CB5B49CA-0C66-4384-9B47-3675E517E203@wincent.com> <7fce93be0912301502r77152c52sbccf762fb6c44610@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Thu Dec 31 12:13:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQIyM-0003aC-Ty
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 12:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbZLaLNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2009 06:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbZLaLNi
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 06:13:38 -0500
Received: from outmail136059.authsmtp.com ([62.13.136.59]:57599 "EHLO
	outmail136059.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752086AbZLaLNi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 06:13:38 -0500
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Dec 2009 06:13:38 EST
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt7.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id nBVB6942009615;
	Thu, 31 Dec 2009 11:06:09 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id nBVB66wO002909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Dec 2009 11:06:08 GMT
Received: from [192.168.1.2] (231.Red-83-60-136.dynamicIP.rima-tde.net [83.60.136.231])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id nBVB61OY025586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 31 Dec 2009 06:06:05 -0500
In-Reply-To: <7fce93be0912301502r77152c52sbccf762fb6c44610@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: 7f3c6a85-f5fc-11de-80b9-0022640b883e
X-Report-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH aR8dAldYdwdEHQAR AmcBW1JeUFU/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSncOcxoH QWEeUht7dwwIf312 bQhlCHMIWhVycFsr RxgHCGwHMTJ9YGBN WV1YdwFWdgdKLBdN aQUxNiYHcRtSMy5w BAg2MngxMDFHYDtU XgFFIlMOCVwGFDcn SngA
X-Authentic-SMTP: 61633436303433.1015:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135945>

El 31/12/2009, a las 00:02, Sylvain Rabot escribi=F3:

> In fact I want to backport the commits of the feature branch into =20
> 12.72.1.
>
> I used git rebase because the drawings of the man page looked like =20
> that I
> wanted to do and it does except for the part it resets the head of my
> feature branch.
>
> But as you said the good behavior would be to cherry pick each =20
> commit of the
> feature branch and apply them into 12.72.1, right ?

Well rebasing is just a convenient way of cherry-picking a bunch of =20
commits, so it's probably the right tool for the job.

But as you've seen, it has the effect of "moving" or "transplanting" =20
the feature branch (replacing the old feature HEAD). If you really =20
want the original feature branch HEAD to continue existing after the =20
rebase you'll need to take some specific action to preserve it =20
beforehand (creating a temporary branch before doing the rebase like =20
Peter Baumann suggested) or restore it afterwards (using "git branch" =20
like I suggested).

But before you actually do that, I'd make sure that you actually have =20
a valid reason for keeping that branch around. Maybe wanting to =20
"backport" those commits onto various different branches might be a =20
valid reason. But it's worth thinking through because Git gives you =20
various tools for supporting different workflows (merging, rebasing, =20
cherry-picking) and they each have their use cases.

Cheers,
Wincent
