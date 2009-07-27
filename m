From: Johan Herland <johan@herland.net>
Subject: Re: [RFC 00/11] Foreign VCS helper program for CVS repositories
Date: Mon, 27 Jul 2009 20:11:19 +0200
Message-ID: <200907272011.19430.johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net> <alpine.LNX.2.00.0907271251280.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jul 27 20:11:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVUfm-0006SF-Qd
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 20:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbZG0SLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 14:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbZG0SLe
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 14:11:34 -0400
Received: from sam.opera.com ([213.236.208.81]:60035 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbZG0SLd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 14:11:33 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n6RIBJ4m006686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 27 Jul 2009 18:11:25 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LNX.2.00.0907271251280.2147@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124178>

On Monday 27 July 2009, Daniel Barkalow wrote:
> On Mon, 27 Jul 2009, Johan Herland wrote:
> > This series is a first draft towards implementing a foreign VCS
> > helper program for CVS.
> >
> > It is based on the 'db/foreign-scm' and 'jh/notes' topics in 'pu'.
> > As such, this patch series should apply cleanly to current 'pu'.
> >
> > The first 4 patches supply the necessary parts of Daniel Barkalow's
> > foreign-scm topic that has not yet been merged to 'pu' (i.e.
> > everything remaining in Daniel's original patch series, except the
> > p4-specific stuff).
>
> I've got some changes to this series in the works; I just made a few
> changes to share the transport-side code for interacting with the
> helper with the transport-side code for interacting with
> native-object helpers. Mainly, this means starting each line in the
> "list" response with "?" to indicate that you don't know the hash,
> since the protocol is trying to be compatible with cases where you do
> know.

No problem. I'm actually considering whether I should rewrite the CVS 
helper to a full-fledged git-shim (btw, thanks for the shim work; it 
looks really promising). I would still probably have to use 
git-fast-import, but I would have more control over the fast-import 
process (e.g. by closing the fast-import process myself, I could 
simplify the code maintaining the marks database).

With the git-shim feature already having found an excellent use case 
(the HTTP fetcher), how do you see the future for the foreign-scm 
topic? I like the idea of rewriting foreign-scm on top of git-shim, but 
is there anything substantial _left_ in foreign-scm after such a 
rewrite?

> > Next, there are 3 patches tweaking and expanding the git-vcs API
> > (with corresponding implementations in the foreign transport code)
> > to adjust for the CVS helper's needs.
>
> These make sense to me. I assume you're planning to support exporting
> in some ways, but haven't got it working yet?

Indeed. The current version is only a first draft that fetches 
successfully from simple toy repositories (but probably not many 
real-world CVS repos). I hope to support both fetching and pushing to 
real-world CVS repos at some point.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
