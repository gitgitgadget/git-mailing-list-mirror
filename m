From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to
 chmod.
Date: Thu, 4 Oct 2007 00:54:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710040053380.28395@racer.site>
References: <20071003105501.GD7085@admingilde.org> <470388DC.4040504@viscovery.net>
 <20071003231941.GA20800@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 01:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdE3y-000568-1y
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 01:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbXJCXz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 19:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbXJCXzZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 19:55:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:54125 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751354AbXJCXzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 19:55:25 -0400
Received: (qmail invoked by alias); 03 Oct 2007 23:55:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 04 Oct 2007 01:55:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2zq5OBsn23tXlcD82XaF/GyqqRTn8+3OIR4kzwU
	GeAslPs/VFq+Nk
X-X-Sender: gene099@racer.site
In-Reply-To: <20071003231941.GA20800@admingilde.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59911>

Hi,

On Thu, 4 Oct 2007, Martin Waitz wrote:

> -		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
> +		/* test that new files are not created with X bit */
> +		filemode = !(st1.st_mode & S_IXUSR);
> +		/* test that we can modify the X bit */
> +		filemode &= (!chmod(path, st1.st_mode ^ S_IXUSR) &&

Should that not be &&=?

Ciao,
Dscho
