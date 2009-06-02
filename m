From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] make it possible to skip away from broken commits
Date: Tue, 02 Jun 2009 13:53:41 -0700
Message-ID: <7vmy8qe4ru.fsf@alter.siamese.dyndns.org>
References: <20090602200731.3630.33652.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBaza-0003ef-Bu
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 22:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbZFBUxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 16:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZFBUxl
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 16:53:41 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40559 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbZFBUxk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 16:53:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090602205342.UDXZ20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 2 Jun 2009 16:53:42 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id z8th1b00J4aMwMQ048th2p; Tue, 02 Jun 2009 16:53:41 -0400
X-Authority-Analysis: v=1.0 c=1 a=jiczcZSvnhMA:10 a=FbtlXE8tIuYA:10
 a=dIu3SnmMAAAA:8 a=drfayxQA0siduz1zRp8A:9 a=MUFtQTpYhGlCQQJayaLZLdQbxTAA:4
 a=Rn8qiON8_f4A:10
X-CM-Score: 0.00
In-Reply-To: <20090602200731.3630.33652.chriscool@tuxfamily.org> (Christian Couder's message of "Tue\, 02 Jun 2009 22\:16\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120547>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch series adds a "--ratio=x/y" option to "git bisect skip" so
> that it is possible to skip away from an area were the commits cannot
> be tested.
>
> Note that in this series "--ratio=4" means the same as "--ratio=1/4".
> But I am not sure if this shortcut is worth it.

Actually my gut feeling is that a tweakable knob itself is worth it,
because the user can never tell what the right value should be.

Especially without any documentation updates that explains what this ratio
refers to ;-), but I suspect, unless the user is very familiar with how
the revision graph bisection internally works, such an explanation would
not help him find a skip ratio that is closer to the optimum than a random
guess.  Why not use a constant ratio (or perhaps a pair of alternating
ratios) on "bisect skip" without any new options?
