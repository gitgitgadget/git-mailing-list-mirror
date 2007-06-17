From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5515 in general
Date: Sun, 17 Jun 2007 01:04:37 -0700
Message-ID: <7v4pl70zxm.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706170034540.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jun 17 10:04:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzpkZ-0006gO-Qw
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 10:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbXFQIEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 04:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754457AbXFQIEl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 04:04:41 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64523 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbXFQIEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 04:04:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070617080437.PUPS1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 17 Jun 2007 04:04:37 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CY4d1X00D1kojtg0000000; Sun, 17 Jun 2007 04:04:37 -0400
In-Reply-To: <Pine.LNX.4.64.0706170034540.4740@iabervon.org> (Daniel
	Barkalow's message of "Sun, 17 Jun 2007 02:06:51 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50338>

In general I would agree that the whole "backward compatible"
thing we do with .git/branches and then .git/remotes when we
really went to the new model of using .git/config primarily was
done too cautiously, in that the configuration would not affect
existing setup that used branches and remotes, as they did not
have any way to express those new concepts (i.e. per branch
default remote, and per branch default merge sources).

I am actually in favor of killing .git/branches support way
before we do 1.6.0, and .git/remotes by the time we do 1.6.0.
But if you can arrange the url/fetch configurations to be still
taken from these old locations while applying per-branch default
remote and merge from .git/config, that would probably be easier
for people to migrate to .git/config only style.
