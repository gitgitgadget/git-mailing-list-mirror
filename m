From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [RFC PATCH 0/2] submodule aware grep
Date: Fri, 24 Sep 2010 15:47:49 +0200
Message-ID: <20100924134748.GA576@book.hvoigt.net>
References: <1285276627-7907-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 15:50:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz8fm-00058D-8I
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 15:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756356Ab0IXNrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 09:47:52 -0400
Received: from darksea.de ([83.133.111.250]:49294 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753125Ab0IXNrw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 09:47:52 -0400
Received: (qmail 32245 invoked from network); 24 Sep 2010 15:47:48 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Sep 2010 15:47:48 +0200
Content-Disposition: inline
In-Reply-To: <1285276627-7907-1-git-send-email-judge.packham@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156987>

Hi,

On Thu, Sep 23, 2010 at 02:17:05PM -0700, Chris Packham wrote:
> This series contains 2 RFC patches that both implement a grep feature for
> submodules.  The first patch is a self-contained script for contrib that should
> work with most current git versions. The 2nd is basically the same
> implementation but done as a proper git submodule command with some of the
> helper code moved to git-sh-setup.sh
> 
> There are a couple of questions for this. Technically I'm making submodule 
> grep-aware, should I be making grep submodule-aware instead? I haven't looked 
> at the grep code yet but I imagine its harder.

Nice work! IMO it would be even nicer to have it as part of git grep.
Have a look at Jens branch about submodule checkout:

http://github.com/jlehmann/git-submod-enhancements (enhance_git_for_submodules)

particularly how checkout_submodule() is implemented. It forks a git
checkout inside the submodule. In a similar way you could fork a grep
there. Then you just have to teach the forked grep to prepend the
submodules path.

Cheers Heiko
