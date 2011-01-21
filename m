From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: cannot fetch arm git tree
Date: Fri, 21 Jan 2011 14:50:26 +0000
Message-ID: <20110121145025.GS13235@n2100.arm.linux.org.uk>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com> <20110116092315.GA27542@n2100.arm.linux.org.uk> <20110116110819.GG6917@pengutronix.de> <AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com> <20110116134248.GD27542@n2100.arm.linux.org.uk> <4D398C43.1000306@vollmann.ch> <20110121134728.GO14956@pengutronix.de> <20110121135725.GR13235@n2100.arm.linux.org.uk> <4D3997FE.5030109@vollmann.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Jello huang <ruifeihuang@gmail.com>, git@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Detlef Vollmann <dv@vollmann.ch>
X-From: git-owner@vger.kernel.org Fri Jan 21 15:51:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgIKN-0005C5-5C
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 15:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab1AUOuw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jan 2011 09:50:52 -0500
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45728 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab1AUOuw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 09:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
	h=Sender:In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=PKxtvwFyEoN5tjV6rhZHrF34SwK0Bto9IU8mACBc4Ro=;
	b=Ox9Bq4b7leN0dbyQvb1Oemgn9w3zYzCpGfMDJjPlQn5BHflHGVgxu47S66jsC+1p2hSzsAAyY51XlbdM+TbmjJhapDb3R3Z4qhjgQQ1CAOyq2ypQb5N/FGdYoFvJj+PN2wXPIwlirIRzfIHGe1Quti0uDVsFCn4vI0KfgarZlaU=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1PgIJn-0007QA-Nh; Fri, 21 Jan 2011 14:50:28 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1PgIJm-0005DL-Ck; Fri, 21 Jan 2011 14:50:26 +0000
Content-Disposition: inline
In-Reply-To: <4D3997FE.5030109@vollmann.ch>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165373>

On Fri, Jan 21, 2011 at 03:28:14PM +0100, Detlef Vollmann wrote:
> It seems to be an implementation of the git protocol using
> HTTP as transport.
> Some info on this is at <http://progit.org/2010/03/04/smart-http.html=
>.

Setting up Smart HTTP

=2E..
   To set it up, it=E2=96=A0s best to walk through the instructions on =
the
   `git-http-backend` documentation page. Basically, you have to instal=
l Git
   v1.6.6 or higher on a server with an Apache 2.x webserver (it has to=
 be
   Apache, currently - other CGI servers don=E2=96=A0t work, last I che=
cked). Then
   you add something similar to this to your http.conf file:

 SetEnv GIT_PROJECT_ROOT /var/www/git
 SetEnv GIT_HTTP_EXPORT_ALL
 ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/

Great.  Deciding that it will be http://servername.example.com/git/ is
really damned annoying as that's traditionally where gitweb lives,
which requires a different script alias.

It seems that due to a lack of coordination between different git
developers, people running webservers have a choice between providing
gitweb or this http extension.

I'm really not interested in working out how to bodge this into working
along side the existing gitweb setup by adding lots of rewrite rules, s=
o
as gitweb got there first I think it has priority, that's what we have
and we'll have to live without the smart http extensions.

It's really not that big a deal if you follow the advice I've given.
