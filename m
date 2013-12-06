From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] rev-parse and "--"
Date: Fri, 6 Dec 2013 16:12:22 -0500
Message-ID: <20131206211222.GB20482@sigill.intra.peff.net>
References: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
 <20131205191518.GB19039@sigill.intra.peff.net>
 <xmqqsiu73w6n.fsf@gitster.dls.corp.google.com>
 <20131205200306.GA13443@sigill.intra.peff.net>
 <xmqqfvq73vhw.fsf@gitster.dls.corp.google.com>
 <20131205210000.GA19617@sigill.intra.peff.net>
 <20131205212851.GA21776@sigill.intra.peff.net>
 <xmqq8uvz3rdf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 22:12:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp2hJ-0002xK-LB
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 22:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869Ab3LFVMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 16:12:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:51814 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753652Ab3LFVMY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 16:12:24 -0500
Received: (qmail 8243 invoked by uid 102); 6 Dec 2013 21:12:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 15:12:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 16:12:22 -0500
Content-Disposition: inline
In-Reply-To: <xmqq8uvz3rdf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238950>

On Thu, Dec 05, 2013 at 01:44:12PM -0800, Junio C Hamano wrote:

> ;-) Good flow of thought.  As to your rev-parse change, I don't
> immediately think of a hole/flaw offhand; it looked a good
> straight-forward change to me.

Here it is with tests and a commit message. While writing the tests, I
noticed that also do not handle true ambiguity the same (we prefer revs,
rather than complaining). That's fixed in the second commit.

  [1/2]: rev-parse: correctly diagnose revision errors before "--"
  [2/2]: rev-parse: diagnose ambiguous revision/filename arguments

-Peff
