From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git clean is not removing a submodule added to a branch when
 switching branches
Date: Mon, 20 Feb 2012 21:36:55 +0100
Message-ID: <4F42AEE7.9060103@web.de>
References: <CAGc=MuDrE_1CVzOsqcodhadcfajaa-BHjHVAp9mFDNbU=wVQqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adrian Cornish <git@bluedreamer.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 21:46:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rza7t-0000qH-Od
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 21:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab2BTUqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 15:46:21 -0500
Received: from fmmailgate06.web.de ([217.72.192.247]:40843 "EHLO
	fmmailgate06.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab2BTUqU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 15:46:20 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Feb 2012 15:46:20 EST
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate06.web.de (Postfix) with ESMTP id 56878C418FA
	for <git@vger.kernel.org>; Mon, 20 Feb 2012 21:36:56 +0100 (CET)
Received: from [192.168.178.48] ([91.3.176.249]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Lwq0e-1SWTvz2Wy0-016Jd7; Mon, 20 Feb 2012 21:36:55
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAGc=MuDrE_1CVzOsqcodhadcfajaa-BHjHVAp9mFDNbU=wVQqQ@mail.gmail.com>
X-Provags-ID: V02:K0:BB2rOOxjkEU2A7w5hbsA6+JCNhj2Y/cOMNhdpAvFFpJ
 2TN8HxjfmH+Km9Z8ukysFfM9j3MP9yloLk9iKWk7c4FSvSCRxY
 yaf6A4vIcPs/MJRRJ+ymC79l3zoTwfHWm0cKLDLLOensJMv0Rk
 Nylk/s+Tgs0By2GRUDMr7bDoT4qRsoB7uU9Hr25kxmYLM3nVFh
 /DWGF6qcvUXX2/dfz/s7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191101>

Am 18.02.2012 22:27, schrieb Adrian Cornish:
> If I add a submodule to a branch and then switch branches, git
> checkout warns it cannot
> remove the submodule. If I then issue a git clean - it says it removes
> the submodule but
> in fact does nothing at all. Is this a bug or expected behaviour.

Right this is just how things work. I won't call it expected behavior,
as some users (like you) would expect to see the submodule be removed
(while others are used to the current behavior that submodule work
trees are never touched).

But one of last years GSoC projects took first steps into the
direction of safely removing submodules (without losing any history).
I have experimental code at my Github repo [1] to update submodule
work trees along with the superproject, but polishing that for
inclusion into mainline will still take some time.

[1] https://github.com/jlehmann/git-submod-enhancements
