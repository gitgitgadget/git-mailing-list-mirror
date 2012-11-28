From: Jeff King <peff@peff.net>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 22:30:09 -0500
Message-ID: <20121128033009.GA3931@sigill.intra.peff.net>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <20121128032337.GB1669@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 04:30:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdYM2-0002lN-Nj
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 04:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab2K1DaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 22:30:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58955 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697Ab2K1DaM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 22:30:12 -0500
Received: (qmail 2201 invoked by uid 107); 28 Nov 2012 03:31:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 22:31:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 22:30:09 -0500
Content-Disposition: inline
In-Reply-To: <20121128032337.GB1669@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210689>

On Tue, Nov 27, 2012 at 10:23:37PM -0500, Eric S. Raymond wrote:

> Jeff King <peff@peff.net>:
> > But I really wonder if anybody actually cares about adding sub-second
> > timestamp support, or if it is merely "because SVN has it".
> 
> There's actually one possible other reason to care.  1-second granularity 
> isn't quite fine enough to guarantee that a (committer, timestamp)
> pair is a unique key.  1 microsecond granularity would be.

You can't guarantee that such a pair is unique, anyway, due to clock
skew.

A much more compelling argument to me would be that you are doing some
bidirectional magic between git and svn, and you want to make make sure
that an svn->git->svn translation will result in the exact same bytes.
Then the argument is still "because SVN has it", but at least it is "and
we interoperate with it" and not simply chasing a cool but useless
feature.

-Peff
