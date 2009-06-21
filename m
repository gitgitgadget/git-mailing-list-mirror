From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rebase -i: use config file format to save author information
Date: Sun, 21 Jun 2009 03:19:36 -0700
Message-ID: <7v8wjlsxc7.fsf@alter.siamese.dyndns.org>
References: <20090621050846.3554.31660.chriscool@tuxfamily.org>
	<alpine.LNX.2.00.0906210244510.2147@iabervon.org>
	<7vhbyat6qc.fsf@alter.siamese.dyndns.org>
	<200906211153.03969.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 12:19:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIK9U-0004dR-Ev
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 12:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbZFUKTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 06:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbZFUKTj
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 06:19:39 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40076 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbZFUKTi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 06:19:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621101937.JZHC2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jun 2009 06:19:37 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6aKc1c0054aMwMQ04aKdSy; Sun, 21 Jun 2009 06:19:37 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=wW3WdqC5rP8A:10 a=dIu3SnmMAAAA:8
 a=eCETg1LVe9i-xPPuY8sA:9 a=1SQ9L4YukmES_fOt5NSH304csckA:4 a=Rn8qiON8_f4A:10
X-CM-Score: 0.00
In-Reply-To: <200906211153.03969.chriscool@tuxfamily.org> (Christian Couder's message of "Sun\, 21 Jun 2009 11\:53\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121983>

Christian Couder <chriscool@tuxfamily.org> writes:

> It may be possible to write a ref to the commit we need information from. 
> And then when "git rebase --continue" is called, we would read this ref and 
> then get information from the referenced commit?

You mean replacing author-script temporary file with the name of the
commit object we are "pick"ing?

That surely sounds like a more direct approach.  I wonder why the script
didn't do that in the first place (I suspect it was just because it was
easier to implement by borrowing the logic to parse authorship information
from git-revert-script).
