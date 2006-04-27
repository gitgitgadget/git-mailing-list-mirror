From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] C version of git-count-objects
Date: Thu, 27 Apr 2006 09:23:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604270914570.18816@localhost.localdomain>
References: <20060427101254.GA22769@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 27 15:24:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ6TH-00085s-JW
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 15:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWD0NXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 09:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWD0NXs
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 09:23:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27950 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965038AbWD0NXs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 09:23:48 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYD00J3PUJN4K80@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 27 Apr 2006 09:23:47 -0400 (EDT)
In-reply-to: <20060427101254.GA22769@peppar.cs.umu.se>
X-X-Sender: nico@localhost.localdomain
To: Peter Hagervall <hager@cs.umu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19230>

On Thu, 27 Apr 2006, Peter Hagervall wrote:

> Answering the call Linus made[1], sort of, but for a completely
> different program.
> 
> Anyway, it ought to be at least as portable as the shell script, and a
> whole lot faster, however much that matters.
> 
[...]
> +	for (i = 0; i < 16; i++) {
> +		subdir[0] = hex_digits[i];
> +		for (j = 0; j < 16; j++) {
> +			subdir[1] = hex_digits[j];
> +			if (access(subdir, R_OK | X_OK))
> +				continue;
> +			chdir(subdir);
> +			if (!(dp = opendir("."))) {
> +				error("can't open subdir %s", subdir);
> +				continue;
> +			}

Looks like you're missing a chdir(".."); there.


Nicolas
