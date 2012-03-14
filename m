From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: --progress for git submodule update?
Date: Wed, 14 Mar 2012 20:42:30 +0100
Message-ID: <4F60F4A6.1070507@web.de>
References: <CAOVFbFiBOH2MyC3HUtf=hA_PssSRENW7uwpBVxh0TwnO7h90XA@mail.gmail.com> <4F5D0FFD.1020509@web.de> <CAOVFbFhMfpFa5=a0Z50H7nHdQFHn9Y4ApUnQJq6GCOFP+AKy5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Kees <cekees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 20:42:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7u5k-0000EJ-Vb
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756968Ab2CNTmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 15:42:32 -0400
Received: from fmmailgate06.web.de ([217.72.192.247]:41267 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab2CNTmc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 15:42:32 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate06.web.de (Postfix) with ESMTP id B1904EF1385
	for <git@vger.kernel.org>; Wed, 14 Mar 2012 20:42:30 +0100 (CET)
Received: from [192.168.178.48] ([91.3.202.6]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MXYjm-1RnQtE1TbK-00WZhh; Wed, 14 Mar 2012 20:42:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAOVFbFhMfpFa5=a0Z50H7nHdQFHn9Y4ApUnQJq6GCOFP+AKy5A@mail.gmail.com>
X-Provags-ID: V02:K0:dR/j43myv8VeWVAlmp31Uu1XJpbdwM6Ei/tDtr9+NsW
 /SE6jFuJmfDHChFKAyDzJ1Xv9nMudF+VpZeHTdhr91utnC8vcp
 DpUk7+EyAIJmNk8uNLKPvS5RrNLp8tKoiDg21XxDkngxDo9hcX
 jofUIJlTcAwOKCWa4choW3NYXXZbXZRfcYNioa8tziUjLHucxn
 +8bgsMkZ4IxLs1vvMCmqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193155>

Am 13.03.2012 03:17, schrieb Chris Kees:
> It's 'git submodule update --recursive' that is taking so long
> silently.  The problem is mainly on the first time. There are about 10
> submodules that together have taken more than 30 minutes. It's not
> really just the amount of data, I think there are also network traffic
> issues that slow things down on some systems.

I suppose with "first time" you mean right after "git submodule init",
when the submodules have to be cloned initially? Thinking about that
again, you mentioned a buildbot doing all that. When the submodules
are updated from a script, no progress output is shown at all and only
the line "Cloning into 'xxx'..." will appear for each submodule, which
explains why you don't see output for quite some time.

So I suspect increasing the timeout on your buildbot is the way to go,
as progress output is intended for humans.
