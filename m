From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Fri, 22 Mar 2013 10:58:03 -0400
Message-ID: <20130322145803.GC3083@sigill.intra.peff.net>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-4-git-send-email-artagnon@gmail.com>
 <7vip4j8oz5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 15:58:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3Qn-00080e-T7
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 15:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933823Ab3CVO6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 10:58:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35759 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933410Ab3CVO6L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 10:58:11 -0400
Received: (qmail 1323 invoked by uid 107); 22 Mar 2013 14:59:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 10:59:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 10:58:03 -0400
Content-Disposition: inline
In-Reply-To: <7vip4j8oz5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218809>

On Fri, Mar 22, 2013 at 07:54:06AM -0700, Junio C Hamano wrote:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> >  mk_empty () {
> > -	rm -fr testrepo &&
> > -	mkdir testrepo &&
> > +	repo_name="$1"
> > +	test -z "$repo_name" && repo_name=testrepo
> > +	rm -fr $repo_name &&
> > +	mkdir $repo_name &&
> 
> Your quoting is sloppy in this entire patch X-<.

I meant to mention that, too. It doesn't matter, as the intent is for it
always to be a simple name like "testrepo", but that assumption is not
documented anywhere. I suspect the quoting in my patch is sloppy, too.

-Peff
