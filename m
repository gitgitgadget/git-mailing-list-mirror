From: kevin brintnall <kbrint@rufus.net>
Subject: Re: [PATCH] added -C option to chdir() into another directory first
Date: Thu, 26 Feb 2009 14:44:23 -0600
Message-ID: <20090226204423.GA34377@rufus.net>
References: <1235679099-33994-1-git-send-email-kbrint@rufus.net> <7vr61lq6ky.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:46:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcn7D-0000Fw-OE
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 21:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbZBZUo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 15:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754295AbZBZUoZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 15:44:25 -0500
Received: from hamachi.rufus.net ([209.181.236.65]:60111 "EHLO
	hamachi.rufus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbZBZUoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 15:44:25 -0500
Received: by hamachi.rufus.net (Postfix, from userid 100)
	id 60D51272D59; Thu, 26 Feb 2009 14:44:23 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <7vr61lq6ky.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111597>

On Thu, Feb 26, 2009 at 12:35:57PM -0800, Junio C Hamano wrote:
> kevin brintnall <kbrint@rufus.net> writes:
> 
> > This allows things like 'git -C /somewhere pull' without specifying both
> > --work-tree and --git-dir.
> 
> Where should "git -C sub/dir apply this.patch" find the file "this.patch"?

Good question..  It should probably come from the original $PWD.  Maybe we
should have "-C $DIR" simulate "--work-tree=$DIR --git=dir=$DIR/.git" ?

> More generally, when "git -C there cmd arg1 arg2 arg3..." is run, how
> should the implementation of cmd learn what to prefix arg$N with?

I envisioned these two as equivalent:

	git -C $DIR something
	cd $DIR ; git something

-- 
 kevin brintnall =~ /kbrint@rufus.net/
