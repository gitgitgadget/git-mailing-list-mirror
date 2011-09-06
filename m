From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Linux 3.1-rc5
Date: Tue, 06 Sep 2011 09:23:39 +0200
Message-ID: <4E65CA7B.5050803@drmicha.warpmail.net>
References: <CA+55aFxDjVJwbpP5YT4o=qud=OcxtT3Ry4HfCtW-FvNdj+RFeQ@mail.gmail.com> <4E65307F.5020103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Sep 06 09:24:10 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1R0q0u-0006kb-2F
	for glk-linux-kernel-3@lo.gmane.org; Tue, 06 Sep 2011 09:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258Ab1IFHXr (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 6 Sep 2011 03:23:47 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56302 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752936Ab1IFHXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2011 03:23:41 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2EC1E23B18;
	Tue,  6 Sep 2011 03:23:41 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 06 Sep 2011 03:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=5Zn930oZNBfJwT9ohP+2Wd
	aNhZo=; b=aIwtT8tGlCXehLQOaJeS6s60uNKhOR+VCiJEJNRdGDTGv4Mm7FjRQC
	+CRTr3L8f9jylCmMrJhUDjevQBkwCJSUbtIlul/4ntpC8aZ782RCUfvNoaEh/w2l
	FlmXVHwxtwjz4tYMS8xU57xBRiJgzWkYqoF6Cfkr5uO0vTJ2bOr/g=
X-Sasl-enc: ZS6KzkKj/lW02Ap48BA1dk3dtV0YtrslZ9C7k5GqRb4l 1315293820
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5D9598206CA;
	Tue,  6 Sep 2011 03:23:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <4E65307F.5020103@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180773>

Mauro Carvalho Chehab venit, vidit, dixit 05.09.2011 22:26:
> Em 04-09-2011 20:27, Linus Torvalds escreveu:
> 
>> One thing to note: If you just do
>>
>>    git pull https://github.com/torvalds/linux.git
>>
>> you probably won't get the tags, since it's not your origin branch. So do
>>
>>    git fetch --tags<...>
>>
>> too, so that you get not only the actual changes, but the tag that you
>> can verify too.
>>
> 
> It would be great if "git remote update" could also verify the tag
> signature (if present), as most of us just do a "git remote update".

...when you should "git fetch --all" ;)

> Maybe an extra parameter for git config remote.tagopt?
> 
> Ok, if in doubt, we can always use git tag -v <new tag>, but doing
> it automagically would help us to detect if a git tag got mangled
> by some  at the moment we update our trees, with seems to be
> a good idea.

The update hook (if you want to reject falsified tags) or post-update
hook (if you want to be warned) is the perfect place for this. It would
be worth amending the standard update hook, me thinks, after removing
its insisting on a project description, and maybe switching the defaults.

Michael
