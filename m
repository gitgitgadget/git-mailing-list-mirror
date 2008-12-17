From: Pete Wyckoff <pw@padd.com>
Subject: Re: New script to convert p4 repositories to git - git-p4c version
	1.
Date: Wed, 17 Dec 2008 09:04:19 -0500
Message-ID: <20081217140419.GA25761@osc.edu>
References: <1228818317.5504.23.camel@localhost> <20081215193058.GA5098@osc.edu> <1229377952.18839.11.camel@therock.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Chapman <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Wed Dec 17 15:06:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCx29-0002o2-13
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 15:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbYLQOEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 09:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbYLQOEW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 09:04:22 -0500
Received: from marge.padd.com ([99.188.165.110]:33444 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbYLQOEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 09:04:21 -0500
Received: from oink.padd.com (oink.padd.com [69.36.12.13])
	by marge.padd.com (Postfix) with ESMTPSA id 899D510F8186;
	Wed, 17 Dec 2008 06:02:08 -0800 (PST)
Received: by oink.padd.com (Postfix, from userid 7770)
	id B360AFD4164; Wed, 17 Dec 2008 09:04:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1229377952.18839.11.camel@therock.nsw.bigpond.net.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103351>

thestar@fussycoder.id.au wrote on Tue, 16 Dec 2008 08:52 +1100:
> On Mon, 2008-12-15 at 14:30 -0500, Pete Wyckoff wrote:
> Modifying the on_branch code is the right place to do what you want,
> however I was hoping that specifying your 'interesting' branches by
> regexp would be sufficient?  All those places that do not get matched
> are effectively ignored and do not become part of the git repo.
[..]
> Do you need to use a client spec here, or is it possible to just use
> regexps?  I'd like to try and avoid the need to parse the clientspec,
> that's all.

There is code to parse the client spec in git-p4, and I did hack it
to put the various depot contents in the git tree according to where
the spec says they go.  Not a big hassle, and will do the same for
git-p4c if needed.  (Not clean enough or tested with non-client-spec
configs to submit upstream for git-p4 though.)

> The script does try to import the full history, however it starts that
> history only at the most recent change, which is defined as a tag.
> 
> Thus, if your main branch is 'trunk', then you should be able to
> manually import your changes, tag it as 'trunk/102388', to indicate
> that's p4's revision 102388 of trunk, and the script should then begin
> checking out changeset 102389.  I haven't had a chance to test that
> theory yet, but it should work.

Okay, this is interesting.  Would like to pursue that approach.
Except for the "manually import" part.  Maybe bits of git-p4's
full-checkout model could be borrowed here?  Anyway, will take a
look when you're ready.

		-- Pete
