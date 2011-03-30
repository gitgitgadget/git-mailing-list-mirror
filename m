From: Mike Hommey <mh@glandium.org>
Subject: Re: remote-helpers and refs without a value
Date: Wed, 30 Mar 2011 08:25:04 +0200
Message-ID: <20110330062504.GA3559@glandium.org>
References: <20110327082428.GA4428@glandium.org>
 <AANLkTi=cNin=XYqbAJMggWj7OcZ8=9PGCVGGg=JRO-bj@mail.gmail.com>
 <20110328075009.GA5115@glandium.org>
 <AANLkTikVPevgKGf2B881ox0zZ5xqBLd9hH1pQF2pW2Jx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 08:25:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4oqD-0005cp-Ot
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 08:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab1C3GZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 02:25:10 -0400
Received: from vuizook.err.no ([85.19.221.46]:48155 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672Ab1C3GZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 02:25:09 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=glandium.org)
	by vuizook.err.no with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mh@glandium.org>)
	id 1Q4oq1-0007pz-D0; Wed, 30 Mar 2011 08:25:06 +0200
Received: from mh by glandium.org with local (Exim 4.74)
	(envelope-from <mh@glandium.org>)
	id 1Q4oq0-0000xU-PY; Wed, 30 Mar 2011 08:25:04 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTikVPevgKGf2B881ox0zZ5xqBLd9hH1pQF2pW2Jx@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: (score 0.4): No, score=0.4 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170356>

On Wed, Mar 30, 2011 at 09:59:42AM +0800, Tay Ray Chuan wrote:
> On Mon, Mar 28, 2011 at 3:50 PM, Mike Hommey <mh@glandium.org> wrote:
> > Failing wouldn't make sense. That'd mean '?' may not be used by
> > remote-helpers, and that they'd need to grab everything from the remote
> > before git even decides what to grab.
> 
> I guess from "grab" you mean fetching the actual objects etc. However,
> I believe the '?' is used only in the ref fetching/matching step,
> which is before the step where the actual objects are fetched.
> 
> So, if a '?' was reported by the helper, then the transport machinery
> would most likely be unable to properly match refs; then, it would not
> direct the remote-helpers to fetch anything (ie. objects).

Which means the helper is doomed not to report '?', and for that, it
needs to fetch from the remote. Which makes the fetch method pretty
useless for non git remotes, while it has some advantages over import
method.

Mike
