From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Bug: Recursive submodules fail when the repo path contains spaces
Date: Tue, 24 Jul 2012 22:08:39 +0200
Message-ID: <500F00C7.4040209@web.de>
References: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Justin Spahr-Summers <justin.spahrsummers@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:08:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StlPY-00018O-KX
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 22:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab2GXUIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 16:08:47 -0400
Received: from mout.web.de ([212.227.17.12]:55749 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711Ab2GXUIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 16:08:46 -0400
Received: from [192.168.178.48] ([79.193.90.49]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MPY5x-1SxuHK3D85-004v2p; Tue, 24 Jul 2012 22:08:44
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com>
X-Provags-ID: V02:K0:SvOJJie/M/Zg3kpWjOxvM+eAF0uekCO1+Kh+kXjOD/f
 FHv/NweHvyPwtRTtaNTOV0pG9CUrj9kBTrZ7AKEGGF3VMysVJh
 gtjFny8iuAaB2ykRPble9+Tl57eZV/ipZzS3i9TpXNKz8DmUaj
 UyGAVInWBYaAaAghisWK9ttq5nB2NZzI+RTB6jNSY5aGLZTEpl
 DDtNq3eGnq9RofbupG34w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202064>

Am 24.07.2012 21:01, schrieb Justin Spahr-Summers:
> This occurs on Mac OS X 10.7.4, on git versions 1.7.10.2 (Apple Git-33) and 1.7.11.3.
> 
> Steps:
>  1. Create or clone a repository to an absolute path that contains spaces.
>  2. Add a submodule to the repository, if it does not already have one.
>  3. Within that submodule, attempt to add another submodule.
> 
> The result is an error "fatal: Not a git repository", followed by the relative path to the submodule directory within .git/modules of the top-level repository.
> 
> Similarly, using "git submodule update --init --recursive" in a freshly-cloned repository that matches the above configuration will fail with the same error. "git clone --recursive" does not seem to suffer from the same problem at clone time, but will still fail to add recursive submodules.

Hmm, I don't understand how that is different from what t7407 does, it uses
"git submodule update --init --recursive" in to populate recursive submodules
in a freshly cloned repository whose path contains a space (in the trash
directory name) in test number 8.

Does the git test suite succeed for you?
