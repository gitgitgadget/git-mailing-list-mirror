From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 16:56:02 +0100
Message-ID: <50BA2892.7060706@web.de>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de> <20121130175309.GA718@odin.tremily.us> <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 16:57:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TepQW-0004uu-GT
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 16:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab2LAP4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 10:56:08 -0500
Received: from mout.web.de ([212.227.15.4]:56528 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986Ab2LAP4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 10:56:07 -0500
Received: from [192.168.1.4] ([88.74.133.139]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0M5OaF-1THg2007yx-00zBVc; Sat, 01 Dec 2012 16:56:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:mYn6xa1ekyOteRjy0pJZoZ88DIQzBaFtW6fTe8FetpF
 P8Et196A942FAiCIKdcsqWrgutJUS6G8ke3g+YHOQRCN6IBhQR
 jAu7OlRVgK/jk1vmtXIRkEotJ/6ase/4UDyHbfIiyaF45bATQQ
 yxxirzMIH2jJFNMKS+VzFHw5P+WJNPSUBDijTkmFoJ7/oMUFN1
 fDNsLJUgIA/ZrqZaQxswg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210975>

Am 01.12.2012 00:52, schrieb Phil Hord:
> If I never 'submodule init' a submodule, it does not get visited by
> 'git submodule foreach', among others.  I think some people use this
> behavior explicitly.
> 
> On the other hand, I've also notice that a submodule which I have
> removed does not get de-inited later one.  It causes my 'git submodule
> foreach' to emit errors.  :-(

I'm currently hacking on "git submodule deinit" which removes the 'url'
setting from git/config. This should do the trick for you, right?

Just removing that submodule automagically would not work that well, as
it would deinitialize a submodule when you switch to a branch where it
isn't present and you'd have to reinitialize it when you come back.
