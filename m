From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH] test-lib: save test counts across invocations
Date: Thu, 01 Sep 2011 14:38:54 -0400
Message-ID: <1314902334.5371.17.camel@umgah.localdomain>
References: <8fe5381a6b69079b8c20452fd4d99a128764dd52.1314882443.git.trast@student.ethz.ch>
	 <20110901163846.GD15018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 01 20:39:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzCAW-0004zW-U3
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 20:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757355Ab1IASjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 14:39:09 -0400
Received: from chmrr.net ([209.67.253.66]:48139 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757319Ab1IASjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 14:39:07 -0400
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=[10.1.10.64])
	by utwig.chmrr.net with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <alex@chmrr.net>)
	id 1QzCAG-000166-VU; Thu, 01 Sep 2011 14:39:04 -0400
In-Reply-To: <20110901163846.GD15018@sigill.intra.peff.net>
X-Mailer: Evolution 2.32.2 
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.76 (build at 25-May-2011 17:04:25)
X-Date: 2011-09-01 14:39:04
X-Connected-IP: 75.147.59.54:32835
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180561>

On Thu, 2011-09-01 at 12:38 -0400, Jeff King wrote:
> Hmm. What happens when we're wrong? Does our eye-candy just print
> something non-sensical like "13/12", or does prove actually care that we
> run the right number of tests?

prove very much does care -- having a mismatch between the number of
tests planned and the number of tests run is an error in the testfile,
and is reported as such in big red text.  This is because stating how
many tests you plan to run gives prove a way (in addition to the exit
status) to know if the test stopped prematurely, so all mismatches
between plan and actual test counts are reported as testfile failures.

As far as I know prove doesn't have a way to print the estimated time
remaining, though using the contents of the .prove file (if you ran
prove --state=save) to guess it wouldn't be all that hard of a change.
 - Alex
