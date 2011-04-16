From: Jeff King <peff@peff.net>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Fri, 15 Apr 2011 21:45:25 -0400
Message-ID: <20110416014525.GA23306@sigill.intra.peff.net>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
 <7v39lkiwoj.fsf@alter.siamese.dyndns.org>
 <20110414175034.GA23342@sigill.intra.peff.net>
 <BANLkTin+K46_RSDsYWHso3v7Gpe_k+0m8Q@mail.gmail.com>
 <20110414214230.GB7709@sigill.intra.peff.net>
 <BANLkTikgZH8135=o5ODcA=780-1D7YFngw@mail.gmail.com>
 <20110414222940.GA19389@sigill.intra.peff.net>
 <BANLkTim0Q+RaExss+U3m-=CHT6Jd1jc56Q@mail.gmail.com>
 <20110415033003.GB19621@sigill.intra.peff.net>
 <BANLkTinifkWJJCNGYo1gHKJGMVmRX7QfmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 03:45:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAua0-0005bH-QM
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 03:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470Ab1DPBp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 21:45:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59966
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab1DPBp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 21:45:27 -0400
Received: (qmail 15941 invoked by uid 107); 16 Apr 2011 01:46:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Apr 2011 21:46:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2011 21:45:25 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinifkWJJCNGYo1gHKJGMVmRX7QfmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171654>

On Fri, Apr 15, 2011 at 10:32:27AM +0200, Erik Faye-Lund wrote:

> >> I was just thinking of interpreting everything left of '<' literally
> >> and encode it (if needed). Currently, we interpret the entire string
> >> literally, encoding the name would an improvement.
> >
> > Won't that be a regression for people who already know that we take
> > things literally and are manually quoting and/or rfc2047-encoding the
> > contents?
> 
> Yes. But won't that always be the case when someone depends on buggy behavior?

I guess I don't see the current behavior as necessarily buggy, just
sub-optimal. I can imagine people have worked around it by embedding
rfc2047-encoded content manually.

But I admit I don't really care that much, and I don't know what common
use is. Grepping the list archives didn't turn up anything useful.

> Besides, send-email takes interprets it's --to and --cc arguments as
> well as sendemail.to and sendemail.cc config options literally (i.e
> quoting if needed without any attempts on unquoting first). IMO having
> two closely related programs with similar options that behave
> different in border-cases is pretty ugly. ESPECIALLY when one of them
> has a habit of forwarding unknown options to the other, like
> send-email does...

Yeah, it would be nice to resolve that inconsistency.

-Peff
