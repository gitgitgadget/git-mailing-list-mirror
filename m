From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] run_external_diff cleanups
Date: Sat, 19 Apr 2014 15:11:29 -0400
Message-ID: <20140419191128.GA9266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:11:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbaft-0000OS-3f
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081AbaDSTLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:11:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:34485 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755201AbaDSTLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 15:11:31 -0400
Received: (qmail 25569 invoked by uid 102); 19 Apr 2014 19:11:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Apr 2014 14:11:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Apr 2014 15:11:29 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246528>

It's possible to overflow an array in run_external_diff and write a
single NULL onto the stack. The first patch below fixes that. The rest
are cleanups and modernizations I noticed while in the area. It's
possible that patch 3 is also a bug fix, depending on your
interpretation.

  [1/6]: run_external_diff: use an argv_array for the command line
  [2/6]: run_external_diff: use an argv_array for the environment
  [3/6]: run_external_diff: clean up error handling
  [4/6]: run_external_diff: drop fflush(NULL)
  [5/6]: run_external_diff: hoist common bits out of conditional
  [6/6]: run_external_diff: refactor cmdline setup logic

-Peff
