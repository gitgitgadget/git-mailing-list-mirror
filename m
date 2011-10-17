From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 3/3] git-gui: new config to control staging of untracked
 files
Date: Mon, 17 Oct 2011 20:34:30 +0200
Message-ID: <20111017183430.GA2540@sandbox-rc>
References: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
 <03727ea04f20c953e7de3f84ab1724a8360ca2c4.1318620267.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 20:34:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFs1F-0002YS-Vp
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 20:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab1JQSed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 14:34:33 -0400
Received: from darksea.de ([83.133.111.250]:54950 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751442Ab1JQSec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 14:34:32 -0400
Received: (qmail 20175 invoked from network); 17 Oct 2011 20:34:30 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Oct 2011 20:34:30 +0200
Content-Disposition: inline
In-Reply-To: <03727ea04f20c953e7de3f84ab1724a8360ca2c4.1318620267.git.bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183802>

Hi,

what the series tries to achieve looks good to me. Just one comment.

On Fri, Oct 14, 2011 at 09:25:21PM +0200, Bert Wesarg wrote:
[...]
> diff --git a/lib/index.tcl b/lib/index.tcl
> index 014acf9..45094c2 100644
> --- a/lib/index.tcl
> +++ b/lib/index.tcl
> @@ -367,7 +367,19 @@ proc do_add_all {} {
>  		}
>  	}
>  	if {[llength $untracked_paths]} {
> -		set reply [ask_popup [mc "Stage also untracked files?"]]
> +		set reply 0
> +		switch -- [get_config gui.stageuntracked] {
> +		no {
> +			set reply 0
> +		}
[...]

Here I am wondering whether we have a similar mechanism in git gui like
in core git that makes yes,true,1 equivalents (and similar with other
values) ? If we don't I think the series is fine as it is otherwise it
probably makes sense to use that mechanism.

Cheers Heiko
