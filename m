From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH] gitk errors out if launched in a subdirectory
Date: Fri, 12 Jan 2007 18:43:40 +0100
Message-ID: <20070112174340.GA6262@xp.machine.xx>
References: <20070109143019.GA24688@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jan 12 18:42:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5QQc-0005at-Cz
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 18:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbXALRmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 12:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbXALRmy
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 12:42:54 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:43077 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932352AbXALRmx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jan 2007 12:42:53 -0500
Received: (qmail 2073 invoked by uid 0); 12 Jan 2007 17:42:49 -0000
Received: from p54aa89f5.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@84.170.137.245)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 12 Jan 2007 17:42:49 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <20070109143019.GA24688@xp.machine.xx>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36684>

Is there something obviously wrong with this patch? It is the second
time I send this (or a slight variant; last time I even removed the
enviroment checking) and nobody answered.

Please say so if it is NAKed.

-Peter


On Tue, Jan 09, 2007 at 03:30:19PM +0100, Peter Baumann wrote:
> Make gitk use git-rev-parse --git-dir to find the repository.
> 
> Signed-off-by: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
> ---
>  gitk |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 3dabc69..ec4f1bd 100755
> --- a/gitk
> +++ b/gitk
> @@ -12,7 +12,7 @@ proc gitdir {} {
>      if {[info exists env(GIT_DIR)]} {
>  	return $env(GIT_DIR)
>      } else {
> -	return ".git"
> +	return [exec git rev-parse --git-dir]
>      }
>  }
>  
> -- 
> 1.4.4.2
> 
