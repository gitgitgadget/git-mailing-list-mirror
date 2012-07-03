From: Jeff King <peff@peff.net>
Subject: Re: git_getpass regression?
Date: Tue, 3 Jul 2012 13:11:22 -0400
Message-ID: <20120703171121.GA3294@sigill.intra.peff.net>
References: <CABPQNSa4uvgijjGCSJDXDMqHC3UkqQKKujG3xDFqnQ13LNrKdQ@mail.gmail.com>
 <20120629173954.GA3804@sigill.intra.peff.net>
 <CABPQNSZ4NhEA1CBiCBD_YNJZcnK8u=NtQ3PeDa5c0NDROPDyrQ@mail.gmail.com>
 <20120629203001.GA12937@sigill.intra.peff.net>
 <CABPQNSY3hJse6J7fDo0S5=ySZA4_7=JisfzLBUu135gR2nSF-w@mail.gmail.com>
 <20120630183607.GA19739@sigill.intra.peff.net>
 <CABPQNSYP6mUZb-1dCifytRxqP7_grzYzON2bjevK2zsGawb-yg@mail.gmail.com>
 <CABPQNSZGcReC4CgaYcmwsXyGSqzQgHKQceZ2M5D=zQmyAs8_Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 19:11:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm6dS-0003yw-4K
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 19:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933225Ab2GCRL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 13:11:29 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52380
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933056Ab2GCRL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 13:11:28 -0400
Received: (qmail 22926 invoked by uid 107); 3 Jul 2012 17:11:35 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 13:11:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 13:11:22 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSZGcReC4CgaYcmwsXyGSqzQgHKQceZ2M5D=zQmyAs8_Ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200918>

On Tue, Jul 03, 2012 at 06:28:11PM +0200, Erik Faye-Lund wrote:

> Is there some other way of getting EOF from the console than Ctrl+C?
> If not, perhaps we can disable the Ctrl+C handling altogether for the
> current process, and restore the console mode on EOF? That only leaves
> the "Bash kills our process"-case, but Bash seems to set a sane
> console mode anyway.

On unix systems, you can generally send EOF on a terminal using Ctrl+D
(and strbuf_getline should handle it properly).  I have no clue if that
works on a Windows console, though. Also, I wonder if these kind of
terminal issues are different based on the terminal emulator you are
using (e.g., msys bash window versus something like pterm).

-Peff
