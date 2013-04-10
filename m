From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 14:59:58 -0400
Message-ID: <20130410185958.GA22394@sigill.intra.peff.net>
References: <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
 <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:00:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0Fh-0008DA-0S
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759172Ab3DJTAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:00:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39000 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757706Ab3DJTAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:00:05 -0400
Received: (qmail 5250 invoked by uid 107); 10 Apr 2013 19:01:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 15:01:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 14:59:58 -0400
Content-Disposition: inline
In-Reply-To: <7vhajemd1x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220723>

On Wed, Apr 10, 2013 at 11:54:34AM -0700, Junio C Hamano wrote:

> > If branch.$name.remote is "when I am on this branch, I want to talk to
> > this remote", that rule is not be impacted by the presence of refspecs
> > at all.
> 
> So running the above while on 'maint' will send master and next to
> the remote your "git push" would send to when run without any
> refspecs?

Exactly. The remote selection is orthogonal to the refspecs provided,
and only cares about which branch you are on.

Which is still kind of weird, because why should the branch you are on
affect the default push location? But that is how default "matching" has
always behaved, and we would remain consistent with that.

> That is internally consistent and understandable, and I have no
> objection to it.  Certainly much better than basing the decision on
> branch.{master,next}.remote as I thought you were suggesting to do.

No, I am not suggesting that. I can see how such a command might be
useful (i.e. "push master to where it goes, next to where it goes",
where "goes" is defined by the upstream config). But that is not
remotely close to how "git push" works now, and would be inconsistent
with the other modes (e.g., matching, explicit refspecs, pushing
non-branches, etc).

-Peff
