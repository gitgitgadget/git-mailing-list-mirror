From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed
 notes refs
Date: Tue, 6 Jan 2015 20:19:58 -0500
Message-ID: <20150107011958.GA3536@peff.net>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
 <e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
 <xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 02:20:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8fIA-0003Mx-9y
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 02:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbbAGBUC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 20:20:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:59826 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751659AbbAGBUB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 20:20:01 -0500
Received: (qmail 30277 invoked by uid 102); 7 Jan 2015 01:20:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jan 2015 19:20:01 -0600
Received: (qmail 16039 invoked by uid 107); 7 Jan 2015 01:20:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Jan 2015 20:20:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jan 2015 20:19:58 -0500
Content-Disposition: inline
In-Reply-To: <xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262121>

On Tue, Jan 06, 2015 at 02:20:33AM -0800, Junio C Hamano wrote:

> The fact that "git notes merge refs/heads/master" fails is a very
> good prevention of end-user mistakes, and this removal of test
> demonstrates that we are dropping a valuable safety.

Is it really that valuable? If it were:

  git notes merge master

I could see somebody running that accidentally. But we are talking about
somebody who is already fully-qualifying a ref (and anything unqualified
continues to get looked up under refs/notes). Do people really go to the
length of qualifying the ref and then get confused or upset that git did
exactly what they asked it to do?

I'm worried that the end-user safety here is really a strawman, and we
are making this more complicated than it needs to be.

-Peff
