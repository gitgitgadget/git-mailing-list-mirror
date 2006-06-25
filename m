From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Repack should try to prevent itself from running twice,
 concurrently.
Date: Sun, 25 Jun 2006 12:17:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606251216250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7vmormn.fsf@assigned-by-dhcp.cox.net>
 <11512302144123-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 12:17:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuRgF-0005AZ-Rb
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 12:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWFYKRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 06:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWFYKRZ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 06:17:25 -0400
Received: from mail.gmx.de ([213.165.64.21]:7085 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932291AbWFYKRY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 06:17:24 -0400
Received: (qmail invoked by alias); 25 Jun 2006 10:17:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 25 Jun 2006 12:17:23 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11512302144123-git-send-email-ryan@michonline.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22604>

Hi,

On Sun, 25 Jun 2006, Ryan Anderson wrote:

> +if [ -f $GIT_DIR/repack.lock ]
> +then
> +	echo "Existing repack job appears to be running."
> +	echo "Remove $GIT_DIR/repack.lock if this is not the case."
> +	exit 1
> +else
> +	echo $$ > $GIT_DIR/repack.lock
> +fi

It is not like it is being an atomic operation, but then, we are not going 
to call repack multiple times a second. I'd say it is sufficient.

Ciao,
Dscho
