From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb: use single quotes for values replaced by the Makefile
Date: Wed, 2 Aug 2006 22:57:07 +0200
Message-ID: <E1G8Nm7-0007bC-7d@moooo.ath.cx>
References: <20060802192333.GA30861@coredump.intra.peff.net> <E1G8N9c-0004GK-Gz@moooo.ath.cx> <7vmzamuaj6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:57:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8NmJ-0003fi-2B
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWHBU5N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWHBU5N
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:57:13 -0400
Received: from moooo.ath.cx ([85.116.203.178]:46772 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751199AbWHBU5L (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:57:11 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vmzamuaj6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24687>

Junio C Hamano <junkio@cox.net> wrote:
> I understand that (1) "@@FOO@@" is problematic, (2) being able
> to run gitweb/gitweb.perl while coming up with improvements is
> nice, but (3) not being able to say "/etc/foo/$ENV{SITE_NAME}"
> is quite a drawback on the deployment side.
> 
> So why don't we use something other than @@, perhaps "++FOO++"?
That's the other way to solve this.  If there is no typical character
for filenames which is handled different in double quotes this is fine
for me too.

> I'm inclined to take these two patches:
> 
>     gitweb: optionally read config from GITWEB_CONFIG (Jeff King)
>     gitweb: require $ENV{'GITWEB_CONFIG'} (Matthias Lederhofer)
The suggestion by Jeff King to use
our $GITWEB_CONFIG = $ENV{GITWEB_CONFIG} || '@@GITWEB_CONFIG@@';
sounds reasonable too.

> so on top of them something like this?
[patch replacing @@ with ++]

Ack.
