From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH (GIT-GUI)] Fix pre-commit hooks under MinGW/MSYS
Date: Thu, 17 Jul 2008 01:18:22 +0000
Message-ID: <20080717011822.GB16740@spearce.org>
References: <200807170012.28769.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 03:22:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJICq-0002qu-2I
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 03:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbYGQBSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 21:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbYGQBSX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 21:18:23 -0400
Received: from george.spearce.org ([209.20.77.23]:33010 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbYGQBSX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 21:18:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CF367382A4; Thu, 17 Jul 2008 01:18:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200807170012.28769.angavrilov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88796>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> Apply the work-around for checking the executable
> permission of hook files not only on Cygwin, but on
> Windows in general.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
> ---
> 	This is a fix for msysgit issue #118.
> 	(http://code.google.com/p/msysgit/issues/detail?id=118)
> 
> 	I've already sent this patch, but resend it as I haven't received any reply,
> 	and it is not in git-gui.git yet.

Thanks.  I'm not sure why I dropped this earlier, but it is
in my git-gui tree now.

 
> diff --git a/git-gui.sh b/git-gui.sh
> index e6e8890..2d14bf2 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -473,10 +473,10 @@ proc githook_read {hook_name args} {
>  	set pchook [gitdir hooks $hook_name]
>  	lappend args 2>@1
>  
> -	# On Cygwin [file executable] might lie so we need to ask
> +	# On Windows [file executable] might lie so we need to ask
>  	# the shell if the hook is executable.  Yes that's annoying.
>  	#
> -	if {[is_Cygwin]} {
> +	if {[is_Windows]} {
>  		upvar #0 _sh interp
>  		if {![info exists interp]} {
>  			set interp [_which sh]

-- 
Shawn.
