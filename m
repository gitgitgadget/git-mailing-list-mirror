From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] gitk: use user-configured background in view
	definition dialog
Date: Tue, 8 Jan 2008 09:55:34 +0000
Message-ID: <20080108095534.18927.qmail@ea6d20fb1070bc.315fe32.mid.smarden.org>
References: <20071228145156.8106.qmail@6afea2d2003e0e.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 11:02:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCBHr-000467-Rc
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 11:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbYAHKB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 05:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbYAHKB4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 05:01:56 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:48694 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751104AbYAHKBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 05:01:55 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2008 05:01:54 EST
Received: (qmail 18928 invoked by uid 1000); 8 Jan 2008 09:55:34 -0000
Content-Disposition: inline
In-Reply-To: <20071228145156.8106.qmail@6afea2d2003e0e.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69856>

Hi, I suggest to apply this change to gitk.  Thanks, Gerrit.


On Fri, Dec 28, 2007 at 02:51:56PM +0000, Gerrit Pape wrote:
> Have the text fields in the view definition dialog (View->New view...)
> use the background color as configured through the preferences, instead
> of hard-coded 'white'.
> 
> This was suggested by Paul Wise through
>  http://bugs.debian.org/457124
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>  gitk |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 684e614..7d70c64 100755
> --- a/gitk
> +++ b/gitk
> @@ -1881,7 +1881,7 @@ proc editview {} {
>  
>  proc vieweditor {top n title} {
>      global newviewname newviewperm viewfiles
> -    global uifont
> +    global uifont bgcolor
>  
>      toplevel $top
>      wm title $top $title
> @@ -1895,12 +1895,12 @@ proc vieweditor {top n title} {
>  	-text [mc "Commits to include (arguments to git rev-list):"]
>      grid $top.al - -sticky w -pady 5
>      entry $top.args -width 50 -textvariable newviewargs($n) \
> -	-background white -font uifont
> +	-background $bgcolor -font uifont
>      grid $top.args - -sticky ew -padx 5
>      message $top.l -aspect 1000 -font uifont \
>  	-text [mc "Enter files and directories to include, one per line:"]
>      grid $top.l - -sticky w
> -    text $top.t -width 40 -height 10 -background white -font uifont
> +    text $top.t -width 40 -height 10 -background $bgcolor -font uifont
>      if {[info exists viewfiles($n)]} {
>  	foreach f $viewfiles($n) {
>  	    $top.t insert end $f
> -- 
> 1.5.3.7
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
