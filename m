From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v8 3/4] submodule: fix sync handling of some relative
 superproject origin URLs
Date: Tue, 05 Jun 2012 23:18:34 +0200
Message-ID: <4FCE77AA.6060005@web.de>
References: <1338716810-9881-1-git-send-email-jon.seymour@gmail.com> <1338716810-9881-4-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, j6t@kdbg.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 23:24:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc1Em-0007M2-7h
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 23:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab2FEVYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 17:24:19 -0400
Received: from mout.web.de ([212.227.17.12]:63145 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab2FEVYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 17:24:18 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jun 2012 17:24:18 EDT
Received: from [192.168.178.48] ([91.3.188.21]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MBkKF-1SjOrS3KKN-00AQom; Tue, 05 Jun 2012 23:18:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1338716810-9881-4-git-send-email-jon.seymour@gmail.com>
X-Provags-ID: V02:K0:A9qFdQnnxh3dTLr+vMXdH+Kc4Jd2vLi148ftA8sNS41
 beOa65b6sRIrJYxFctZ94RQsI0+tp9wJByXC0l8fHWKi8bUPr+
 KzHIHA/Y6OQbXYCH/ABOp52CZUqFhqPpTevkfRuWq9CcZvoMrQ
 DEFyBWePRFqv0ngAhcPo0n3Y4L1SYILP08XM/iYOGq/wlUUcx0
 rahSAjncyenyZAEq6X5zA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199293>

Am 03.06.2012 11:46, schrieb Jon Seymour:
> @@ -959,19 +985,32 @@ cmd_sync()
>  	while read mode sha1 stage sm_path
>  	do
>  		name=$(module_name "$sm_path")
> -		url=$(git config -f .gitmodules --get submodule."$name".url)
> +		# path from superproject origin repo to submodule origin repo

This comment is misleading as it only describes part of the truth, in a lot
of cases it'll just be an absolute URL of the submodule.

> +		module_url=$(git config -f .gitmodules --get submodule."$name".url)

And I see no real value of renaming "url" to "module_url" here (but maybe
that is just me).

So I'd vote for dropping that comment and the "url" to "module_url" change.
But apart from that and the issues Junio mentioned in his response this
series is looking good to me.
