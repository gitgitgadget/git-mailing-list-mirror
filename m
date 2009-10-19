From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Unapplied patches reminder
Date: Mon, 19 Oct 2009 10:10:50 +0200
Message-ID: <20091019081050.GB44290@book.hvoigt.net>
References: <20091019052030.6117@nanako3.lavabit.com> <7vbpk4i8ii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 10:10:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MznKT-00089t-Hv
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 10:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbZJSIKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 04:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572AbZJSIKr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 04:10:47 -0400
Received: from darksea.de ([83.133.111.250]:58105 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754160AbZJSIKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 04:10:47 -0400
Received: (qmail 15419 invoked from network); 19 Oct 2009 10:10:50 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 19 Oct 2009 10:10:50 +0200
Content-Disposition: inline
In-Reply-To: <7vbpk4i8ii.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130676>

On Sun, Oct 18, 2009 at 04:31:49PM -0700, Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
> > ...
> > From:	Heiko Voigt <hvoigt@hvoigt.net>
> > Subject: [PATCH] fix testsuite to not use any hooks possibly provided by source
> > Date:	Wed, 23 Sep 2009 20:30:28 +0200
> > Message-ID: <20090923183023.GA85456@book.hvoigt.net>
> >
> >     This is useful if you are using the testsuite with local changes that
> >     include activated default hooks suitable for your teams installation.
> 
> This may be useful when Heiko or somebody actually has changes that needs
> this fix, but otherwise was an unnecessary code churn during pre-release 
> code freeze.  I am reasonably sure that Heiko will include it in a series
> that requires this one.
> 
> In other words, I am not against it per-se, but I would prefer to see
> patches that actually depends on this change at the same time.  Otherwise
> this "is supposed to be no-op, and promises it will help in the future",
> and needs extra mental effort to validate the latter claim.

Well, currently we do not have any activated hooks. They are all sample.
And because the use scenarios for git are so diverse we will probably
never have any default hook activated.
But I imagine that if you are creating a default installation for any
team you will activate some. For an example take this patch:

http://thread.gmane.org/gmane.comp.version-control.git/110874

it is not in master because it was to specific but I have such a hook
activated. It does not allow you to commit on master which breaks the
testsuite.

So in my opinion we should not run the testsuite with hooks even though
the current defaults are all deactivated.

I am afraid that I will never be able to persuade everyone on the list
to not commit on master... ;)

cheers Heiko

P.S.: Just thinking of previous hooks, I might make it an option like
      hooks.doNotCommitOnMaster. But still the hooks would be
      deactivated.
