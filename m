From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 0/3] fix cloning superprojects from "."
Date: Tue, 13 Nov 2012 09:32:33 +0100
Message-ID: <20121113083233.GA38188@book.hvoigt.net>
References: <CAABvdFyn=_2JKHYA_jAduoNAti3U0YFHbdU94esm=m8R0s2LcA@mail.gmail.com> <20121108185643.GN15560@sigill.intra.peff.net> <20121109184225.GA1190@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Issues <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 09:32:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYBvQ-0003jS-82
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 09:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab2KMIcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 03:32:39 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:52901 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab2KMIch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 03:32:37 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TYBv8-0000HY-8s; Tue, 13 Nov 2012 09:32:34 +0100
Content-Disposition: inline
In-Reply-To: <20121109184225.GA1190@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209586>

Hi,

On Fri, Nov 09, 2012 at 07:42:26PM +0100, Heiko Voigt wrote:
> Since this is a change in behaviour I would like to further think about
> the implications this brings if we fix this. Not sure how many people
> clone from ".". The correct behavior (as documented) is the one you
> introduce with your patch. If we decide to fix this we should also correct
> the path calculation in git-submodule.sh.

Ok I think this corner case is not that commonly used since most people
work with remote remotes which you can not cd into to clone from ".".

Here is a patch series to clean this handling up.

Cheers Heiko

Heiko Voigt (3):
  Fix relative submodule setup of submodule tests
  ensure that relative submodule url needs ./ or ../
  fix corner case for relative submodule path calculation

 git-submodule.sh             | 22 +++++++++++++++++
 t/t7400-submodule-basic.sh   | 56 ++++++++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh    |  2 ++
 t/t7406-submodule-update.sh  |  2 ++
 t/t7407-submodule-foreach.sh |  2 ++
 t/t7506-status-submodule.sh  |  2 ++
 6 files changed, 86 insertions(+)

-- 
1.8.0.3.gaed4666
