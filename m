From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Installing on AIX fails
Date: Thu, 03 Jun 2010 18:12:13 +0200
Message-ID: <4C07D45D.50503@drmicha.warpmail.net>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 18:13:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKD2W-0006Ie-9v
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 18:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab0FCQMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 12:12:37 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:41993 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752004Ab0FCQMf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 12:12:35 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 57A4FF846B;
	Thu,  3 Jun 2010 12:12:34 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 03 Jun 2010 12:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3PU9mfBNvX6OJB4MyvInDZdQhgY=; b=WroEBXEhx3ooMwRmTRFgzqAQlnAwozko7cKN96VkPe/Te14Ryh/OfGK4Limv3zS5/eHkKz9gtZxBr1dbXPYwMhyWOAyKKZ0mofsvczw5SiX5uLXW4hdkMKC+u/6wIbUUBXMlIsV8WheXEv/9YWpD4MVa3D+aiV/xyxZR/cTGx0w=
X-Sasl-enc: g2AaWqsBUqEVOAp/MVVdEK2IF3OEPAOqAa56HRqf80fU 1275581554
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C036549BCE;
	Thu,  3 Jun 2010 12:12:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148343>

Dario Rodriguez venit, vidit, dixit 03.06.2010 17:32:
> Hi all,
> 
> I was trying to install git in a development and testing server we
> have. The first problem was that AIX 'make' tool does NOT support
> conditionals in makefiles, and display errors such...
> 
> 
> [...]
> "Makefile", line 1003: make: Dependency line needs colon or double
> colon operator.
> "Makefile", line 1007: make: Dependency line needs colon or double
> colon operator.
> "Makefile", line 1009: make: Dependency line needs colon or double
> colon operator.
> "Makefile", line 1011: make: Dependency line needs colon or double
> colon operator.
> [...]
> 
> 
> ... until I get stucked. Well, I solved this by just using GNU make,
> then I compile:
> 
> 
> $ /usr/linux/bin/make prefix=$HOME/apps/ NO_OPENSSL=1 NO_TCLTK=1
> NO_EXPAT=1 PYTHON_PATH=/usr/local/bin/python
> 
> 
> and it all works, with angels singing and everything... a testing repo
> works fine for a test drive without installing, excepting 'git log'
> that just don't display anything.
> Now, when I feel good to install it...
> 
> 
> $ /usr/linux/bin/make prefix=$HOME/apps/ NO_OPENSSL=1 NO_TCLTK=1
> NO_EXPAT=1 PYTHON_PATH=/usr/local/bin/python install
> 
> [...]
> install -d -m 755 '/myhomedir/apps/bin'
> getopt: illegal option -- d
> Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
>                [-G group] [-S] [-n dirc] [-o] [-s] file [dirx ...]
> make: *** [install] Error 2
> 
> 
> 
> Now the installing process fails because of the AIX 'install' tool and
> I wonder, can I patch/configure the installing process for AIX? May be
> a set of utils for building in such systems would help some people.

AIX tools are a pain in the back end. If you want to compile & install
anything GNU there you need better tools. In case of install, there's
often something in /usr/ucb or /usr/ccs.

Are you using gcc or xlc btw?

> 
> PD: If you don't understand me please let me know it and I will try
> again : )  My english could be horrible since I'm Argentinian.

It's certainly good enough!

> PD2: I don't know if AIX python path is always /usr/local/bin/python,
> but I've seen that git Makefiles set /usr/local/bin/python for FreeBSD
> only:
> 
> git_remote_helpers/Makefile:
> ifndef PYTHON_PATH
>         ifeq ($(uname_S),FreeBSD)
>                 PYTHON_PATH = /usr/local/bin/python
>         else
>                 PYTHON_PATH = /usr/bin/python
>         endif
> endif
> 
> I think 'test' the file is a good way for auto-configuration.

You don't need to worry about python for git right now. It's set up for
a few things which are yet to come.

Cheers,
Michael
