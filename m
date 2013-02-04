From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [New Feature] git-submodule-move - Easily move submodules
Date: Mon, 04 Feb 2013 21:14:31 +0100
Message-ID: <511016A7.7010005@web.de>
References: <510EE661.8060600@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "W. Trevor King" <wking@tremily.us>
To: TJ <git@iam.tj>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:15:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2SRP-0000yw-MN
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 21:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417Ab3BDUOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 15:14:37 -0500
Received: from mout.web.de ([212.227.15.3]:51037 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131Ab3BDUOg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 15:14:36 -0500
Received: from [192.168.178.41] ([91.3.191.145]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LhvyA-1Ugkzj1TgQ-00mVLJ; Mon, 04 Feb 2013 21:14:33
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <510EE661.8060600@iam.tj>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:ujjbTmgDxw/sVuqpRpDoE+qcynTV7JDF97OrY5pjuZI
 jEPYwyjBmE0qvdonWL7XNJoFpGQC6c2wmjKeu6ghCYzXKv+3g6
 ACxemHPTDce5acr8bVQKMinjrSZ179iutVL/fHwRp5sRlLEsc3
 p9EUCe4jBR0tR3ZTvwgg4NSMjxBOmnSqWJYQ+WIjjfqG+cnWpa
 12e4UilQdt0G1zOiHb6Fw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215416>

Am 03.02.2013 23:36, schrieb TJ:
> I've recently had need to re-arrange more than ten submodules within a project and discovered there is apparently no easy way to do it.
> 
> Using some suggestions I found on Stack Overflow I eventually figured out the steps required. Because the steps can be
> complex I thought it would be handy to have a tool to automate the functionality.
> 
> I have put together a reasonably bullet-proof shell script "git-submodule-move" that does the job pretty well. I've put it through quite a bit of testing and trusted it with my own project and it has
> performed well.
> 
> I've published to github so others can use and improve it.
> 
> https://github.com/iam-TJ/git-submodule-move

I'd propose to drop these two steps:
 updating super-repository's submodule name
 moving super-repository's submodule repository

Changing the name makes the moved submodule a completely new entity and will
lead to a reclone of the repository as soon as recursive checkout materializes.
And Trevor already mentioned the long term solution which is to teach "git mv"
to do all that, which is next on my list.
