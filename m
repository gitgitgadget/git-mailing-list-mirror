From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 23:22:50 +0100
Message-ID: <hbf.20111211x512@bombur.uio.no>
References: <jbvj5o$skt$1@dough.gmane.org>
	<1kc4qnw.1xgi3yf14oaw7gM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gelonida@gmail.com (Gelonida N), git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Sun Dec 11 23:42:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZs6c-0002RC-F1
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 23:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595Ab1LKWmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 17:42:46 -0500
Received: from mail-out2.uio.no ([129.240.10.58]:58488 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab1LKWmp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 17:42:45 -0500
X-Greylist: delayed 1190 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Dec 2011 17:42:44 EST
Received: from mail-mx5.uio.no ([129.240.10.46])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RZrnI-00083W-7p; Sun, 11 Dec 2011 23:22:52 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx5.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RZrnH-0003Pp-QI; Sun, 11 Dec 2011 23:22:52 +0100
Received: from hbf by bombur.uio.no with local (Exim 4.72)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RZrnG-0001np-Ji; Sun, 11 Dec 2011 23:22:50 +0100
In-Reply-To: <1kc4qnw.1xgi3yf14oaw7gM%lists@haller-berlin.de>
X-Mailer: VM 7.18 under Emacs 22.2.1
X-UiO-Ratelimit-Test: rcpts/h 3 msgs/h 1 sum rcpts/h 6 sum msgs/h 2 total rcpts 2011 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-2.023,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 65395C31DB3F79C90D8A0C9301A4541E412F387F
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 861 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186819>

Stefan Haller writes:
>Gelonida N <gelonida@gmail.com> wrote:
> 
>> What is the best way to fastforward all fastforwardable tracking
>> branches after a git fetch?
> 
> Here's a script that does this.  It isn't very well tested, I hope I
> didn't miss any edge cases. Use at your own risk.

Local branches can track each other.  So the script needs to toposort
the branches, or to loop until either nothing was done or an error
happened.  (The latter to prevent an eternal loop on error.)

I've wished for a more limited 'git ff' command than this:
- git update-ref --ff-only, and branch/fetch options based on this.
- Fast-forward only the branches tracking one particular remote/branch,
  and maybe branches tracking the fast-forwarded branches.
- Fast-forward to another remote or branch than the tracked one.
I have a few aliases for it, but never thought much of a good common
design.

-- 
Hallvard
