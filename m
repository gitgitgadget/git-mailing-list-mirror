From: Josef Sipek <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH] guilt(1): Obvious bashisms fixed.
Date: Thu, 14 Jun 2007 11:15:12 -0400
Message-ID: <20070614151512.GB934@filer.fsl.cs.sunysb.edu>
References: <11818254621527-git-send-email-madcoder@debian.org> <1181825462590-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 17:15:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyr2d-00068H-EA
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 17:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbXFNPPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbXFNPPQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 11:15:16 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:36933 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbXFNPPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 11:15:15 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l5EFFCMb003463;
	Thu, 14 Jun 2007 11:15:12 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l5EFFCtQ003461;
	Thu, 14 Jun 2007 11:15:12 -0400
Content-Disposition: inline
In-Reply-To: <1181825462590-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50204>

On Thu, Jun 14, 2007 at 02:50:57PM +0200, Pierre Habouzit wrote:
>   + function foo { } -> foo() { }
>   + add wrapper for echo -e
>   + couple of '[' bashisms
>   + get rid of easy local variables to remove
>   + avoid cd - (using subshells)
... 

Just a small nit-pick :)

> diff --git a/guilt b/guilt
> index 2ae76f8..80f3faf 100755
> --- a/guilt
> +++ b/guilt
> @@ -20,7 +20,29 @@ SUBDIRECTORY_OK=1
...
> +guilt_commands()
>  {
>  	local command
>  	for command in $0-*
> @@ -32,7 +54,7 @@ function guilt_commands
>  	done
>  }
>  
> -if [ `basename $0` = "guilt" ]; then
> +if [ "`basename $0`" = "guilt" ]; then

You added quotes here - that's ok....

>  	# being run as standalone
>  
>  	# by default, we shouldn't fail
> @@ -58,7 +80,7 @@ if [ `basename $0` = "guilt" ]; then

But did not add them here.... :)

Josef "Jeff" Sipek.

-- 
A CRAY is the only computer that runs an endless loop in just 4 hours...
