From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC PATCH 3/3] grep: add support for grepping in
	submodules
Date: Thu, 30 Sep 2010 20:59:37 +0200
Message-ID: <20100930185937.GA15457@book.hvoigt.net>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-4-git-send-email-judge.packham@gmail.com> <4CA3BBD7.3090006@web.de> <4CA3C569.4020309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 20:59:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1OM4-0004Eu-Py
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 20:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703Ab0I3S7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 14:59:40 -0400
Received: from darksea.de ([83.133.111.250]:40616 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751317Ab0I3S7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 14:59:39 -0400
Received: (qmail 25147 invoked from network); 30 Sep 2010 20:59:37 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 30 Sep 2010 20:59:37 +0200
Content-Disposition: inline
In-Reply-To: <4CA3C569.4020309@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157702>

Hi,

On Wed, Sep 29, 2010 at 04:02:01PM -0700, Chris Packham wrote:
> On 29/09/10 15:21, Jens Lehmann wrote:
> > Am 29.09.2010 22:28, schrieb Chris Packham:
> >> When the --recurse-submodules option is given git grep will search in
> >> submodules as they are encountered.
> > 
> > As "git clone" already introduced a "--recursive" option for
> > submodule recursion IMO "--recursive" should be used here too for
> > consistency. (Maybe you took the idea to use "--recurse-submodules"
> > from my "git-checkout-recurse-submodules" branch on github? But that
> > is only used there because I didn't get around to change it yet like
> > I did in the "fetch-submodules-too" branch).
> 
> I actually started with --recursive and switched to
> --recurse-submodules. One thing with this is the standard grep
> --recursive option which may cause some confusion if people expect git
> grep to behave like normal grep. I'll switch to using --recursive for
> now until someone objects to the potential confusion.

How about dropping the option all together and making grep search all
populated submodules by default and maybe have an option to turn it off.
Since git grep is searching recursive by default this would be what I
would expect as a user. Are there other reasons to turn off the search
in submodules than the potential runtime penalty because of forks? 

> One more thought on this that has been hanging around in my mind. I
> sometimes want to do something on all but one submodule, in this case
> with grep I'm fairly likely to want to skip a linux repository because I
> already know the thing I'm looking for is in userland. Maybe in the
> future we can make --recursive take an argument that allows us to
> specify/restrict which submodules get included in the command invocation.

Thinking about this how about not providing a disable submodule
recursion option at all? Just provide an --exclude option and let it be
used transparently for both normal subfolders and submodules?

Cheers Heiko
