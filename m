From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 13:37:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701171334410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com> <200701171048.03686.jnareb@gmail.com>
 <Pine.LNX.4.63.0701171138371.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701171311.36358.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 13:38:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7A3M-0003Xw-6N
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 13:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbXAQMiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 07:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbXAQMiE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 07:38:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:43720 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751093AbXAQMiD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 07:38:03 -0500
Received: (qmail invoked by alias); 17 Jan 2007 12:38:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 17 Jan 2007 13:38:00 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200701171311.36358.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36996>

Hi,

On Wed, 17 Jan 2007, Jakub Narebski wrote:

> No key or value can contain "\n".

I just tried this:

	$ cat > .git/config << EOF
	[section] key = "Hello\nWorld"
	EOF
	$ git-repo-config -l
	section.key=Hello
	World

So, values _can_ contain newlines.

> With "\n" as separator you can simply rrturn NUL in the noval case.

Which would buy you what exactly? You can tell that the user did not say 
"noval = true", but "noval". Great. But the _effect_ should be the same!

Anyway, I realize you don't like my solution, so I will just shut up.

Ciao,
Dscho
