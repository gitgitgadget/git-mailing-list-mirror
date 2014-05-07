From: Eric Wong <normalperson@yhbt.net>
Subject: [ANNOUNCE] ssoma - some sort of mail archiver (using git)
Date: Wed, 7 May 2014 06:59:03 +0000
Message-ID: <20140507065903.GA32120@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 08:59:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whvos-0006z5-Qf
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 08:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbaEGG7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 02:59:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58175 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbaEGG7F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 02:59:05 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C3020694;
	Wed,  7 May 2014 06:59:03 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248285>

ssoma is a git-based mail archiver and transport.  Email is injected via
ssoma-mda(1) (MDA: mail delivery agent) on a server and may be shared
(via git) and extracted to mbox, Maildir, or IMAP via ssoma(1).  ssoma
exists primarily as the mechanism (not policy) for public-inbox but may
easily be used for other projects.

Readers of public-inbox instances may install ssoma to extract messages
into their favorite mail client for reading.

See http://public-inbox.org/ for more information on how ssoma is used.

Source code: git clone git://80x24.org/ssoma
WWW: http://ssoma.public-inbox.org/
Installation info: http://ssoma.public-inbox.org/INSTALL.html
Discussion: meta@public-inbox.org (no subscription required[1])

You may subscribe to meta@public-inbox.org via ssoma:
LISTNAME is a name of your choosing:

    URL=git://public-inbox.org/meta
    LISTNAME=public-inbox

    # to initialize a maildir (this may be a new or existing maildir,
    # ssoma will not touch existing messages)
    # If you prefer mbox, use mbox:/path/to/mbox as the last argument
    ssoma add $LISTNAME $URL maildir:/path/to/maildir

    # read with your favorite MUA (only using mutt as an example)
    mutt -f /path/to/maildir # (or /path/to/mbox)

    # to keep your mbox or maildir up-to-date, periodically run the following:
    ssoma sync $LISTNAME

    # your MUA may modify and delete messages from the maildir or mbox,
    # this does not affect ssoma functionality at all

    # to sync all your ssoma subscriptions
    ssoma sync

    # You may wish to sync in your cronjob
    ssoma sync --cron

If you prefer web browsers, you may also read the list at:
http://public-inbox.org/meta/ without installing ssoma
Or use an Atom feed reader: http://public-inbox.org/meta/atom.xml

[1] - or possible at this point:  public-inbox is an archives first,
      pull-based approach to mailing lists.  Anybody may also run a
      push service on top of it, though.

Mail repository format
----------------------
If you are uncomfortable running code in ssoma for any reason and
would rather read directly from the git repository, the following
document describes it:

    http://ssoma.public-inbox.org/ssoma_repository.txt

Thanks for reading this far!
-- 
Eric Wong
