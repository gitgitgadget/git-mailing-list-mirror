From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 16:42:55 +0100
Message-ID: <50BA257F.9070607@web.de>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de> <20121130175309.GA718@odin.tremily.us> <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com> <20121201124842.GA32291@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Dec 01 16:43:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TepEB-0006Ls-Js
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 16:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab2LAPnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 10:43:24 -0500
Received: from mout.web.de ([212.227.17.11]:61583 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852Ab2LAPnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 10:43:23 -0500
Received: from [192.168.1.4] ([88.74.133.139]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MKrU4-1TepDU3oHo-0006Fe; Sat, 01 Dec 2012 16:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121201124842.GA32291@odin.tremily.us>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:26fLw9kuILsJCDFfQDp2w2/qlBxi2nj80GoTE97uv2B
 T+xDHqOdXG9ZZ667IaLeN9prlWDb4yKHaaqQmjTaLZfSr37rKS
 KRMPOTcT7deu5lJZS4LRyvElPYf0Ea3areueRX4a+exrDjdrn3
 1KcRWOIiLFkQhT8kypK7bmkHoeUlBGwJgcSJ6Dlqa78eeEodO+
 wseZvtMl0idQvdSaOpJnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210973>

Am 01.12.2012 13:48, schrieb W. Trevor King:
> On Fri, Nov 30, 2012 at 06:52:22PM -0500, Phil Hord wrote:
>> If I never 'submodule init' a submodule, it does not get visited by 'git submodule foreach', among others.  I think some people use this behavior explicitly.
> 
> This is something I'll fix while working up a trial patch.  Currently cmd_update calls module_clone if the <submodule>/.git does not exist. This should probably happen in each command (in a wrapper around module_list?).  It's possible that module_list itself would need some work, but I haven't absorbed its implementation yet [1].

Please do not fix it, this is a feature. "update" is the only command
where that should happen (and only if "url" is set in .git/config, as
I explained in my other mail). So everything should be fine here.
