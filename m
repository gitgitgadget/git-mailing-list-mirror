From: Jeff King <peff@peff.net>
Subject: Re: git log omits deleting merges
Date: Fri, 21 Mar 2014 01:23:12 -0400
Message-ID: <20140321052312.GB31161@sigill.intra.peff.net>
References: <5305B045.2060503@gmail.com>
 <20140320195404.GA19252@sigill.intra.peff.net>
 <BC292A8591EF4E8AB1E553FBF6ECC336@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ephrim Khong <dr.khong@gmail.com>, Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:23:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQrvM-0002Hm-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 06:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838AbaCUFXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 01:23:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:43798 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752498AbaCUFXO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 01:23:14 -0400
Received: (qmail 14109 invoked by uid 102); 21 Mar 2014 05:23:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Mar 2014 00:23:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Mar 2014 01:23:12 -0400
Content-Disposition: inline
In-Reply-To: <BC292A8591EF4E8AB1E553FBF6ECC336@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244640>

On Thu, Mar 20, 2014 at 10:56:58PM -0000, Philip Oakley wrote:

> >This is by design. Git-log does not calculate or show merge diffs
> >unless
> >"-c" or "--cc" is specified, and thus no diff-filter can match.
> 
> This is hard to discern from the log(1) man page as this conflates
> commit inclusion (limiting?) with the diff formatting.
> 
> The -c and -cc options are listed in the diff formatting section, but
> that's well down the man page. Even then, the note for the options doesn't
> say that it will cause the log output to now include the merge commits.

Merge commits are always considered. But we don't show merge _diffs_
without "-c" or "--cc". And they cannot match a diff-filter if we don't
calculate the diffs.

That being said, I can certainly imagine there is room for improvement
in the documentation.  The --diff-filter option is in the "diff options"
section, but perhaps the top of that section might want to make special
mention of "-c" and "--cc"?

-Peff
