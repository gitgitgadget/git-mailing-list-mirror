From: Bill Lear <rael@zopyra.com>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 10:34:19 -0600
Message-ID: <17875.14859.177000.558634@lisa.zopyra.com>
References: <vpq64a4bzp1.fsf@olympe.imag.fr>
	<20070214142731.GA1478@moooo.ath.cx>
	<45D33485.5020906@webdrake.net>
	<17875.14305.910866.273778@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Joseph Wakeling <joseph.wakeling@webdrake.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 17:34:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHN5o-0005uf-1E
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbXBNQeV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbXBNQeV
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:34:21 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61272 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932365AbXBNQeT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:34:19 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1EGYJ129258;
	Wed, 14 Feb 2007 10:34:19 -0600
In-Reply-To: <17875.14305.910866.273778@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39672>

On Wednesday, February 14, 2007 at 10:25:05 (-0600) Bill Lear writes:
>...
>If you must ...
>
>% cat ~/.gitconfig
>[alias]
>	scp !scp
>	rcp !rcp
>% git scp -rp . me@remotehost:/directory

Actually that was a bit tongue-in-cheek, syntactically incorrect (I
believe missing '='), I'm not actually sure it will work, nor if the
patch for this actually got in to 1.5.0.  The patch I saw does not
appear to pass the rest of the command line to the system call, but
perhaps I'm wrong and someone else can confirm.

If the patch to do this is reasonable, I would expect the command:

% git scp -rp . me@remotehost:/directory

to expand to:

% scp -rp . me@remotehost:/directory

and if not, I think it should, just as when I have:

[alias]
	pub = push /my/repo

and:

% git pub branch:branch

expands to:

% git push /my/repo branch:branch


Bill
