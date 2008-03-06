From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: [PATCH v2] gitk: Add horizontal scrollbar to the diff view
Date: Thu, 06 Mar 2008 21:43:30 +0100
Message-ID: <47D05772.3080706@dirk.my1.cc>
References: <20080306123845.GA12115@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org, gitster@pobox.com, newsletter@dirk.my1.cc,
	git@vger.kernel.org
To: kaitanie@cc.helsinki.fi
X-From: git-owner@vger.kernel.org Thu Mar 06 21:45:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXMwv-0001So-Hy
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 21:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934277AbYCFUnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 15:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933925AbYCFUnj
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 15:43:39 -0500
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:58805 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548AbYCFUnh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 15:43:37 -0500
Received: from [84.176.109.220] (helo=[192.168.2.100])
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JXMw7-00013r-My; Thu, 06 Mar 2008 21:43:31 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <20080306123845.GA12115@localdomain>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76420>

Hi Pekka,

thank you for the patch. I'm using "git version 1.5.4.950.ga176"
which is "1.5.4-preview20080202" of the msysGit package,
i.e. the Windows version.
It works great for me either. Exactly what I wanted.

   -- Dirk

Pekka Kaitaniemi schrieb:
> Adding horizontal scroll bar makes the scrolling feature more
> discoverable to the users. The horizontal scrollbar is a bit narrower
> than vertical ones so we don't make too big impact on available screen
> real estate.
>
> An interesting side effect of Tk scrollbars is that the "elevator"
> size changes depending on the visible content. So the horizontal
> scrollbar "elevator" changes as the user scrolls the view up and down.
>
> Signed-off-by: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
> ---
> This patch adds a relatively narrow horizontal scrollbar to the diff
> pane. It might be a bit more complicated to implement an on-demand
> one, however...
>
> The patch seems to work fine on Linux and ion3 window manager. I
> haven't had a chance to test it with other systems.
>
>  gitk |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/gitk b/gitk
> index f1f21e9..5340811 100755
> --- a/gitk
> +++ b/gitk
> @@ -857,14 +857,18 @@ proc makewindow {} {
>      set ctext .bleft.ctext
>      text $ctext -background $bgcolor -foreground $fgcolor \
>  	-state disabled -font textfont \
> -	-yscrollcommand scrolltext -wrap none
> +	-yscrollcommand scrolltext  -wrap none \
> +	-xscrollcommand ".bleft.sbhorizontal set"
>      if {$have_tk85} {
>  	$ctext conf -tabstyle wordprocessor
>      }
>      scrollbar .bleft.sb -command "$ctext yview"
> +    scrollbar .bleft.sbhorizontal -command "$ctext xview" -orient h \
> +	-width 10
>      pack .bleft.top -side top -fill x
>      pack .bleft.mid -side top -fill x
>      pack .bleft.sb -side right -fill y
> +    pack .bleft.sbhorizontal -side bottom -fill x -in .bleft
>      pack $ctext -side left -fill both -expand 1
>      lappend bglist $ctext
>      lappend fglist $ctext
>   

