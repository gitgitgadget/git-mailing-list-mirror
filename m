From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] git-rev-size: calculate sizes of repository
Date: Sun, 20 Aug 2006 14:38:40 -0700
Message-ID: <7vlkpjytnj.fsf@assigned-by-dhcp.cox.net>
References: <20060820105452.GA19630@nospam.com>
	<Pine.LNX.4.63.0608201519360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060820152404.GA5679@nospam.com>
	<Pine.LNX.4.63.0608201805070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rutger Nijlunsing <git@wingding.demon.nl>
X-From: git-owner@vger.kernel.org Sun Aug 20 23:38:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEv0H-0001Qc-B3
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 23:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWHTVim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 17:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWHTVim
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 17:38:42 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:23197 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751142AbWHTVil (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 17:38:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060820213841.XRXT6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 20 Aug 2006 17:38:41 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25768>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 20 Aug 2006, Rutger Nijlunsing wrote:
>
>> I _knew_ it... Please go bug someone else. The only thing I did was
>> help someone, and for that I choose my own tools since I do it for
>> fun.
>
> Fair enough.
>
> -- 8< --
> [PATCH] Add git-rev-size
>
> This tool spits out the number of trees, the number of blobs, and the total
> bytes of the blobs for a given rev range.

I do not speak ruby (well I suspect I could read it if I wanted
to but I didn't try) so this may or may not be something
Johannes inherited from the original, but I think the code
overcounts blobs and trees for a top-level tree that happens to
have the same blob (or tree) twice.  I am not sure if that is
intended.

Overcounting would give closer estimate for how big a tar
archive would be, or how big an populated working tree would be,
so it could be considered a feature.  It all depends on what
this tools is useful for, I guess.
