From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] git: expand user path in --git-dir
Date: Tue, 25 Sep 2012 09:27:47 +0200
Message-ID: <50615CF3.2010802@drmicha.warpmail.net>
References: <5060588D.3080202@drmicha.warpmail.net> <fdeaa78c0a520ce80e6d2cb09978dab348104eaf.1348491039.git.git@drmicha.warpmail.net> <alpine.LNX.2.01.1209250732150.25195@nerf07.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jan Engelhardt <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 09:28:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGPYk-0005WV-RB
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 09:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab2IYH1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 03:27:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47544 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097Ab2IYH1t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Sep 2012 03:27:49 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EA7D72063E;
	Tue, 25 Sep 2012 03:27:48 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 25 Sep 2012 03:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=sTgYCvIfhm/3d5Xkp22q5L
	lQ3C0=; b=kTQV1J4S6bBBYO/ZD66rpDUCWhyMHm8oJvA2aAMO2sFivtV7ZkCUfi
	Ei96ZqmVzPnDybIrYEuGCtAOxACVzC9EKLhcQfkrJyDn/VDRV8a5JnaPi3r715K0
	4WdV1NGnmDH7ZLo4Dow6FPe6ZG+feXoDH41DO8fYK0TA0d7qcnpHM=
X-Sasl-enc: heGftZk6moC+6POuSYuU80leTrc2slzdcB4dZLJaOnLK 1348558068
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 629764827CB;
	Tue, 25 Sep 2012 03:27:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <alpine.LNX.2.01.1209250732150.25195@nerf07.vanv.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206352>

Jan Engelhardt venit, vidit, dixit 25.09.2012 07:33:
> 
> On Monday 2012-09-24 14:57, Michael J Gruber wrote:
> 
>> Currently, all paths in the config file are subject to tilde expansion
>> for user paths while the argument to --git-dir is not expanded, and
>> neither are paths in the environment such as GIT_DIR. From the user
>> perspective, though, the two commands
>>
>> GIT_DIR=~user/foo git command
>> git --git-dir=~user/foo command
>>
>> currently behave differently because in the first case the shell would
>> perform tilde expansion, but not in the second.
> 
> If git uses a standardized option logic (getopt-like) which accepts
> both '=' and (new argument) for long options, you could easily do
> 
> 	git --git-dir ~user/foo command

Of course, but wouldn't it be even more confusing if tilde expansion "is
done" for "--git-dir ~user/foo" but not "--git-dir=~user/foo"?

That confusion is all bash's "fault" since "is done" == "is done by
bash" (or not), but still.

Michael
