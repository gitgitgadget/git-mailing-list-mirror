From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 09:09:51 +0200
Message-ID: <E1G8ArX-0006r2-6D@moooo.ath.cx>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com> <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Aug 02 09:10:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Ari-0004HU-Jj
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 09:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWHBHJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 03:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWHBHJ6
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 03:09:58 -0400
Received: from moooo.ath.cx ([85.116.203.178]:53409 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751290AbWHBHJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 03:09:57 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24632>

Junio C Hamano <junkio@cox.net> wrote:
> In any case, I think tweaking gitweb.cgi from Makefile like
> Martin Waitz did is as easy and clean for people who want to
> customize; it should just be the matter of defining the
> necessary params in config.mak.
Ack.

> I do not think there is much difference between any of the
> customization proposed so far (yours, Martin's and the one from
> Matthias Lederhofer) from functionality and ease-of-use point of
> view.  They all try to make customization can be done in one
> place, and the difference is mostly of taste, so I'd just pick
> one from Martin.
Functionality is a bit different.  If you have a configuration where
perl is used this cannot be done using the make variables.  I would like
to have the option to include a perl file (this does not conflict with
using the Makefile to fill in some values), I've explained this in my
other patch.  The ways I see to specify the file to include are an
environment variable (I don't know if all webservers make it easy to set
one), files after __DATA__ or just $include_file =
@@GITWEB_INCLUDE_FILE@@ which is replaced by the filename or undef if
the user did not set this variable.  For the .pm thing I don't know if
it is not too complicated to change the path I can put the file and just
allowing the user to specify the full path is probably the best.  (I
think the $include_file way is probably the one to use, using __DATA__
is a bit obscur, and not everyone can set environment variables for the
webserver.)
