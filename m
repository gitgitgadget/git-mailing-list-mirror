From: Jeff King <peff@peff.net>
Subject: Re: Looking for a way to turn off/modify ref disambiguation
Date: Tue, 23 Aug 2011 17:15:36 -0400
Message-ID: <20110823211536.GA7759@sigill.intra.peff.net>
References: <CAPRoxBXjL3Y3KRd8R2guX9Ar374sw-pBhz1bCzNZxn1vC6XNPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 23:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvyK0-0000Vb-HM
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 23:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab1HWVPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 17:15:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44673
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948Ab1HWVPi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 17:15:38 -0400
Received: (qmail 28374 invoked by uid 107); 23 Aug 2011 21:16:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Aug 2011 17:16:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Aug 2011 17:15:36 -0400
Content-Disposition: inline
In-Reply-To: <CAPRoxBXjL3Y3KRd8R2guX9Ar374sw-pBhz1bCzNZxn1vC6XNPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179971>

On Tue, Aug 23, 2011 at 02:26:48PM -0500, Nathan W. Panike wrote:

>        1.          If $GIT_DIR/<name> exists, that is what you mean
> (this is usually useful only for HEAD, FETCH_HEAD, ORIG_HEAD,
> MERGE_HEAD and CHERRY_PICK_HEAD);
>        2.          otherwise, refs/<name> if it exists;
>        3.          otherwise, refs/tags/<refname> if it exists;
>        4.          otherwise, refs/heads/<name> if it exists;
>        5.          otherwise, refs/remotes/<name> if it exists;
>        6.          otherwise, refs/remotes/<name>/HEAD if it exists.
> ...
> 
> Is there any way to change this behavior, e.g., so that rule 6 becomes
> an error? Say, by setting a config option?

You can remove the remote HEAD reference with:

  git remote set-head origin -d

That will only fix that particular repo, though. There is no config
option to disable it for all newly cloned repos.

-Peff
