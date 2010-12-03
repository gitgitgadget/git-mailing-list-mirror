From: Jeff King <peff@peff.net>
Subject: Re: cannot find hash in the log output
Date: Fri, 3 Dec 2010 16:11:58 -0500
Message-ID: <20101203211158.GA2632@sigill.intra.peff.net>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
 <7v8w07rje3.fsf@alter.siamese.dyndns.org>
 <AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
 <AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
 <20101203175212.GA8267@sigill.intra.peff.net>
 <AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:12:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcvJ-0007eL-Vr
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab0LCVME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 16:12:04 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43098 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659Ab0LCVMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 16:12:03 -0500
Received: (qmail 26094 invoked by uid 111); 3 Dec 2010 21:12:00 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.205)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 03 Dec 2010 21:12:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Dec 2010 16:11:58 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162857>

On Fri, Dec 03, 2010 at 03:10:40PM -0500, Eugene Sajine wrote:

> Yes this does make sense to me. Although it is not necessary to have
> conflicts during the merge - recursive merge as i understand also can
> create new blobs.

I haven't thought about it too hard, but I don't see why any merge would
create a new blob unless there is a conflict. Otherwise you are always
taking one of the blobs that already exists in some other part of
history.

> Now as this is pretty much clear: don't you think that the information
> about one blob content changed during the merge should be present in
> the merge commit info?

No. We suppress "uninteresting" parts of merges by default because they
are mostly clutter. If you really want to see them, use "-m".

> It seems strange that git log <filename> contains merge commit, but
> git whatchanged <filename> doesn't show the merge commit, while this
> merge commit actually had a change of content in the file,

The fact that git whatchanged does not show merge commits by default is
just historical. There is really no need for whatchanged to exist at all
these days, now that "git log" can do diffs internally. In fact, it is
simply implemented these days as "git log" with a few different
defaults.

-Peff
