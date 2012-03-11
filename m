From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: --progress for git submodule update?
Date: Sun, 11 Mar 2012 21:50:05 +0100
Message-ID: <4F5D0FFD.1020509@web.de>
References: <CAOVFbFiBOH2MyC3HUtf=hA_PssSRENW7uwpBVxh0TwnO7h90XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Kees <cekees@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:50:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6pio-00084g-Lu
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 21:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab2CKUuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 16:50:13 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:38827 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab2CKUuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 16:50:11 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate05.web.de (Postfix) with ESMTP id D53046B3291B
	for <git@vger.kernel.org>; Sun, 11 Mar 2012 21:50:09 +0100 (CET)
Received: from [192.168.178.48] ([91.3.165.207]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LjJaZ-1Sd7vU2hax-00cdfA; Sun, 11 Mar 2012 21:50:07
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAOVFbFiBOH2MyC3HUtf=hA_PssSRENW7uwpBVxh0TwnO7h90XA@mail.gmail.com>
X-Provags-ID: V02:K0:O8I/HHg6J8aauI+joT+0B1F/p04jnDiaV4jOidVOxKw
 wI4CKSZfFqgDYyVydO93A6v9YvRTT/+rY/5DXp6MDePdGTHn4U
 nixqwn4dYvu3bvxFRsrKmFki8FIa2WR/58Gd0fDrLlSy17cj35
 6vks+UNu1L5AkZdsMZU6dS9lDhpkK0Llc1HExkFrQS8LljXtTd
 5t/J/iWyDt5RxIlm0+9Kg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192827>

Am 10.03.2012 08:17, schrieb Chris Kees:
> Would it be reasonable to have a --progress option for 'git submodule
> update'? I'm using buildbot with a git repository containing large
> submodules, and buildbot times out on the submodule update
> occasionally because there is no output for long periods of time.
> Adjusting buildbot's timeout factor will do for me in the short run.

As cloning a submodule talks a lot about its progress am I right
suspecting it is the checkout part that is taking so long for you?
The submodule script always uses the -q option for git checkout
(which also gets rid of the unwanted "detached HEAD" messages). So
AFAICS before a --progress option could be added to the submodule
script, git checkout would have to learn an option to show progress
but not the detached HEAD message (or to just suppress that advice).

What times are we talking about here?
